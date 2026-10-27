package Listner;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class ToastContext {
    // Thread-safe set to avoid duplicate toast handling
    private static final Set<String> seenToasts =
            Collections.synchronizedSet(new HashSet<>());

    // Use this to define what toasts are expected for negative test cases
    private static final Set<String> expectedToasts =
            Collections.synchronizedSet(new HashSet<>());

    /**
     * Add an expected toast message (for negative test cases)
     * Example: ToastContext.addExpected("Invalid credentials");
     */
    public static void addExpected(String message) {
        expectedToasts.add(message.trim().toLowerCase());
    }

    /**
     * Clear expected messages (should be called before each scenario)
     */
    public static void clearExpected() {
        expectedToasts.clear();
    }

    /**
     * Mark a toast as seen to avoid duplicate handling
     */
    public static boolean isNew(String message) {
        return seenToasts.add(message.trim());
    }

    /**
     * Check whether a toast is expected (negative flow)
     */
    public static boolean isExpected(String message) {
        return expectedToasts.stream()
                .anyMatch(exp -> message.toLowerCase().contains(exp));
    }

    /**
     * Reset seen messages — call at the start or end of a scenario
     */
    public static void reset() {
        seenToasts.clear();
        expectedToasts.clear();
    }
}
