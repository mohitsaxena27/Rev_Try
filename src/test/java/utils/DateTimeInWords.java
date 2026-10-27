package utils;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.Locale;
public class DateTimeInWords {

    private static final String[] ONES = {
            "Zero","One","Two","Three","Four","Five","Six","Seven","Eight","Nine",
            "Ten","Eleven","Twelve","Thirteen","Fourteen","Fifteen","Sixteen","Seventeen","Eighteen","Nineteen"
    };
    private static final String[] TENS = {
            "","","Twenty","Thirty","Forty","Fifty","Sixty","Seventy","Eighty","Ninety"
    };
    private static final String[] ORDINALS = {
            "", "First","Second","Third","Fourth","Fifth","Sixth","Seventh","Eighth","Ninth",
            "Tenth","Eleventh","Twelfth","Thirteenth","Fourteenth","Fifteenth","Sixteenth","Seventeenth","Eighteenth","Nineteenth",
            "Twentieth","Twenty First","Twenty Second","Twenty Third","Twenty Fourth","Twenty Fifth","Twenty Sixth","Twenty Seventh","Twenty Eighth","Twenty Ninth",
            "Thirtieth","Thirty First"
    };

    public static String GetDateTimeInWord() {

        ZoneId chicagoZone = ZoneId.of("America/Chicago");
        ZonedDateTime now = ZonedDateTime.now(chicagoZone);

        String month = now.getMonth().getDisplayName(TextStyle.FULL, Locale.ENGLISH); // August
        String dayOrdinal = ORDINALS[now.getDayOfMonth()]; // Seventh
        String yearTwoWords = twoDigitNumberToWords(now.getYear() % 100); // Twenty Five
        String hourWords = numberToWords(now.getHour()); // Sixteen
        String minuteWords = numberToWords(now.getMinute()); // Thirty Five

        String result = String.join(" ",
                month,
                dayOrdinal,
                yearTwoWords,
                hourWords,
                minuteWords
        );

        System.out.println(result);

        return result;
    }

    private static String twoDigitNumberToWords(int n) {
        if (n < 10) return "Zero " + ONES[n];  // ensures "Zero Five" for year 2005 → 05
        return numberToWords(n);
    }

    private static String numberToWords(int n) {
        if (n < 20) return ONES[n];
        int t = n / 10;
        int o = n % 10;
        if (o == 0) return TENS[t];
        return TENS[t] + " " + ONES[o];
    }

    public static String numericTimestamp() {

        ZoneId chicagoZone = ZoneId.of("America/Chicago");

        // Pattern: ddMMyyyyHHmmss (all numbers)
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("ddMMyyyyHHmmss");

        String numericTimestamp = LocalDateTime.now(chicagoZone).format(formatter);

        System.out.println(numericTimestamp);

        return  numericTimestamp;
    }
}
