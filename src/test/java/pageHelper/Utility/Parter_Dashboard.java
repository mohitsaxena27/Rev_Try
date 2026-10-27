package pageHelper.Utility;

import Listner.ToastContext;
import com.aventstack.extentreports.MediaEntityBuilder;
import com.aventstack.extentreports.Status;
import com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter;
import core.apiHelper;
import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import lombok.extern.log4j.Log4j;
import org.apache.commons.lang.StringUtils;
import org.dom4j.DocumentException;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.Keys;
import org.openqa.selenium.support.Color;
import org.testng.Assert;
import pageHelper.bddDriver;
import utils.*;
import utils.MailUtility.maiUtility;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@Log4j
public class Parter_Dashboard {
    public webHelper webDriver;
    public apiHelper apiDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader iframexml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    Common_Apis ca;

    public Parter_Dashboard(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        apiDriver = new baseDriverHelper(DriverInstance.getApiDriver(), DriverInstance.API_RESPONCE_THREAD_LOCAL.get());
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        pageObject = new xmlreader("Generics" + File.separator + "Partner_Dashboard.xml");
        iframexml = new xmlreader("Generics" + File.separator + "CommonFrame.xml");
        ca = new Common_Apis(DriverInstance);
    }

    //Login to Samsara
    @Then("Login to Samsara Account with UserName as {string} and Password as {string}")
    public void loginToSamsaraAccountWithUserNameAsAndPasswordAs(String arg0, String arg1) throws DocumentException, InterruptedException, IOException {
        if(arg0.contains("SysData"))
        {
            arg0= DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        if(arg1.contains("SysData"))
        {
            arg1= DriverInstance.getVariable(arg1.split("=>")[1]);

        }
        webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("EmailField")), arg0);
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("ContinueBtn")));
        webDriver.waitForElementLoad(4);
        webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("Password")), arg1);
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("SignInBtn")));
        webDriver.waitForElementLoad(5);
    }

    //Samsara - Matching Route
    @Then("Search Samsara routes for {string} and click the matching route")
    public void searchSamsaraRoutesForAndClickTheMatchingRoute(String routeNumber) throws Exception {
        String storedRouteKey = DriverInstance.getVariable(routeNumber);
        if (storedRouteKey != null && !storedRouteKey.isEmpty()) {
            String generatedRouteNumber = DriverInstance.getVariable(storedRouteKey);
            routeNumber = generatedRouteNumber != null && !generatedRouteNumber.isEmpty()
                    ? generatedRouteNumber
                    : storedRouteKey;
        }

        String searchLocator = pageObject.getlocator("SamsaraRoutesSearchInput");
        String resultLocator = pageObject.getlocator("SamsaraRouteNumberResult")
                .replace("{Paramlink}", routeNumber);

        webDriver.waitUntilElementIsVisible(searchLocator);
        webDriver.ClickOnElement(webDriver.passwebelement(searchLocator));
        webDriver.SendKeys(webDriver.passwebelement(searchLocator), routeNumber);
        webDriver.waitForElementLoad(3);
        webDriver.waitUntilElementIsVisible(resultLocator);
        webDriver.ScrollIntoView(webDriver.passwebelement(resultLocator));
        webDriver.safeJavaScriptClick(webDriver.passwebelement(resultLocator));
        webDriver.waitForElementLoad(3);
    }

    //Click on Samsara Routes
    @Then("Click Samsara route action {string} for location {string}")
    public void clickSamsaraRouteActionForLocation(String action, String location) throws Exception {
        String locator;
        if (action.equalsIgnoreCase("Scheduled")) {
            locator = pageObject.getlocator("SamsaraScheduledStart")
                    .replace("{Paramlink}", location);
        } else {
            locator = pageObject.getlocator("SamsaraEnRouteForLocation")
                    .replace("{Paramlink}", location);
        }

        webDriver.waitUntilElementIsVisible(locator);
        webDriver.ScrollIntoView(webDriver.passwebelement(locator));
        webDriver.safeJavaScriptClick(webDriver.passwebelement(locator));
        webDriver.waitForElementLoad(2);
    }

    //Click Samsara View Details
    @Then("Click Samsara {string} for location {string}")
    public void clickSamsaraViewDetailsForLocation(String action, String location) throws Exception {
        if (!action.equalsIgnoreCase("View details")) {
            throw new IllegalArgumentException("Unsupported Samsara action: " + action);
        }

        String locator = pageObject.getlocator("SamsaraViewDetailsForLocation")
                .replace("{Paramlink}", location);

        webDriver.waitUntilElementIsVisible(locator);
        Assert.assertEquals(webDriver.getwebelementscount(locator), 1,
                "Expected exactly one View details control for Samsara location '" + location + "'");
        webDriver.ScrollIntoView(webDriver.passwebelement(locator));
        webDriver.waitforElementtobeclickable(locator);
        webDriver.safeJavaScriptClick(webDriver.passwebelement(locator));
        webDriver.waitForElementLoad(2);
    }

    //Samsara Route Edit
    @Then("Click Samsara route {string}")
    public void clickSamsaraScheduleAction(String action) throws Exception {
        String locator;
        if (action.equalsIgnoreCase("Edit")) {
            locator = pageObject.getlocator("SamsaraScheduleEditButton");
        } else if (action.equalsIgnoreCase("Save")) {
            locator = pageObject.getlocator("SamsaraScheduleEditSaveButton");
        } else if (action.equalsIgnoreCase("Back")) {
            locator = pageObject.getlocator("SamsaraRouteBackButton");
        } else {
            throw new IllegalArgumentException("Unsupported Samsara schedule action: " + action);
        }

        webDriver.waitforElementtobeclickable(locator);
        webDriver.ScrollIntoView(webDriver.passwebelement(locator));
        if (action.equalsIgnoreCase("Edit")) {
            webDriver.ClickOnElement(webDriver.passwebelement(locator));
        } else {
            webDriver.safeJavaScriptClick(webDriver.passwebelement(locator));
        }

        if (action.equalsIgnoreCase("Edit")) {
            webDriver.waitUntilElementIsVisible(pageObject.getlocator("SamsaraActualArrivalDateTime"));
        } else if (action.equalsIgnoreCase("Back")) {
            webDriver.waitForElementLoad(2);
        }
    }
    //Actual Arrival Time
    @Then("Set Samsara actual arrival time to {string} hours before current time")
    public void setSamsaraActualArrivalTime(String hoursBeforeCurrentTime) throws Exception {
        enterSamsaraActualDateTime("SamsaraActualArrivalDateTime",
                Integer.parseInt(hoursBeforeCurrentTime));
    }
    //Actual Arrival Time
    @Then("Set Samsara actual departure time to {string} hours before current time")
    public void setSamsaraActualDepartureTime(String hoursBeforeCurrentTime) throws Exception {
        enterSamsaraActualDateTime("SamsaraActualDepartureDateTime",
                Integer.parseInt(hoursBeforeCurrentTime));
    }
    //Actual Arrival Time
    @Then("Set Samsara actual arrival time to {string} minutes before current time")
    public void setSamsaraActualArrivalTimeInMinutes(String minutesBeforeCurrentTime) throws Exception {
        enterSamsaraActualDateTimeInMinutes("SamsaraActualArrivalDateTime",
                Integer.parseInt(minutesBeforeCurrentTime));
    }
    //Actual Arrival Time
    @Then("Store Samsara displayed actual arrival as {string} and departure as {string}")
    public void storeSamsaraDisplayedActualTimes(String arrivalVariablePrefix,
                                                  String departureVariablePrefix) throws Exception {
        storeDisplayedActualTime("SamsaraDisplayedActualArrival", arrivalVariablePrefix);
        storeDisplayedActualTime("SamsaraDisplayedActualDeparture", departureVariablePrefix);
    }

    private void storeDisplayedActualTime(String locatorName, String variablePrefix) throws Exception {
        String locator = pageObject.getlocator(locatorName);
        webDriver.waitUntilElementIsVisible(locator);
        String displayed = webDriver.getText(webDriver.passwebelement(locator)).trim();
        // e.g. "Oct 9, 3:14 AM CDT" -> Chicago date/time in the TMS format
        String dateTimeText = displayed.replaceAll("\\s+[A-Z]{3,4}$", "").trim();
        int year = LocalDate.now(ZoneId.of("America/Chicago")).getYear();
        LocalDateTime value = LocalDateTime.parse(year + " " + dateTimeText,
                new java.time.format.DateTimeFormatterBuilder()
                        .parseCaseInsensitive()
                        .appendPattern("yyyy MMM d, h:mm a")
                        .toFormatter(Locale.ENGLISH));
        String statusDate = value.format(DateTimeFormatter.ofPattern("MM/dd/yyyy", Locale.ENGLISH));
        String statusTime = value.format(DateTimeFormatter.ofPattern("HH:mm", Locale.ENGLISH));
        String expectedDate = DriverInstance.getVariable(variablePrefix + "_Date");
        String expectedTime = DriverInstance.getVariable(variablePrefix + "_Time");
        System.out.println(variablePrefix + " Samsara displayed: " + displayed + " -> " + statusDate + " "
                + statusTime + " | entered (Chicago): " + expectedDate + " " + expectedTime);
        Assert.assertEquals(statusDate + " " + statusTime, expectedDate + " " + expectedTime,
                "Samsara displayed " + variablePrefix + " differs from the value entered");
        DriverInstance.setVariable(variablePrefix + "_Date", statusDate);
        DriverInstance.setVariable(variablePrefix + "_Time", statusTime);
        DriverInstance.setVariable(variablePrefix + "_Status_Date", statusDate);
        DriverInstance.setVariable(variablePrefix + "_Status_Time", statusTime);
    }

    //Wait for Samsara
    @Then("Wait for Samsara schedule edit modal to close")
    public void waitForSamsaraScheduleEditModalToClose() throws Exception {
        webDriver.waitForElementNotToBeVisible(pageObject.getlocator("SamsaraScheduleEditModal"));
    }

    private void enterSamsaraActualDateTime(String locatorName, int hoursBeforeCurrentTime) throws Exception {
        String locator = pageObject.getlocator(locatorName);
        LocalDateTime referenceTime = LocalDateTime.now(ZoneId.systemDefault());
        String dateTime = referenceTime
                .minusHours(hoursBeforeCurrentTime)
                .format(DateTimeFormatter.ofPattern("MM/dd/yyyy h:mm a", Locale.ENGLISH));

        enterSamsaraActualDateTime(locatorName, locator, dateTime);
    }

    private void enterSamsaraActualDateTimeInMinutes(String locatorName, int minutesBeforeCurrentTime) throws Exception {
        String locator = pageObject.getlocator(locatorName);
        LocalDateTime referenceTime = LocalDateTime.now(ZoneId.systemDefault());
        String dateTime = referenceTime
                .minusMinutes(minutesBeforeCurrentTime)
                .format(DateTimeFormatter.ofPattern("MM/dd/yyyy h:mm a", Locale.ENGLISH));

        enterSamsaraActualDateTime(locatorName, locator, dateTime);
    }

    private void enterSamsaraActualDateTime(String locatorName, String locator, String dateTime) throws Exception {
        webDriver.waitforElementtobeclickable(locator);
        String existingDisplayValue = webDriver.getText(webDriver.passwebelement(locator)).trim();
        System.out.println("Samsara " + locatorName + " value before update: "
                + existingDisplayValue);
        webDriver.safeJavaScriptClick(webDriver.passwebelement(locator));

        LocalDateTime target = LocalDateTime.parse(dateTime, new java.time.format.DateTimeFormatterBuilder()
                .parseCaseInsensitive().appendPattern("MM/dd/yyyy h:mm a").toFormatter(Locale.ENGLISH));
        WebElement dateInput = webDriver.getwebelements(pageObject.getlocator(locatorName + "Input")).stream()
                .filter(WebElement::isDisplayed)
                .findFirst()
                .orElseThrow(() -> new IllegalStateException(
                        "No active Samsara date input found for " + locatorName));
        dateInput.sendKeys(Keys.CONTROL, "a");
        String typedDateTime = target.format(DateTimeFormatter.ofPattern("MM/dd/yyyy hh:mm a", Locale.ENGLISH));
        dateInput.sendKeys(typedDateTime);
        webDriver.waitForElementLoad(1);
        System.out.println("Samsara " + locatorName + " typed: " + typedDateTime
                + " | input shows: " + dateInput.getAttribute("value"));
        WebElement field = webDriver.getwebelements(pageObject.getlocator("SamsaraTimeInput")).stream()
                .filter(WebElement::isDisplayed)
                .findFirst()
                .orElseThrow(() -> new IllegalStateException(
                        "No active Samsara time input found for " + locatorName));
        field.sendKeys(Keys.CONTROL, "a");
        field.sendKeys(target.format(DateTimeFormatter.ofPattern("hh:mm a", Locale.ENGLISH)));
        System.out.println("Samsara " + locatorName + " time box shows: " + field.getAttribute("value"));
        String applyLocator = pageObject.getlocator("SamsaraDateTimeApplyButton");
        WebElement applyButton = webDriver.getwebelements(applyLocator).stream()
                .filter(WebElement::isDisplayed)
                .filter(WebElement::isEnabled)
                .findFirst()
                .orElseThrow(() -> new IllegalStateException(
                        "No active Samsara Apply button found for " + locatorName));
        webDriver.safeJavaScriptClick(applyButton);
        webDriver.waitForElementLoad(1);
        String appliedDisplayValue = webDriver.getText(webDriver.passwebelement(locator)).trim();
        System.out.println("Samsara " + locatorName + " entered value: " + dateTime
                + " | value after Apply: " + appliedDisplayValue);
        Assert.assertFalse(appliedDisplayValue.isEmpty()
                        || appliedDisplayValue.toLowerCase(Locale.ENGLISH).startsWith("add actual"),
                "Samsara did not apply " + locatorName + " value");

        if (locatorName.equals("SamsaraActualArrivalDateTime")) {
            DriverInstance.setVariable("Samsara_Actual_Arrival_Time", dateTime);
            storeActualDateAndTime("Samsara_Actual_Arrival", dateTime);
        } else {
            DriverInstance.setVariable("Samsara_Actual_Departure_Time", dateTime);
            storeActualDateAndTime("Samsara_Actual_Departure", dateTime);
        }
    }

    private void storeActualDateAndTime(String variablePrefix, String dateTime) {
        DateTimeFormatter formatter = new java.time.format.DateTimeFormatterBuilder()
                .parseCaseInsensitive()
                .appendPattern("MM/dd/yyyy h:mm a")
                .toFormatter(Locale.ENGLISH);
        LocalDateTime value = LocalDateTime.parse(dateTime, formatter);
        ZonedDateTime chicagoValue = value.atZone(ZoneId.systemDefault())
                .withZoneSameInstant(ZoneId.of("America/Chicago"));
        String chicagoDate = chicagoValue.format(DateTimeFormatter.ofPattern("MM/dd/yyyy", Locale.ENGLISH));
        String chicagoTime = chicagoValue.format(DateTimeFormatter.ofPattern("HH:mm", Locale.ENGLISH));
        DriverInstance.setVariable(variablePrefix + "_Date", chicagoDate);
        DriverInstance.setVariable(variablePrefix + "_Time", chicagoTime);
        DriverInstance.setVariable(variablePrefix + "_Status_Date", chicagoDate);
        DriverInstance.setVariable(variablePrefix + "_Status_Time", chicagoTime);
    }

}