package utils.TimeZone;

import java.time.*;
import java.time.format.DateTimeFormatter;

public class TimeZoneUpdate {

    public static String convertTime(
                String dateStr,
                String timeStr,
                String sourceZoneId // e.g. "America/Chicago"
        ) {
            // Detect current system timezone (target)
            ZoneId targetZone = ZoneId.systemDefault();

            // Formatters
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("M/d/yyyy");
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("h:mm:ss a");
            DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("M/d/yyyy, h:mm:ss a");

            // Parse input
            LocalDate date = LocalDate.parse(dateStr, dateFormatter);
            LocalTime time = LocalTime.parse(timeStr, timeFormatter);

            // Source zone (handles DST automatically)
            ZoneId sourceZone = ZoneId.of(sourceZoneId);

            // Create ZonedDateTime
            ZonedDateTime sourceDateTime = ZonedDateTime.of(date, time, sourceZone);

            // Convert to current system timezone
            ZonedDateTime targetDateTime = sourceDateTime.withZoneSameInstant(targetZone);

            return targetDateTime.format(outputFormatter);
        }

    public static String convertTime(String dateStr, String sourceZoneId) {

        // Target timezone (system)
        ZoneId targetZone = ZoneId.systemDefault();

        // Formatter
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("M/d/yyyy, h:mm:ss a");

        // Parse as LocalDateTime (not LocalDate)
        LocalDateTime localDateTime = LocalDateTime.parse(dateStr, formatter);

        // Source timezone
        ZoneId sourceZone = ZoneId.of(sourceZoneId);

        // Create ZonedDateTime in source zone
        ZonedDateTime sourceDateTime = localDateTime.atZone(sourceZone);

        // Convert to target zone
        ZonedDateTime targetDateTime = sourceDateTime.withZoneSameInstant(targetZone);

        // Format output
        return targetDateTime.format(formatter);
    }


    }

