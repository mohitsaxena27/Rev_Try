package pageHelper.Test.PayIQ;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pageHelper.Utility.Common_Apis;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.Log;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Log4j
public class PayIQ_Loads {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    Common_Steps cs;

    public PayIQ_Loads(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("PayIQ" + File.separator + "PayIQ_Loads.xml");
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        cs = new Common_Steps(DriverInstance);
    }

    @Then("Verify table with {string} as {string} does not have {string} as {string}")
    public void verifyTableDoesNotHave(String arg1, String arg2, String arg3, String arg4) throws DocumentException, InterruptedException {
        if(arg2.contains("SysData"))
        {
            arg2= DriverInstance.getVariable(arg2.split("=>")[1]);
        }
        if(arg4.contains("SysData"))
        {
            arg4= DriverInstance.getVariable(arg4.split("=>")[1]);
        }
        String locator = pageObject.getlocator("ParticipantMatches").replace("{paramlink1}", arg1).replace("{paramlink2}", arg2).replace("{paramlink3}", arg3).replace("{paramlink4}", arg4);
        int count = webDriver.getwebelementscount(locator);
        Assert.assertEquals(count, 0, "Record found with " + arg3 + " as '" + arg4 + "' when it should not exist.");
    }

    @Then("Verify table has {string} records with {string} as {string}")
    public void verifyTableHasRecordsWithAs(String expectedCount, String columnName, String value) throws DocumentException, InterruptedException {
        if (value.contains("SysData")) {
            value = DriverInstance.getVariable(value.split("=>")[1]);
        }
        String locator = pageObject.getlocator("VerifyTableRecordsWithOneParam").replace("{paramlink1}", columnName).replace("{paramlink2}", value);
        int actualCount = webDriver.getwebelementscount(locator);
        System.out.println("Expected Count : " + expectedCount);
        System.out.println("Actual Count   : " + actualCount);
        Assert.assertEquals(actualCount, Integer.parseInt(expectedCount));
    }

//    @Then("Store date with month offset {int} and day {int} in format {string} into {string}")
//    public void storeDateWithMonthOffsetAndDayInFormatMMMDYyyyInto(int arg0, int arg1,String timeFormat, String arg2) {
//        DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern(timeFormat, Locale.ENGLISH);
//        LocalDate date = LocalDate.now().plusMonths(arg0).withDayOfMonth(arg1);
//        DriverInstance.setVariable(arg2, date.format(FORMATTER));
//    }
//    @Then("Store current date in format {string} into {string}")
//    public void storeCurrentDate(String format, String variable) {
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(format, Locale.ENGLISH);
//        DriverInstance.setVariable(variable, LocalDate.now().format(formatter));
//    }
//
//    @Then("Convert stored date {string} from MMM d, yyyy to yyyy-MM-dd and store into {string}")
//    public void convertStoredDateFromMMMDYyyyToYyyyMMDdAndStoreInto(String arg0, String arg1) {
//        String storedDate = DriverInstance.getVariable(arg0);
//        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("MMM d, yyyy", Locale.ENGLISH);
//        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
//        LocalDate date = LocalDate.parse(storedDate, inputFormatter);
//        DriverInstance.setVariable(arg1, date.format(outputFormatter));
//    }

    @Then("Store date with month offset {int} and day {int} in format {string} into {string}")
    public void storeDateWithMonthOffsetAndDayInFormatMMMDYyyyInto(
            int monthOffset,
            int day,
            String timeFormat,
            String variable) {

        DateTimeFormatter formatter =
                DateTimeFormatter.ofPattern(timeFormat, Locale.ENGLISH);

        LocalDate date = ZonedDateTime.now(ZoneId.of("America/Chicago"))
                .toLocalDate()
                .plusMonths(monthOffset)
                .withDayOfMonth(day);

        String result = date.format(formatter);

        DriverInstance.setVariable(variable, result);

        System.out.println("Chicago Date: " + date);
        System.out.println(variable + " = " + result);
    }


