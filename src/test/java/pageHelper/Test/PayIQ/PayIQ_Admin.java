package pageHelper.Test.PayIQ;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.cucumber.java.en_old.Ac;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.testng.Assert;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.PropReader;
import utils.PropReader;
import utils.PropertyReader;
import utils.TimeZone.DateRangeUtil;
import utils.xmlreader;
import org.openqa.selenium.WebElement;

import java.io.IOException;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.time.temporal.TemporalAdjusters;

import java.time.format.DateTimeFormatter;
import java.util.List;
import org.testng.Assert;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.text.SimpleDateFormat;
import java.util.Date;
import io.cucumber.datatable.DataTable;
import java.util.List;
import java.util.Map;
import org.openqa.selenium.WebElement;

@Log4j
public class PayIQ_Admin {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    Common_Steps cs;

    public PayIQ_Admin(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("PayIQ" + File.separator + "PayIQ_Admin.xml");
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        cs = new Common_Steps(DriverInstance);
    }


    @Then("Wait till {string} is {string}")
    public void waitTillIs(String jobName, String status) throws DocumentException, InterruptedException {
        webDriver.waitForElementLoad(3);
        String locator = pageObject.getlocator("CheckJobStatus").replace("{paramlink1}", jobName).replace("{paramlink2}", status);

        int maxWaitTime = 15 * 60; // 30 minutes in seconds
        int pollingInterval = 10;  // Check every 10 seconds
        int elapsedTime = 0;

        while (elapsedTime < maxWaitTime) {

            int count = webDriver.getwebelementscount(locator);

            if (count > 0) {
                System.out.println(jobName + " status is " + status);
                return;
            }

            System.out.println("Waiting for " + jobName + " to become " + status + "... (" + elapsedTime + "s elapsed)");

            Thread.sleep(pollingInterval * 1000L);
            elapsedTime += pollingInterval;
        }

        throw new AssertionError(jobName + " did not reach status '" + status + "' within 30 minutes.");
    }

