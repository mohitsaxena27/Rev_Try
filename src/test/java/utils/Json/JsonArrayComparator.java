package utils.Json;

import org.json.JSONArray;
import org.json.JSONObject;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;

public class JsonArrayComparator {


    private static final Set<String> IGNORE_FIELDS = new HashSet<>(
            Arrays.asList(
                    "ediProviderRetrievalDatetime"
            )
    );

    public static void verifyEdiJsonResponse(String actualResponse, String expectedFilePath) {
        try {
            JSONArray actualArray = new JSONArray(actualResponse.trim());
            JSONArray expectedArray = new JSONArray(expectedFilePath.trim());
            // 🔥 Convert actual → Map using ediCode (order independent)
            Map<Integer, JSONObject> actualMap = new HashMap<>();
            for (int i = 0; i < actualArray.length(); i++) {
                JSONObject obj = actualArray.getJSONObject(i);
                actualMap.put(obj.getInt("ediCode"), obj);
            }
            // 🔍 Validate expected objects
            for (int i = 0; i < expectedArray.length(); i++) {
                JSONObject expectedObj = expectedArray.getJSONObject(i);
                int ediCode = expectedObj.getInt("ediCode");
                JSONObject actualObj = actualMap.get(ediCode);
                if (actualObj == null) {
                    throw new RuntimeException("❌ Missing EDI with code: " + ediCode);
                }
                compareJsonObjects(actualObj, expectedObj, "EDI[" + ediCode + "].");
            }
            System.out.println("✅ EDI JSON Verification Passed");
        } catch (Exception e) {
            throw new RuntimeException("❌ EDI JSON Verification Failed: " + e.getMessage(), e);
        }
    }

    private static void compareJsonObjects(JSONObject actual, JSONObject expected, String path) {

        for (String key : expected.keySet()) {

            // ✅ Ignore fields globally (any level)
            if (IGNORE_FIELDS.contains(key)) {
                continue;
            }

            if (!actual.has(key)) {
                throw new RuntimeException("❌ Missing key: " + path + key);
            }

            Object actualValue = actual.get(key);
            Object expectedValue = expected.get(key);

            compareValues(actualValue, expectedValue, path + key + ".");
        }
    }

    private static void compareValues(Object actual, Object expected, String path) {

        if (actual instanceof JSONObject && expected instanceof JSONObject) {
            compareJsonObjects((JSONObject) actual, (JSONObject) expected, path);
            return;
        }

        if (actual instanceof JSONArray && expected instanceof JSONArray) {
            compareJsonArrays((JSONArray) actual, (JSONArray) expected, path);
            return;
        }

        // ✅ NUMBER FIX (MOST IMPORTANT)
        if (actual instanceof Number && expected instanceof Number) {

            double actualNum = ((Number) actual).doubleValue();
            double expectedNum = ((Number) expected).doubleValue();

            if (Double.compare(actualNum, expectedNum) != 0) {
                throw new RuntimeException("❌ Mismatch at " + path +
                        " Expected: " + expected +
                        " Actual: " + actual);
            }
            return;
        }

        // ✅ Dynamic placeholders
        if (expected instanceof String) {
            String expectedStr = (String) expected;

            if ("IGNORE".equalsIgnoreCase(expectedStr)) return;

            if (expectedStr.contains("(18 character SFID)")) {
                if (actual == null || actual.toString().length() != 18) {
                    throw new RuntimeException("❌ Invalid SFID at " + path);
                }
                return;
            }

            if (expectedStr.matches("\\{.*\\}")) return;
        }

        // ✅ STRING COMPARISON
        String actualStr = String.valueOf(actual).trim();
        String expectedStr = String.valueOf(expected).trim();

        if (!actualStr.equalsIgnoreCase(expectedStr)) {
            throw new RuntimeException("❌ Mismatch at " + path +
                    " Expected: " + expected +
                    " Actual: " + actual);
        }
    }
    private static void compareJsonArrays(JSONArray actualArr, JSONArray expectedArr, String path) {

        boolean[] matched = new boolean[actualArr.length()];

        for (int i = 0; i < expectedArr.length(); i++) {

            Object expectedItem = expectedArr.get(i);
            boolean matchFound = false;

            for (int j = 0; j < actualArr.length(); j++) {

                if (matched[j]) continue;

                try {
                    compareValues(actualArr.get(j), expectedItem, path + "[" + i + "]");
                    matched[j] = true;
                    matchFound = true;
                    break;

                } catch (Exception e) {
                    // 🔥 DEBUG LINE (THIS WILL HELP YOU A LOT)
                    System.out.println("❌ Attempt failed at " + path + "[" + i + "] -> " + e.getMessage());
                }
            }

            if (!matchFound) {
                throw new RuntimeException("❌ No matching element found at " + path + "[" + i + "]");
            }
        }
    }
}