    @Then("Store current date in format {string} into {string}")
    public void storeCurrentDate(String format, String variable) {

        DateTimeFormatter formatter =
                DateTimeFormatter.ofPattern(format, Locale.ENGLISH);

        LocalDate chicagoDate =
                ZonedDateTime.now(ZoneId.of("America/Chicago")).toLocalDate();

        String result = chicagoDate.format(formatter);

        DriverInstance.setVariable(variable, result);

        System.out.println("Chicago Current Date: " + chicagoDate);
        System.out.println(variable + " = " + result);
    }


    @Then("Convert stored date {string} from MMM d, yyyy to yyyy-MM-dd and store into {string}")
    public void convertStoredDateFromMMMDYyyyToYyyyMMDdAndStoreInto(
            String sourceVariable,
            String targetVariable) {

        String storedDate = DriverInstance.getVariable(sourceVariable);

        DateTimeFormatter inputFormatter =
                DateTimeFormatter.ofPattern("MMM d, yyyy", Locale.ENGLISH);

        DateTimeFormatter outputFormatter =
                DateTimeFormatter.ofPattern("yyyy-MM-dd", Locale.ENGLISH);

        LocalDate date = LocalDate.parse(storedDate.trim(), inputFormatter);

        String result = date.format(outputFormatter);

        DriverInstance.setVariable(targetVariable, result);

        System.out.println("Input Date: " + storedDate);
        System.out.println(targetVariable + " = " + result);
    }

    @Then("Store date {string} days and {string} {string} from current date into {string}")
    public void storeDateDaysAndDurationFromCurrentDate(
            String days,
            String value,
            String unit,
            String variableName) {

        int dayOffset = Integer.parseInt(days);
        int durationValue = Integer.parseInt(value);

        // Get current date based on Chicago timezone
        ZoneId chicagoZone = ZoneId.of("America/Chicago");
        LocalDate date = ZonedDateTime.now(chicagoZone)
                .toLocalDate()
                .plusDays(dayOffset);

        if (unit.equalsIgnoreCase("years")) {
            date = date.plusYears(durationValue);
        } else if (unit.equalsIgnoreCase("months")) {
            date = date.plusMonths(durationValue);
        } else {
            throw new IllegalArgumentException(
                    "Invalid unit: " + unit + ". Use 'months' or 'years'.");
        }

        // Chicago/US date format: M/d/yyyy
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("M/d/yyyy");

        String formattedDate = date.format(formatter);

        DriverInstance.setVariable(variableName, formattedDate);

        System.out.println("Chicago Date: " + formattedDate);
        System.out.println(variableName + " = " + formattedDate);
    }

//    @Then("Capture month from date {string} and provide date {string} in format {string} and store into {string}")
//    public void captureMonthFromDateAndProvideDateInFormat(
//            String inputDate,
//            String day,
//            String outputFormat,
//            String key) {
//
//        if (inputDate.contains("SysData=>")) {
//            inputDate = DriverInstance.getVariable(inputDate.split("=>", 2)[1]);
//        }
//
//        inputDate = inputDate.trim();
//
//        DateTimeFormatter inputFormatter =
//                DateTimeFormatter.ofPattern("M/d/yyyy, h:mm a", Locale.ENGLISH);
//
//        LocalDateTime dateTime =
//                LocalDateTime.parse(inputDate, inputFormatter);
//
//        LocalDate resultDate = LocalDate.of(
//                dateTime.getYear(),
//                dateTime.getMonth(),
//                Integer.parseInt(day)
//        );
//
//        DateTimeFormatter outputFormatter =
//                DateTimeFormatter.ofPattern(outputFormat, Locale.ENGLISH);
//
//        String result = resultDate.format(outputFormatter);
//
//        System.out.println("Input Date: " + inputDate);
//        System.out.println("Output Date: " + result);
//
//        DriverInstance.setVariable(key, result);
//    }

