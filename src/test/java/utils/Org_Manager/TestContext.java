package utils.Org_Manager;

public class TestContext {
    private static ThreadLocal<String> currentOrg = new ThreadLocal<>();

    public static void setOrg(String org) {
        currentOrg.set(org);
    }

    public static String getOrg() {
        return currentOrg.get();
    }

    public static void remove() {
        currentOrg.remove();
    }
}

