package utils.Json;

import com.fasterxml.jackson.databind.JsonNode;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.Duration;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Iterator;

public class JsonComparator {

    private static final int DECIMAL_SCALE = 2;
    private static final int TIME_TOLERANCE_MINUTES = 5;

    public static boolean compare(JsonNode expected, JsonNode actual) {
        return compare(expected, actual, "");
    }

    private static boolean compare(JsonNode expected, JsonNode actual, String path) {

        if (expected == null && actual == null) return true;
        if (expected == null || actual == null) {
            System.out.println("Mismatch at " + path);
            return false;
        }

        // OBJECT
        if (expected.isObject()) {

            Iterator<String> fields = expected.fieldNames();

            while (fields.hasNext()) {

                String field = fields.next();

                JsonNode eNode = expected.get(field);
                JsonNode aNode = actual.get(field);

                String newPath = path + "/" + field;

                if (aNode == null) {
                    System.out.println("Missing field in actual: " + newPath);
                    return false;
                }

                // mileage tolerance
                if ("mileage".equals(field)) {

                    BigDecimal e = new BigDecimal(eNode.asText())
                            .setScale(DECIMAL_SCALE, RoundingMode.HALF_UP);

                    BigDecimal a = new BigDecimal(aNode.asText())
                            .setScale(DECIMAL_SCALE, RoundingMode.HALF_UP);

                    if (e.compareTo(a) != 0) {
                        System.out.println("Mileage mismatch at " + newPath);
                        return false;
                    }
                    continue;
                }

                // respondByTime tolerance
                if ("respondByTime".equals(field)||"statusTime".equals(field)) {

                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");

                    LocalTime eTime = LocalTime.parse(eNode.asText(), formatter);
                    LocalTime aTime = LocalTime.parse(aNode.asText(), formatter);

                    long diff = Math.abs(Duration.between(eTime, aTime).toMinutes());

                    if (diff > TIME_TOLERANCE_MINUTES) {
                        System.out.println("Time mismatch at " + newPath);
                        return false;
                    }
                    continue;
                }

                if (!compare(eNode, aNode, newPath))
                    return false;
            }

            return true;
        }

        // ARRAY
        if (expected.isArray()) {

            if (expected.size() != actual.size()) {
                System.out.println("Array size mismatch at " + path);
                return false;
            }

            for (int i = 0; i < expected.size(); i++) {

                if (!compare(expected.get(i), actual.get(i), path + "[" + i + "]"))
                    return false;
            }

            return true;
        }

        // NUMERIC comparison (fix floating precision)
        if (expected.isNumber() && actual.isNumber()) {

            BigDecimal e = expected.decimalValue()
                    .setScale(DECIMAL_SCALE, RoundingMode.HALF_UP);

            BigDecimal a = actual.decimalValue()
                    .setScale(DECIMAL_SCALE, RoundingMode.HALF_UP);

            if (e.compareTo(a) != 0) {
                System.out.println("Number mismatch at " + path + " Expected:" + e + " Actual:" + a);
                return false;
            }

            return true;
        }

        // DEFAULT comparison
        if (!expected.equals(actual)) {
            System.out.println("Value mismatch at " + path +
                    " Expected:" + expected +
                    " Actual:" + actual);
            return false;
        }

        return true;
    }
}
