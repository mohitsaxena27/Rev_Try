package pageHelper.Test.PayIQ;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.TimeZone.DateRangeUtil;
import utils.xmlreader;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Log4j
public class PayIQ_Details {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    Common_Steps cs;

    public PayIQ_Details(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("PayIQ" + File.separator + "PayIQ_Details.xml");
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        cs = new Common_Steps(DriverInstance);
    }

    @Then("Verify Logs displaying as {string}")
    public void verifyLogsDisplayingAs(String arg0) throws DocumentException, InterruptedException {
        Pattern pattern = Pattern.compile("\\{([^}]*)\\}");
        Matcher matcher = pattern.matcher(arg0);
        while (matcher.find()) {
            arg0 = arg0.replace("{" + matcher.group(1) + "}", DriverInstance.getVariable(matcher.group(1)));
            System.out.println(matcher.group(1));
            matcher = pattern.matcher(arg0);
        }
        System.out.println("Final Log Text: " + arg0);
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("LogsDetail").replace("{paramlink}", arg0)));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("LogsDetail").replace("{paramlink}", arg0));
        webDriver.verifyElementToBePresent(pageObject.getlocator("LogsDetail").replace("{paramlink}", arg0));
    }

    @Then("Verify Logs Contains as {string}")
    public void verifyLogsConatinsAs(String arg0) throws DocumentException, InterruptedException {
        Pattern pattern = Pattern.compile("\\{([^}]*)\\}");
        Matcher matcher = pattern.matcher(arg0);
        while (matcher.find()) {
            arg0 = arg0.replace("{" + matcher.group(1) + "}", DriverInstance.getVariable(matcher.group(1)));
            System.out.println(matcher.group(1));
            matcher = pattern.matcher(arg0);
        }
        System.out.println("Final Log Text: " + arg0);
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("LogsDetailContains").replace("{paramlink}", arg0)));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("LogsDetailContains").replace("{paramlink}", arg0));
        webDriver.verifyElementToBePresent(pageObject.getlocator("LogsDetailContains").replace("{paramlink}", arg0));
    }

    @Then("Then Verify {string} is at least {string}")
    public void thenVerifyIsAtLeast(String arg0, String arg1) {
        String actualText = DriverInstance.getVariable(arg0);
        String currency;
        double expectedValue;
        if (arg1.startsWith("CAD")) {
            currency = "CAD";
            Matcher expectedMatcher = Pattern.compile("CAD\\s*([0-9]+(?:\\.[0-9]+)?)").matcher(arg1);
            Assert.assertTrue(expectedMatcher.find(), "Invalid expected CAD amount: " + arg1);
            expectedValue = Double.parseDouble(expectedMatcher.group(1));
        } else if (arg1.startsWith("USD")) {
            currency = "USD";
            Matcher expectedMatcher = Pattern.compile("USD\\s*([0-9]+(?:\\.[0-9]+)?)").matcher(arg1);
            Assert.assertTrue(expectedMatcher.find(), "Invalid expected USD amount: " + arg1);
            expectedValue = Double.parseDouble(expectedMatcher.group(1));
        } else {
            throw new AssertionError("Expected amount must start with CAD or USD.");
        }
        Matcher actualMatcher = Pattern.compile(currency + "\\s*([0-9]+(?:\\.[0-9]+)?)").matcher(actualText);
        Assert.assertTrue(actualMatcher.find(), currency + " amount not found in: " + actualText);
        double actualValue = Double.parseDouble(actualMatcher.group(1));
        Assert.assertTrue(actualValue >= expectedValue, "Expected " + currency + " value " + actualValue + " to be greater than or equal to " + expectedValue);
    }

    @Then("Verify {string} is within current month")
    public void verifyIsWithinCurrentMonth(String arg0) {
        String actualDateRange = DriverInstance.getVariable(arg0);
        LocalDate today = LocalDate.now();
        LocalDate firstDay = today.withDayOfMonth(1);
        LocalDate lastDay = today.withDayOfMonth(today.lengthOfMonth());
        String expectedDateRange = firstDay + " to " + lastDay;
        Assert.assertEquals(actualDateRange, expectedDateRange, "Expected date range: " + expectedDateRange + " but found: " + actualDateRange);
    }

    @Then("Verify the field value {string} has {string} decimal places")
    public void verifyTheFieldValueHasDecimalPlaces(String arg0, String arg1) {
        if (arg0.contains("SysData")) {
            arg0 = DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        Assert.assertNotNull(arg0, "Captured value is null");
        Pattern pattern = Pattern.compile("([\\d,]+(?:\\.\\d+)?)");
        Matcher matcher = pattern.matcher(arg0);
        Assert.assertTrue(matcher.find(), "No numeric value found in: " + arg0);
        String number = matcher.group(1).replace(",", "");
        int actualDecimalPlaces = 0;
        if (number.contains(".")) {
            actualDecimalPlaces = number.substring(number.indexOf('.') + 1).length();
        }
        int expectedDecimalPlaces = Integer.parseInt(arg1);
        Assert.assertEquals(actualDecimalPlaces, expectedDecimalPlaces, "Expected " + expectedDecimalPlaces + " decimal places but found " + actualDecimalPlaces + " in value: " + arg0);
    }

    @Then("Verify {string} is within a cent of {string}")
    public void verifyIsWithinACentOf(String arg0, String arg1) {
        if (arg0.contains("SysData")) {
            arg0 = DriverInstance.getVariable(arg0.split("=>")[1]);
        } else if (DriverInstance.getVariable(arg0) != null) {
            arg0 = DriverInstance.getVariable(arg0);
        }
        if (arg1.contains("SysData")) {
            arg1 = DriverInstance.getVariable(arg1.split("=>")[1]);
        } else if (DriverInstance.getVariable(arg1) != null) {
            arg1 = DriverInstance.getVariable(arg1);
        }
        Pattern pattern = Pattern.compile("([\\d,]+(?:\\.\\d+)?)");
        Matcher matcher = pattern.matcher(arg0);
        if (matcher.find()) {
            arg0 = matcher.group(1).replace(",", "");
        }
        matcher = pattern.matcher(arg1);
        if (matcher.find()) {
            arg1 = matcher.group(1).replace(",", "");
        }
        double value1 = Double.parseDouble(arg0);
        double value2 = Double.parseDouble(arg1);
        double difference = Math.abs(value1 - value2);
        Assert.assertTrue(difference <= 0.01, "Expected values to be within a cent, but found difference of " + difference + " (Value1: " + value1 + ", Value2: " + value2 + ")"
        );
    }

    @Then("Get {string} from {string} Segment mileage box and store into {string}")
    public void getFromSegmentMileageBoxAndStoreInto(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException {
        String value = webDriver.getText(webDriver.passwebelement(pageObject.getlocator("Unloaded").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
        DriverInstance.setVariable(arg2, value);
        System.out.println("Unloaded Value captured : " + value);
    }
    @Then("Get {string} from the {string} Segment mileage box and store into {string}")
    public void getFromSegmentMileageBoxAndStoreInto2(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException {
        String value = webDriver.getText(webDriver.passwebelement(pageObject.getlocator("Unloaded_1").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
        DriverInstance.setVariable(arg2, value);
        System.out.println("Unloaded Value captured : " + value);
    }

    @Then("extract the numeric value from {string} and store in {string}")
    public void extractTheNumericValueFromAndStoreIn(String arg0, String arg1) {
        if (arg0.contains("SysData")) {
            arg0 = DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        if (arg0 == null || arg0.trim().isEmpty()) {
            throw new RuntimeException("No value found for variable: " + arg0);
        }
  //      Matcher matcher = Pattern.compile("[\\d,]+(?:\\.\\d+)?").matcher(arg0);
        Matcher matcher = Pattern.compile("-?\\$?[\\d,]+(?:\\.\\d+)?").matcher(arg0);
        if (matcher.find()) {
            String numericValue = matcher.group();
            DriverInstance.setVariable(arg1, numericValue);
            System.out.println("Original Value : " + arg0);
            System.out.println("Extracted Value: " + numericValue);
        } else {
            throw new RuntimeException("No numeric value found in: " + arg0);
        }
    }

    @Then("Multiple {string} with {string} and store in {string} and {string}")
    public void multipleWithAndStoreInAnd(String arg0, String arg1, String arg2, String arg3) {
        if (arg0.contains("SysData")) {
            arg0 = DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        Pattern pattern = Pattern.compile("([\\d,]+(?:\\.\\d+)?)");
        Matcher matcher = pattern.matcher(arg0);
        if (matcher.find()) {
            arg0 = matcher.group(1).replace(",", "");
        }
        double value = Double.parseDouble(arg0);
        double multiplier = Double.parseDouble(arg1);
        double result = value * multiplier;
        String threeDecimalFormattedResult = String.format("%,.3f", Math.floor(result * 1000) / 1000);
        String twoDecimalFormattedResult = String.format("%,.2f", result);
        DriverInstance.setVariable(arg2, threeDecimalFormattedResult);
        DriverInstance.setVariable(arg3, twoDecimalFormattedResult);
        System.out.println("Stored full value " + arg2 + " = " + threeDecimalFormattedResult);
        System.out.println("Stored 2 decimal value " + arg3 + " = " + twoDecimalFormattedResult);
    }

    @Then("Click on {string} with {string} as {string} and {string} as {string} and {string} as {string} and {string} as {string}")
    public void clickOnWithAsAndAsAndAsAndAs(String arg0, String arg1, String arg2, String arg3, String arg4, String arg5, String arg6, String arg7, String arg8) throws DocumentException, InterruptedException {
        if (arg8.contains("SysData")) {
            arg8 = DriverInstance.getVariable(arg8.split("=>")[1]);
        }
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("ClickOnRecordsWithFour").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg3).replace("{paramlink4}", arg4).replace("{paramlink5}", arg5).replace("{paramlink6}", arg6).replace("{paramlink7}", arg7).replace("{paramlink8}", arg8).replace("{paramlink9}", arg0)));
        webDriver.waitforElementtobeclickable(pageObject.getlocator("ClickOnRecordsWithFour").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg3).replace("{paramlink4}", arg4).replace("{paramlink5}", arg5).replace("{paramlink6}", arg6).replace("{paramlink7}", arg7).replace("{paramlink8}", arg8).replace("{paramlink9}", arg0));
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("ClickOnRecordsWithFour").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg3).replace("{paramlink4}", arg4).replace("{paramlink5}", arg5).replace("{paramlink6}", arg6).replace("{paramlink7}", arg7).replace("{paramlink8}", arg8).replace("{paramlink9}", arg0)));
    }

    @Then("Verify table contains {string} records with {string} as {string} and {string} as {string} and {string} as {string}")
    public void verifyTableContainsRecordsWithAsAndAsAndAs(String expectedCount, String arg1, String arg2, String arg3, String arg4, String arg5, String arg6) throws DocumentException, InterruptedException {
        if (arg2.contains("SysData=>")) {
            arg2 = DriverInstance.getVariable(arg2.split("=>")[1]);
        }
        String locator = pageObject.getlocator("TableRecordsWithThree").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg3).replace("{paramlink4}", arg4).replace("{paramlink5}", arg5).replace("{paramlink6}", arg6);
        int actualCount = webDriver.getwebelementscount(locator);
        webDriver.Stringcomparator(String.valueOf(actualCount), expectedCount);
    }

    @Then("Verify table has {string} records with {string} as {string} and {string} as {string} and {string} as {string}")
    public void verifyTableHasRecordsWithAsAndAsAndAs(String expectedCount, String arg1, String arg2, String arg3, String arg4, String arg5, String arg6) throws DocumentException, InterruptedException {
        if (arg2.contains("SysData=>")) {
            arg2 = DriverInstance.getVariable(arg2.split("=>")[1]);
        }
        if (arg6.contains("SysData=>")) {
            arg6 = DriverInstance.getVariable(arg6.split("=>")[1]);
        }
        String locator = pageObject.getlocator("TableRecordsWithThree").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg3).replace("{paramlink4}", arg4).replace("{paramlink5}", arg5).replace("{paramlink6}", arg6);
        System.out.println(locator);
        int actualCount = webDriver.getwebelementscount(locator);
        webDriver.Stringcomparator(String.valueOf(actualCount), expectedCount);
    }

    @Then("Verify {string} Table Details")
    public void verifyTableWithDetails(String tableName, DataTable dataTable) throws Exception {

        List<Map<String, String>> expectedRows = dataTable.asMaps(String.class, String.class);
        pageHelper.Utility.TableVerifier tv = new pageHelper.Utility.TableVerifier(DriverInstance);
        tv.verifyTable(tableName, expectedRows);
    }

    @Then("Store date with offset {string} as {string}")
    public void storeDateWithOffsetAs(String offset, String variableName) {
        String date = webDriver.ReturnCurrentDateAndTime(offset, "M/d/yyyy");
        DriverInstance.setVariable(variableName, date);
    }


    @Then("Verify Expected Ship Date belongs to Date Range")
    public void verifyExpectedShipDateBelongsToDateRange() {

        String shipDate = DriverInstance.getVariable("ShipMonth");
        String dateRange = DriverInstance.getVariable("DateRange");

        boolean status = DateRangeUtil.isDateWithinRange(shipDate, dateRange);

        Assert.assertTrue(status,
                "Expected Ship Date '" + shipDate
                        + "' is not within Date Range '" + dateRange + "'");

        System.out.println("Ship Date : " + shipDate);
        System.out.println("Date Range : " + dateRange);
    }

    @Then("Verify Logs Contains as Details {string}")
    public void verifyLogsConatinsAsDetails(String arg0) throws DocumentException, InterruptedException {

        Pattern pattern = Pattern.compile("\\{([^}]*)\\}");
        Matcher matcher = pattern.matcher(arg0);
        while (matcher.find()) {
            String variable = matcher.group(1);
            arg0 = arg0.replace("{" + variable + "}", DriverInstance.getVariable(variable));
            matcher = pattern.matcher(arg0);
        }
        System.out.println("Final Log Text: " + arg0);
        String[] colonParts = arg0.split(":", 2);
        String plan = colonParts[0].trim();
         String[] logParts = colonParts[1].split("=");
        String xpath = pageObject.getlocator("LogsDetailContainsValue").replace("{paramlink1}", plan).replace("{paramlink2}", logParts[0].trim()).replace("{paramlink3}", logParts[1].trim()).replace("{paramlink4}", logParts[2].trim());
        webDriver.ScrollIntoView(webDriver.passwebelement(xpath));
        webDriver.waitUntilElementIsVisible(xpath);
        webDriver.verifyElementToBePresent(xpath);
    }