    @Then("Click on {string} with {string} as {string}")
    public void clickOnWithAs(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException {
        if (arg2.contains("SysData")) {
            arg2 = DriverInstance.getVariable(arg2.split("=>")[1]);
        }
        System.out.println(pageObject.getlocator("ClickonRecord").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg0));
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("ClickonRecord").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg0)));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("ClickonRecord").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg0));
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("ClickonRecord").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg0)));
    }

    @Then("Get {string} Name with {string} as {string} and store in {string}")
    public void clickOnWithAs(String arg0, String arg1, String arg2, String arg4) throws DocumentException, InterruptedException {
        if (arg1.contains("SysData")) {
            arg1 = DriverInstance.getVariable(arg1.split("=>")[1]);
        }
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("ClickonRecord").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg0)));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("ClickonRecord").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg0));
        String text = webDriver.GetText(webDriver.passwebelement(pageObject.getlocator("ClickonRecord").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg0)));
        DriverInstance.setVariable(arg4, text);
    }
    @Then("Get {string} Name with {string} as {string} and {string} as {string} and store in {string}")
    public void GetNameWith2Params(String arg0, String arg1, String arg2, String arg3, String arg4, String key) throws DocumentException, InterruptedException {
        if (arg2.contains("SysData")) {
            arg2 = DriverInstance.getVariable(arg2.split("=>")[1]);
        }
        if (arg4.contains("SysData")) {
            arg4 = DriverInstance.getVariable(arg4.split("=>")[1]);
        }
        System.out.println(pageObject.getlocator("ClickonRecordWithTwoParam").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg3).replace("{paramlink4}", arg4).replace("{paramlink5}", arg0));
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("ClickonRecordWithTwoParam").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg3).replace("{paramlink4}", arg4).replace("{paramlink5}", arg0)));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("ClickonRecordWithTwoParam").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg3).replace("{paramlink4}", arg4).replace("{paramlink5}", arg0));
        String text = webDriver.GetText(webDriver.passwebelement(pageObject.getlocator("ClickonRecordWithTwoParam").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg3).replace("{paramlink4}", arg4).replace("{paramlink5}", arg0)));
        DriverInstance.setVariable(key, text);
    }

    @Then("Verify Normalized Text displaying as {string}")
    public void verifyNormalizedTextDisplayingAs(String arg0)
            throws DocumentException, InterruptedException {

        String locator;

        if (arg0.contains("SysData")) {
            String value = arg0.split("=>")[1];
            locator = pageObject.getlocator("Global_Text_Contains_Normalized")
                    .replace("{paramlink}", DriverInstance.getVariable(value));
        } else {
            locator = pageObject.getlocator("Global_Text_Contains_Normalized")
                    .replace("{paramlink}", arg0);
        }

        webDriver.waitUntilElementIsVisible(locator);
        webDriver.verifyElementToBePresent(locator);
    }


    @Then("Click on {string} button on {string} section")
    public void clickOnButtonOnPage(String arg0, String arg1)
            throws DocumentException, InterruptedException {

        String xpath = pageObject.getlocator("BtnClickOnSection")
                .replace("{paramlink1}", arg0)
                .replace("{paramlink2}", arg1);

        System.out.println("XPath = " + xpath);

        webDriver.waitforElementtobeclickable(xpath);
        webDriver.ClickOnElement(webDriver.getwebelement(xpath));
    }


    @Then("Click on {string} with {string} as {string} and {string} as {string}")
    public void clickOnWithAnd(String arg0, String arg1, String arg2, String arg3, String arg4) throws DocumentException, InterruptedException {
        if (arg2.contains("SysData")) {
            arg2 = DriverInstance.getVariable(arg2.split("=>")[1]);
        }
        if (arg4.contains("SysData")) {
            arg4 = DriverInstance.getVariable(arg4.split("=>")[1]);
        }
        System.out.println(pageObject.getlocator("ClickonRecordWithTwoParam").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg3).replace("{paramlink4}", arg4).replace("{paramlink5}", arg0));
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("ClickonRecordWithTwoParam").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg3).replace("{paramlink4}", arg4).replace("{paramlink5}", arg0)));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("ClickonRecordWithTwoParam").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg3).replace("{paramlink4}", arg4).replace("{paramlink5}", arg0));
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("ClickonRecordWithTwoParam").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg3).replace("{paramlink4}", arg4).replace("{paramlink5}", arg0)));
    }

    @Then("Set Payroll {string} Month Range on To {string}")
    public void setPayrollMonthRangeOnTo(String arg0, String arg1) {
        DriverInstance.setVariable(arg1, DateRangeUtil.getMonthDateRange(arg0));

    }
    @Then("Set Payroll Month Range from date {string} on To {string}")
    public void setPayrollMonthRangeFromDateOnTo(String arg0, String arg1) {

        String date = DriverInstance.getVariable(arg0);

        DriverInstance.setVariable(
                arg1,
                DateRangeUtil.getMonthDateRangeFromDate(date)
        );
    }

    @Then("Recently Viewed to All Pending")
    public void recentlyViewedToAllPending() throws Exception {

        webDriver.waitForElementLoad(3);

        webDriver.waitUntilTheElementIsVisible(
                webDriver.getwebelement(
                        pageObject.getlocator("ListViewDropdown")
                                .replace("{paramlink}", "Select a List View:")));

        webDriver.safeJavaScriptClick(
                webDriver.getwebelement(
                        pageObject.getlocator("ListViewDropdown")
                                .replace("{paramlink}", "Select a List View:")));

        webDriver.waitForElementLoad(1);

        webDriver.waitUntilElementIsVisible(
                pageObject.getlocator("ListViewName")
                        .replace("{paramlink}", "All Pending"));

        webDriver.safeJavaScriptClick(
                webDriver.passwebelement(
                        pageObject.getlocator("ListViewName")
                                .replace("{paramlink}", "All Pending")));
    }


    @Then("Click on icon {string} on {string}")
    public void clickOnIconOnAccessorial(String iconName, String accessorial) throws Exception {

        int index = 0;

        if (accessorial.contains("_")) {
            // Accessorial_2 -> 2 -> convert to zero-based index = 1
            index = Integer.parseInt(accessorial.split("_")[1]) - 1;
        }

        String xpath = pageObject.getlocator("AccessorialRemoveIcon")
                .replace("{paramlink1}", String.valueOf(index))
                .replace("{paramlink2}", iconName);

        webDriver.waitForElementLoad(1);
        webDriver.ScrollIntoView(webDriver.getwebelement(xpath));
        webDriver.WaitforElementtobeclickable(xpath);
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xpath));
        webDriver.waitForElementLoad(2);
    }

    @Then("Click on {string} with {string} as {string} and {string} as {string} and {string} as {string}")
    public void clickOnWithAsAndAsAndAs(String arg0, String arg1, String arg2, String arg3, String arg4, String arg5, String arg6) throws DocumentException, InterruptedException {
        if (arg2.contains("SysData")) {
            arg2 = DriverInstance.getVariable(arg2.split("=>")[1]);
        }
        if (arg4.contains("SysData")) {
            arg4 = DriverInstance.getVariable(arg4.split("=>")[1]);
        }
        if (arg6.contains("SysData")) {
            arg6 = DriverInstance.getVariable(arg6.split("=>")[1]);
        }
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("ClickOnRecordsWithThree").replace("{paramlink1}",arg1).replace("{paramlink2}",arg2).replace("{paramlink3}",arg3).replace("{paramlink4}",arg4).replace("{paramlink5}",arg5).replace("{paramlink6}",arg6).replace("{paramlink7}",arg0)));
        webDriver.waitforElementtobeclickable(pageObject.getlocator("ClickOnRecordsWithThree").replace("{paramlink1}",arg1).replace("{paramlink2}",arg2).replace("{paramlink3}",arg3).replace("{paramlink4}",arg4).replace("{paramlink5}",arg5).replace("{paramlink6}",arg6).replace("{paramlink7}",arg0));
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("ClickOnRecordsWithThree").replace("{paramlink1}",arg1).replace("{paramlink2}",arg2).replace("{paramlink3}",arg3).replace("{paramlink4}",arg4).replace("{paramlink5}",arg5).replace("{paramlink6}",arg6).replace("{paramlink7}",arg0)));
    }

    @Then("Verify Timestamp date is {string}")
    public void verifyTimestampDateIs(String expectedDate) throws DocumentException, InterruptedException {
        if (expectedDate.contains("SysData=>")) {
            expectedDate = DriverInstance.getVariable(expectedDate.split("=>")[1]);
        } else if (expectedDate.equalsIgnoreCase("Current Date")) {
            expectedDate = new SimpleDateFormat("M/d/yyyy").format(new Date());
        }
        String locator = pageObject.getlocator("AdminLogsTimeStamp").replace("{paramlink}", expectedDate);
        System.out.println("Expected Date : " + expectedDate);
        System.out.println("Locator       : " + locator);
        webDriver.waitUntilElementIsVisible(locator);
        System.out.println("Actual Timestamp : " + webDriver.passwebelement(locator).getText());
        webDriver.verifyElementToBePresent(locator);
    }

    @Then("Verify logs in PayIQ Admin displaying as {string}")
    public void verifyLogsInPayIQAdminDisplayingAs(String arg0) throws DocumentException, InterruptedException {
        Pattern pattern = Pattern.compile("\\{([^}]*)\\}");
        Matcher matcher = pattern.matcher(arg0);
        while (matcher.find()) {
            arg0 = arg0.replace("{" + matcher.group(1) + "}", DriverInstance.getVariable(matcher.group(1)));
            System.out.println(matcher.group(1));
            matcher = pattern.matcher(arg0);
        }
        System.out.println("Final Log Text: " + arg0);
        String locator = pageObject.getlocator("PayIQLogsDetail").replace("{paramlink}", arg0);
        System.out.println("Locator: " + locator);
        webDriver.waitUntilElementIsVisible(locator);
        webDriver.verifyElementToBePresent(locator);
    }

    @Then("Set First date of month into {string}")
    public void setFirstDateOfMonthInto(String arg0) {
        ZoneId chicagoZone = ZoneId.of("America/Chicago");

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("M/d/yyyy");

        String firstDateOfMonth = ZonedDateTime.now(chicagoZone)
                .toLocalDate()
                .withDayOfMonth(1)
                .format(formatter);

        DriverInstance.setVariable(arg0, firstDateOfMonth);
    }

    @Then("Set Last date of month into {string}")
    public void setLastDateOfMonthInto(String variableName) {
        ZoneId chicagoZone = ZoneId.of("America/Chicago");

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("M/d/yyyy");

        String lastDateOfMonth = ZonedDateTime.now(chicagoZone)
                .toLocalDate()
                .with(TemporalAdjusters.lastDayOfMonth())
                .format(formatter);

        DriverInstance.setVariable(variableName, lastDateOfMonth);
    }

    @Then("Choose {string} button on {string} section")
    public void clickOnButtonOnFilter(String arg0, String arg1)
            throws DocumentException, InterruptedException {

        String xpath = pageObject.getlocator("BtnClickOnFiltersSection")
                .replace("{paramlink1}", arg0)
                .replace("{paramlink2}", arg1);

        System.out.println("XPath = " + xpath);

        webDriver.waitforElementtobeclickable(xpath);
        webDriver.ClickOnElement(webDriver.getwebelement(xpath));
    }


    @Then("Store date with month offset {int} and day {int} in format MMM d, yyyy into {string}")
    public void storeDateWithMonthOffsetAndDayInFormatMMMDYyyyInto(int arg0, int arg1, String arg2) {
        DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("MMM d, yyyy", Locale.ENGLISH);
        LocalDate date = LocalDate.now().plusMonths(arg0).withDayOfMonth(arg1);
        DriverInstance.setVariable(arg2, date.format(FORMATTER));
    }

    @Then("Convert {string} {string} into browser timezone and store on {string}")
    public void convertIntoBrowserTimezoneAndStoreOn(String day,String arg0, String arg1) {
            if(arg0.contains("SysData"))
            {
                arg0= DriverInstance.getVariable(arg0.split("=>")[1]);
            }
            // Chicago timezone
            ZoneId chicagoZone = ZoneId.of("America/Chicago");
            // Browser/system timezone
            ZoneId browserZone = ZoneId.systemDefault();
            System.out.println(browserZone);
            // Tomorrow's date in Chicago
            LocalDate chicagoDate = LocalDate.now(chicagoZone).plusDays(Integer.parseInt(day));

            // Parse input time
//            DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("h:mm a");
        DateTimeFormatter inputFormatter =DateTimeFormatter.ofPattern("h:mm a", Locale.ENGLISH);
            LocalTime localTime = LocalTime.parse(arg0, inputFormatter);

            // Create Chicago date-time
            ZonedDateTime chicagoDateTime = ZonedDateTime.of(
                    chicagoDate,
                    localTime,
                    chicagoZone
            );

            // Convert Chicago time to browser timezone
            ZonedDateTime browserDateTime = chicagoDateTime.withZoneSameInstant(browserZone);

            // Format: 8/11/2026, 10:30 AM GMT+5:30
            DateTimeFormatter outputFormatter =
                    DateTimeFormatter.ofPattern("M/d/yyyy, h:mm a z");
//            String convertedTime = browserDateTime.format(outputFormatter);
        String convertedTime = browserDateTime.format(outputFormatter).toUpperCase(Locale.ENGLISH);
            if(convertedTime.contains("IST"))
            {
                convertedTime=convertedTime.replace(" IST","");
            }
            DriverInstance.setVariable(arg1, convertedTime);
        }


    @Then("Add {int} hours to {string} and convert into browser timezone and store on {string}")
    public void addHoursAndConvertIntoBrowserTimezone(int hours, String arg0, String arg1) {

        if (arg0.contains("SysData")) {
            arg0 = DriverInstance.getVariable(arg0.split("=>")[1]);
        }

        // Chicago timezone
        ZoneId chicagoZone = ZoneId.of("America/Chicago");

        // Browser/System timezone
        ZoneId browserZone = ZoneId.systemDefault();

        // Input time format
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("h:mm a", Locale.ENGLISH);
        // Parse input time
        LocalTime chicagoTime =
                LocalTime.parse(arg0, inputFormatter);

        // Today's date in Chicago
        LocalDate chicagoDate =
                LocalDate.now(chicagoZone);

        // Create Chicago date/time and add hours
        ZonedDateTime chicagoDateTime =
                ZonedDateTime.of(
                        chicagoDate,
                        chicagoTime,
                        chicagoZone
                ).plusHours(hours);

        ZonedDateTime finalDateTime;

        // If browser is already Chicago, no conversion required
        if (browserZone.equals(chicagoZone)) {
            finalDateTime = chicagoDateTime;
        } else {
            // Convert Chicago time to browser timezone
            finalDateTime = chicagoDateTime.withZoneSameInstant(browserZone);
        }

        // Output format
        DateTimeFormatter outputFormatter =
                DateTimeFormatter.ofPattern("M/d/yyyy, hh:mm a z", Locale.ENGLISH);


        String result = finalDateTime.format(outputFormatter);
        if(result.contains("IST"))
        {
            result = result.replace("IST","").trim();
        }
        DriverInstance.setVariable(arg1, result);
    }

    @Then("Add {int} hours to {string} and store on {string}")
    public void add12HoursAndStoreOn(int time, String arg0, String arg1) {

        if (arg0.contains("SysData")) {
            arg0 = DriverInstance.getVariable(arg0.split("=>")[1]);
        }

        DateTimeFormatter timeFormatter =
                DateTimeFormatter.ofPattern("h:mm a", Locale.ENGLISH);

        DateTimeFormatter outputFormatter =
                DateTimeFormatter.ofPattern("M/d/yyyy, h:mm a", Locale.ENGLISH);

        // Parse input time
        LocalTime inputTime = LocalTime.parse(arg0, timeFormatter);
        // Combine today's date with input time
        LocalDateTime dateTime = LocalDateTime.of(
                LocalDate.now(),
                inputTime
        );
        // Add 12 hours
        LocalDateTime updatedDateTime = dateTime.plusHours(time);
        // Store date + time
        String updatedValue = updatedDateTime.format(outputFormatter);
        DriverInstance.setVariable(arg1, updatedValue);
    }

    @Then("Verify Scheduled Job for {string} displaying as {string}")
    public void verifyScheduledJobForDisplayingAs(String arg0, String arg1) throws DocumentException, InterruptedException {
        if(arg1.contains("SysData"))
        {
            arg1= DriverInstance.getVariable(arg1.split("=>")[1]);
        }
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("ScheduleJobNextSceduleTime").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1)));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("ScheduleJobNextSceduleTime").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1));
        webDriver.verifyElementToBePresent(pageObject.getlocator("ScheduleJobNextSceduleTime").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1));
    }

    @Then("Store last 15 minute interval time on {string}")
    public void storeLast15MinuteIntervalTime(String variableName) {

        ZoneId chicagoZone = ZoneId.of("America/Chicago");

        ZonedDateTime currentTime = ZonedDateTime.now(chicagoZone);

        // Get the previous 15-minute interval
        int minute = currentTime.getMinute();
        int roundedMinute = (minute / 15) * 15;

        ZonedDateTime intervalTime = currentTime
                .withMinute(roundedMinute)
                .withSecond(0)
                .withNano(0);

        // Format as 12:00 AM
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("h:mm a");
        DateTimeFormatter formatter =DateTimeFormatter.ofPattern("h:mm a", Locale.ENGLISH);
        String intervalTimeValue = intervalTime.format(formatter);

        DriverInstance.setVariable(variableName, intervalTimeValue);
    }


    @Then("Store next 15 minute interval time on {string}")
    public void storeNext15MinuteIntervalTime(String variableName) {

        ZoneId chicagoZone = ZoneId.of("America/Chicago");

        ZonedDateTime currentTime = ZonedDateTime.now(chicagoZone);

        // Get the next 15-minute interval
        int minute = currentTime.getMinute();
        int nextMinute = ((minute / 15) + 1) * 15;

        ZonedDateTime intervalTime = currentTime
                .withSecond(0)
                .withNano(0)
                .plusMinutes(nextMinute - minute);

        // Format as 12:00 AM
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("h:mm a");
        DateTimeFormatter formatter =DateTimeFormatter.ofPattern("h:mm a", Locale.ENGLISH);
        String intervalTimeValue = intervalTime.format(formatter);

        DriverInstance.setVariable(variableName, intervalTimeValue);
    }


    @Then("Wait till time {string} is over")
    public void waitTillTimeIsOver(String variableName) {

        if(variableName.contains("SysData"))
        {
            variableName=DriverInstance.getVariable(variableName.split("=>")[1]);
        }

        ZoneId chicagoZone = ZoneId.of("America/Chicago");


//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("h:mm a");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("h:mm a", Locale.ENGLISH);
        LocalTime targetTime = LocalTime.parse(variableName, formatter);

        ZonedDateTime now = ZonedDateTime.now(chicagoZone);

        ZonedDateTime targetDateTime = now
                .withHour(targetTime.getHour())
                .withMinute(targetTime.getMinute())
                .withSecond(0)
                .withNano(0);

        // If target time has passed, check if it is a midnight/day rollover
        if (!targetDateTime.isAfter(now)) {

            // If target is 12:00 AM, it means next day's midnight
            if (targetTime.equals(LocalTime.MIDNIGHT)) {
                targetDateTime = targetDateTime.plusDays(1);
            } else {
                // Target time already passed, continue without waiting
                return;
            }
        }

        long waitSeconds = Duration.between(now, targetDateTime).getSeconds();

        try {
            Thread.sleep(waitSeconds * 1000);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new RuntimeException("Wait was interrupted", e);
        }
    }

    @Then("Set URL with {string} and store into {string}")
    public void setURLWithAndStoreInto(String arg0, String arg1) {
        String url = PropReader.get("application_url");
        DriverInstance.setVariable(arg1, url.replace(".com", arg0));
    }

    @Then("Verify Pay Estimate Status for {string} as {string}")
    public void verifyPayEstimateStatusForAs(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("StatusPayEstimate").replace("{paramlink}", arg0));
        String fieldName = webDriver.passwebelement(pageObject.getlocator("StatusPayEstimate").replace("{paramlink}", arg0)).getAttribute("for");
        WebElement element = webDriver.passwebelement(xml.getlocator("FormFields").replace("{paramlink}", fieldName));
        String ActualText = webDriver.Getattribute(element, "value");
        System.out.println("Actual Test:" + ActualText);
        webDriver.Stringcomparator(ActualText, arg1);
    }

    public String getValueFromPayEstimate(String RecordNum, String Name, int index) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("EstimateField").replace("{paramlink}", Name).replace("{RecordNum}",RecordNum).replace("{index}",String.valueOf(index)));
        String fieldName = webDriver.passwebelement(pageObject.getlocator("EstimateField").replace("{paramlink}", Name).replace("{RecordNum}",RecordNum).replace("{index}",String.valueOf(index))).getAttribute("for");
        WebElement element = webDriver.passwebelement(xml.getlocator("FormFields").replace("{paramlink}", fieldName));
        String ActualText = webDriver.Getattribute(element, "value");
        System.out.println("Actual Test:" + ActualText);
        return ActualText;
    }
    @Then("Verify {string} Estimated Pay for Section {string}")
    public void verifyEstimatedPaySection(String recordnum,String section, DataTable dt) throws Exception {

        List<Map<String, String>> data = dt.asMaps(String.class, String.class);
        String Load_leg = data.get(0).get("Load / Leg");
        String TierRule = data.get(0).get("Tier/Rule");
        String Type = data.get(0).get("Type");
        String Rate = data.get(0).get("Rate");
        String Qty = data.get(0).get("Qty");
        String Comment = data.get(0).get("Comment");
        String Estimated_Pay_Amount = data.get(0).get("Estimated Pay Amount");

        if(TierRule.equalsIgnoreCase("SysData"))
        {
            TierRule= DriverInstance.getVariable(TierRule.split("=>")[1]);
        }
        if(Estimated_Pay_Amount.contains("SysData"))
        {
            Estimated_Pay_Amount=DriverInstance.getVariable(Estimated_Pay_Amount.split("=>")[1]);
        }
        String Actual_LoadLeg = getValueFromPayEstimate(recordnum,section,1);
        String Actual_Type = getValueFromPayEstimate(recordnum,section,2);
        String Actual_Rate = getValueFromPayEstimate(recordnum,section,3);
        String Actual_Qty = getValueFromPayEstimate(recordnum,section,4);
        String Actual_Comment = getValueFromPayEstimate(recordnum,section,5);
        String Actual_Estimated_Pay_Amount = getValueFromPayEstimate(recordnum,section,6);

        DriverInstance.setVariable(section+"_EstimatedPay_LoadLeg",Actual_LoadLeg);
        DriverInstance.setVariable(section+"_EstimatedPay_Type",Actual_Type);
        DriverInstance.setVariable(section+"_EstimatedPay_Rate",Actual_Rate);
        DriverInstance.setVariable(section+"_EstimatedPay_Qty",Actual_Qty);
        DriverInstance.setVariable(section+"_EstimatedPay_Comment",Actual_Comment);
        DriverInstance.setVariable(section+"_EstimatedPay_Estimated_Pay_Amount",Actual_Estimated_Pay_Amount);

        if(!Load_leg.equalsIgnoreCase("NA"))
        {
           webDriver.Partialstringcomparator(Actual_LoadLeg,Load_leg);
        }
        if(!TierRule.equalsIgnoreCase("NA"))
        {
            String Actual_TierRule= webDriver.getText(webDriver.getwebelement(pageObject.getlocator("EstimatePayCalculationTier").replace("{RecordNum}",recordnum).replace("{paramlink}", section).replace("{paramlink2}",TierRule)));
            DriverInstance.setVariable(section+"_EstimatedPay_TierRule",Actual_TierRule);
            webDriver.Partialstringcomparator(Actual_TierRule,TierRule);
        }
        if(!Type.equalsIgnoreCase("NA"))
        {
            webDriver.Partialstringcomparator(Actual_Type,Type);
        }
        if(!Rate.equalsIgnoreCase("NA"))
        {
            webDriver.Partialstringcomparator(Actual_Rate,Rate);
        }
        if(!Qty.equalsIgnoreCase("NA"))
        {
            webDriver.Partialstringcomparator(Actual_Qty,Qty);
        }
        if(!Comment.equalsIgnoreCase("NA"))
        {
            webDriver.Partialstringcomparator( Actual_Comment,Comment);
        }
        if(!Estimated_Pay_Amount.equalsIgnoreCase("NA"))
        {
            webDriver.Partialstringcomparator(Actual_Estimated_Pay_Amount,Estimated_Pay_Amount);
        }

    }
    @Then("Verify Text not displaying as {string} under Pay Estimate Details")
    public void verifyMessageAreNotDisplayingAs(String arg0) throws DocumentException, InterruptedException {
        if (arg0.contains("SysData")) {
            String Value = arg0.split("=>")[1];
            webDriver.verifyElementNotToBePresent(pageObject.getlocator("VerifyEstimatedPaySection").replace("{paramlink}", Value));
        }
        else {
            webDriver.verifyElementNotToBePresent(pageObject.getlocator("VerifyEstimatedPaySection").replace("{paramlink}", arg0));
        }
    }

    @Then("Click Estimated Pay button with Title {string} in Section {string}")
    public void clickEstimatedPayButtonWithTitle(String title, String section) throws Exception {

        String xpath = pageObject.getlocator("EstimatedPaySaveButton")
                .replace("{paramlink1}", section)
                .replace("{paramlink2}", title);

        System.out.println("Section = " + section);
        System.out.println("Title = " + title);
        System.out.println("XPath = " + xpath);

        WebElement element = webDriver.getwebelement(xpath);

        if (element == null) {
            throw new Exception(
                    "Estimated Pay button not found." +
                            "\nSection: " + section +
                            "\nTitle: " + title +
                            "\nXPath: " + xpath);
        }

        System.out.println("Estimated Pay Save button found.");

        webDriver.ScrollIntoView(element);
        webDriver.WaitforElementtobeclickable(xpath);
        webDriver.ClickOnElement(element);
    }

    @Then("Verify if the time difference of {string} and {string} is within {string}")
    public void verifyTimeDifferenceWithin(String beforeTimeVariable, String afterTimeVariable, String allowedMinutes) {
        String beforeTime = DriverInstance.getVariable(beforeTimeVariable);
        String afterTime = DriverInstance.getVariable(afterTimeVariable);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy, h:mm:ss a");
        LocalDateTime beforeDateTime = LocalDateTime.parse(beforeTime, formatter);
        LocalDateTime afterDateTime = LocalDateTime.parse(afterTime, formatter);
        long differenceInSeconds = Duration.between(beforeDateTime, afterDateTime).getSeconds();
        long allowedSeconds = Long.parseLong(allowedMinutes) * 60;
        System.out.println("Before Execute : " + beforeTime);
        System.out.println("After Execute  : " + afterTime);
        System.out.println("Time Difference: " + differenceInSeconds + " seconds");
        System.out.println("Allowed Time   : " + allowedMinutes + " minutes");
        Assert.assertTrue(differenceInSeconds <= allowedSeconds, "Time difference exceeded " + allowedMinutes + " minutes. " + "Actual difference: " + differenceInSeconds + " seconds");
    }

