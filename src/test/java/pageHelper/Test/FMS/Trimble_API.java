package pageHelper.Test.FMS;

import com.relevantcodes.extentreports.utils.DateTimeUtil;
import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;
import org.testng.Assert;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Log4j
public class Trimble_API {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader Generic;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    Common_Steps cs;
    public Trimble_API(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("FMS" + File.separator + "Trimble_API.xml");
        Generic = new xmlreader("Generics" + File.separator + "Common.xml");
        cs = new Common_Steps(DriverInstance);
    }

    @Then("Store {string} on Trimble Maps Trip Viewer with Key {string}")
    public void storeOnTrimbleMapsTripViewer(String arg0, String Key) throws DocumentException, InterruptedException {
        String fullText =webDriver.getText(pageObject.getlocator("KeyValue").replace("{paramlink}",arg0));
        String actText = fullText.replace(arg0, "").trim();
        System.out.println(actText);
        DriverInstance.setVariable(Key,actText);
        if(arg0.contains("Trip Name:"))
        {
            Matcher m = Pattern.compile("plan-\\d+").matcher(actText);
            String result = m.find() ? m.group() : "";
            System.out.println(result);  // plan-2
            DriverInstance.setVariable(Key+"Plan_Number",result);
        }
    }

    @Then("Verify Assertion for {string} contains {string}")
    public void verifyAssertionForAs(String arg0, String arg1) {
             if (arg1.contains("{") && arg1.contains("}")) {
                 String key = arg1.substring(arg1.indexOf("{") + 1, arg1.indexOf("}"));
                 String keyValue = DriverInstance.getVariable(key);
                 arg1 = arg1.replace("{" + key + "}", keyValue);
             }
             if (arg1.contains("SysData")) {
                 arg1 = DriverInstance.getVariable(arg1.split("=>")[1]);
             }
             if (arg1.contains("Date(yyyy-MM-dd)")) {
                 String value = arg1.split("=>")[1];
                 arg1 = webDriver.ReturnDateInSpecifiedFormat(value, "yyyy-MM-dd");
             }
             String actual = DriverInstance.getVariable(arg0);
               if (actual == null) {
                  actual = "";
               }
             Assert.assertTrue(
                     actual.contains(arg1),
                     "Expected value [" + arg1 + "] to be contained in actual [" + actual + "]"
             );

    }

    @Then("Verify Assertion for {string} contains {string} or {string}")
    public void verifyAssertionForContainsOr(
            String actualVariable,
            String expectedValue1,
            String expectedValue2) {

        // Resolve first expected value
        expectedValue1 = resolveExpectedValue(expectedValue1);

        // Resolve second expected value
        expectedValue2 = resolveExpectedValue(expectedValue2);

        // Get actual value
        String actual = DriverInstance.getVariable(actualVariable);

        if (actual == null) {
            actual = "";
        }

        boolean result = actual.contains(expectedValue1)
                || actual.contains(expectedValue2);

        Assert.assertTrue(
                result,
                "Expected actual value [" + actual + "] to contain either [" +
                        expectedValue1 + "] OR [" + expectedValue2 + "]"
        );
    }

    private String resolveExpectedValue(String value) {

        // Resolve {variable} placeholders
        Pattern pattern = Pattern.compile("\\{([^{}]+)}");
        Matcher matcher = pattern.matcher(value);
        StringBuffer resolvedValue = new StringBuffer();

        while (matcher.find()) {

            String key = matcher.group(1);
            String keyValue = DriverInstance.getVariable(key);

            if (keyValue == null) {
                keyValue = "";
            }

            matcher.appendReplacement(
                    resolvedValue,
                    Matcher.quoteReplacement(keyValue)
            );
        }

        matcher.appendTail(resolvedValue);
        value = resolvedValue.toString();

        // Resolve SysData
        if (value.contains("SysData=>")) {

            String variableName = value.split("=>", 2)[1];
            String variableValue = DriverInstance.getVariable(variableName);

            if (variableValue != null) {
                value = variableValue;
            }
        }

        // Resolve Date
        if (value.contains("Date(yyyy-MM-dd)=>")) {

            String dateValue = value.split("=>", 2)[1];

            value = webDriver.ReturnDateInSpecifiedFormat(
                    dateValue,
                    "yyyy-MM-dd"
            );
        }

        return value;
    }