//    @Then("Store date {string} days and {string} {string} from current date in format {string} into {string}")
//    public void storeDateWithOffset(String days, String value, String unit, String format, String variableName) {
//        int dayOffset = Integer.parseInt(days);
//        int durationValue = Integer.parseInt(value);
//        LocalDate date = LocalDate.now().plusDays(dayOffset);
//        if (unit.equalsIgnoreCase("years")) {
//            date = date.plusYears(durationValue);
//        } else if (unit.equalsIgnoreCase("months")) {
//            date = date.plusMonths(durationValue);
//        } else if (!unit.equalsIgnoreCase("days")) {
//            throw new IllegalArgumentException("Invalid unit: " + unit + ". Use 'months', 'years' or 'days'.");
//        }
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(format, Locale.ENGLISH);
//        String formattedDate = date.format(formatter);
//        DriverInstance.setVariable(variableName, formattedDate);
//    }

    @Then("Store date {string} days and {string} {string} from current date in format {string} into {string}")
    public void storeDateWithOffset(
            String days,
            String value,
            String unit,
            String format,
            String variableName) {

        int dayOffset = Integer.parseInt(days);
        int durationValue = Integer.parseInt(value);

        // Get current date based on Chicago timezone
        LocalDate date = ZonedDateTime
                .now(ZoneId.of("America/Chicago"))
                .toLocalDate()
                .plusDays(dayOffset);

        if (unit.equalsIgnoreCase("years")) {
            date = date.plusYears(durationValue);
        } else if (unit.equalsIgnoreCase("months")) {
            date = date.plusMonths(durationValue);
        } else if (unit.equalsIgnoreCase("days")) {
            date = date.plusDays(durationValue);
        } else {
            throw new IllegalArgumentException(
                    "Invalid unit: " + unit +
                            ". Use 'months', 'years' or 'days'."
            );
        }

        DateTimeFormatter formatter =
                DateTimeFormatter.ofPattern(format, Locale.ENGLISH);

        String formattedDate = date.format(formatter);

        DriverInstance.setVariable(variableName, formattedDate);

        System.out.println("Chicago Current Date: " +
                ZonedDateTime.now(ZoneId.of("America/Chicago")).toLocalDate());

        System.out.println(variableName + " = " + formattedDate);
    }

    @Then("Verify Logs displaying as either {string} or {string}")
    public void verifyLogsDisplayingAsEither(String arg0, String arg1) throws DocumentException, InterruptedException {
        Pattern pattern = Pattern.compile("\\{([^}]*)\\}");
        Matcher matcher = pattern.matcher(arg0);
        while (matcher.find()) {
            arg0 = arg0.replace("{" + matcher.group(1) + "}", DriverInstance.getVariable(matcher.group(1)));
            matcher = pattern.matcher(arg0);
        }
        matcher = pattern.matcher(arg1);
        while (matcher.find()) {
            arg1 = arg1.replace("{" + matcher.group(1) + "}", DriverInstance.getVariable(matcher.group(1)));
            matcher = pattern.matcher(arg1);
        }
        System.out.println("Log Option 1: " + arg0);
        System.out.println("Log Option 2: " + arg1);

        String xpath1 = pageObject.getlocator("LogsDetail").replace("{paramlink}", arg0);
        if (webDriver.getwebelementscount(xpath1) > 0) {
            webDriver.ScrollIntoView(webDriver.passwebelement(xpath1));
            webDriver.waitUntilElementIsVisible(xpath1);
            webDriver.verifyElementToBePresent(xpath1);
            return;
        }
        String xpath2 = pageObject.getlocator("LogsDetail").replace("{paramlink}", arg1);

        if (webDriver.getwebelementscount(xpath2) > 0) {
            webDriver.ScrollIntoView(webDriver.passwebelement(xpath2));
            webDriver.waitUntilElementIsVisible(xpath2);
            webDriver.verifyElementToBePresent(xpath2);
            return;
        }
        throw new AssertionError("Neither expected log was displayed.\n" + "Expected either:\n1. " + arg0 + "\nOR\n2. " + arg1);
    }
}
