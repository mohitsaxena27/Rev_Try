package pageHelper.Test.TMS.Load;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pageHelper.Utility.CommonFunction;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.*;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Log4j
public class Load_Summary {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    Common_Steps cm;
    public PropertyReader propertyReader = new PropertyReader();
    public Load_Summary(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("TMS" + File.separator + "Load" + File.separator + "Load_Summary.xml");
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        cm = new Common_Steps(DriverInstance);
    }

    @Then("Expand {string} for {string} Load")
    public void expendForLoad(String arg0, String arg1) throws DocumentException, InterruptedException {
       webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("Expandsection").replace("{paramlink}", arg0).replace("index",arg1)));
       webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("Expandsection").replace("{paramlink}", arg0).replace("index",arg1)));
       webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("Expandsection").replace("{paramlink}", arg0).replace("index",arg1)));
       webDriver.waitForElementLoad(1);
    }

    @Then("Collapse {string} for {string} Load")
    public void CollapseForLoad(String arg0, String arg1) throws Exception {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("Expandsection").replace("{paramlink}", arg0).replace("index",arg1)));
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("Expandsection").replace("{paramlink}", arg0).replace("index",arg1)));
        webDriver.safeJavaScriptClick(webDriver.passwebelement(pageObject.getlocator("Expandsection").replace("{paramlink}", arg0).replace("index",arg1)));
        webDriver.waitForElementLoad(1);
    }

    @Then("Verify {string} data is created with following details")
    public void verifyDataIsCreatedWithFollowingDetails(String DiffText, DataTable dt) throws DocumentException, InterruptedException {
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);

        if(DiffText.contains("SysData"))
        {
            DiffText= DriverInstance.getVariable(DiffText.split("=>")[1]);
        }
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                if(entry.getKey().contains("Date")||entry.getKey().contains("Status As Of")||entry.getKey().contains("Update Received At"))
                {
                    if(entry.getValue().contains("/"))
                    {
                        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("VerifyTable").replace("{paramlink}", DiffText).replace("{paramlink1}", entry.getValue())));
                        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("VerifyTable").replace("{paramlink}", DiffText).replace("{paramlink1}", entry.getValue())));
                        webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyTable").replace("{paramlink}", DiffText).replace("{paramlink1}", entry.getValue()));
                    }
                    else if(entry.getValue().contains("SysData")) {
                        String Value = DriverInstance.getVariable(entry.getValue().split("=>")[1]);
                        System.out.println(Value);
                        String ActText;
                        if(entry.getKey().contains("Status As Of"))
                        {
                            System.out.println(pageObject.getlocator("LoadTrackinglogDetails").replace("{paramlink}", DiffText).replace("{index}", "1"));
                            ActText=webDriver.GetText(webDriver.passwebelement(pageObject.getlocator("LoadTrackinglogDetails").replace("{paramlink}", DiffText).replace("{index}", "1")));
                            System.out.println(ActText);
                        }
                        else{
                            ActText=webDriver.GetText(webDriver.passwebelement(pageObject.getlocator("LoadTrackinglogDetails").replace("{paramlink}", DiffText).replace("{index}", "2")));
                            System.out.println(ActText);
                        }
                        webDriver.ToleranceTime(ActText,Value,"M/d/yyyy, h:mm a");
                    }
                    else {
                        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("VerifyTable").replace("{paramlink}", DiffText).replace("{paramlink1}", webDriver.ReturnDate(entry.getValue()))));
                        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("VerifyTable").replace("{paramlink}", DiffText).replace("{paramlink1}", webDriver.ReturnDate(entry.getValue()))));
                        webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyTable").replace("{paramlink}", DiffText).replace("{paramlink1}", webDriver.ReturnDate(entry.getValue())));
                    }
                }

                else if(entry.getValue().contains("SysData"))
                {
                    String Value = entry.getValue().split("=>")[1];
                    webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("VerifyTable").replace("{paramlink}", DiffText).replace("{paramlink1}", DriverInstance.getVariable(Value))));
                    webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("VerifyTable").replace("{paramlink}", DiffText).replace("{paramlink1}", DriverInstance.getVariable(Value))));
                    webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyTable").replace("{paramlink}", DiffText).replace("{paramlink1}", webDriver.ReturnDate(Value)));
                }
                else if(entry.getValue().contains("NA"))
                {
                    webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("VerifyTable").replace("{paramlink}", DiffText).replace("{paramlink1}", "")));
                    webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("VerifyTable").replace("{paramlink}", DiffText).replace("{paramlink1}", "")));
                    webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyTable").replace("{paramlink}", DiffText).replace("{paramlink1}", ""));
                }
                else{
                    webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("VerifyTable").replace("{paramlink}", DiffText).replace("{paramlink1}", entry.getValue())));
                    webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("VerifyTable").replace("{paramlink}", DiffText).replace("{paramlink1}", entry.getValue())));
                    webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyTable").replace("{paramlink}", DiffText).replace("{paramlink1}", entry.getValue()));
                }

            }
        }
    }
    @Then("Verify Table details with Reference of {string} as {string}")
    public void verifyDataIsWithRef(String Label,String LabelValue, DataTable dt) throws DocumentException, InterruptedException {
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());

                if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                    if (entry.getValue().contains("SysData")) {
                        String Value = entry.getValue().split("=>")[1];
                        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("VerifyTableWithRef").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey()).replace("{paramlink4}", DriverInstance.getVariable(Value))));
                        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("VerifyTableWithRef").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey()).replace("{paramlink4}", DriverInstance.getVariable(Value))));
                        webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyTableWithRef").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey()).replace("{paramlink4}", DriverInstance.getVariable(Value)));
                    } else if (entry.getValue().contains("NA")) {
                        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("VerifyTableWithRef").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey()).replace("{paramlink4}", "")));
                        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("VerifyTableWithRef").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey()).replace("{paramlink4}", "")));
                        webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyTableWithRef").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey()).replace("{paramlink4}", ""));
                    }
                    else if (entry.getKey().equalsIgnoreCase("Available")) {
                        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("VerifyTableWithRef").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey()).replace("{paramlink4}", webDriver.ExpectedDate(entry.getValue()))));
                        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("VerifyTableWithRef").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey()).replace("{paramlink4}", webDriver.ExpectedDate(entry.getValue()))));
                        webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyTableWithRef").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey()).replace("{paramlink4}", webDriver.ExpectedDate(entry.getValue())));
                    }
                    else if (entry.getKey().equalsIgnoreCase("Age (min)")) {
                        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("GetAgeMinValue").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey())));
                        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("GetAgeMinValue").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey())));
                        String AgeMin= webDriver.getText(webDriver.passwebelement(pageObject.getlocator("GetAgeMinValue").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey())));
                        verifyAgeMinValue(AgeMin);
                    }
                    else if (entry.getKey().contains("_2")) {
                        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("VerifyTableWithRef").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey().replace("_2","")).replace("{paramlink4}", entry.getValue())));
                        webDriver.waitUntilElementIsVisible(pageObject.getlocator("VerifyTableWithRef").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey().replace("_2","")).replace("{paramlink4}", entry.getValue()));
                        webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyTableWithRef").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey().replace("_2","")).replace("{paramlink4}", entry.getValue()));

                    }

                    else {
                        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("VerifyTableWithRef").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey()).replace("{paramlink4}", entry.getValue())));
                        webDriver.waitUntilElementIsVisible(pageObject.getlocator("VerifyTableWithRef").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey()).replace("{paramlink4}", entry.getValue()));
                        webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyTableWithRef").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey()).replace("{paramlink4}", entry.getValue()));
                    }
                }
                else{
                    webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("VerifyTableWithRef").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey()).replace("{paramlink4}", "")));
                    webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("VerifyTableWithRef").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey()).replace("{paramlink4}", "")));
                    webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyTableWithRef").replace("{paramlink1}", Label).replace("{paramlink2}", LabelValue).replace("{paramlink3}", entry.getKey()).replace("{paramlink4}", ""));

                }

            }
        }
    }

    public void verifyAgeMinValue(String ActualTime) {

        ZoneId centralZone = ZoneId.of("America/Chicago");
        ZonedDateTime currentTime = ZonedDateTime.now(centralZone);

        // Determine if DST is active
        boolean isDST = centralZone.getRules().isDaylightSavings(currentTime.toInstant());

        // Reference time: 9 AM during DST, otherwise 8 AM
        LocalTime referenceTime = isDST ? LocalTime.of(9, 0) : LocalTime.of(8, 0);

        ZonedDateTime referenceDateTime = ZonedDateTime.of(
                LocalDate.now(centralZone),
                referenceTime,
                centralZone
        );
        long expectedAgeMin = Duration.between(referenceDateTime, currentTime).toMinutes();
        if (expectedAgeMin > 0) {
            System.out.println("Age is positive");
            Assert.assertTrue(Long.parseLong(ActualTime)>expectedAgeMin);
        } else if (expectedAgeMin < 0) {
            System.out.println("Age is negative");
            Assert.assertTrue(expectedAgeMin>Long.parseLong(ActualTime));
        }

    }


    @Then("Verify {string} Stop with {string}")
    public void verifyStopWith(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("VerifyTextWithStop").replace("{paramlink1}", arg0).replace("{paramlink2}",arg1)));
        webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyTextWithStop").replace("{paramlink1}", arg0).replace("{paramlink2}",arg1));

    }


    @Then("the Stop Detail table should have the following items:")
    public void theStopDetailTableShouldHaveTheFollowingItems(DataTable dt ) throws DocumentException, InterruptedException {
        List<Map<String, String>> expectedRows = dt.asMaps(String.class, String.class);

        for (Map<String, String> row : expectedRows) {
            String Sno = row.get("#");
            String itemNumber = row.get("Item Number");
            String cargoSummary = row.get("Cargo Summary");
            String pickupStop = row.get("Pickup Stop");
            String deliveryStop = row.get("Delivery Stop");

            // Verify Cargo Summary
            WebElement cargoElem = webDriver.getwebelement(pageObject.getlocator("VerifyItemDetails").replace("{paramlink1}",Sno).replace("{paramlink2}",itemNumber).replace("{index}","1"));
            Assert.assertTrue(cargoElem.getText().contains(cargoSummary));

            // Verify Pickup Stop
            WebElement pickupElem = webDriver.getwebelement(pageObject.getlocator("VerifyItemDetails").replace("{paramlink1}",Sno).replace("{paramlink2}",itemNumber).replace("{index}","2"));
            Assert.assertEquals(pickupElem.getText().trim(), pickupStop);

            // Verify Delivery Stop
            WebElement deliveryElem = webDriver.getwebelement(pageObject.getlocator("VerifyItemDetails").replace("{paramlink1}",Sno).replace("{paramlink2}",itemNumber).replace("{index}","3"));
            Assert.assertEquals(deliveryElem.getText().trim(), deliveryStop);
        }
    }

    @Then("The Item Detail table should have the following items:")
    public void theItemDetailTableShouldHaveTheFollowingItems(DataTable dt ) throws DocumentException, InterruptedException {
        List<Map<String, String>> expectedRows = dt.asMaps(String.class, String.class);

        for (Map<String, String> row : expectedRows) {

            String Sno = row.get("#");
            String itemNumber = row.get("Item Number");
            String cargoSummary = row.get("Cargo Summary");
            String loadNum = row.get("Load");
            String pickupStop = row.get("Pickup Stop");
            String deliveryStop = row.get("Delivery Stop");

            String loadNumberExpected = loadNum;
            if (loadNum.contains("SysData")) {
                String key = loadNum.split("=>")[1];
                loadNumberExpected = DriverInstance.getVariable(key);
            }

            // Verify Cargo Summary
            WebElement cargoElem = webDriver.getwebelement(pageObject.getlocator("VerifyItemDetails").replace("{paramlink1}",Sno).replace("{paramlink2}",itemNumber).replace("{index}","1"));
            Assert.assertTrue(cargoElem.getText().contains(cargoSummary));

            // Verify Load Number
            WebElement loadNumber1 = webDriver.getwebelement(pageObject.getlocator("VerifyItemDetails").replace("{paramlink1}", Sno).replace("{paramlink2}", itemNumber).replace("{index}", "2"));
            Assert.assertTrue(loadNumber1.getText().contains(loadNumberExpected));

            // Verify Pickup Stop
            WebElement pickupElem = webDriver.getwebelement(pageObject.getlocator("VerifyItemDetails").replace("{paramlink1}",Sno).replace("{paramlink2}",itemNumber).replace("{index}","3"));
            Assert.assertEquals(pickupElem.getText().trim(), pickupStop);

            // Verify Delivery Stop
            WebElement deliveryElem = webDriver.getwebelement(pageObject.getlocator("VerifyItemDetails").replace("{paramlink1}",Sno).replace("{paramlink2}",itemNumber).replace("{index}","4"));
            Assert.assertEquals(deliveryElem.getText().trim(), deliveryStop);
        }
    }

    @Then("Verify no {string} are marked true")
    public void verifyNoCheckboxesAreChecked(String arg0) throws DocumentException, InterruptedException {
        // Locate all checkboxes under the stop detail section
        List<WebElement> checkboxes = webDriver.getwebelements(pageObject.getlocator("AssosirialCheckBox"));

        boolean anyChecked = false;

        // Iterate over all checkboxes
        for (WebElement checkbox : checkboxes) {
            if (checkbox.isSelected() || Boolean.parseBoolean(checkbox.getAttribute("checked"))) {
                anyChecked = true;
                break;
            }
        }
        // Assert that none are checked
        Assert.assertFalse(anyChecked,"Some checkboxes are checked!");
    }

    @Then("Click on {string} on {string} item")
    public void clickOnOnItem(String arg0, String arg1) throws Exception {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("ButtonIconWithTitle").replace("{paramlink}", arg0).replace("index",arg1)));
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("ButtonIconWithTitle").replace("{paramlink}", arg0).replace("index",arg1)));
        webDriver.safeJavaScriptClick(webDriver.passwebelement(pageObject.getlocator("ButtonIconWithTitle").replace("{paramlink}", arg0).replace("index",arg1)));
        webDriver.waitForElementLoad(1);
    }

    @Then("Click on {string} {string} chevron")
    public void clickOnChevron(String arg0, String arg1) throws Exception {
        try {
            webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("chevronButton").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
            webDriver.waitUntilElementIsVisible(pageObject.getlocator("chevronButton").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1));
            webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("chevronButton").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
        } catch (Exception e) {
            webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("chevronButton").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
            webDriver.waitUntilElementIsVisible(pageObject.getlocator("chevronButton").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1));
            webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("chevronButton").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
        }
        }

    @Then("Click on {string} {string} Link")
    public void clickOnStopOneLink(String stopType, String stopName) throws Exception {
        String locator = pageObject.getlocator("Stop_One_Link")
                .replace("{paramlink1}", stopType)
                .replace("{paramlink2}", stopName);

        webDriver.waitUntilElementIsVisible(locator);
        webDriver.ScrollIntoView(webDriver.passwebelement(locator));
        webDriver.ClickOnElement(webDriver.passwebelement(locator));
        webDriver.waitForElementLoad(1);
    }

    @Then("Load Summary - Click on {string} {string} Text")
    public void clickOnText(String arg0, String arg1) throws Exception {
        try {
            webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("chevronButton").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
            webDriver.waitUntilElementIsVisible(pageObject.getlocator("chevronButton").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1));
            webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("chevronButton").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
        } catch (Exception e) {
            webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("chevronButton").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
            webDriver.waitUntilElementIsVisible(pageObject.getlocator("chevronButton").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1));
            webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("chevronButton").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
        }
    }

    @Then("Click on {string} {string} button")
    public void clickOnChevron1(String arg0, String arg1) throws Exception {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("chevronButton").replace("{paramlink1}", arg0).replace("{paramlink2}",arg1)));
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("chevronButton").replace("{paramlink1}", arg0).replace("{paramlink2}",arg1)));
        webDriver.Clickon(webDriver.passwebelement(pageObject.getlocator("chevronButton").replace("{paramlink1}", arg0).replace("{paramlink2}",arg1)));
    }
    @Then("Verify {string} Shipment is {string}")
    public void VerifyChevron(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("VerifyShipmentStage").replace("{paramlink1}", arg0).replace("{paramlink2}",arg1)));
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("VerifyShipmentStage").replace("{paramlink1}", arg0).replace("{paramlink2}",arg1)));
        webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyShipmentStage").replace("{paramlink1}", arg0).replace("{paramlink2}",arg1));
    }

    @Then("Click on Text {string} on {string} item")
    public void clickOnOnTextItem(String arg0, String arg1) throws Exception {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("StopTextLink").replace("{paramlink}", arg0).replace("index",arg1)));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("StopTextLink").replace("{paramlink}", arg0).replace("index",arg1));
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("StopTextLink").replace("{paramlink}", arg0).replace("index",arg1)));
        webDriver.waitForElementLoad(1);
    }

    @Then("Select the + action next to the {string} integration listing")
    public void selectTheActionNextToTheIntegrationListing(String arg0) throws Exception {
        if(arg0.equalsIgnoreCase("DAT"))
        {
            arg0 = arg0.replace(arg0, "DAT 2");
        }
            webDriver.ScrollToElement(webDriver.getwebelement(pageObject.getlocator("LoadPostingIntegration").replace("{paramlink}",arg0)));
            webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("LoadPostingIntegration").replace("{paramlink}",arg0)));
            if(arg0.equalsIgnoreCase("Transcore")){
                ZonedDateTime chicagoTime = ZonedDateTime.now(ZoneId.of("America/Chicago"));
                int hour = chicagoTime.getHour();

                // Night = 6:00 PM through 5:59 AM
                boolean isNight = hour >= 20 || hour < 6;
                if (isNight) {
                    System.out.println("SKIPPING SCENARIO:  " + chicagoTime);
                    DriverInstance.setVariable("Transcore_Down","Yes");
                    //throw new SkipException("Transcore scenario skipped because it is Night " + "in Chicago. Chicago time: " + chicagoTime);

                }

            }

    }

    @Then("Select the Remove action next to the {string} integration listing")
    public void selectTheRemoveActionNextToTheIntegrationListing(String arg0) throws Exception {
//        if(arg0.equalsIgnoreCase("DAT"))
//        {
//            arg0 = arg0.replace(arg0, "DAT 2");
//        }
        if(webDriver.getwebelementscount(pageObject.getlocator("LoadRemovePostingIntegration").replace("{paramlink}",arg0))>0)
        {
        webDriver.ScrollToElement(webDriver.getwebelement(pageObject.getlocator("LoadRemovePostingIntegration").replace("{paramlink}",arg0)));
        webDriver.Clickon(webDriver.passwebelement(pageObject.getlocator("LoadRemovePostingIntegration").replace("{paramlink}",arg0)));
        webDriver.waitForElementLoad(2);
        cm.closeToastMessage();
        }
    else {
        System.out.println("Remove button not found for " + arg0 + ". Skipping this integration.");
    }
    }

    @Then("Click on {string} for Records having {string} as {string}")
    public void clickOnForRecordsHavingAs(String Posting, String Load, String loadNum) throws Exception {
        if (loadNum.contains("SysData"))
        {
            loadNum=DriverInstance.getVariable(loadNum.split("=>")[1].trim());
        }
        webDriver.waitForElementLoad(1);
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("LoadPostingNumber").replace("{paramlink1}", Load).replace("{paramlink2}", loadNum).replace("{paramlink3}", Posting)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("LoadPostingNumber").replace("{paramlink1}", Load).replace("{paramlink2}", loadNum).replace("{paramlink3}", Posting)));
        webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("LoadPostingNumber").replace("{paramlink1}", Load).replace("{paramlink2}", loadNum).replace("{paramlink3}", Posting)));
    }

    @Then("Verify {string} {string} chevron have {string} checkmark")
    public void verifyAndChevronsHave(String pickDrop, String Stage, String Color) throws DocumentException, InterruptedException {
        webDriver.ScrollToElement(webDriver.getwebelement(pageObject.getlocator("ShipmentStatus").replace("{paramlink}",Stage)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("ShipmentStatus").replace("{paramlink}",Stage)));
        System.out.println("Checkmark is visible");

        WebElement wl = webDriver.getwebelement(pageObject.getlocator("chevronButton").replace("{paramlink1}",pickDrop).replace("{paramlink2}",Stage));
        String color = wl.getCssValue("color");
        String hexColor = org.openqa.selenium.support.Color.fromString(color).asHex();
        java.awt.Color decodedColor = java.awt.Color.decode(hexColor);
        System.out.println(" Color is: " + hexColor);
        String colorName = ColorUtils.getClosestColorName(
                decodedColor.getRed(), decodedColor.getGreen(), decodedColor.getBlue());
        System.out.println("Color Name: " + colorName);

        webDriver.Stringcomparator(colorName, Color);
    }

    @Then("Verify {string} {string} chevron is highlighted with {string}")
    public void verifyChevronIsHighlightedWith(String pickDrop, String Stage, String Color) throws DocumentException, InterruptedException {

        WebElement wl = webDriver.getwebelement(pageObject.getlocator("chevron").replace("{paramlink1}",pickDrop).replace("{paramlink2}",Stage));
        String bgColor = wl.getCssValue("background-color");
        String BGhex = org.openqa.selenium.support.Color.fromString(bgColor).asHex();
        java.awt.Color decodedColor = java.awt.Color.decode(BGhex);
        System.out.println("Color is: " + BGhex);
        String colorName = ColorUtils.getClosestColorName(
                decodedColor.getRed(), decodedColor.getGreen(), decodedColor.getBlue());
        System.out.println("Color Name: " + colorName);

        webDriver.Stringcomparator(colorName, Color);
    }

    @Then("Verify {string} Color with {string} Text of {string} {string} Button is {string}")
    public void verifyColorWithTextOfButtonIs(String arg0, String arg1, String arg4, String arg2,  String arg3) throws DocumentException, InterruptedException {
        String Locators;
        if(arg2.equalsIgnoreCase("ThumbsUp"))
        {
            String title = "Arrival/Departure = Expected";
            if (arg3.equalsIgnoreCase("disabled")) {
                Locators = xml.getlocator("WithTitle").replace("{paramlink}", title).replace("{paramlink2}", "true");
            } else {
                Locators = xml.getlocator("WithTitle").replace("{paramlink}", title);
            }

        }
        else if( arg2.charAt(arg2.length() - 2) == '_')
        {
            if (arg3.equalsIgnoreCase("disabled")) {
                Locators = "("+pageObject.getlocator("chevronButton").replace("{paramlink1}", arg2.split("_")[0]).replace("{paramlink2}", "true")+")["+arg2.charAt(arg2.length() - 1)+"]";
            } else {
                Locators = "("+pageObject.getlocator("chevronButton").replace("{paramlink1}", arg2.split("_")[0]).replace("{paramlink2}", "false")+")["+arg2.charAt(arg2.length() - 1)+"]";
            }
        }
        else {
            if (arg3.equalsIgnoreCase("disabled")) {
                Locators = pageObject.getlocator("chevronButton").replace("{paramlink1}", arg2).replace("{paramlink2}", "true");
            } else {
                Locators = pageObject.getlocator("chevronButton").replace("{paramlink1}", arg4).replace("{paramlink2}", arg2);
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

    @Then("Verify button is present with {string}")
    public void verifyButtonIsPresentWith(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("WithTitle").replace("{paramlink}",arg0)));
    }

    @Then("Update Location as {string}")
    public void updateLocationAs(String arg0) throws Exception {
        if(webDriver.getwebelementscount(pageObject.getlocator("ClearLocation"))>0) {
            webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("ClearLocation")));
        }
        webDriver.waitForElementLoad(1);
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("UpdateLocation")));
        webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("UpdateLocation")),arg0);
        webDriver.waitForElementLoad(1);
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("SelectLocation").replace("{paramlink}",arg0)));
    }
    @Then("Verify No Search Result displaying with {string}")
    public void verifyMessageAreNotDisplayingAs(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementNotToBePresent(pageObject.getlocator("SelectLocation").replace("{paramlink}",arg0));
    }
    @Then("Verify Search Result displaying with {string}")
    public void verifyMessageAreDisplayingAs(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementToBePresent(pageObject.getlocator("SelectLocation").replace("{paramlink}",arg0));
    }
    @Then("Enter Location as {string}")
    public void EnterLocationAs(String arg0) throws Exception {
        if(webDriver.getwebelementscount(pageObject.getlocator("ClearLocation"))>0) {
            webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("ClearLocation")));
        }
        webDriver.waitForElementLoad(1);
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("UpdateLocation")));
        webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("UpdateLocation")),arg0);
        webDriver.waitForElementLoad(1);
    }

    @Then("Verify Stop {string} Details")
    public void verifyStopDetails(String arg0, DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        cf.ValidateStopDetails(arg0,dt);
    }

    @Then("Verify {string} Stop Text is {string}")
    public void verifyStopTextIs(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("VerifyStopName").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1));
        webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyStopName").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1));

    }

    @Then("Verify Title {string} on Stop {string}")
    public void VerifyTitleOnStop(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("SelectMoveStop").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
        String title=webDriver.Getattribute(webDriver.getwebelement(pageObject.getlocator("SelectMoveStop").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)),"title");
        Assert.assertEquals(arg0,title);
    }
    @Then("Click on button with Title {string} on Stop {string}")
    public void clickOnButtonWithTitleOnStop(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("SelectMoveStop").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
        webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("SelectMoveStop").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));

    }
    @Then("Verify {string} Stop Details")
    public void verifyDetails(String arg0, DataTable dt) throws Exception {
        ValidateStopDetails(arg0, dt);
    }

    public void ValidateStopDetails(String arg0, DataTable dt) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                try{
                    webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("VerifyStopDetails").replace("{paramlink1}",arg0).replace("{paramlink2}", entry.getKey())));
                    webDriver.waitUntilElementIsVisible(pageObject.getlocator("VerifyStopDetails").replace("{paramlink1}",arg0).replace("{paramlink2}", entry.getKey()));
                    WebElement element = webDriver.passwebelement(pageObject.getlocator("VerifyStopDetails").replace("{paramlink1}",arg0).replace("{paramlink2}", entry.getKey()));
                    String Text = element.getText();
                    System.out.println("Text is "+Text);
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        if(entry.getValue().trim().equalsIgnoreCase("NA"))
                        {
                            System.out.println("Values are: " + Text);
                            Assert.assertEquals(Text, "",entry.getKey()+": Actual value is "+Text+ " But Expected as "+entry.getValue());
                        }
                        else if(entry.getKey().contains("Date")&&!entry.getValue().trim().contains("/")&&!entry.getValue().contains("SysData"))
                        {
                            System.out.println("Values are: " + webDriver.ReturnDate(entry.getValue()));
                            Assert.assertEquals(Text,  webDriver.ReturnDate(entry.getValue()),entry.getKey()+": Actual value is "+Text+ " But Expected as "+ webDriver.ReturnDate(entry.getValue()));
                        }
                        else if(entry.getValue().equalsIgnoreCase("SysData=>ContactEmail"))
                        {
                            System.out.println("Values are: " + Text);
                            Assert.assertEquals(Text, propertyReader.readproperty("EmailID"),entry.getKey()+": Actual value is "+Text+ " But Expected as "+propertyReader.readproperty("EmailID"));
                        }
                        else if(entry.getValue().contains("SysData"))
                        {
                            String Value = entry.getValue().split("=>")[1];
                            Assert.assertTrue(Text.contains(DriverInstance.getVariable(Value)),entry.getKey()+": Actual value is "+Text+ " But Expected as "+DriverInstance.getVariable(Value));

                        }
                        else {
                            System.out.println("Values are: " + Text);
                            Assert.assertTrue(Text.contains(entry.getValue()),entry.getKey()+": Actual value is "+Text+ " But Expected as "+entry.getValue());
                        }
                    }
                    else{
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, "",entry.getKey()+": Actual value is "+Text+ " But Expected as "+entry.getValue());
                    }
                }
                catch(Exception e)
                {
                    webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("VerifyStopDetails").replace("{paramlink1}",arg0).replace("{paramlink2}", entry.getKey())));
                    WebElement element = webDriver.passwebelement(pageObject.getlocator("VerifyStopDetails").replace("{paramlink1}",arg0).replace("{paramlink2}", entry.getKey()));
                    String Text = element.getText();
                    if(entry.getValue().equalsIgnoreCase("NA"))
                    {
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, "",entry.getKey()+": Actual value is "+Text+ " But Expected as "+entry.getValue());
                    }
                    else {
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, entry.getValue(),entry.getKey()+": Actual value is "+Text+ " But Expected as "+entry.getValue());
                    }
                }
            }
        }
    }

    @Then("Capture Distance from Load Map in {string}")
    public void captureDistanceFromLoadMapIn(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("LoadMapDistance")));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("LoadMapDistance"));
       String Text= webDriver.getTextUsingJS(webDriver.passwebelement(pageObject.getlocator("LoadMapDistance")));
       if(arg0.contains("Miles"))
       {
           String Miles = Text.split("/")[0];
           DriverInstance.setVariable("Miles",Miles);
       }
       else {
           String Kms = Text.split("/")[1];
           DriverInstance.setVariable("Kilometres",Kms);
       }
    }
    @Then("Click on Edit icon with Field Name {string} {string}")
    public void clickOnEditIconWithFieldName(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("Stop_Field_Edit_Icon").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("Stop_Field_Edit_Icon").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("Stop_Field_Edit_Icon").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
        webDriver.waitForElementLoad(1);
    }


    @And("Set {string} as {string} into {double}")
    public void setAsInto(String arg0, String arg1, double arg2) {
        if(arg1.contains("SysData=>")) {
            arg1 = DriverInstance.getVariable(arg1.split("=>")[1]).trim().replace(",","");

        }
        double baseValue = Double.parseDouble(arg1);
        double calculated = baseValue * arg2;
        // 🔹 Round to 2 decimal places (HALF_UP)
        BigDecimal rounded = BigDecimal.valueOf(calculated)
                .setScale(2, RoundingMode.HALF_UP);
        DriverInstance.setVariable(arg0, rounded.toPlainString());
    }

    @Then("Get {string} from {string}")
    public void getFrom(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("BannerDetails").replace("{paramlink}",arg0).replace("{paramlink2}",arg1)));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("BannerDetails").replace("{paramlink}",arg0).replace("{paramlink2}",arg1));
        String value;
        value = webDriver.GetText(webDriver.passwebelement(pageObject.getlocator("BannerDetails").replace("{paramlink}",arg0).replace("{paramlink2}",arg1))).replace(",","");
        if(value.equalsIgnoreCase(""))
        {   webDriver.waitForElementLoad(5);
            value = webDriver.GetText(webDriver.passwebelement(pageObject.getlocator("BannerDetails").replace("{paramlink}",arg0).replace("{paramlink2}",arg1))).replace(",","");
        }
        DriverInstance.setVariable(arg0,value);
    }

    @Then("Verify Carrier Tracking Status as {string}")
    public void verifyCarrierTrackingStatusAs(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("CarrierTrackingStatus"));
        String text = webDriver.getText(webDriver.passwebelement(pageObject.getlocator("CarrierTrackingStatus")));
        System.out.println(text);
        Assert.assertTrue(text.contains(arg0),"Carrier Tracking Status not matched");
    }

    @Then("Select Mode Picklist as {string} & Book it Now Option as {string} for {string}")
    public void selectModePicklistAsBookItNowOptionAsFor(String arg0, String arg1, String arg2) throws Exception {
        //Select Mode
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("LoadPostingAction").replace("{paramlink}", arg2).replace("{index}","1")));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("LoadPostingAction").replace("{paramlink}", arg2).replace("{index}","1"));
        String fieldName = webDriver.passwebelement(pageObject.getlocator("LoadPostingAction").replace("{paramlink}", arg2).replace("{index}","1")).getAttribute("for");
        WebElement element = webDriver.passwebelement(xml.getlocator("FormFields").replace("{paramlink}", fieldName));
        webDriver.ScrollIntoView(element);
        webDriver.safeJavaScriptClick(element);
        webDriver.SelectComboBoxOption(webDriver.getwebelement(pageObject.getlocator("LoadPostingDropdown").replace("{paramlink}", arg2)), webDriver.getwebelement(pageObject.getlocator("LoadPostingDropdownText").replace("{paramlink1}", arg2).replace("{paramlink2}",arg0)));
        webDriver.waitForElementLoad(2);
        if(arg1.equalsIgnoreCase("True")) {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("LoadPostingAction").replace("{paramlink}", arg2).replace("{index}","2")));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("LoadPostingAction").replace("{paramlink}", arg2).replace("{index}","2"));
        String fieldName1 = webDriver.passwebelement(pageObject.getlocator("LoadPostingAction").replace("{paramlink}", arg2).replace("{index}","2")).getAttribute("for");
        WebElement element1 = webDriver.passwebelement(xml.getlocator("FormFields").replace("{paramlink}", fieldName1));
        webDriver.ScrollIntoView(element1);
            try {
                webDriver.ClickOnElement(element1);
            } catch (Exception e) {
                webDriver.safeJavaScriptClick(element1);
            }
        }
    }

    @Then("Select Load Posting for {string} contains {string}")
    public void selectLoadPostingForContains(String arg0, String arg1) throws DocumentException, InterruptedException {
        if(arg1.contains("SysData"))
        {
            arg1=DriverInstance.getVariable(arg1.split("=>")[1]);
        }
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("LoadPostingLink").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("LoadPostingLink").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("LoadPostingLink").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
        webDriver.waitForElementLoad(1);
    }

    @Then("Verify Tracking log count is greater than {string}")
    public void verifyTrackingLogCountIsGreaterThan(String arg0) throws InterruptedException, DocumentException {

        int Count = webDriver.getwebelementscount(pageObject.getlocator("TrackingLogRecords"));
        Assert.assertTrue(Count>Integer.parseInt(arg0), "More than defined records are not present");
    }

    @Then("Verify {string} Load posting has dropdown value {string}")
    public void verifyLoadPostingHasDropdownValue(String posting, String dropdownValue) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("LoadPosting").replace("{paramlink1}", posting).replace("{paramlink2}", dropdownValue)));
        webDriver.verifyElementToBePresent(pageObject.getlocator("LoadPosting").replace("{paramlink1}", posting).replace("{paramlink2}", dropdownValue));
    }

    private final List<String> capturedSuccessMessages = new ArrayList<>();
    private final List<String> capturedErrorMessages = new ArrayList<>();
    private final Set<String> capturedLoadBoardNames = new LinkedHashSet<>();
    private final Set<String> successfulLoadBoards = new LinkedHashSet<>();
    private final Set<String> failedLoadBoards = new LinkedHashSet<>();

    @And("Capture load post success and error messages")
    public void captureLoadBoardSuccessAndErrorMessages() throws Exception {
        capturedSuccessMessages.clear();
        capturedErrorMessages.clear();
        successfulLoadBoards.clear();
        failedLoadBoards.clear();
        capturedLoadBoardNames.clear();

        long startTime = System.currentTimeMillis();
        long maxWaitTime = 120000;
        Set<String> processedMessages = new LinkedHashSet<>();
        while (System.currentTimeMillis() - startTime < maxWaitTime) {
            // Capture ALL currently visible success toasts.
            List<WebElement> successToasts = webDriver.getWebElements(xml.getlocator("ToastDescription"));
            for (WebElement toast : successToasts) {
                try {
                    String message = webDriver.getOverlayText(toast);
                    if (message == null || message.trim().isEmpty()) {
                        continue;
                    }
                    message = message.replaceAll("\\s+", " ").trim();
                    if (processedMessages.add("SUCCESS:" + message)) {
                        capturedSuccessMessages.add(message);
                        System.out.println("SUCCESS TOAST: " + message);
                    }
                    if (message.contains(":")) {
                        String boardName = message.split(":", 2)[0].trim();
                        successfulLoadBoards.add(boardName);
                        capturedLoadBoardNames.add(boardName);
                    }
                } catch (Exception e) {
                    System.out.println("Unable to read success toast: " + e.getMessage());
                }
            }

            // Capture ALL currently visible error toasts.
            List<WebElement> errorToasts = webDriver.getWebElements(xml.getlocator("ErrorMessage"));
            for (WebElement toast : errorToasts) {
                try {
                    String message = webDriver.getOverlayText(toast);

                    if (message == null || message.trim().isEmpty()) {
                        continue;
                    }
                    message = message.replaceAll("\\s+", " ").trim();
                    if (processedMessages.add("ERROR:" + message)) {
                        capturedErrorMessages.add(message);
                        System.out.println("ERROR TOAST: " + message);
                    }
                    if (message.contains(":")) {
                        String boardName = message.split(":", 2)[0].trim();
                        failedLoadBoards.add(boardName);
                        capturedLoadBoardNames.add(boardName);
                    }
                } catch (Exception e) {
                    System.out.println("Unable to read error toast: " + e.getMessage());
                }
            }
            if (capturedLoadBoardNames.size() >= 5) {
                System.out.println("All 5 load boards captured.");
                break;
            }
            Thread.sleep(100);
        }
        System.out.println("Successful boards: " + successfulLoadBoards);
        System.out.println("Failed boards: " + failedLoadBoards);
        if (capturedLoadBoardNames.size() < 5) {
            throw new AssertionError(
                    "Expected toast messages for 5 unique load boards, but captured "
                            + capturedLoadBoardNames.size()
                            + " within 60 seconds. Captured boards: "
                            + capturedLoadBoardNames
                            + ". Success messages: " + capturedSuccessMessages
                            + ". Error messages: " + capturedErrorMessages);
        }
        cm.closeToastMessage2();
        for (String boardName : failedLoadBoards) {
            cm.closeErrorToastMessage2(boardName);
       DriverInstance.setVariable("SuccessfulLoadPostCount", "(" + successfulLoadBoards.size() + ")");
        }
    }

    @Then("Verify load posting buttons based on toast messages")
    public void verifyLoadBoardPostingButtonsBasedOnToastMessages() throws Exception {
        List<String> failures = new ArrayList<>();
        // Successful posting: verify Remove/tick button.
        for (String boardName : successfulLoadBoards) {
            String locator = pageObject.getlocator("LoadRemovePostingIntegration").replace("{paramlink}", boardName);
            List<WebElement> buttons = webDriver.getWebElements(locator);
            if (!buttons.isEmpty()) {
                System.out.println("Tick button found for " + boardName);
            } else {
                failures.add("Remove/tick button missing for " + boardName);
            }
        }

        // Failed posting: verify Post/+ button.
        for (String boardName : failedLoadBoards) {
            String locator = pageObject.getlocator("LoadPostingIntegration").replace("{paramlink}", boardName);
            List<WebElement> buttons = webDriver.getWebElements(locator);
            if (!buttons.isEmpty()) {
                System.out.println("'+' button found for " + boardName);
            } else {
                failures.add("Post/+ button missing for " + boardName);
            }
        }
        if (!failures.isEmpty()) {
            throw new AssertionError(
                    "Load-board button verification failed:\n"
                            + String.join("\n", failures));
        }
    }

    @Then("Verify header button based on load posting result")
    public void verifyHeaderButtonBasedOnLoadPostingResult() throws Exception {
        String expectedButton;
        if (!failedLoadBoards.isEmpty()) {
            expectedButton = "Post";
        } else if (successfulLoadBoards.size() == 5) {
            expectedButton = "Remove";
        } else {
            throw new AssertionError(
                    "Cannot verify header button. Captured successful boards: "
                            + successfulLoadBoards
                            + ", failed boards: " + failedLoadBoards);
        }
        String locator = xml.getlocator("ButtonTitle").replace("{paramlink}", expectedButton);
        List<WebElement> buttons = webDriver.getWebElements(locator);
        if (buttons.isEmpty()) {
            throw new AssertionError(
                    "Expected header button '" + expectedButton
                            + "' was not found.");
        }
    }

    @Then("Verify load posts are re-posted")
    public void verifyPreviouslyPostedLoadsAreRepostedAndRemainTicked() throws Exception {

        if (successfulLoadBoards.isEmpty()) {
            throw new AssertionError("No loads were successfully posted during the initial posting.");
        }

        boolean transCoreWasPosted = successfulLoadBoards.stream().anyMatch(board -> board.equalsIgnoreCase("TransCore"));

        // TransCore requires a warning banner; all other boards require success banners.
        Set<String> boardsToVerify = new LinkedHashSet<>(successfulLoadBoards);
        boardsToVerify.removeIf(board -> board.equalsIgnoreCase("TransCore"));
        Set<String> repostedBoards = new LinkedHashSet<>();
        Set<String> processedMessages = new LinkedHashSet<>();

        boolean transCoreWarningFound = !transCoreWasPosted;
        long startTime = System.currentTimeMillis();
        long maxWaitTime = 60000;

        while (System.currentTimeMillis() - startTime < maxWaitTime) {

            // 1. Verify success banners for all boards except TransCore.
            List<WebElement> successToasts = webDriver.getWebElements(xml.getlocator("ToastDescription"));

            for (WebElement toast : successToasts) {
                try {
                    String message = webDriver.getOverlayText(toast);

                    if (message == null || message.trim().isEmpty()) {
                        continue;
                    }

                    message = message.replaceAll("\\s+", " ").trim();
                    if (!message.toLowerCase().contains("successfully re-posted")) {
                        continue;
                    }

                    if (!processedMessages.add(message)) {
                        continue;
                    }

                    System.out.println("RE-POST SUCCESS: " + message);

                    if (message.contains(":")) {
                        String boardName = message.split(":", 2)[0].trim();

                        if (boardsToVerify.contains(boardName)) {
                            repostedBoards.add(boardName);

                            System.out.println("Previously successful load re-posted: " + boardName);
                        }
                    }

                } catch (Exception e) {
                    System.out.println("Unable to read re-post success toast: " + e.getMessage());
                }
            }

            // 2. Verify the specific warning banner for TransCore, if applicable.
            if (transCoreWasPosted && !transCoreWarningFound) {
                try {
                    List<WebElement> warningToasts = webDriver.getWebElements("//div[@data-key='warning']");

                    for (WebElement toast : warningToasts) {
                        String warningMessage = webDriver.getOverlayText(toast);

                        if (warningMessage == null) {
                            continue;
                        }

                        warningMessage = warningMessage.replaceAll("\\s+", " ").trim();

                        String normalizedMessage = warningMessage.toLowerCase();

                        if (normalizedMessage.contains("transcore") && normalizedMessage.contains("does not support re-posting a load")) {
                            transCoreWarningFound = true;
                            System.out.println("EXPECTED TRANSCORE WARNING: " + warningMessage);
                            break;
                        }
                    }

                } catch (Exception e) {
                    System.out.println("Unable to read TransCore warning: " + e.getMessage());
                }
            }

            // Stop when all required success banners and the TransCore warning appear.
            if (repostedBoards.containsAll(boardsToVerify) && transCoreWarningFound) {
                break;
            }

            Thread.sleep(200);
        }

        // 3. Verify success banners for non-TransCore boards.
        Set<String> missingReposts = new LinkedHashSet<>(boardsToVerify);
        missingReposts.removeAll(repostedBoards);

        if (!missingReposts.isEmpty()) {
            throw new AssertionError("Re-post success message missing for loads: " + missingReposts + ". Successfully re-posted: " + repostedBoards);
        }

        // 4. Verify TransCore warning if it was initially posted.
        if (!transCoreWarningFound) {
            throw new AssertionError(
                    "Expected TransCore warning banner was not displayed. "
                            + "Expected message to contain: "
                            + "'TransCore' and "
                            + "'does not support re-posting a load'.");
        }

        // 5. Verify that every initially successful board remains ticked.
        for (String boardName : successfulLoadBoards) {
            String locator = pageObject.getlocator("LoadRemovePostingIntegration").replace("{paramlink}", boardName);
            List<WebElement> removeButtons = webDriver.getWebElements(locator);

            if (removeButtons.isEmpty()) {
                throw new AssertionError(
                        "Load '" + boardName
                                + "' was previously posted, but its "
                                + "tick button (Remove) is missing.");
            }
        }

        cm.closeToastMessage2();
        System.out.println(
                "PASS: All non-TransCore loads were re-posted successfully, "
                        + "the expected TransCore warning was verified when applicable, "
                        + "and all initially successful loads remain ticked.");
    }


    @Then("Click on Native {string} icon and verify toast messages and action buttons")
    public void clickNativeIconAndVerifyToastMessagesAndActionButtons(String icon) throws Exception {
        // Proceed only when all 5 boards were initially posted successfully.
        if (successfulLoadBoards.size() != 5 || !failedLoadBoards.isEmpty()) {
            System.out.println("SKIPPING this step because all 5 boards were not " + "successfully posted. Successful: " + successfulLoadBoards + ", Failed: " + failedLoadBoards);
            return;
        }
        cm.clickOnNativeIcon(icon);
        Set<String> removedBoards = new LinkedHashSet<>();
        Set<String> processedMessages = new LinkedHashSet<>();
        long startTime = System.currentTimeMillis();
        long maxWaitTime = 120000;

        // Capture removal success messages.
        while (System.currentTimeMillis() - startTime < maxWaitTime) {
            List<WebElement> successToasts = webDriver.getWebElements(xml.getlocator("ToastDescription"));
            for (WebElement toast : successToasts) {
                try {
                    String message = webDriver.getOverlayText(toast);

                    if (message == null || message.trim().isEmpty()) {
                        continue;
                    }

                    message = message.replaceAll("\\s+", " ").trim();

                    if (!message.contains("This load posting was removed from the load board.")) {
                        continue;
                    }

                    if (!processedMessages.add(message)) {
                        continue;
                    }
                    System.out.println("REMOVE SUCCESS TOAST: " + message);
                    if (message.contains(":")) {
                        String boardName = message.split(":", 2)[0].trim();
                        if (successfulLoadBoards.contains(boardName)) {
                            removedBoards.add(boardName);
                        }
                    }
                } catch (Exception e) {
                    System.out.println("Unable to read removal toast: " + e.getMessage());
                }
            }

            System.out.println("Removal confirmations received: " + removedBoards.size() + "/" + successfulLoadBoards.size());
            if (removedBoards.containsAll(successfulLoadBoards)) {
                break;
            }
            Thread.sleep(100);
        }
        // Fail if any expected removal confirmation is missing.
        Set<String> missingRemovals = new LinkedHashSet<>(successfulLoadBoards);
        missingRemovals.removeAll(removedBoards);
        if (!missingRemovals.isEmpty()) {
            throw new AssertionError(
                    "Removal success toast missing for boards: "
                            + missingRemovals
                            + ". Confirmed removals: " + removedBoards);
        }

        // Verify each removed board now has the + (Post) button.
        for (String boardName : successfulLoadBoards) {
            String locator = xml.getlocator("LoadPostingIntegration").replace("{paramlink}", boardName);
            List<WebElement> postButtons = webDriver.getWebElements(locator);
            if (postButtons.isEmpty()) {
                throw new AssertionError(
                        "Load posting was removed for '" + boardName
                                + "', but its Post (+) button was not found.");
            }
        }

        System.out.println("PASS: All 5 load postings were removed successfully, " + "and all corresponding buttons show Post (+).");
        cm.closeToastMessage2();

        // Verify header button still shows tick (Remove)
        String headerLocator = xml.getlocator("ButtonTitle").replace("{paramlink}", "Remove");
        List<WebElement> headerButtons = webDriver.getWebElements(headerLocator);
        if (headerButtons.isEmpty()) {
            throw new AssertionError(
                    "Expected header button to display Remove (tick), "
                            + "but it was not found.");
        }
        System.out.println("PASS: Header button still displays Remove (tick).");
    }

    @Then("Verify tracking details")
    public void verifyTrackingDetails(DataTable dataTable) throws Exception {
        String locator = pageObject.getlocator("SamsaraPickupDeliveryStatus");
        webDriver.waitUntilElementIsVisible(locator);

        String actualStatus = webDriver.getText(webDriver.passwebelement(locator))
                .replaceAll("\\s+", " ")
                .trim();
        Map<String, String> expectedValues = dataTable.asMaps(String.class, String.class).get(0);
        String expectedStatus = String.format(
                "Stop 1 - Pickup --- Arrived %s %s. Departed %s %s. "
                        + "Stop 2 - Delivery - No tracking updates available for this stop.",
                formatSamsaraDisplayDate(resolveExpectedValue(expectedValues.get("Arrival Date"))),
                resolveExpectedValue(expectedValues.get("Arrival Time")),
                formatSamsaraDisplayDate(resolveExpectedValue(expectedValues.get("Departure Date"))),
                resolveExpectedValue(expectedValues.get("Departure Time")));

        for (int attempt = 0; attempt < 12; attempt++) {
            if (actualStatus.equals(expectedStatus)) {
                return;
            }
            webDriver.waitForElementLoad(5);
            actualStatus = webDriver.getText(webDriver.passwebelement(locator))
                    .replaceAll("\\s+", " ")
                    .trim();
        }

        Assert.assertEquals(actualStatus, expectedStatus,
                "Unexpected Samsara Pickup/Delivery Status after waiting for synchronization");
    }
    private String formatSamsaraDisplayDate(String date) {
        return LocalDate.parse(date, DateTimeFormatter.ofPattern("MM/dd/yyyy", Locale.ENGLISH))
                .format(DateTimeFormatter.ofPattern("M/d/yyyy", Locale.ENGLISH));
    }
    private String resolveExpectedValue(String value) {
        if (value != null && value.startsWith("SysData=>")) {
            return DriverInstance.getVariable(value.substring("SysData=>".length()));
        }
        return value;
    }
}