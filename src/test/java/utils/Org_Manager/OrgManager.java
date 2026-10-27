package utils.Org_Manager;

import utils.PropReader;
import utils.PropertyReader;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;

public class OrgManager {

    private static BlockingQueue<String> orgPool;
    static int NumberOfOrgUsed;
    // Tracks orgs currently allocated to tests and their allocation time.
    private static final Map<String, Long> allocatedOrgs =
            new ConcurrentHashMap<>();

    static {
        try {
            NumberOfOrgUsed = Integer.parseInt(PropReader.readproperty("NumberOfOrgUsed"));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        if (NumberOfOrgUsed <= 0) {
            throw new IllegalArgumentException(
                    "NumberOfOrgUsed must be greater than zero");
        }

        orgPool = new ArrayBlockingQueue<>(NumberOfOrgUsed);

        for (int i = 1; i <= NumberOfOrgUsed; i++) {
            orgPool.add("Org" + i);
        }
    }

    public static String acquireOrg() throws InterruptedException {
        String org = orgPool.take(); // waits automatically
        System.out.println("Allocated Org: " + org);
        allocatedOrgs.put(org, System.currentTimeMillis());
        System.out.println(
                "[ORG POOL] Allocated: " + org
                        + " | Available: " + orgPool.size()
                        + " | Allocated count: " + allocatedOrgs.size());
        return org;
    }

//    public static void releaseOrg(String org) {
//        orgPool.offer(org);
//        System.out.println("Released Org: " + org);
//    }

    public static void releaseOrg(String org) {

        if (org == null || org.trim().isEmpty()) {
            System.err.println("[ORG POOL] Cannot release null/empty org");
            return;
        }

        // Remove only if this org is currently allocated.
        Long allocatedAt = allocatedOrgs.remove(org);

        if (allocatedAt == null) {
            System.err.println(
                    "[ORG POOL] Duplicate or invalid release ignored: "
                            + org);
            return;
        }

        if (!orgPool.offer(org)) {
            // Restore tracking if the queue unexpectedly cannot accept it.
            allocatedOrgs.putIfAbsent(org, allocatedAt);

            System.err.println(
                    "[ORG POOL] Release failed; queue is full for: " + org);
            return;
        }

        System.out.println(
                "[ORG POOL] Released: " + org
                        + " | Available: " + orgPool.size()
                        + " | Allocated count: " + allocatedOrgs.size());
    }

    // Detection only: does not automatically release orgs.
    public static void checkStaleOrgs(long timeoutMinutes) {

        long timeoutMillis =
                TimeUnit.MINUTES.toMillis(timeoutMinutes);

        long now = System.currentTimeMillis();

        allocatedOrgs.forEach((org, allocatedAt) -> {

            long elapsed = now - allocatedAt;

            if (elapsed >= timeoutMillis) {
                System.err.println(
                        "[ORG POOL WARNING] Org may be stuck: " + org
                                + " | Allocated for: "
                                + TimeUnit.MILLISECONDS.toMinutes(elapsed)
                                + " minutes");
            }
        });

        System.out.println(
                "[ORG POOL STATUS] Available: " + orgPool.size()
                        + " | Allocated: " + allocatedOrgs.size());
    }

    public static List<String> StaleOrgList(long timeoutMinutes) {

        List<String> staleOrgs = new ArrayList<>();

        long now = System.currentTimeMillis();
        long timeoutMillis = TimeUnit.MINUTES.toMillis(timeoutMinutes);

        allocatedOrgs.forEach((org, allocatedAt) -> {
            long elapsed = now - allocatedAt;

            if (elapsed >= timeoutMillis) {
                staleOrgs.add(org);

                System.out.println(
                        "[ORG POOL] Stale Org: " + org
                                + " | Occupied for: "
                                + TimeUnit.MILLISECONDS.toMinutes(elapsed)
                                + " minutes"
                );
            }
        });

        return staleOrgs;
    }

    public static int getAvailableOrgCount() {
        return orgPool.size();
    }
    public static int getAllocatedOrgCount() {
        return allocatedOrgs.size();
    }
}

