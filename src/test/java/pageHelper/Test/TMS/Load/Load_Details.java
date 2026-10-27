package pageHelper.Test.TMS.Load;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pageHelper.Test.FMS.Fleet_Trip_Event;
import pageHelper.Utility.Common_Steps;
import pageHelper.Utility.Common_Steps_Frame;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.io.IOException;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Log4j
public class Load_Details {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public xmlreader Generic;
    public Common_Steps cs;
    public Load_Summary ls;
    public Freight_Plan fp;
    public Common_Steps_Frame csf;
    public PropertyReader propertyReader = new PropertyReader();
    public Load_Details(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        Generic = new xmlreader("Generics" + File.separator + "Common.xml");
        pageObject=new xmlreader("TMS"+ File.separator+"Load"+File.separator+"Load_Details.xml");
    }


    @Then("Wait for {string} Field Value Update with {string}")
    public void waitForFieldValueUpdateWith(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("VerifyFieldValue").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
    }

    @Then("Set {string} on to {string}")
    public void setOnTo(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", arg0)));
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", arg0)));
        WebElement element = webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", arg0));
        String Text = element.getText();
        System.out.println("Man "+Text);
        DriverInstance.setVariable(arg1,Text.trim());
    }

    @Then("Compare and Set {string} on to {string}")
    public void CompareAndsetOnTo(String arg0, String arg1) throws DocumentException, InterruptedException {

        if(arg0.contains("Status")){
            String expCode = DriverInstance.getVariable(arg0);
            String expectedLoadStatus;

            switch (expCode.toUpperCase().trim()) {

                case "CREATED": expectedLoadStatus = "Assigned";
                               break;

                case "PENDING_PICKUP": expectedLoadStatus = "Dispatched";
                                       break;

                case "IN_TRANSIT", "OUT_FOR_DELIVERY", "EXCEPTION":expectedLoadStatus = "In Transit";
                    break;

                case "DELIVERED": expectedLoadStatus = "Delivered";
                                  break;

                case "VOID": expectedLoadStatus = "Cancelled";
                             break;

                default:throw new RuntimeException("Unsupported Shipment Code : " + expCode);
            }

            System.out.println("Shipment Code : " + expCode);
            System.out.println("Expected Load Status : " + expectedLoadStatus);
            System.out.println("UI Value : " + expectedLoadStatus);

            DriverInstance.setVariable(arg1, expectedLoadStatus);
        }
        else{
            webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", arg0)));
            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", arg0)));
            WebElement element = webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", arg0));
            String Text = element.getText();
            System.out.println("Man "+Text);
            DriverInstance.setVariable(arg1,Text.trim());
        }
    }

    @Then("Set {string} with Date {string} and Time {string}")
    public void setWithDateAndTime(String arg0, String arg1, String arg2) {
        String DateValue = webDriver.ReturnDate(arg1);
        String Time;
        if (arg2.contains("SysData")) {
            String Value = arg2.split("=>")[1];
            Time = DriverInstance.getVariable(Value);
        }
        else{
            Time =arg2;
        }
        DriverInstance.setVariable(arg0,DateValue+", "+Time);
    }