    @Then("Verify {string} not equal to {string}")
    public void verifyNotEqualsAs(String arg0, String arg1) {
        if (arg1.contains("{") && arg1.contains("}")) {
            String key = arg1.substring(arg1.indexOf("{") + 1, arg1.indexOf("}"));
            String keyValue = DriverInstance.getVariable(key);
            arg1 = arg1.replace("{" + key + "}", keyValue);
        }
        if (arg1.contains("SysData")) {
            arg1 = DriverInstance.getVariable(arg1.split("=>")[1]);
        }
        if (arg1.contains("Date(yyyy-MM-dd)")) {
            String value = arg1.split("=>")[1];
            arg1 = webDriver.ReturnDateInSpecifiedFormat(value, "yyyy-MM-dd");
        }
        String actual = DriverInstance.getVariable(arg0);
        Assert.assertFalse(actual.equalsIgnoreCase(arg1),actual+ " is same as "+arg1);

    }

    @Then("Verify Assertion for {string} contains {string} with Format as {string}")
    public void verifyAssertionForContainsWithFormatAs(String arg0, String arg1, String arg2) {
        if(arg1.contains("TimeData"))
        {
            String actual = DriverInstance.getVariable(arg0);
            // Fix invalid seconds if needed (411 -> 41)
            if (actual.matches(".*:\\d{3}\\+.*")) {
                actual = actual.replaceFirst(":(\\d{2})(\\d)\\+", ":$1+");
            }
            OffsetDateTime dateTime = OffsetDateTime.parse(actual);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern(arg2);
            String ActualTime=  dateTime.format(formatter);

            arg1 = DriverInstance.getVariable(arg1.split("=>")[1]);
            webDriver.ToleranceTime(ActualTime,arg1,arg2);
        }
    }

    @Then("Verify Assertion for {string} not contains {string}")
    public void verifyAssertionForAsNot(String arg0, String arg1) {
        if (arg1.contains("{") && arg1.contains("}")) {
            String key = arg1.substring(arg1.indexOf("{") + 1, arg1.indexOf("}"));
            String keyValue = DriverInstance.getVariable(key);
            arg1 = arg1.replace("{" + key + "}", keyValue);
        }
        if(arg1.contains("SysData"))
        {
            arg1 = DriverInstance.getVariable(arg1.split("=>")[1]);
        }
        if(arg1.contains("Date(yyyy-MM-dd)"))
        {
            String value = arg1.split("=>")[1];
            arg1 = webDriver.ReturnDateInSpecifiedFormat(value,"yyyy-MM-dd");
        }
        String actual = DriverInstance.getVariable(arg0);
        Assert.assertFalse(
                actual.contains(arg1),
                "Expected value [" + arg1 + "] not to be contained in actual [" + actual + "]"
        );
    }

    @Then("Verify Assertion for {string} having {string}")
    public void verifyAssertionForAsof(String arg0, String arg1) {
        if (arg1.contains("{") && arg1.contains("}")) {
            String key = arg1.substring(arg1.indexOf("{") + 1, arg1.indexOf("}"));
            String keyValue = DriverInstance.getVariable(key);
            arg1 = arg1.replace("{" + key + "}", keyValue);
        }
        if(arg1.contains("SysData"))
        {
            arg1 = DriverInstance.getVariable(arg1.split("=>")[1]);
        }
        if(arg1.contains("Date(yyyy-MM-dd)"))
        {
            String value = arg1.split("=>")[1];
            arg1 = webDriver.ReturnDateInSpecifiedFormat(value,"yyyy-MM-dd");
        }
        System.out.println("Man1 - "+arg0);
        String actual = DriverInstance.getVariable(arg0);
        System.out.println("Man2 - "+actual);
        Assert.assertEquals(
                actual.trim(),arg1.trim(),
                "Expected value [" + arg1 + "] to be contained in actual [" + actual + "]"
        );
    }

