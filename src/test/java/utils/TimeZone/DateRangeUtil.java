package utils.TimeZone;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;


public class DateRangeUtil {
    private static final ZoneId CHICAGO_ZONE = ZoneId.of("America/Chicago");
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    public static String getMonthDateRange(String type) {

        // Current date in Chicago time zone
        LocalDate chicagoDate = ZonedDateTime.now(CHICAGO_ZONE).toLocalDate();

        YearMonth yearMonth;

        switch (type.toLowerCase()) {
            case "previous":
                yearMonth = YearMonth.from(chicagoDate).minusMonths(1);
                break;

            case "next":
                yearMonth = YearMonth.from(chicagoDate).plusMonths(1);
                break;

            case "current":
            default:
                yearMonth = YearMonth.from(chicagoDate);
                break;
        }

        LocalDate startDate = yearMonth.atDay(1);
        LocalDate endDate = yearMonth.atEndOfMonth();

        return startDate.format(FORMATTER) + " to " + endDate.format(FORMATTER);
    }

    public static void main(String[] args) {
        System.out.println(getMonthDateRange("current"));
        System.out.println(getMonthDateRange("previous"));
        System.out.println(getMonthDateRange("next"));
    }
    public static boolean isDateWithinRange(String date, String dateRange) {

        String[] range = dateRange.split(" to ");

        LocalDate startDate = LocalDate.parse(range[0].trim());
        LocalDate endDate = LocalDate.parse(range[1].trim());
        LocalDate actualDate = LocalDate.parse(date.trim());

        return !actualDate.isBefore(startDate)
                && !actualDate.isAfter(endDate);
    }

    public static String getMonthDateRangeFromDate(String date) {

        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("MMM d, yyyy");

        LocalDate transactionDate = LocalDate.parse(date, inputFormatter);

        YearMonth yearMonth = YearMonth.from(transactionDate);

        LocalDate startDate = yearMonth.atDay(1);
        LocalDate endDate = yearMonth.atEndOfMonth();

        return startDate.format(FORMATTER) + " to " + endDate.format(FORMATTER);
    }
}

