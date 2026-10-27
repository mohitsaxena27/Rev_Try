package pageHelper.Test.FMS;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;
import org.testng.Assert;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Log4j
public class Fleet_Equipment {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader Generic;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    Common_Steps cs;
    public Fleet_Equipment(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("FMS" + File.separator + "Fleet_Equipment.xml");
        Generic = new xmlreader("Generics" + File.separator + "Common.xml");
        cs = new Common_Steps(DriverInstance);
    }
    @Then("Verify Map is Rendering")
    public void verifyMapIsRendering() throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("IframeMap")));
        webDriver.verifyElementToBePresent(pageObject.getlocator("IframeMap"));
    }
    @Then("Verify {string} button is displaying and {string}")
    public void verifyButtonIsDisplayingAnd(String arg0, String arg1) throws DocumentException, InterruptedException {

        if(arg1.equalsIgnoreCase("disabled"))
        {
            webDriver.verifyElementToBePresent(pageObject.getlocator("buttonTittle").replace("{paramlink}",arg0));
        }
        else{
            webDriver.verifyElementToBePresent(pageObject.getlocator("buttonTittle").replace("{paramlink}",arg0).replace(" and @disabled",""));
        }
    }

    @Then("Verify Header")
    public void verifyHeader(DataTable dt) throws DocumentException, InterruptedException {
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            for (Map.Entry<String, String> entry : details.entrySet()) {
                webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("VerifyHeader").replace("{paramlink}",entry.getValue())));
                webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyHeader").replace("{paramlink}",entry.getValue()));
            }
        }
    }
    @Then("Verify {string} Table having Records")
    public void verifyHeader1(String section, DataTable dt) throws DocumentException, InterruptedException {
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println(pageObject.getlocator("VerifyHeaderwithTab").replace("{Sections}",section).replace("{paramlink}",entry.getValue()));
                webDriver.waitUntilElementIsVisible(pageObject.getlocator("VerifyHeaderwithTab").replace("{Sections}",section).replace("{paramlink}",entry.getValue()));
                webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyHeaderwithTab").replace("{Sections}",section).replace("{paramlink}",entry.getValue()));
            }
        }
    }

    @Then("Verify {string} Table having Icon & Records")
    public void verifyHeaderIconRecords(String section, DataTable dt) throws DocumentException, InterruptedException {
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println(pageObject.getlocator("VerifyHeaderRecordsIcon").replace("{Sections}",section).replace("{paramlink}",entry.getValue()));
                webDriver.waitUntilElementIsVisible(pageObject.getlocator("VerifyHeaderRecordsIcon").replace("{Sections}",section).replace("{paramlink}",entry.getValue()));
                webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyHeaderRecordsIcon").replace("{Sections}",section).replace("{paramlink}",entry.getValue()));
            }
        }
    }
    @Then("Verify {string} Table not having Records")
    public void verifynotHeader1(String section, DataTable dt) throws DocumentException, InterruptedException {
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            for (Map.Entry<String, String> entry : details.entrySet()) {
                webDriver.verifyElementNotToBePresent(pageObject.getlocator("VerifyHeaderwithTab").replace("{Sections}",section).replace("{paramlink}",entry.getValue()));
            }
        }
    }
    @Then("Verify Table data")
    public void verifyTableData(DataTable dt) throws DocumentException, InterruptedException {
//        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
//        if (!dataRows.isEmpty()) {
//            Map<String, String> details = dataRows.get(0);
//            for (Map.Entry<String, String> entry : details.entrySet()) {
//                webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("VerifyTableData").replace("{paramlink1}",entry.getKey()).replace("{paramlink2}",entry.getValue())));
//                webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyTableData").replace("{paramlink1}",entry.getKey()).replace("{paramlink2}",entry.getValue()));
//            }
//        }
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        for (Map<String, String> details : dataRows) {
            for (Map.Entry<String, String> entry : details.entrySet()) {

                String locator = pageObject.getlocator("VerifyTableData")
                        .replace("{paramlink1}", entry.getKey())
                        .replace("{paramlink2}", entry.getValue());
                webDriver.ScrollIntoView(
                        webDriver.passwebelement(locator));
                webDriver.verifyElementToBePresent(locator);
            }
        }
    }

    @Then("Verify Carrier Equipment Types Table data")
    public void verifyCarrierEquipmentTableData(DataTable dt) throws DocumentException, InterruptedException {
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        for (Map<String, String> row : dataRows) {
            String Number = row.get("Number");
            String Equipment = row.get("Equipment_type");
            String Locator = pageObject.getlocator("VerifyEquipmentTableData").replace("{paramlink}",Number);
            webDriver.mouseOver(Locator);
            webDriver.waitForElementLoad(2);
            webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyEquipment").replace("{paramlink}",Equipment));
            webDriver.waitForElementLoad(1);
            webDriver.waitforElementtobeclickable(pageObject.getlocator("CloseModalIcon"));
            webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("CloseModalIcon")));
        }
    }

    @Then("Verify Table With Header")
    public void verifyTableWithData(DataTable dt) throws DocumentException, InterruptedException {
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            for (Map.Entry<String, String> entry : details.entrySet()) {
                if(entry.getValue().contains("SysData=>")) {
                    String value = DriverInstance.getVariable(entry.getValue().split("=>")[1]);
                    webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("VerifyTableDataContains").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", value)));
                    webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyTableDataContains").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", value));
                }
                else{
                    webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("VerifyTableDataContains").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                    webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyTableDataContains").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue()));

                }
                }
        }
    }


    @Then("Verify Table data for Log With Time")
    public void verifyTableDataLog(DataTable dt) throws DocumentException, InterruptedException {
        List<Map<String, String>> rows = dt.asMaps(String.class, String.class);
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("M/d/yyyy", Locale.ENGLISH);

        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("h:mm a");
        DateTimeFormatter finalFormatter = DateTimeFormatter.ofPattern("MM/dd/yyyy, h:mm a");

        for (Map<String, String> row : rows) {

            int daysAgo = Integer.parseInt(row.get("DaysAgo"));
            String startTimeStr = row.get("Start Time");
            String endTimeStr   = row.get("End Time");

            // Compute date
            LocalDate logDate = LocalDate.now(ZoneId.of("America/Chicago")).minusDays(daysAgo);

            // Convert time only (no date)
            LocalTime startTime = LocalTime.parse(startTimeStr, timeFormatter);
            LocalTime endTime   = LocalTime.parse(endTimeStr, timeFormatter);

            // WINTER MONTH ADJUSTMENT (Nov → March)
            ZoneId zone = ZoneId.of("America/Chicago");
            ZonedDateTime now = ZonedDateTime.now(zone);
            boolean isDST = zone.getRules().isDaylightSavings(now.toInstant());
            if (isDST) {
                //2026-03-11T06:15:00+00:00
                System.out.println("Currently CDT (Daylight Saving Time)");
                startTime = startTime.plusHours(1);
                endTime   = endTime.plusHours(1);
            }

            // Build final string for verification
            String expectedStart =  webDriver.ReturnDate("-3")+ ", " + startTime.format(timeFormatter);
            String expectedEnd   = logDate.format(dateFormatter) + ", " + endTime.format(timeFormatter);

            // Scroll & verify START TIME
            webDriver.ScrollIntoView(
                    webDriver.passwebelement(
                            pageObject.getlocator("VerifyTableData")
                                    .replace("{paramlink1}", "Start Time")
                                    .replace("{paramlink2}", expectedStart)
                    )
            );

            webDriver.verifyElementToBePresent(
                    pageObject.getlocator("VerifyTableData")
                            .replace("{paramlink1}", "Start Time")
                            .replace("{paramlink2}", expectedStart)
            );

            // Verify END TIME
            webDriver.verifyElementToBePresent(
                    pageObject.getlocator("VerifyTableData")
                            .replace("{paramlink1}", "End Time")
                            .replace("{paramlink2}", expectedEnd)
            );
        }
    }

    @Then("Verify Table data for Log With Date and Time")
    public void verifyTableDataLogWithDateTime(DataTable dt) throws DocumentException, InterruptedException {

        List<Map<String, String>> rows = dt.asMaps(String.class, String.class);

        // Date format coming from DataTable → Example: 1/1/2024 or 01/01/2024
        DateTimeFormatter inputDateFormatter  = DateTimeFormatter.ofPattern("M/d/yyyy", Locale.ENGLISH);

        DateTimeFormatter timeFormatter       = DateTimeFormatter.ofPattern("h:mm a", Locale.ENGLISH);
        DateTimeFormatter finalDateFormatter  = DateTimeFormatter.ofPattern("M/d/yyyy", Locale.ENGLISH);

        for (Map<String, String> row : rows) {

            String dateStr      = row.get("Date");        // <== new input column
            String startTimeStr = row.get("Start Time");
            String endTimeStr   = row.get("End Time");

            // Convert input date to LocalDate
            LocalDate logDate = LocalDate.parse(dateStr, inputDateFormatter);

            // Convert input time
            LocalTime startTime = LocalTime.parse(startTimeStr, timeFormatter);
            LocalTime endTime   = LocalTime.parse(endTimeStr, timeFormatter);

            // WINTER MONTH ADJUSTMENT (Nov → Mar)
            int month = logDate.getMonthValue();
            boolean isWinter = (month == 11 || month == 12 || month <= 3);

            if (isWinter) {
                startTime = startTime.plusHours(1);
                endTime   = endTime.plusHours(1);
            }
            // Build expected strings
            String expectedStart = logDate.format(finalDateFormatter) + ", " + startTime.format(timeFormatter);
            String expectedEnd   = logDate.format(finalDateFormatter) + ", " + endTime.format(timeFormatter);

            // Scroll & verify START TIME
            webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("VerifyTableData").replace("{paramlink1}", "Start Time").replace("{paramlink2}", expectedStart)));
            webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyTableData").replace("{paramlink1}", "Start Time").replace("{paramlink2}", expectedStart));

            // Verify END TIME
            webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyTableData").replace("{paramlink1}", "End Time").replace("{paramlink2}", expectedEnd));
        }
    }



    @Then("Select Records for {string} on Fleet Equipment Page")
    public void selectRecordsForOnFleetEqupmentPage(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("SelectRecords").replace("{paramlink}", arg0)));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("SelectRecords").replace("{paramlink}", arg0));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("SelectRecords").replace("{paramlink}", arg0)));

    }
    @Then("Select View Manager as {string}")
    public void selectViewManagerAs(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("ViewManagerInput").replace("{paramlink}", arg0)));
        WebElement wl =webDriver.passwebelement(pageObject.getlocator("ViewManagerInput").replace("{paramlink}", arg0));
        boolean flag = wl.isSelected();
        if(!flag) {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("SelectViewManager").replace("{paramlink}", arg0)));
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("SelectViewManager").replace("{paramlink}", arg0));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("SelectViewManager").replace("{paramlink}", arg0)));
        }
    }
    @Then("De-Select View Manager as {string}")
    public void De_SelectViewManagerAs(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("ViewManagerInput").replace("{paramlink}", arg0)));
        WebElement wl =webDriver.passwebelement(pageObject.getlocator("ViewManagerInput").replace("{paramlink}", arg0));
        boolean flag = wl.isSelected();
        if(flag) {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("SelectViewManager").replace("{paramlink}", arg0)));
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("SelectViewManager").replace("{paramlink}", arg0));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("SelectViewManager").replace("{paramlink}", arg0)));
        }
    }
    @Then("View Manager : Verify {string} is {string}")
    public void VerifyViewManagerChecked(String arg0, String arg1) throws Exception {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("ViewManagerInput").replace("{paramlink}", arg0)));
        WebElement wl =webDriver.passwebelement(pageObject.getlocator("ViewManagerInput").replace("{paramlink}", arg0));
        boolean flag = wl.isSelected();
        if(arg1.equalsIgnoreCase("Selected"))
        {
             Assert.assertTrue(flag,arg0+" is not selected on View Manager");
        }
        else{
            Assert.assertFalse(flag,arg0+" is selected on View Manager");

        }
    }
    @Then("Scroll into Section {string} for {string} on Fleet Console")
    public void scrollIntoSection(String arg0, String arg1) throws Exception{
        try {
            webDriver.ScrollIntoComplexView(Generic.getlocator("Global_Text").replace("{paramlink}", arg0));
        }
        catch (TimeoutException e)
        {
            Common_Steps cm = new Common_Steps(DriverInstance);
            cm.clickOnButtonWithTitle("View Manager");
            cm.waitForSeconds("2");
            selectViewManagerAs(arg1);
            cm.waitForSeconds("2");
            webDriver.ScrollIntoComplexView(Generic.getlocator("Global_Text").replace("{paramlink}", arg0));
        }
    }

    @Then("Verify details for all Enabled fields on Fleet Management Modal")
    public void verifyDetailsForAllEnabledFieldsOnFleetManagermentModal(DataTable dt) throws DocumentException, InterruptedException {
        validateServicesData1(dt,Boolean.TRUE,Boolean.FALSE);

    }

    public void validateServicesData1(DataTable dt, Boolean isenabled, Boolean Required) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {

                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                String fieldName = webDriver.passwebelement(pageObject.getlocator("LabelText").replace("{paramlink}", entry.getKey())).getAttribute("for");
                System.out.println(fieldName);
                WebElement element = webDriver.passwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
                webDriver.ScrollIntoView(element);
                String Tag = element.getTagName();

                String type = element.getAttribute("type");

                String role = element.getAttribute("role");

                if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {

                    String ActualText = webDriver.Getattribute(element, "value");
                    System.out.println("Actual Test:" + ActualText);
                    Boolean enabled = element.isEnabled();
                    Boolean readonly = Boolean.valueOf(webDriver.Getattribute(element, "readonly"));
                    System.out.println("Read only Value" + readonly);
                    System.out.println("Enable Value" + enabled);
                    System.out.println("Enable Value" + enabled);
                    Boolean actualSate = (enabled && !readonly);
                    Boolean RequiredElement = Boolean.valueOf(webDriver.Getattribute(element, "required"));
                    if (Required) {
                        Assert.assertEquals(RequiredElement, true);
                    }
                    Assert.assertEquals(actualSate, isenabled);
                    if (entry.getKey().contains("Date")) {
                        webDriver.Partialstringcomparator(ActualText, webDriver.ExpectedDate(entry.getValue()));
                    } else {
                        webDriver.Partialstringcomparator(ActualText, entry.getValue());
                    }
                } else if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && "combobox".equalsIgnoreCase(role)) {
                    String ActualText = webDriver.Getattribute(element, "data-value");
                    Boolean RequiredElement = Boolean.valueOf(webDriver.Getattribute(element, "required"));
                    if (Required) {
                        Assert.assertEquals(RequiredElement, true);
                    }
                    webDriver.Stringcomparator(ActualText, entry.getValue());
                } else if (Tag.equalsIgnoreCase("input") && "password".equalsIgnoreCase(type)) {
                    //   webDriver.SendKeys(element, DriverInstance.getThreadLocalMapValue(entry.getKey()));
//                    String ActualText = webDriver.getAttributeValueUsingJavascript(element);
                    String ActualText = webDriver.Getattribute(element, "value");
                    Assert.assertEquals(element.isEnabled(), isenabled);
                    String actualSize = "0";
                    String expectedSize = "0";
                    try {
                        actualSize = String.valueOf(ActualText.length());
                    } catch (NullPointerException e) {
                        actualSize = "0";
                    }

                    try {
                        expectedSize = String.valueOf(entry.getValue().length());
                    } catch (NullPointerException e) {
                        expectedSize = "0";
                    }
                    webDriver.Stringcomparator(actualSize, expectedSize);
//                    webDriver.Stringcomparator(ActualText, entry.getValue());
//                    Assert.assertNotNull(ActualText, "Password Fields has some value");

                    System.out.println("Current Fields:" + entry.getKey() + " is Encrypted as this is Password type Element");

                } else if (Tag.equalsIgnoreCase("input") && "checkbox".equalsIgnoreCase(type)) {
                    //    webDriver.SendKeys(element, DriverInstance.getThreadLocalMapValue(entry.getKey()));

                    boolean isChecked = "true".equalsIgnoreCase(element.getAttribute("aria-checked"));
                    System.out.println(isChecked + "" + new Date());
                    if (isChecked) {
                        System.out.println("Checkbox is checked");
                    } else {
                        System.out.println("Checkbox is unchecked");
                    }
//                    Assert.assertEquals(isChecked, Boolean.valueOf(entry.getValue()));
                    Boolean RequiredElement = Boolean.valueOf(webDriver.Getattribute(element, "required"));
                    if (Required) {
                        Assert.assertEquals(RequiredElement, true);
                    }
                } else if (Tag.equalsIgnoreCase("button") && "button".equalsIgnoreCase(type)) {
                    String ActualText = webDriver.Getattribute(element, "data-value");
                    Boolean RequiredElement = Boolean.valueOf(webDriver.Getattribute(element, "required"));
                    if (Required) {
                        Assert.assertEquals(RequiredElement, true);
                    }
                    webDriver.Partialstringcomparator(ActualText, entry.getValue());
                } else if (Tag.equalsIgnoreCase("select")) {
                    // Create a Select object
                    Select select = new Select(element);
                    String selectedText = select.getFirstSelectedOption().getText();
                    System.out.println("Selected Text: " + selectedText);
                    webDriver.Stringcomparator(selectedText, entry.getValue());
                }
            }
        }
    }

    @Then("Verify Static Field {string} value as {string}")
    public void verifyStaticFieldValueAs(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("VerifystaticValue").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
        webDriver.verifyElementToBePresent(pageObject.getlocator("VerifystaticValue").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1));
    }

    @Then("Select {string} as {string} on FMS")
    public void selectAsOnFMS(String arg0, String arg1) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("VerifyOption").replace("{paramlink}", arg0)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("VerifyOption").replace("{paramlink}", arg0)));
        String value=webDriver.Getattribute(webDriver.getwebelement(pageObject.getlocator("VerifyOption").replace("{paramlink}", arg0)),"title");
        if (!value.contains(arg1)) {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("MultiSelectContainer").replace("{paramlink}", arg0)));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("MultiSelectContainer").replace("{paramlink}", arg0)));
            webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("MultiSelectContainer").replace("{paramlink}", arg0)));
            webDriver.waitForElementLoad(1);
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("OptionSelect").replace("{paramlink}", arg1)));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("OptionSelect").replace("{paramlink}", arg1)));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("OptionSelect").replace("{paramlink}", arg1)));
            webDriver.waitForElementLoad(2);
            webDriver.verifyElementToBePresent(pageObject.getlocator("VerifySelected").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1));
        }
    }
    @Then("De-Select {string} as {string} on FMS")
    public void DeselectAsOnFMS(String arg0, String arg1) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("VerifyOption").replace("{paramlink}", arg0)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("VerifyOption").replace("{paramlink}", arg0)));
        String value=webDriver.Getattribute(webDriver.getwebelement(pageObject.getlocator("VerifyOption").replace("{paramlink}", arg0)),"title");
        System.out.println("Man"+value);
          if (value.contains(arg1)) {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("MultiSelectContainer").replace("{paramlink}", arg0)));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("MultiSelectContainer").replace("{paramlink}", arg0)));
            webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("MultiSelectContainer").replace("{paramlink}", arg0)));
            webDriver.waitForElementLoad(1);
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("OptionSelect").replace("{paramlink}", arg1)));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("OptionSelect").replace("{paramlink}", arg1)));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("OptionSelect").replace("{paramlink}", arg1)));
            webDriver.waitForElementLoad(1);
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("MultiSelectContainer").replace("{paramlink}", arg0)));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("MultiSelectContainer").replace("{paramlink}", arg0)));
            webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("MultiSelectContainer").replace("{paramlink}", arg0)));

          }
    }

    @Then("No {string}records are rendered in the section")
    public void noRecordsAreRenderedInTheSection(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyNoDataWithTable").replace("{paramlink}", arg0));
    }

    @Then("Fleet Equipment : Verify Records {string} Radio button not Selected")
    public void fleetEquipmentVerifyRecordsRadioButtonNotSelected(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("SelectRecords").replace("{paramlink}", arg0)));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("SelectRecords").replace("{paramlink}", arg0));
        WebElement wl = webDriver.getwebelement(pageObject.getlocator("SelectRecords").replace("{paramlink}", arg0));
        Assert.assertFalse(wl.isSelected(),arg0 + " is not selected");
    }

    @Then("Verify Button with Title {string} is disabled")
    public void verifyButtonWithTitleIsDisabled(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("DisabledTitle").replace("{paramlink}",arg0));
        webDriver.verifyElementToBePresent(pageObject.getlocator("DisabledTitle").replace("{paramlink}",arg0));
    }


}
