package utils;

import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.node.*;

import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.Iterator;
import java.util.Map;

public class JsonTimeUpdater {

    private static final ObjectMapper MAPPER = new ObjectMapper();

    public static String updateAllUtcTimes(String json) throws Exception {
        JsonNode rootNode = MAPPER.readTree(json);
        updateNodeRecursively(rootNode);
        return MAPPER.writerWithDefaultPrettyPrinter().writeValueAsString(rootNode);
    }

    private static void updateNodeRecursively(JsonNode node) {
        if (node.isObject()) {
            Iterator<Map.Entry<String, JsonNode>> fields = node.fields();
            while (fields.hasNext()) {
                Map.Entry<String, JsonNode> entry = fields.next();
                JsonNode value = entry.getValue();

                if (value.isTextual() && isUtcDateTime(value.asText())) {
                    ((ObjectNode) node).put(
                            entry.getKey(),
                            adjustTimeBasedOnMonth(value.asText())
                    );
                } else {
                    updateNodeRecursively(value);
                }
            }
        } else if (node.isArray()) {
            for (JsonNode child : node) {
                updateNodeRecursively(child);
            }
        }
    }

    private static boolean isUtcDateTime(String value) {
        return value.matches("\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{3}Z");
    }

    private static String adjustTimeBasedOnMonth(String utcDateTime) {
        Instant instant = Instant.parse(utcDateTime);
        ZonedDateTime zdt = instant.atZone(ZoneOffset.UTC);

        int month = zdt.getMonthValue();

        // Nov–Feb → +1 hour
        boolean addHour = (month == 11 || month == 12 || month <= 3);

        if (addHour) {
            zdt = zdt.plusHours(1);
        }

        return zdt.format(
                DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                        .withZone(ZoneOffset.UTC)
        );
    }
}