@Then("Verify if the time difference of stored {string} and {string} is within {string}")
public void verifyTimeDifferenceStoredWithin(String beforeTimeVariable, String afterTimeVariable, String allowedMinutes) {
    String beforeTime = DriverInstance.getVariable(beforeTimeVariable);
    String afterTime = DriverInstance.getVariable(afterTimeVariable);
    DateTimeFormatter localFormatter = new DateTimeFormatterBuilder().parseCaseInsensitive().appendPattern("M/d/yyyy, h:mm a").toFormatter(Locale.ENGLISH);
    DateTimeFormatter zonedFormatter = new DateTimeFormatterBuilder().parseCaseInsensitive().appendPattern("M/d/yyyy, hh:mm a O").toFormatter(Locale.ENGLISH);
    ZoneId testZone = ZoneId.of("Asia/Kolkata");
    ZonedDateTime beforeDateTime;
    ZonedDateTime afterDateTime;
    if (beforeTime.toUpperCase(Locale.ENGLISH).contains("GMT")) {
        beforeDateTime = ZonedDateTime.parse(beforeTime, zonedFormatter);
    } else {
        beforeDateTime = LocalDateTime.parse(beforeTime, localFormatter)
                .atZone(testZone);
    }
    if (afterTime.toUpperCase(Locale.ENGLISH).contains("GMT")) {
        afterDateTime = ZonedDateTime.parse(afterTime, zonedFormatter);
    } else {
        afterDateTime = LocalDateTime.parse(afterTime, localFormatter)
                .atZone(testZone);
    }
    long differenceInSeconds = Math.abs(Duration.between(beforeDateTime, afterDateTime).getSeconds());
    long allowedSeconds = Long.parseLong(allowedMinutes) * 60;

    System.out.println("Before Execute : " + beforeTime);
    System.out.println("After Execute  : " + afterTime);
    System.out.println("Time Difference: " + differenceInSeconds + " seconds");
    System.out.println("Allowed Time   : " + allowedMinutes + " minutes");

    Assert.assertTrue(differenceInSeconds <= allowedSeconds, "Time difference exceeded " + allowedMinutes + " minutes. Actual difference: " + differenceInSeconds + " seconds");
}

    @Then("Enter {string} with Label {string} -")
    public void EnterWithLabel(String value, String label) throws Exception {
        String xpath = xml.getlocator("SetupFieldsByLabel").replace("{paramlink}", label);
        webDriver.ScrollIntoView(webDriver.getwebelement(xpath));
        webDriver.waitforElementtobeclickable(xml.getlocator("SetupFieldsByLabel").replace("{paramlink}", label));
        webDriver.EnterTextUsingJS(webDriver.getwebelement(xpath), value);
    }

    @Then("Convert {string} {string} from timezone {string} into browser timezone and store on {string}")
    public void convertIntoBrowserTimezoneAndStoreOn(String day, String time, String sourceTimezone, String variableName) {

        if (time.contains("SysData")) {
            time = DriverInstance.getVariable(time.split("=>")[1]);
        }
        ZoneId sourceZone = ZoneId.of(sourceTimezone);
        ZoneId browserZone = ZoneId.systemDefault();
        System.out.println("Source timezone: " + sourceZone);
        System.out.println("Browser timezone: " + browserZone);
        LocalDate sourceDate = LocalDate.now(sourceZone).plusDays(Integer.parseInt(day));
//        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("h:mm a");
        DateTimeFormatter inputFormatter =DateTimeFormatter.ofPattern("h:mm a", Locale.ENGLISH);
        LocalTime localTime = LocalTime.parse(time, inputFormatter);
        ZonedDateTime sourceDateTime = ZonedDateTime.of(sourceDate, localTime, sourceZone);
        System.out.println("Source DateTime: " + sourceDateTime);
        ZonedDateTime browserDateTime = sourceDateTime.withZoneSameInstant(browserZone);
//        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("M/d/yyyy, h:mm a z");
        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("M/d/yyyy, hh:mm a z", Locale.ENGLISH);
//        String convertedTime = browserDateTime.format(outputFormatter);
        String convertedTime = browserDateTime.format(outputFormatter).toUpperCase(Locale.ENGLISH);
        if (convertedTime.contains(" IST")) {
            convertedTime = convertedTime.replace(" IST", "");
        }
        System.out.println("Converted Browser Time: " + convertedTime);
        DriverInstance.setVariable(variableName, convertedTime);
    }

    @Then("Verify PayIQ Admin log Type column {string} {string}")
    public void verifyPayIQAdminLogTypeColumn(String condition, String expectedValue) throws DocumentException, InterruptedException {
        String xpath;
        if (condition.equalsIgnoreCase("has")) {
            xpath = pageObject.getlocator("AdminLogTypeHas").replace("{paramlink1}", expectedValue);
            WebElement element = webDriver.passwebelement(xpath);
            Assert.assertNull(element, "Type column does not contain '" + expectedValue + "'");
        }
        else if (condition.equalsIgnoreCase("does not have")) {
            xpath = pageObject.getlocator("AdminLogTypeNotHas").replace("{paramlink1}", expectedValue);
            WebElement element = webDriver.passwebelement(xpath);
            Assert.assertNull(element, "Type column contains '" + expectedValue + "'");
        } else {
            Assert.fail("Invalid condition: " + condition);
        }
    }

    @Then("Verify all values in the PayIQ Admin log Load column should be {string}")
    public void verifyAllValuesInThePayIQAdminLogLoadColumnShouldBe(String expectedValue) throws DocumentException, InterruptedException {
        if (expectedValue.contains("SysData")) {
            expectedValue = DriverInstance.getVariable(expectedValue.split("=>")[1]);
        }
        String xpath = pageObject.getlocator("AdminLogLoad").replace("{paramlink1}", expectedValue);
        WebElement element = webDriver.passwebelement(xpath);
        Assert.assertNull(element, "Load column contains a value other than '" + expectedValue + "'");
    }

    @Then("Verify all values in the PayIQ Admin log Driver log column should be {string}")
    public void verifyAllValuesInThePayIQAdminLogDriverLogColumnShouldBe(String expectedValue) throws DocumentException, InterruptedException {
        if (expectedValue.contains("SysData")) {
            expectedValue = DriverInstance.getVariable(expectedValue.split("=>")[1]);
        }
        String xpath = pageObject.getlocator("AdminLogDriverLog").replace("{paramlink1}", expectedValue);
        WebElement element = webDriver.passwebelement(xpath);
        Assert.assertNull(element, "Driver log column contains a value other than '" + expectedValue + "'");
    }

    @Then("Verify all values in the PayIQ Admin log Trip Plan Leg column should be {string}")
    public void verifyAllValuesInThePayIQAdminLogTripPlanLegColumnShouldBe(String expectedValue) throws DocumentException, InterruptedException {
        if (expectedValue.contains("SysData")) {
            expectedValue = DriverInstance.getVariable(expectedValue.split("=>")[1]);
        }
        String xpath = pageObject.getlocator("AdminLogTripPlanLeg").replace("{paramlink1}", expectedValue);
        WebElement element = webDriver.passwebelement(xpath);
        Assert.assertNull(element, "Trip plan column contains a value other than '" + expectedValue + "'");
    }

    @Then("Enter Label {string} as {string}")
    public void enterLabelText(String arg0, String arg1) throws Exception {
        if (arg1.contains("SysData")) {
            arg1 = DriverInstance.getVariable(arg1.split("=>")[1]);
        }
        webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("InputField").replace("{paramlink}", arg0)), arg1);
        webDriver.waitForElementLoad(1);
    }

    @Then("Verify Label {string} field is empty")
    public void verifyLabelFieldIsEmpty(String label) throws Exception {
        WebElement element = webDriver.getwebelement(xml.getlocator("InputField").replace("{paramlink}", label));
        String value = element.getAttribute("value");
        Assert.assertTrue(value == null || value.trim().isEmpty(), "Expected field '" + label + "' to be empty, but found: " + value);
    }

    @Then("Verify {string} tab is present")
    public void verifyTabIsPresent(String tabName) throws DocumentException, InterruptedException {
        WebElement tab = webDriver.getwebelement(pageObject.getlocator("AdminTabs").replace("{paramlink}", tabName));
        Assert.assertTrue(tab.isDisplayed(), "Tab '" + tabName + "' is not present");
    }

    @Then("Verify {string} column header is present")
    public void verifyColumnHeaderIsPresent(String columnName) throws Exception {
        String actualColumnName = columnName;
        int occurrence = 1;
        Matcher matcher = Pattern.compile("_(\\d+)$").matcher(columnName);
        if (matcher.find()) {
            occurrence = Integer.parseInt(matcher.group(1));
            actualColumnName = columnName.substring(0, matcher.start());
        }
        String locator = pageObject.getlocator("TableColumnHeader").replace("{paramlink}", actualColumnName);
        List<WebElement> headers = webDriver.getWebElements(locator);
        Assert.assertTrue(headers.size() >= occurrence, "Column header '" + columnName + "' is not present. Expected occurrence " + occurrence + ", but found " + headers.size());
        WebElement header = headers.get(occurrence - 1);
        webDriver.ScrollIntoView(header);
        webDriver.waitUntilTheElementIsVisible(header);
        String actualText = header.getText().trim();
        Assert.assertEquals(actualText, actualColumnName, "Column header mismatch for '" + columnName + "'");
        System.out.println("Successfully verified: " + columnName);
    }

    @Then("Store the first Timestamp of PayIQ Admin log on {string}")
    public void storeTheFirstTimestampOfPayIQAdminLogOn(String variableName) throws DocumentException, InterruptedException {
        WebElement element = webDriver.getwebelement(pageObject.getlocator("AdminLogsFirstTimeStamp"));
        String value = element.getText().trim();
        DriverInstance.setVariable(variableName, value);
    }
    @Then("Verify date {string} falls between {string} and {string}")
    public void verifyDateFallsBetweenAnd(String dateToCheck, String startDate, String endDate) {

        if(dateToCheck.contains("SysData"))
        {
            dateToCheck= DriverInstance.getVariable(dateToCheck.split("=>")[1]);
        }
        if(startDate.contains("SysData"))
        {
            startDate= DriverInstance.getVariable(startDate.split("=>")[1]);
        }
        if(endDate.contains("SysData"))
        {
            endDate= DriverInstance.getVariable(endDate.split("=>")[1]);
        }
        boolean result = isDateBetween(dateToCheck, startDate, endDate);

        Assert.assertTrue(
                result,
                "Date " + dateToCheck + " does not fall between "
                        + startDate + " and " + endDate
        );
    }
    public static boolean isDateBetween(String dateToCheck, String startDate, String endDate) {

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("M/d/yyyy");

        LocalDate date = LocalDate.parse(dateToCheck, formatter);
        LocalDate start = LocalDate.parse(startDate, formatter);
        LocalDate end = LocalDate.parse(endDate, formatter);

        return !date.isBefore(start) && !date.isAfter(end);
    }

    @Then("Verify Type is {string}")
    public void verifyTypeIs(String expectedType)
            throws DocumentException, InterruptedException {

        if (expectedType.contains("SysData=>")) {
            expectedType = DriverInstance.getVariable(expectedType.split("=>")[1]);
        }

        String locator = pageObject.getlocator("AdminLogsType")
                .replace("{paramlink}", expectedType);

        System.out.println("Expected Type : " + expectedType);
        System.out.println("Locator       : " + locator);

        webDriver.waitUntilElementIsVisible(locator);

        String actualType = webDriver.passwebelement(locator).getText();

        System.out.println("Actual Type   : " + actualType);

        webDriver.verifyElementToBePresent(locator);
    }


    @Then("Verify Type is not {string}")
    public void verifyTypeIsNot(String expectedType)
            throws DocumentException, InterruptedException {

        if (expectedType.contains("SysData=>")) {
            expectedType = DriverInstance.getVariable(
                    expectedType.split("=>")[1]
            );
        }
        String locator = pageObject.getlocator("AdminLogsType")
                .replace("{paramlink}", expectedType);

        System.out.println("Expected Type should NOT be : " + expectedType);
        System.out.println("Locator                       : " + locator);
        try {
            boolean isPresent = webDriver.isElementPresent(locator);
            System.out.println("Type Present : " + isPresent);
            if (isPresent) {
                throw new AssertionError(
                        "FAIL: Unexpected Type '" + expectedType
                                + "' is present in the results."
                );
            }
            System.out.println(
                    "PASS: Type '" + expectedType
                            + "' is NOT present in the results."
            );
        } catch (org.openqa.selenium.NoSuchElementException e) {

            System.out.println(
                    "PASS: Type '" + expectedType
                            + "' is NOT present in the results."
            );
        }
    }

     @Then("Verify the Logs displaying as {string}")
    public void verifyLogsDisplayingAs(String arg0) throws DocumentException, InterruptedException {

        Pattern pattern = Pattern.compile("\\{([^}]*)\\}");
        Matcher matcher = pattern.matcher(arg0);

        while (matcher.find()) {
            arg0 = arg0.replace(
                    "{" + matcher.group(1) + "}",
                    DriverInstance.getVariable(matcher.group(1))
            );

            System.out.println(matcher.group(1));
            matcher = pattern.matcher(arg0);
        }

        System.out.println("Final Log Text: " + arg0);

        // Use your existing passwebelement() approach
        String locator = pageObject.getlocator("LogsDetailText");

        webDriver.ScrollIntoView(
                webDriver.passwebelement(locator)
        );

        webDriver.waitUntilElementIsVisible(locator);

        // Get actual log text
        String actualLogText = webDriver.getText(locator);

        System.out.println("Actual Log Text: " + actualLogText);

        /*
         * Find USD values.
         * Example:
         * 11,130.157 USD
         * 11,130.159 USD
         */
        Pattern usdPattern = Pattern.compile(
                "([\\d,]+\\.\\d+)\\s*USD"
        );

        /*
         * Replace only the USD amount.
         * Everything else remains unchanged and must match exactly.
         */
        String expectedText = usdPattern
                .matcher(arg0)
                .replaceAll("USD_VALUE");

        String actualText = usdPattern
                .matcher(actualLogText)
                .replaceAll("USD_VALUE");

        // Verify all non-USD text exactly
        if (!expectedText.equals(actualText)) {

            throw new AssertionError(
                    "Log text mismatch.\n" +
                            "Expected: " + arg0 +
                            "\nActual: " + actualLogText
            );
        }

        // Compare USD values
        Matcher expectedMatcher = usdPattern.matcher(arg0);
        Matcher actualMatcher = usdPattern.matcher(actualLogText);

        while (expectedMatcher.find() && actualMatcher.find()) {

            double expectedAmount = Double.parseDouble(
                    expectedMatcher.group(1).replace(",", "")
            );

            double actualAmount = Double.parseDouble(
                    actualMatcher.group(1).replace(",", "")
            );

            // Round both values to 2 decimal places
            expectedAmount = Math.round(expectedAmount * 100.0) / 100.0;
            actualAmount = Math.round(actualAmount * 100.0) / 100.0;

            System.out.println(
                    "Expected USD: " +
                            String.format("%,.2f", expectedAmount)
            );

            System.out.println(
                    "Actual USD: " +
                            String.format("%,.2f", actualAmount)
            );

            if (Double.compare(expectedAmount, actualAmount) != 0) {

                throw new AssertionError(
                        "USD value mismatch.\n" +
                                "Expected: " +
                                String.format("%,.2f USD", expectedAmount) +
                                "\nActual: " +
                                String.format("%,.2f USD", actualAmount)
                );
            }
        }

        System.out.println("Log verification passed.");
    }

 @Then("Store date {int} days after stored date {string} in format {string} into {string}")
    public void storeDateDaysAfterStoredDate(int daysToAdd, String storedDateVariable, String timeFormat, String outputVariable) {
        String storedDate;
        if (storedDateVariable.contains("SysData=>")) {
            storedDate = DriverInstance.getVariable(storedDateVariable.split("=>")[1]);
        } else {
            storedDate = DriverInstance.getVariable(storedDateVariable);
        }
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate date = LocalDate.parse(storedDate, inputFormatter);
        LocalDate newDate = date.plusDays(daysToAdd);
        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern(timeFormat, Locale.ENGLISH);
        DriverInstance.setVariable(outputVariable, newDate.format(outputFormatter));
        System.out.println("Original Date : " + storedDate);
        System.out.println("New Date      : " + newDate.format(outputFormatter));
    }

    @Then("Convert {string} in {string} format into {string}")
    public void convertDateFormat(String dateValue, String timeFormat, String outputVariable) {
        if (dateValue.contains("SysData=>"))
        {
            dateValue = DriverInstance.getVariable(dateValue.split("=>", 2)[1]);
        }
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd", Locale.ENGLISH);
        LocalDate date = LocalDate.parse(dateValue, inputFormatter);
        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern(timeFormat, Locale.ENGLISH);
        String formattedDate = date.format(outputFormatter);
        DriverInstance.setVariable(outputVariable, formattedDate);
        System.out.println("Original Date : " + dateValue);
        System.out.println("Converted Date: " + formattedDate);
    }
@Then("Set First date of month into {string} in format {string}")
    public void setFirstDateOfMonthInto(String arg0, String dateFormat) {
        ZoneId chicagoZone = ZoneId.of("America/Chicago");

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(dateFormat);

        String firstDateOfMonth = ZonedDateTime.now(chicagoZone)
                .toLocalDate()
                .withDayOfMonth(1)
                .format(formatter);

        DriverInstance.setVariable(arg0, firstDateOfMonth);
    }

    @Then("Set Last date of month into {string} in format {string}")
    public void setLastDateOfMonthInto(String variableName, String dateFormat) {
        ZoneId chicagoZone = ZoneId.of("America/Chicago");

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(dateFormat);

        String lastDateOfMonth = ZonedDateTime.now(chicagoZone)
                .toLocalDate()
                .with(TemporalAdjusters.lastDayOfMonth())
                .format(formatter);

        DriverInstance.setVariable(variableName, lastDateOfMonth);
    }
}



