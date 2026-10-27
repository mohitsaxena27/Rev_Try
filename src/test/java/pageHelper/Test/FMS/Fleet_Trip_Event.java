package pageHelper.Test.FMS;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.ColorUtils;
import utils.PropertyReader;
import utils.TimeZone.TimeZoneUpdate;
import utils.xmlreader;

import java.io.File;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.stream.Collectors;

@Log4j
public class Fleet_Trip_Event {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader Generic;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    Common_Steps cs;

    public Fleet_Trip_Event(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("FMS" + File.separator + "Fleet_Trip_Event.xml");
        Generic = new xmlreader("Generics" + File.separator + "Common.xml");
        cs = new Common_Steps(DriverInstance);
    }

    @Then("Trip Event - Verify Icon {string} is displaying with background color {string}")
    public void tripEventVerifyIconIsDisplayingWithBackgroundColor(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("IconName").replace("{paramlink}", arg0));
        webDriver.verifyElementToBePresent(pageObject.getlocator("IconName").replace("{paramlink}", arg0));
        WebElement wl = webDriver.getwebelement(pageObject.getlocator("IconName").replace("{paramlink}", arg0));
        String imgbackgroundcolor = wl.getCssValue("background-color");
        String BGhex1 = org.openqa.selenium.support.Color.fromString(imgbackgroundcolor).asHex();
        java.awt.Color bgcolor1 = java.awt.Color.decode(BGhex1);
        System.out.println("Background Color is: " + bgcolor1);
        System.out.println("RGB: " + bgcolor1.getRed() + "," + bgcolor1.getGreen() + "," + bgcolor1.getBlue());
        String colorName1 = ColorUtils.getClosestColorName(
                bgcolor1.getRed(), bgcolor1.getGreen(), bgcolor1.getBlue());
        System.out.println("Color Name: " + colorName1);
        webDriver.Stringcomparator(colorName1, arg1);
    }

    @Then("Verify table headers on Revenova Modals")
    public void verifyTableHeadersOnRevenovaModals(DataTable dataTable) throws DocumentException, InterruptedException {
        List<String> expectedHeaders = dataTable.asList();

        List<WebElement> headerElements = webDriver.getWebElements(pageObject.getlocator("TableHeaderModal"));
        List<String> actualHeaders = headerElements.stream()
                .map(WebElement::getText)
                .map(String::trim)
                .collect(Collectors.toList());
        Assert.assertEquals(actualHeaders, expectedHeaders,
                "Table headers mismatch");
    }

    @Then("Trip Event : Verify Text displaying as {string}")
    public void verifyMessageAreDisplayingAs(String arg0) throws DocumentException, InterruptedException {

        if (arg0.contains("SysData")) {
            String Value = arg0.split("=>")[1];
            webDriver.waitUntilElementIsVisible(pageObject.getlocator("Global_Text").replace("{paramlink}", DriverInstance.getVariable(Value)));
            webDriver.verifyElementToBePresent(pageObject.getlocator("Global_Text").replace("{paramlink}", DriverInstance.getVariable(Value)));
        }
        else{
            webDriver.waitUntilElementIsVisible(pageObject.getlocator("Global_Text").replace("{paramlink}", arg0));
            webDriver.verifyElementToBePresent(pageObject.getlocator("Global_Text").replace("{paramlink}", arg0));
        }
    }

    @Then("Trip Event : Verify Text not displaying as {string}")
    public void verifyMessageAreNotDisplayingAs(String arg0) throws DocumentException, InterruptedException {

        if (arg0.contains("SysData")) {
            String Value = arg0.split("=>")[1];
            webDriver.verifyElementNotToBePresent(pageObject.getlocator("Global_Text").replace("{paramlink}", DriverInstance.getVariable(Value)));
        }
        else{
            webDriver.verifyElementNotToBePresent(pageObject.getlocator("Global_Text").replace("{paramlink}", arg0));
        }
    }

    @Then("Trip Event : Verify {string} Color with {string} Text of {string} Button is {string}")
    public void verifyColorWithTextOfButtonIs(String arg0, String arg1, String arg2, String arg3) throws DocumentException, InterruptedException {
        String Locators;
        if( arg2.charAt(arg2.length() - 2) == '_')
        {
            if (arg3.equalsIgnoreCase("disabled")) {
                Locators = "("+pageObject.getlocator("VerifyButton").replace("{paramlink1}", arg2.split("_")[0]).replace("{paramlink2}", "true")+")["+arg2.charAt(arg2.length() - 1)+"]";
            } else {
                Locators = "("+pageObject.getlocator("VerifyButton").replace("{paramlink1}", arg2.split("_")[0]).replace("{paramlink2}", "false")+")["+arg2.charAt(arg2.length() - 1)+"]";
            }
        }
        else {
            if (arg3.equalsIgnoreCase("disabled")) {
                Locators = pageObject.getlocator("VerifyButton").replace("{paramlink1}", arg2).replace("{paramlink2}", "true");
            } else {
                Locators = pageObject.getlocator("VerifyButton").replace("{paramlink1}", arg2).replace("{paramlink2}", "false");
            }
        }
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(Locators));
        webDriver.verifyElementToBePresent(Locators);
        System.out.println(Locators);
        WebElement wl = webDriver.getwebelement(Locators);
        String color = wl.getCssValue("color");
        String BGhex = org.openqa.selenium.support.Color.fromString(color).asHex();
        java.awt.Color bgcolor = java.awt.Color.decode(BGhex);
        System.out.println(" Color is: " + bgcolor);
        String colorName = ColorUtils.getClosestColorName(
                bgcolor.getRed(), bgcolor.getGreen(), bgcolor.getBlue());
        System.out.println("Color Name: " + colorName);
        webDriver.Stringcomparator(colorName, arg1);

        WebElement wl2 = webDriver.getwebelement(Locators + "/..");
        String imgbackgroundcolor = wl.getCssValue("background-color");
        String BGhex1 = org.openqa.selenium.support.Color.fromString(imgbackgroundcolor).asHex();
        java.awt.Color bgcolor1 = java.awt.Color.decode(BGhex1);
        System.out.println("Color is: " + bgcolor1);
        System.out.println("RGB: " + bgcolor1.getRed() + "," + bgcolor1.getGreen() + "," + bgcolor1.getBlue());
        String colorName1 = ColorUtils.getClosestColorName(
                bgcolor1.getRed(), bgcolor1.getGreen(), bgcolor1.getBlue());
        System.out.println("Color Name: " + colorName1);
        webDriver.Stringcomparator(colorName1, arg0);
    }

    @Then("Trip Event : Click on button with Title {string}")
    public void clickOnButtonWithTitle(String arg0) throws DocumentException, InterruptedException {
        try {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("WithTitle").replace("{paramlink}", arg0)));
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("WithTitle").replace("{paramlink}", arg0));
            webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("WithTitle").replace("{paramlink}", arg0)));
        }
        catch (Exception e1)
        {
            webDriver.waitForElementLoad(2);
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("WithTitle").replace("{paramlink}", arg0)));
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("WithTitle").replace("{paramlink}", arg0));
            webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("WithTitle").replace("{paramlink}", arg0)));

        }
    }

    @Then("Verify {string} row is added in Trip Events table with below details")
    public void verifyNewRowIsAddedInTripEventsTable(String rownum, DataTable dataTable) throws DocumentException, InterruptedException {

        List<Map<String, String>> expectedDataList = dataTable.asMaps(String.class, String.class);
        Map<String, String> expectedData = expectedDataList.get(0);

        // Fetch first row values from table
        List<WebElement> rowCells =webDriver.getwebelements(pageObject.getlocator("TripEventRecords").replace("{index}",rownum));

        List<String> actualValues = rowCells.stream()
                .map(e -> e.getText().trim())
                .collect(Collectors.toList());

        // Map actual table values
        Map<String, String> actualData = new LinkedHashMap<>();

        actualData.put("Name", actualValues.get(0));
        actualData.put("Trip Plan", actualValues.get(1));
        actualData.put("Trip Plan Segment", actualValues.get(2));
        actualData.put("Trip Plan Leg", actualValues.get(3));
        actualData.put("Type", actualValues.get(4));
        actualData.put("DateTime", actualValues.get(5));
        actualData.put("Event Detail", actualValues.get(6));
        actualData.put("Action Taken", actualValues.get(7));
        actualData.put("Addressed By", actualValues.get(8));
        actualData.put("Is Alert", actualValues.get(9));

        // Verify Name dynamic value
        Assert.assertTrue(
                actualData.get("Name").matches("Trip Event-\\d+"),
                "Invalid Name value: " + actualData.get("Name")
        );

        // Verify Trip Plan dynamic value
        String expectedTripPlan = expectedData.get("Trip Plan");

        if (expectedTripPlan.contains("SysData")) {
            expectedTripPlan = DriverInstance.getVariable(expectedTripPlan.split("=>")[1]);
        }

        Assert.assertEquals(actualData.get("Trip Plan"),
                expectedTripPlan,
                "Trip Plan mismatch");

        // Verify static values
        Assert.assertEquals(actualData.get("Trip Plan Segment"),
                expectedData.get("Trip Plan Segment"));

        Assert.assertEquals(actualData.get("Trip Plan Leg"),
                expectedData.get("Trip Plan Leg"));

        Assert.assertEquals(actualData.get("Type"),
                expectedData.get("Type"));


        Assert.assertEquals(actualData.get("Event Detail"),
                expectedData.get("Event Detail"));

        Assert.assertEquals(actualData.get("Is Alert").toLowerCase(),
                expectedData.get("Is Alert").toLowerCase());

        // Verify dynamic date (+3 days)
        if (expectedData.get("Date").contains("Date")) {
          String Date = webDriver.ReturnDateInSpecifiedFormat(expectedData.get("Date").split("=>")[1],"MM/dd/yyyy");
          String DateAndTime=Date+", "+expectedData.get("Time");

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy, hh:mm a",Locale.ENGLISH);
            DateTimeFormatter Expectedformatter = DateTimeFormatter.ofPattern("MM/dd/yyyy, hh:mm a",Locale.ENGLISH);

            System.out.println("Date = [" + Date + "]");
            System.out.println("Time = [" + expectedData.get("Time") + "]");
            System.out.println("DateAndTime = [" + DateAndTime + "]");
            System.out.println("DateAndTime length = " + DateAndTime.length());
           // Parse Chicago time
            LocalDateTime localDateTime = LocalDateTime.parse(DateAndTime, formatter);

            // Chicago timezone
            ZonedDateTime chicagoZdt = localDateTime.atZone(ZoneId.of("America/Chicago"));
            // Convert to current system timezone
            ZonedDateTime currentZoneTime = chicagoZdt.withZoneSameInstant(ZoneId.systemDefault());

            // Format output
            String convertedTime = currentZoneTime.format(Expectedformatter);
            System.out.println("Expected DateTime: [" + convertedTime + "]");
            System.out.println("Actual DateTime: [" + actualData.get("DateTime") + "]");
            System.out.println("Converted Time: " + convertedTime);
            Assert.assertEquals(actualData.get("DateTime"),
                    convertedTime,
                    "Date mismatch");
        }

        // Verify Null fields
        if ( Objects.nonNull(expectedData.get("Action Taken")) && !expectedData.get("Action Taken").isEmpty()) {
            Assert.assertEquals(actualData.get("Action Taken"),
                    expectedData.get("Action Taken"));
        }
        else {
            Assert.assertTrue(
                    actualData.get("Action Taken").isEmpty(),
                    "Action Taken should be blank"
            );
        }
        if ( Objects.nonNull(expectedData.get("Addressed By")) && !expectedData.get("Addressed By").isEmpty()) {
            Assert.assertEquals(actualData.get("Addressed By"),
                    expectedData.get("Addressed By"));
        }
        else {
            Assert.assertTrue(
                    actualData.get("Addressed By").isEmpty(),
                    "Addressed By should be blank"
            );
        }

        // Verify radio button unselected
        WebElement radioButton = webDriver.passwebelement(pageObject.getlocator("TripEventRecordCheckbox").replace("{index}",rownum));
        if(expectedData.get("SelectCheckbox").equalsIgnoreCase("False")) {
            Assert.assertFalse(
                    radioButton.isSelected(),
                    "Radio button should be unselected"
            );
        }
        else{
            Assert.assertTrue(
                    radioButton.isSelected(),
                    "Radio button should be unselected"
            );
        }

        System.out.println("Trip Events row verified successfully.");
    }

    @Then("Trip Event : Select Event Records With {string} as {string}")
    public void tripEventSelectEventRecordsWithAs(String arg0, String arg1) throws Exception {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("SelectTripEventWithType").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1)));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("SelectTripEventWithType").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1));
        webDriver.safeJavaScriptClick(webDriver.passwebelement(pageObject.getlocator("SelectTripEventWithType").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1)));


    }

    @Then("Verify chatter details")
    public void verifyChatterDetails(DataTable dataTable) throws DocumentException, InterruptedException {

        List<Map<String, String>> rows =
                dataTable.asMaps(String.class, String.class);

        for (Map<String, String> row : rows) {

            for (Map.Entry<String, String> entry : row.entrySet()) {

                String header = entry.getKey();
                String expectedValue = entry.getValue();

                if (expectedValue.contains("Date=>")) {
                    expectedValue =
                            webDriver.ReturnDate(expectedValue.split("=>")[1]);
                }

                WebElement element = webDriver.passwebelement(
                        pageObject.getlocator("ChatterDetails")
                                .replace("{paramlink1}", header)
                                .replace("{paramlink2}", expectedValue)
                );

                Assert.assertTrue(
                        element.isDisplayed(),
                        "Value '" + expectedValue
                                + "' is not displayed under header '"
                                + header + "'"
                );
            }
        }
    }

    @Then("Verify Trip Event count is {string} for {string}")
    public void verifyTripEventCountIsFor(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("TripEventOnFleetAsset").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0)));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("TripEventOnFleetAsset").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0));
        webDriver.verifyElementToBePresent(pageObject.getlocator("TripEventOnFleetAsset").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0));
    }

    @Then("Click on Trip Event for {string}")
    public void clickOnTripEventFor(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("TripEventWithFleetAsset").replace("{paramlink1}",arg0)));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("TripEventWithFleetAsset").replace("{paramlink1}",arg0));
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("TripEventWithFleetAsset").replace("{paramlink1}",arg0)));
    }

    @Then("Trip Plan - Status is highlighted {string}")
    public void tripPlanStatusIsHighlighted(String arg0) throws DocumentException, InterruptedException {
      WebElement el = webDriver.passwebelement(pageObject.getlocator("TripPlanBackgroundColor"));
        String imgbackgroundcolor=el.getCssValue("background-color");
        String BGhex1 = org.openqa.selenium.support.Color.fromString(imgbackgroundcolor).asHex();
        java.awt.Color bgcolor1 = java.awt.Color.decode(BGhex1);
        System.out.println("Background Color is: "+bgcolor1);
        System.out.println("RGB: " + bgcolor1.getRed() + "," + bgcolor1.getGreen() + "," + bgcolor1.getBlue());
        String colorName1 = ColorUtils.getClosestColorName(
                bgcolor1.getRed(), bgcolor1.getGreen(), bgcolor1.getBlue());
        System.out.println("Color Name: " + colorName1);
        webDriver.Stringcomparator(colorName1,arg0);
    }

    @Then("Trip Event : Verify Trip Event Count is {string}")
    public void tripEventVerifyTripEventCountIs(String arg0) throws DocumentException, InterruptedException {
        WebElement el = webDriver.passwebelement(pageObject.getlocator("TripEventTable"));
        String RecordCount = el.getDomAttribute("data-num-rows");
        webDriver.Stringcomparator(RecordCount,arg0);
    }

    @Then("Verify Label {string} is displaying with Value of {string}")
    public void verifyLabelIsDisplayingWithValueOf(String arg0, String arg1) throws DocumentException, InterruptedException {
        String ActualValue;
        WebElement el = webDriver.passwebelement(pageObject.getlocator("LabelInput").replace("{paramlink}",arg0));
         String Role=el.getDomAttribute("role");
         if("combobox".equalsIgnoreCase(Role))
         {
            ActualValue=el.getDomAttribute("data-value");
          }
         else{
            ActualValue=el.getAttribute("value");
         }
         if(arg1.contains("SysData"))
         {
             arg1=DriverInstance.getVariable(arg1.split("=>")[1]);
         }

         if(arg0.contains("Time")&&!arg0.contains("Carrier ETA Time"))
         {
             Assert.assertTrue(
                     isTimeWithinTolerance(ActualValue, arg1, 5),
                     "❌ Time mismatch beyond tolerance.\nExpected: "
                             + arg1 + "\nActual: " + ActualValue
             );
         }
         else {
             System.out.println("Label = [" + arg0 + "]");
             System.out.println("Expected before assert = [" + arg1 + "]");
             System.out.println("Actual before assert = [" + ActualValue + "]");

             Assert.assertEquals(ActualValue, arg1);
         }
    }

    @Then("Verify read-only label {string} is displaying with text value of {string}")
    public void verifyReadOnlyLabelIsDisplayingWithTextValueOf(String arg0, String arg1)
            throws DocumentException, InterruptedException {
        String locator = Generic.getlocator("Verify_Label_Text_Value2")
                .replace("{paramlink1}", arg0)
                .replace("{paramlink2}", arg1);
        if (webDriver.getwebelementscount(locator) == 0) {
            locator = Generic.getlocator("Verify_Label_Text_Value")
                    .replace("{paramlink1}", arg0)
                    .replace("{paramlink2}", arg1);
        }

        WebElement field = webDriver.passwebelement(locator);
        webDriver.ScrollIntoView(field);
        webDriver.waitUntilTheElementIsVisible(field);
        webDriver.verifyElementToBePresent(locator);
    }

    @Then("Verify Label {string} is displaying with button data Value as {string}")
    public void verifyLabelIsDisplayingWithdataValueOf(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("LabelButtonDataValue").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1));
        webDriver.verifyElementToBePresent(pageObject.getlocator("LabelButtonDataValue").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1));

    }

    public boolean isTimeWithinTolerance(String uiText,
                                         String expectedText,
                                         long toleranceSeconds) {

        DateTimeFormatter formatter =
                DateTimeFormatter.ofPattern("h:mm a",Locale.ENGLISH);

        LocalTime uiTime = LocalTime.parse(uiText.trim(), formatter);
        LocalTime expectedTime = LocalTime.parse(expectedText.trim(), formatter);

        long diff = Math.abs(
                ChronoUnit.MINUTES.between(expectedTime, uiTime)
        );

        return diff <= toleranceSeconds;
    }

    @Then("Verify {string} is displaying before {string}")
    public void verifyIsDisplayingBefore(String arg0, String arg1) throws DocumentException, InterruptedException {
     webDriver.waitUntilElementIsVisible(pageObject.getlocator("VerifyTitlePlace").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0));
     webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyTitlePlace").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0));
    }
}