    @Then("Capture month from date {string} and provide date {string} in format {string} and store into {string}")
    public void captureMonthFromDateAndProvideDateInFormat(
            String inputDate,
            String day,
            String outputFormat,
            String key) {

        if (inputDate.contains("SysData=>")) {
            inputDate = DriverInstance.getVariable(
                    inputDate.split("=>", 2)[1]
            );
        }

        inputDate = inputDate.trim();

        // Chicago timezone
        ZoneId chicagoZone = ZoneId.of("America/Chicago");

        // Input format: 9/16/2026, 5:30 PM
        DateTimeFormatter inputFormatter =
                DateTimeFormatter.ofPattern("M/d/yyyy, h:mm a", Locale.ENGLISH);

        LocalDateTime localDateTime =
                LocalDateTime.parse(inputDate, inputFormatter);

        // Treat the input date/time as Chicago local time
        ZonedDateTime chicagoDateTime =
                localDateTime.atZone(chicagoZone);

        LocalDate chicagoDate = chicagoDateTime.toLocalDate();

        // Keep the year and month from the Chicago date,
        // but replace the day with the provided day
        LocalDate resultDate = LocalDate.of(
                chicagoDate.getYear(),
                chicagoDate.getMonth(),
                Integer.parseInt(day)
        );

        DateTimeFormatter outputFormatter =
                DateTimeFormatter.ofPattern(outputFormat, Locale.ENGLISH);

        String result = resultDate.format(outputFormatter);

        System.out.println("Chicago Input Date: " + inputDate);
        System.out.println("Chicago Output Date: " + result);

        DriverInstance.setVariable(key, result);
    }



    @Then("Search and Select {string} Checkbox for the Value {string}")
    public void searchAndSelectCheckboxForTheValue(String arg0,String arg1) throws Exception {

        if (arg0.contains("SysData")) {
            arg0 = DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        if (arg1.contains("SysData")) {
            arg1 = DriverInstance.getVariable(arg1.split("=>")[1]);
        }

        String loadRowLocator = pageObject.getlocator("LoadRows").replace("{paramlink}", arg1);
        String deductibleCheckboxItem = pageObject.getlocator("Checkbox").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0);
        String editButtonLocator="./td//span[text()='"+arg0+"']/..//../..//../..//../../button[contains(@aria-labelledby,'edit')]";
        String deductibleCheckboxLocator="./td//lightning-icon[contains(@icon-name,'utility')]";
        webDriver.ScrollIntoView(webDriver.passwebelement(loadRowLocator));
        webDriver.waitforElementtobeclickable(loadRowLocator);
        WebElement loadRow = webDriver.passwebelement(loadRowLocator);
        webDriver.waitforElementtobeclickable(loadRowLocator);
        WebElement editButton = loadRow.findElement(By.xpath(editButtonLocator));
        webDriver.waitForElementToBeClickable(editButton);
        webDriver.Clickon(editButton);
        WebElement deductibleCheckBox = loadRow.findElement(By.xpath(deductibleCheckboxLocator));
        webDriver.waitForElementLoad(2);
        webDriver.waitForElementToBeClickable(deductibleCheckBox);
            webDriver.Clickon(webDriver.passwebelement(deductibleCheckboxItem));
            webDriver.waitForElementLoad(2);
            webDriver.waitForElementToBeClickable(loadRow);
            webDriver.Clickon(loadRow);
            Log.info("Deductible checkbox selected");

    }

    @Then("Verify ePayment Message displaying as {string}")
    public void verifyEPaymentMessageDisplayingAs(String arg0) throws DocumentException, InterruptedException {

        if(arg0.contains("SysData"))
        {
            arg0= DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        try {
            webDriver.waitUntilElementIsVisible(xml.getlocator("VerifyMessage").replace("{paramlink}", arg0));
            webDriver.verifyElementToBePresent(xml.getlocator("VerifyMessage").replace("{paramlink}", arg0));
            cs.closeToastMessage();
        } catch (Exception e) {
                cs.verifyErrorMessageArecontains("Read timed out");
        }
    }
}