    @Then("Store {string} {string} into {string}")
    public void storeLocationInto(String arg0, String location, String arg1) throws DocumentException, InterruptedException {
       if(location.contains("Arrival_Time"))
       {
           webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("Arrival_Time").replace("index", arg0)));
           webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("Arrival_Time").replace("index", arg0)));
           String fullText = webDriver.getText(pageObject.getlocator("Arrival_Time").replace("index", arg0)).replace("\n", " ").trim();;
           DriverInstance.setVariable(arg1, fullText);
       }
       else if(location.contains("ArrivalTime_Window"))
       {
           webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("Arrival_Time_Window").replace("index", arg0)));
           webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("Arrival_Time_Window").replace("index", arg0)));
           String fullText = webDriver.getText(pageObject.getlocator("Arrival_Time_Window").replace("index", arg0)).replace("\n", " ").trim();;
           DriverInstance.setVariable(arg1, fullText);
       }
       else if(location.contains("DeptTime"))
       {
           webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("DeptTime").replace("index", arg0)));
           webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("DeptTime").replace("index", arg0)));

           String fullText = webDriver.getText(pageObject.getlocator("DeptTime").replace("index", arg0)).replace("\n", " ").trim();;
           DriverInstance.setVariable(arg1, fullText);
       }
       else if(location.contains("Stop_Duration"))
       {
           webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("StopDuration").replace("index", arg0)));
           webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("StopDuration").replace("index", arg0)));

           String fullText = webDriver.getText(pageObject.getlocator("StopDuration").replace("index", arg0)).replace("\n", " ").trim();;
           DriverInstance.setVariable(arg1, fullText);
       }
       else {
           webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("LocationName").replace("{paramlink}", location).replace("index", arg0)));
           webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("LocationName").replace("{paramlink}", location).replace("index", arg0)));
           String fullText = webDriver.getText(pageObject.getlocator("LocationName").replace("{paramlink}", location).replace("index", arg0)).replace("\n", " ").trim();;
           DriverInstance.setVariable(arg1, fullText);
       }
    }

    public static Map<String, String> calculateEtaEtd(String currentEtaString) {

            final DateTimeFormatter FORMATTER =
                    DateTimeFormatter.ofPattern("MM/dd/yy HH:mm:ss z");
            // Parse ETA using America/New_York (auto-handles EST/EDT)
            ZonedDateTime eta = ZonedDateTime.parse(currentEtaString, FORMATTER);

            // Current date/time in EST/EDT
            ZonedDateTime now = ZonedDateTime.now(ZoneId.of("America/New_York"));

            // 1️⃣ Check ETA is today's date (VERY IMPORTANT)
            if (!eta.toLocalDate().equals(now.toLocalDate())) {
                throw new IllegalArgumentException(
                        "Invalid ETA: ETA date must be TODAY (" + now.toLocalDate() + ")"
                );
            }

            // 2️⃣ Check ETA must be a future time today
            if (!eta.isAfter(now)) {
                throw new IllegalArgumentException(
                        "Invalid ETA: ETA time must be in the future"
                );
            }

            validateEstOrEdt(currentEtaString,eta);
            // 3️⃣ Add 60 minutes for ETD (Trip Plan Leg 2 rule)
            ZonedDateTime etd = eta.plusMinutes(60);

            // Return formatted results
            Map<String, String> result = new HashMap<>();
            result.put("ArrivalTime(ETA)", eta.format(FORMATTER));
            result.put("DepartureTime(ETD)", etd.format(FORMATTER));

            return result;
    }
    private static void validateEstOrEdt(String originalEtaString, ZonedDateTime eta) {

        // Extract EST/EDT from original string
        String passedZone = originalEtaString.trim().substring(originalEtaString.length() - 3);
        // Should be "EST" or "EDT"

        // Normalize ETA to New York timezone
        ZonedDateTime nyTime = eta.withZoneSameInstant(ZoneId.of("America/New_York"));
        ZoneOffset offset = nyTime.getOffset();

        // Determine expected EST/EDT based on offset
        String expectedZone = offset.equals(ZoneOffset.of("-05:00")) ? "EST" : "EDT";

        // Compare
        if (!passedZone.equalsIgnoreCase(expectedZone)) {
            throw new IllegalArgumentException(
                    "Incorrect timezone. For this date, expected: "
                            + expectedZone + " but got: " + passedZone
            );
        }
    }

    @Then("Verify Arrival Time as Today Data and Dept Time as Arrival Data plus {int} hour")
    public void verifyArrivalTimeAsTodayDataAndDeptTimeAsArrivalDataPlusHour(int arg0) {
        String ArrivalDate =DriverInstance.getVariable("ETA2").replace("Current ETA","").trim();
        String DeptDate = DriverInstance.getVariable("DEPT2").replace("Current ETD","").trim();
        Map<String, String> output = calculateEtaEtd(ArrivalDate);
        System.out.println("Arrival Time = " + output.get("ArrivalTime(ETA)"));
        System.out.println("Departure Time = " + output.get("DepartureTime(ETD)"));
        Assert.assertTrue(ArrivalDate.contains(output.get("ArrivalTime(ETA)")));
        Assert.assertTrue(DeptDate.contains(output.get("DepartureTime(ETD)")));
    }

    @Then("Verify Planned Start location departure data as Yesterday and Time as {string}")
    public void verifyPlannedStartLocationDepartureDataAsYesterdayAndTimeAs(String arg0) {
        String DeptDate = DriverInstance.getVariable("DEPT1").replace("Current ETD","").trim();
        validatePlannedStart(DeptDate,1);
    }
    @Then("Verify Planned Start location departure data as Today and Time as {string}")
    public void verifyPlannedStartLocationDepartureDataAsTodayAndTimeAs(String arg0) {
        String DeptDate = DriverInstance.getVariable("DEPT1").replace("Current ETD","").trim();
        validatePlannedStart(DeptDate,0);
    }

    public static void validatePlannedStart(String displayedDateTime,int day) {

        // Example input: 12/09/25 01:15:00 CST
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yy HH:mm:ss z");

        ZonedDateTime displayed = ZonedDateTime.parse(displayedDateTime, formatter);
        ZonedDateTime now = ZonedDateTime.now(ZoneId.of("America/Chicago"));
        ZonedDateTime yesterday = now.minusDays(day);

        // 1️⃣ Validate date = yesterday
        if (!displayed.toLocalDate().equals(yesterday.toLocalDate())) {
            throw new IllegalArgumentException("Date must be "+day);
        }

        // 2️⃣ Validate time is 1:15 or 2:15
        LocalTime t = displayed.withZoneSameInstant(ZoneId.of("America/Chicago")).toLocalTime();
        boolean validTime = t.equals(LocalTime.of(0, 15))||t.equals(LocalTime.of(1, 15)) || t.equals(LocalTime.of(2, 15));

        if (!validTime) {
            throw new IllegalArgumentException("Time must be 00:15 or 01:15 or 02:15");
        }

        // 3️⃣ Validate CST/CDT based on offset
        ZoneOffset offset = displayed.getOffset();
        String expectedZone = offset.equals(ZoneOffset.of("-06:00")) ? "CST" : "CDT";

        String passedZone = displayedDateTime.substring(displayedDateTime.length() - 3);

        if (!passedZone.equals(expectedZone)) {
            throw new IllegalArgumentException(
                    "Incorrect timezone. Expected " + expectedZone + " but got " + passedZone
            );
        }
    }

    @Then("Verify Last Leg location arrival {string} time window renders as {int} days from today {string} to {string} TimeZone {string}")
    public void verifyLastLegLocationArrivalTimeWindowRendersAsFourDaysFromTodayMSTToMST(String ATW, int day,String start, String End, String Timezone) {
        int sHour = Integer.parseInt(start.split(":")[0]);
        int sMin = Integer.parseInt(start.split(":")[1]);
        int eHour = Integer.parseInt(End.split(":")[0]);
        int eMin = Integer.parseInt(End.split(":")[1]);
        validateLastLegArrivalWindow(DriverInstance.getVariable(ATW), day, sHour,  sMin,  eHour,  eMin,Timezone);
    }
    public void validateLastLegArrivalWindow(String uiRange, int day,int arg0, int arg1, int arg2, int arg3, String Timezone) {
        // Split into start and end
        String[] parts = uiRange.split(" to ");
        String uiStartTime = parts[0].trim();  // 12/13/25 15:45:00 MST
        String uiEndTime   = parts[1].trim();  // 12/13/25 16:30:00 MST

        // Mountain Timezone (handles MST/MDT automatically)
//        ZoneId mountainTZ = ZoneId.of("America/Denver");
        ZoneId mountainTZ = ZoneId.of(Timezone);

        // 4 days from today
        LocalDate targetDate = LocalDate.now(mountainTZ).plusDays(day);

        // Expected times
        ZonedDateTime expectedStart = targetDate.atTime(arg0, arg1, 0).atZone(mountainTZ);
        ZonedDateTime expectedEnd   = targetDate.atTime(arg2, arg3, 0).atZone(mountainTZ);

        // UI formatter including seconds: MM/dd/yy HH:mm:ss z
        DateTimeFormatter formatter =
                DateTimeFormatter.ofPattern("MM/dd/yy HH:mm:ss z", Locale.US);

        // Parse UI values
        ZonedDateTime actualStart = ZonedDateTime.parse(uiStartTime, formatter);
        ZonedDateTime actualEnd   = ZonedDateTime.parse(uiEndTime, formatter);

//        // Determine expected timezone short name (MST or MDT)
//        String expectedTZ = expectedStart.getZone().getDisplayName(TextStyle.SHORT, Locale.US);
//
//        // ---- Timezone Validation ----
//        if (!uiStartTime.endsWith(expectedTZ)) {
//            throw new AssertionError("Incorrect timezone for Start! Expected: " +
//                    expectedTZ + " | UI: " + uiStartTime);
//        }
//
//        if (!uiEndTime.endsWith(expectedTZ)) {
//            throw new AssertionError("Incorrect timezone for End! Expected: " +
//                    expectedTZ + " | UI: " + uiEndTime);
//        }

        // ---- Time Match Validation ----
        if (!actualStart.equals(expectedStart)) {
            throw new AssertionError("Start time mismatch!\nExpected: " +
                    expectedStart + "\nActual:   " + actualStart);
        }

        if (!actualEnd.equals(expectedEnd)) {
            throw new AssertionError("End time mismatch!\nExpected: " +
                    expectedEnd + "\nActual:   " + actualEnd);
        }

        System.out.println("✔ Last Leg arrival window validated successfully: " +
                expectedStart + " to " + expectedEnd );
    }

    @Then("Verify Total Address count is {string}")
    public void verifyTotalAddressCountIs(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("LocationCount")));
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("LocationCount")));
        int count = webDriver.getwebelementscount(pageObject.getlocator("LocationCount"));
        webDriver.Stringcomparator(arg0,String.valueOf(count));
    }

    @Then("Refresh current Page until Trimble Page Content is updated")
    public void refreshCurrentPageUntilTrimblePageContentIsUpdated() throws DocumentException, InterruptedException {
        waitUntilLastModifiedWithinOneMinute(60);
    }
    public void waitUntilLastModifiedWithinOneMinute(int maxWaitSeconds) {

        long endTime = System.currentTimeMillis() + (maxWaitSeconds * 1000);
        while (System.currentTimeMillis() < endTime) {
            try {
               webDriver.Refresh();
                String fullText =webDriver.getText(pageObject.getlocator("KeyValue").replace("{paramlink}","Last Modified:"));
                String lastModifiedText = fullText.replace("Last Modified:", "").trim();
                System.out.println(lastModifiedText);
                // Parse ISO 8601 format: 2025-12-11T01:42:04+05:30
                OffsetDateTime lastModified = OffsetDateTime.parse(lastModifiedText);

                // Current time
                OffsetDateTime now = OffsetDateTime.now();

                // Acceptable window: now minus 1 minute
                OffsetDateTime oneMinuteAgo = now.minusMinutes(1);

                System.out.println("Last Modified: " + lastModified + " | One min ago: " + oneMinuteAgo);

                // Condition: lastModified is within last 1 minute
                if (!lastModified.isBefore(oneMinuteAgo)) {
                    System.out.println("SUCCESS: Last Modified is within 1 minute.");
                    return;
                }

                // Wait before next refresh
                Thread.sleep(2000);

            } catch (Exception e) {
                System.out.println("Retrying… " + e.getMessage());
            }
        }

        throw new RuntimeException("Failed: Last Modified not updated within 1 minute.");
    }

    @Then("Store Trip Status Value on Trimble Maps Trip Viewer with Key {string}")
    public void storeTripStatusValueOnTrimbleMapsTripViewerWithKey(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("TripStatus")));
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("TripStatus")));
        String fullText = webDriver.getText(pageObject.getlocator("TripStatus"));
        DriverInstance.setVariable(arg0, fullText);
    }

    @Then("Verify {string} time is rendered with day {string} at {string}")
    public void verifyTimeIsRenderedWith(String arg0, String Date, String Time)
    {
        String DateTime;
        String DST = Time.split("or")[0].trim().replace("CDT:","");
        String CST = Time.split("or")[1].trim().replace("CST:","");;

        ZoneId zone = ZoneId.of("America/Chicago");
        ZonedDateTime now = ZonedDateTime.now(zone);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        String  targetDate = LocalDate.now(zone)
                .plusDays(Integer.parseInt(Date)).format(formatter);

        boolean isDST = zone.getRules().isDaylightSavings(now.toInstant());
        if (isDST) {
            //2026-03-11T06:15:00+00:00
            System.out.println("Currently CDT (Daylight Saving Time)");
            DateTime=targetDate+"T"+DST;
        }
        else {
            System.out.println("Currently CST (Standard Time)");
            DateTime=targetDate+"T"+CST;
        }
        System.out.println("Expected Time"+DateTime);
        String actual = DriverInstance.getVariable(arg0);
        if(actual.endsWith("+00:00"))
        {
            actual=actual.replace("+00:00","Z");
        }
        Assert.assertTrue(
                actual.contains(DateTime),
                "Expected value [" + DateTime + "] to be contained in actual [" + actual + "]"
        );
    }

    @Then("Verify {string} is rendered with day {string} with format {string} at {string}")
    public void verifyTimeIsRenderedWithDate(String arg0, String Date,String format, String Time)
    {
        String DateTime;
        String DST = Time.split("or")[0].trim().replace("CDT:","");
        String CST = Time.split("or")[1].trim().replace("CST:","");;

        ZoneId zone = ZoneId.of("America/Chicago");
        ZonedDateTime now = ZonedDateTime.now(zone);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(format);

        String  targetDate = LocalDate.now(zone)
                .plusDays(Integer.parseInt(Date)).format(formatter);

        boolean isDST = zone.getRules().isDaylightSavings(now.toInstant());
        if (isDST) {
            //2026-03-11T06:15:00+00:00
            System.out.println("Currently CDT (Daylight Saving Time)");
            DateTime=targetDate+" "+DST;
        }
        else {
            System.out.println("Currently CST (Standard Time)");
            DateTime=targetDate+" "+CST;
        }
        System.out.println("Expected Time"+DateTime);
        String actual = DriverInstance.getVariable(arg0);
        if(actual.endsWith("+00:00"))
        {
            actual=actual.replace("+00:00","Z");
        }
        Assert.assertTrue(
                actual.contains(DateTime),
                "Expected value [" + DateTime + "] to be contained in actual [" + actual + "]"
        );
    }

    @Then("Verify {string} Records are displaying with data {string}")
    public void verifyRecordsAreDisplayingWithData(String arg0, String arg1) throws DocumentException, InterruptedException {
        if (arg1.contains("SysData")) {
            String Value = arg1.split("=>")[1];
            arg1 = DriverInstance.getVariable(Value);
        }
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("NumOfRecords").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1));
        webDriver.verifyElementToBePresent(pageObject.getlocator("NumOfRecords").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1));
    }

    @Then("Get Trip Event Name on {string}")
    public void GetTripEventName(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("TripEventName"));
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("TripEventName")));
        String TV=webDriver.GetText(webDriver.passwebelement(pageObject.getlocator("TripEventName")));
        DriverInstance.setVariable(arg0,TV);
    }


    @Then("Store Current Date and Time in UTC on {string} with Format as {string}")
    public void storeCurrentDateAndTimeInUTCOn(String arg0, String arg1) {
        String Text= getUtcTimeFromCST(arg1);
        DriverInstance.setVariable(arg0,Text);
    }
    public static String getUtcTimeFromCST(String Timezone) {
        // Central Time (handles CST/CDT automatically)
        ZoneId centralZone = ZoneId.of("America/Chicago");
        // Current time in CST/CDT
        ZonedDateTime centralTime = ZonedDateTime.now(centralZone);
        // Convert to UTC
        ZonedDateTime utcTime = centralTime.withZoneSameInstant(ZoneId.of("UTC"));
        // Formatter
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(Timezone);
        return utcTime.format(formatter);
    }


    @Then("Store Leg {string} {string} on to {string}")
    public void storeLegOnTo(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("LegPTAValue").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1));
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("LegPTAValue").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1)));
        webDriver.waitForElementLoad(1);
        String TV=webDriver.GetText(webDriver.passwebelement(pageObject.getlocator("LegPTAValue").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1)));
        DriverInstance.setVariable(arg2,TV);
    }
}