    @Then("Enter Last Reported City as {string}")
    public void enterLastReportedCityAs(String arg0) throws DocumentException, InterruptedException, IOException {
        webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("Last_Reported_City")), arg0.split(",")[0].trim());
        webDriver.waitForElementLoad(2);
        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("Global_Text").replace("{paramlink}",arg0)));
        webDriver.ClickOnElement(webDriver.passwebelement(Generic.getlocator("Global_Text").replace("{paramlink}",arg0)));
    }
    @Then("Set {string} with {string} Format and {string} Timezone")
    public void setWithDateAndTimeWithTimezone(String arg0, String arg1, String arg2) {
        String cstTime = ZonedDateTime.now(ZoneId.of(arg2))
                .format(DateTimeFormatter.ofPattern(arg1)).toUpperCase();
        System.out.println(cstTime);
        DriverInstance.setVariable(arg0,cstTime);
    }

    @Then("Click on {string} where {string}")
    public void selectLinkWhere(String arg0, String arg1) throws Exception {
            if(arg1.contains("SysData")) {
                arg1 = arg1.split("=>")[1];
                arg1 = DriverInstance.getVariable(arg1);
            }
            System.out.println("Posting is: "+pageObject.getlocator("LoadPostRecord").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0));
            webDriver.waitUntilElementIsVisible(pageObject.getlocator("LoadPostRecord").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0));
            webDriver.waitForElementLoad(1);
            webDriver.safeJavaScriptClick(webDriver.passwebelement(pageObject.getlocator("LoadPostRecord").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0)));
        }

    @Then("Verify expected result based on {string}")
    public void verifyExpectedResultWhenLoadStatusIs(String arg0) throws Exception {

        String codeStatus = DriverInstance.getVariable(arg0);
        System.out.println("Actual Load Status: " + codeStatus);

        switch (codeStatus.toUpperCase()) {

            case "CREATED":
            case "VOID":
                System.out.println("Load Status is " + codeStatus
                        + ". No further validation required.");
                break;

            case "PENDING_PICKUP":
                // Load Detail LWC > 1P > En Route
                validatePendingPickup();
                break;

            case "IN_TRANSIT":
                // Load Detail LWC > 1P > Departed
                // 2D > Stop Path Action
                validateInTransit();
                break;

            case "OUT_FOR_DELIVERY":
                // 1P > Stop Path Action
                // 2D > En Route Path
                validateOutForDelivery();
                break;

            case "DELIVERED":
                // 1P > Stop Path Action
                // 2D > Departed Path
                validateDelivered();
                break;

            case "EXCEPTION":
                // 1P > Stop Path Action
                // 2D > En Route Path
                validateException();
                break;

            default:
                throw new RuntimeException("Unsupported Load Status: " + codeStatus);
        }
    }
    private void validatePendingPickup() throws Exception {
        Common_Steps cs = new Common_Steps(DriverInstance);
        Load_Summary ls = new Load_Summary(DriverInstance);
        Fleet_Trip_Event fte  = new Fleet_Trip_Event(DriverInstance);
        cs.goToTab("Shipment");
        cs.waitForSeconds("2");
        ls.clickOnChevron("1P","En Route");
        System.out.println("PENDING_PICKUP_eventDateTime = ["
                + DriverInstance.getVariable("PENDING_PICKUP_eventDateTime") + "]");
        String ArrivalDate =DriverInstance.getVariable("PENDING_PICKUP_eventDateTime").split(" ")[0];
        System.out.println("ArrivalDate = [" + ArrivalDate + "]");
        String Date = LocalDate.parse(ArrivalDate)
                .format(DateTimeFormatter.ofPattern("MMM d, yyyy",Locale.ENGLISH));
        System.out.println("Formatted Date = [" + Date + "]");

        String ArrivalTime =DriverInstance.getVariable("PENDING_PICKUP_eventDateTime").split(" ")[1];

        String Time = ArrivalTime.substring(0, ArrivalTime.lastIndexOf(":"));
        System.out.println("Formatted Time = [" + Time + "]");

        fte.verifyLabelIsDisplayingWithValueOf("Carrier ETA Date",Date);
        fte.verifyLabelIsDisplayingWithValueOf("Carrier ETA Time",Time);
        cs.waitForSeconds("2");
        cs.goToTab("Details");
        cs.scrollIntoSection("Tracking Information");
        cs.verifyIsSetTo("Last Tracking Update Source","WWEX");
    }
    private void validateInTransit() throws Exception {
        cs.goToTab("Shipments");
        ls.clickOnChevron("1P", "Departed");
        String ArrivalDate =DriverInstance.getVariable("actual_StartTime").split(" ")[0];
        String ArrivalTime =DriverInstance.getVariable("actual_StartTime").split(" ")[1];

        LocalDate date = LocalDate.parse(ArrivalDate);
        String formattedDate = date.format(DateTimeFormatter.ofPattern("MMM d, yyyy"));

        ArrivalTime = ArrivalTime.substring(0, 5);
        cs.verifyIsSetTo("Arrival Date", formattedDate);
        cs.verifyIsSetTo("Arrival time", ArrivalTime);

        verifyStopDetailsForFieldWithValue("2P","Stop Status", "En Route");

        cs.goToTab("Details");
        csf.scrollIntoSection("Load Summary");
        cs.verifyIsSetTo("Last Reported Location",DriverInstance.getVariable("Region")+DriverInstance.getVariable("Locality")+DriverInstance.getVariable("CountryCode"));
        cs.verifyIsSetTo("Last Tracking Update",DriverInstance.getVariable("Event_DateAndTime"));
        csf.scrollIntoSection("Shipment IDs");
        cs.verifyIsSetTo("PRO Number",DriverInstance.getVariable("PRO Number"));
        csf.scrollIntoSection("Tracking Information");
        cs.verifyIsSetTo("Last Tracking Update Source","WWEX");
    }
    private void validateOutForDelivery() throws Exception {
        cs.goToTab("Shipments");
        ls.clickOnChevron("1P", "Departed");
        String ArrivalDate =DriverInstance.getVariable("actual_StartTime").split(" ")[0];
        String ArrivalTime =DriverInstance.getVariable("actual_StartTime").split(" ")[1];

        LocalDate date = LocalDate.parse(ArrivalDate);
        String formattedDate = date.format(DateTimeFormatter.ofPattern("MMM d, yyyy"));

        ArrivalTime = ArrivalTime.substring(0, 5);
        cs.verifyIsSetTo("Arrival Date", formattedDate);
        cs.verifyIsSetTo("Arrival time", ArrivalTime);

        verifyStopDetailsForFieldWithValue("2P","Stop Status", "En Route");

        cs.goToTab("Details");
        csf.scrollIntoSection("Load Summary");
        cs.verifyIsSetTo("Last Reported Location",DriverInstance.getVariable("Region")+DriverInstance.getVariable("Locality")+DriverInstance.getVariable("CountryCode"));
        cs.verifyIsSetTo("Last Tracking Update",DriverInstance.getVariable("Event_DateAndTime"));
        csf.scrollIntoSection("Shipment IDs");
        cs.verifyIsSetTo("PRO Number",DriverInstance.getVariable("PRO Number"));
        csf.scrollIntoSection("Tracking Information");
        cs.verifyIsSetTo("Last Tracking Update Source","WWEX");
    }
    private void validateDelivered() throws Exception {
        cs.goToTab("Shipments");
        ls.clickOnChevron("1P", "Departed");
        String DepDate =DriverInstance.getVariable("actual_StartTime").split(" ")[0];
        String DepTime =DriverInstance.getVariable("actual_StartTime").split(" ")[1];

        LocalDate date = LocalDate.parse(DepDate);
        String formattedDate = date.format(DateTimeFormatter.ofPattern("MMM d, yyyy"));

        DepTime = DepTime.substring(0, 5);
        cs.verifyIsSetTo("Arrival Date", formattedDate);
        cs.verifyIsSetTo("Arrival time", DepTime);
        verifyStopDetailsForFieldWithValue("2P","Stop Status", "En Route");

        cs.goToTab("Details");
        csf.scrollIntoSection("Load Summary");
        cs.verifyIsSetTo("Last Reported Location",DriverInstance.getVariable("Region")+DriverInstance.getVariable("Locality")+DriverInstance.getVariable("CountryCode"));
        cs.verifyIsSetTo("Last Tracking Update",DriverInstance.getVariable("Event_DateAndTime"));
        csf.scrollIntoSection("Shipment IDs");
        cs.verifyIsSetTo("PRO Number",DriverInstance.getVariable("PRO Number"));
        csf.scrollIntoSection("Tracking Information");
        cs.verifyIsSetTo("Last Tracking Update Source","WWEX");
    }
    private void validateException() throws Exception {
        cs.goToTab("Shipments");
        ls.clickOnChevron("1P", "Departed");
        String CarrierETADate =DriverInstance.getVariable("actual_StartTime").split(" ")[0];
        String CarrierETATime =DriverInstance.getVariable("actual_StartTime").split(" ")[1];

        LocalDate date = LocalDate.parse(CarrierETADate);
        String formattedDate = date.format(DateTimeFormatter.ofPattern("MMM d, yyyy"));

        CarrierETATime = CarrierETATime.substring(0, 5);
        cs.verifyIsSetTo("Carrier ETA Date", formattedDate);
        cs.verifyIsSetTo("Carrier ETA Time", CarrierETATime);

        verifyStopDetailsForFieldWithValue("2P","Stop Status", "En Route");

        cs.goToTab("Details");
        csf.scrollIntoSection("Load Summary");
        cs.verifyIsSetTo("Last Reported Location",DriverInstance.getVariable("Region")+DriverInstance.getVariable("Locality")+DriverInstance.getVariable("CountryCode"));
        cs.verifyIsSetTo("Last Tracking Update",DriverInstance.getVariable("Event_DateAndTime"));
        csf.scrollIntoSection("Shipment IDs");
        cs.verifyIsSetTo("PRO Number",DriverInstance.getVariable("PRO Number"));
        csf.scrollIntoSection("Tracking Information");
        cs.verifyIsSetTo("Last Tracking Update Source","WWEX");
    }

    @Then("Verify {string} Stop Details for field {string} with value {string}")
    public void verifyStopDetailsForFieldWithValue(String Stop, String fieldName, String expectedValue) throws InterruptedException, DocumentException, IOException {

        try {
            String locator = pageObject.getlocator("VerifyStopDetails")
                    .replace("{paramlink1}", Stop)
                    .replace("{paramlink2}", fieldName);

            webDriver.ScrollIntoView(webDriver.passwebelement(locator));
            webDriver.waitUntilElementIsVisible(locator);

            WebElement element = webDriver.passwebelement(locator);
            String actualText = element.getText().trim();

            System.out.println("Field: " + fieldName);
            System.out.println("Actual Value: " + actualText);
            System.out.println("Expected Value: " + expectedValue);

            validateStopFieldValue(fieldName, actualText, expectedValue);

        } catch (Exception e) {

            String locator = pageObject.getlocator("VerifyStopDetails")
                    .replace("{paramlink1}", Stop)
                    .replace("{paramlink2}", fieldName);

            webDriver.ScrollIntoView(webDriver.passwebelement(locator));

            WebElement element = webDriver.passwebelement(locator);
            String actualText = element.getText().trim();

            validateStopFieldValue(fieldName, actualText, expectedValue);
        }
    }
    private void validateStopFieldValue(String fieldName, String actualText, String expectedValue) throws IOException {

        if (Objects.nonNull(expectedValue) && !expectedValue.isEmpty()) {

            if (expectedValue.trim().equalsIgnoreCase("NA")) {

                Assert.assertEquals(actualText, "",
                        fieldName + ": Actual value is " + actualText + " But Expected as " + expectedValue);

            } else if (fieldName.contains("Date")
                    && !expectedValue.trim().contains("/")
                    && !expectedValue.contains("SysData")) {

                String expectedDate = webDriver.ReturnDate(expectedValue);

                Assert.assertEquals(actualText, expectedDate,
                        fieldName + ": Actual value is " + actualText + " But Expected as " + expectedDate);

            } else if (expectedValue.equalsIgnoreCase("SysData=>ContactEmail")) {

                String email = propertyReader.readproperty("EmailID");

                Assert.assertEquals(actualText, email,
                        fieldName + ": Actual value is " + actualText + " But Expected as " + email);

            } else if (expectedValue.contains("SysData")) {

                String variableName = expectedValue.split("=>")[1];
                String storedValue = DriverInstance.getVariable(variableName);

                Assert.assertTrue(actualText.contains(storedValue),
                        fieldName + ": Actual value is " + actualText + " But Expected as " + storedValue);

            } else {

                Assert.assertTrue(actualText.contains(expectedValue),
                        fieldName + ": Actual value is " + actualText + " But Expected as " + expectedValue);
            }

        } else {

            Assert.assertEquals(actualText, "",
                    fieldName + ": Actual value is " + actualText + " But Expected as blank");
        }
    }

    @Then("Wait until any one file is present in the Documents tab for {string} with a maximum wait of {int} minutes for push updates")
    public void waitUntilAnyOneFileIsPresentInTheDocumentsTabForWithAMaximumWaitOfMinutesForPushUpdatesThenWaitAndVerifyTheFilesPresentInTheDocumentTab(String arg0, int arg1) throws Exception {
      waitForExpectedDocument(arg0,Duration.ofMinutes(arg1));
    }

    public void waitForExpectedDocument(String Load, Duration timeout) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        cm.navigateStoredURL(Load);
        cm.goToTab("Documents");

        long refreshInterval = Duration.ofMinutes(3).toMillis();
        long endTime = System.currentTimeMillis() + timeout.toMillis();

        List<String> expectedFiles = Arrays.asList(
                "Weight & Inspection Certificate.PNG",
                "Delivery Receipt.PNG",
                "Bill of Lading.PNG",
                "Invoice.PNG"
        );

        while (System.currentTimeMillis() < endTime) {

            List<WebElement> displayedFiles = webDriver.getwebelements(pageObject.getlocator("GetFileNames"));
            boolean fileFound = displayedFiles.stream()
                    .map(WebElement::getText)
                    .anyMatch(expectedFiles::contains);

            if (fileFound) {
                return; // Success
            }

            try {
                Thread.sleep(refreshInterval);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                throw new RuntimeException("Interrupted while waiting for documents.", e);
            }

           webDriver.Refresh();
            cm.waitForSeconds("2");
            cm.goToTab("Documents");
        }

        Assert.fail("None of the expected documents were found within "
                + timeout.toMinutes() + " minutes. Expected one of: " + expectedFiles);
    }


    @Then("Delete {string} Stop from Load Details with reason {string}")
    public void deleteStopFromLoadLwcWithReason(String arg0, String arg1) throws DocumentException, InterruptedException {

        String deleteButtonXpath=pageObject.getlocator("StopsButtonGroup").replace("{paramlink1}",arg0).replace("{paramlink2}","Delete Stops");
        arg0= String.valueOf(arg0.charAt(0));
        String deleteReasonXpath=pageObject.getlocator("StopsRemoveReason").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1);
        WebElement deleteButton = webDriver.getwebelement(deleteButtonXpath);
        webDriver.ScrollIntoView(deleteButton);
        webDriver.waitForElementToBeClickable(deleteButton);
        webDriver.ClickOnElement(deleteButton);
        webDriver.waitForElementLoad(2);
        webDriver.waitUntilElementIsVisible(deleteReasonXpath);
        WebElement deleteReason = webDriver.getwebelement(deleteReasonXpath);
        webDriver.ScrollIntoView(deleteReason);
        webDriver.waitForElementToBeClickable(deleteReason);
        webDriver.ClickOnElement(deleteReason);
    }


    @Then("Select Delete Stops for {string} Stop under Load Details")
    public void selectDeleteStopsForStopUnderLoadDetails(String arg0) throws InterruptedException, DocumentException {
        String deleteButtonXpath=pageObject.getlocator("StopsButtonGroup").replace("{paramlink1}",arg0).replace("{paramlink2}","Delete Stops");
        WebElement deleteButton = webDriver.getwebelement(deleteButtonXpath);
        webDriver.ScrollIntoView(deleteButton);
        webDriver.waitForElementToBeClickable(deleteButton);
        webDriver.ClickOnElement(deleteButton);
        webDriver.waitForElementLoad(2);;
    }

    @Then("Get and Verify Delete Stops pop-up details")
    public void getAndVerifyDeleteStopsPopUpDetails(DataTable dataTable) throws DocumentException, InterruptedException {
        Map<String,Map<String,List<String>>> stopDetails=new HashMap<>();
        String reason1="Delete stop and associated line items";
        String reason2="Delete stop and move associated line items";

        String stopTextXpath = pageObject.getlocator("StopTexts");
        String stopLocationXpath = pageObject.getlocator("StopLocations");
        List<WebElement> stops = webDriver.getwebelements(stopTextXpath);
        List<WebElement> stopLocations = webDriver.getwebelements(stopLocationXpath);
        for (int i = 0; i < stops.size(); i++) {
            webDriver.ScrollToElement(stops.get(i));
            webDriver.waitForElementToBeClickable(stops.get(i));
            String stopName = webDriver.getText(stops.get(i));
            String stopLocation = webDriver.getText(stopLocations.get(i));
            String ReasonXpath1 = pageObject.getlocator("StopsRemoveReason").replace("{paramlink1}", stopName).replace("{paramlink2}", reason1);
            String ReasonXpath2 = pageObject.getlocator("StopsRemoveReason").replace("{paramlink1}", stopName).replace("{paramlink2}", reason2);
            List<String> reasons = Arrays.asList(ReasonXpath1, ReasonXpath2);
            Map<String, List<String>> stopLocationMap = new HashMap<>();
            stopLocationMap.put(stopLocation, reasons);
            stopDetails.put(stopName, stopLocationMap);
        }

        List<Map<String, String>> dataRows = dataTable.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                String expectedStopName = entry.getKey();
                String expectedStopLocation = entry.getValue();

                for (Map.Entry<String, Map<String, List<String>>> mapEntry : stopDetails.entrySet()) {
                    String actualStops = mapEntry.getKey();
                    Map<String, List<String>> values = mapEntry.getValue();
                    for (Map.Entry<String, List<String>> detailsLocationWithReason : values.entrySet()) {
                        String actualLocation = detailsLocationWithReason.getKey();
                        List<String> actualReasons = detailsLocationWithReason.getValue();
                        if (actualStops.equalsIgnoreCase(expectedStopName) && actualLocation.equalsIgnoreCase(expectedStopLocation)) {
                            Assert.assertTrue(actualReasons.contains(reason1) && actualReasons.contains(reason2));
                        }
                    }
                }
            }
        }
    }

    @Then("Verify Stop count is {string}")
    public void verifyStopCountIs(String arg0) throws DocumentException, InterruptedException {
        String iconXpath = pageObject.getlocator("ButtonIcon").replace("{paramlink}", "Delete Stops");
        List<WebElement> icons = webDriver.getwebelements(iconXpath);
        Assert.assertEquals(icons.size(), Integer.valueOf(arg0));
    }
}
