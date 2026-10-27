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
import pageHelper.Utility.CommonFunction;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.ColorUtils;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Log4j
public class Freight_Plan {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    public Freight_Plan(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("TMS" + File.separator + "Load" + File.separator + "Freight_Plan.xml");
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
    }
    @Then("Freight Plan - Select the {string} Load hyperlink in the Carrier Loads Section")
    public void freightPlanSelectTheLoadHyperlinkInTheCarrierLoadsSection(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("CarrierLoadLink").replace("index",arg0)));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("CarrierLoadLink").replace("index",arg0));
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("CarrierLoadLink").replace("index",arg0)));
    }
    @Then("Freight Plan - Verify and get the {string} Load hyperlink in the Carrier Loads Section on {string}")
    public void freightPlanVerifyTheLoadHyperlinkInTheCarrierLoadsSection(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("CarrierLoadLink").replace("index",arg0)));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("CarrierLoadLink").replace("index",arg0));
        webDriver.verifyElementToBePresent(pageObject.getlocator("CarrierLoadLink").replace("index",arg0));
        String text = webDriver.GetText(webDriver.passwebelement(pageObject.getlocator("CarrierLoadLink").replace("index",arg0)));
        DriverInstance.setVariable(arg1,text);
    }

    @Then("Freight Plan - Verify and get the {string} Load hyperlink in the User Selected Load(s) - Load View Section on {string}")
    public void freightPlanVerifyTheLoadHyperlinkInTheUserSelectedLoadViewSection(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("CustomerLoadLink").replace("index",arg0)));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("CustomerLoadLink").replace("index",arg0));
        webDriver.verifyElementToBePresent(pageObject.getlocator("CustomerLoadLink").replace("index",arg0));
        String text = webDriver.GetText(webDriver.passwebelement(pageObject.getlocator("CustomerLoadLink").replace("index",arg0)));
        DriverInstance.setVariable(arg1,text);
        System.out.println("Customer" +arg0+ "Load created " +arg1);
    }

    @Then("Freight Plan - Get the Fright Plan Number and Store on {string}")
    public void GetFreightPlanNumber( String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("GetFreightPlanNumberFromLoad")));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("GetFreightPlanNumberFromLoad"));
        String text = webDriver.GetText(webDriver.passwebelement(pageObject.getlocator("GetFreightPlanNumberFromLoad")));
        DriverInstance.setVariable(arg1,text);
        System.out.println("Freight Plan captured " +arg1);
    }

    @Then("Freight Plan - Verify and get the {string} Load hyperlink in the Customer Loads Section on {string}")
    public void freightPlanVerifyTheLoadHyperlinkInTheCustomerLoadsSection(String arg0, String arg1) throws DocumentException, InterruptedException {
        if(arg0.contains("SysData")){
            arg0=arg0.split("=>")[1];
        }
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("CustomerLoadLink").replace("index",arg0)));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("CustomerLoadLink").replace("index",arg0));
        webDriver.verifyElementToBePresent(pageObject.getlocator("CarrierLoadLink").replace("index",arg0));

        String text = webDriver.GetText(webDriver.passwebelement(pageObject.getlocator("CarrierLoadLink").replace("index",arg0)));
        DriverInstance.setVariable(arg1,text);
    }

    @Then("Freight Plan - {string} {string} and select {string}")
    public void freightPlanAddFromResult(String arg1, String arg0, String arg2) throws Exception {
        webDriver.waitForElementLoad(1);
        webDriver.waitUntilElementIsVisible(xml.getlocator("GlobalPlaceholder").replace("{paramlink}", "Add Load Number"));
        if(arg0.contains("SysData"))
        {
            String Value = arg0.split("=>")[1];
            arg0 = DriverInstance.getVariable(Value);
        }
        webDriver.EnterTextUsingJS(webDriver.getwebelement(xml.getlocator("GlobalPlaceholder").replace("{paramlink}", arg1)), arg0);
        webDriver.waitForElementLoad(1);
        webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("Global_Text").replace("{paramlink}", arg2)));
        webDriver.waitForElementLoad(3);
    }

    @Then("Freight Plan - {string} {string}")
    public void freightPlanAddLoadNumber(String arg1, String arg0) throws Exception {
        webDriver.waitForElementLoad(1);
        webDriver.waitUntilElementIsVisible(xml.getlocator("GlobalPlaceholder").replace("{paramlink}", "Add Load Number"));
        if(arg0.contains("SysData"))
        {
            String Value = arg0.split("=>")[1];
            arg0 = DriverInstance.getVariable(Value);
        }
        webDriver.EnterTextUsingJS(webDriver.getwebelement(xml.getlocator("GlobalPlaceholder").replace("{paramlink}", arg1)), arg0);
        webDriver.waitForElementLoad(1);
        webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("Global_Text").replace("{paramlink}", arg0)));
        webDriver.waitForElementLoad(3);
    }

    @Then("the Freight Plan Financial Summary should display the following rows")
    public void verifyFinancialSummaryRows(DataTable table) throws DocumentException, InterruptedException {

        List<Map<String, String>> expectedRows = table.asMaps();
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("FreightPlanFinancialSummaryText"));
        List<WebElement> rowContainers = webDriver.getwebelements(pageObject.getlocator("FreightPlanFinancialSummaryText"));

        String allRowText = rowContainers.stream()
                .map(WebElement::getText)
                .map(this::normalizeCellText)
                .reduce("", String::concat);

        for (Map<String, String> expected : expectedRows) {
            String loadNumber = DriverInstance.getVariable(expected.get("Load Number"));
            String expectedPattern =
                    loadNumber +
                            expected.get("Customer").replaceAll("\\s+", "") +
                            expected.get("Customer Quote Total").replaceAll("\\s+", "") +
                            expected.get("Carrier Quote Total").replaceAll("\\s+", "") +
                            expected.get("Quoted Margin").replaceAll("\\s+", "") +
                            expected.get("Customer Invoice Total").replaceAll("\\s+", "") +
                            expected.get("Carrier Invoice Total").replaceAll("\\s+", "") +
                            expected.get("Invoiced Margin").replaceAll("\\s+", "");

            System.out.println("Actual "+allRowText);
            System.out.println("Expected "+expectedPattern);

            String normalizedActual = allRowText
                    .replaceAll("\\s+", "")
                    .replace("\u00A0", "")
//                    .replaceAll("(\\d+)\\.\\d+", "$1")   // Remove decimal part
                    .trim();

            String normalizedExpected = expectedPattern
                    .replaceAll("\\s+", "")
                    .replace("\u00A0", "")
//                    .replaceAll("(\\d+)\\.\\d+", "$1")   // Remove decimal part
                    .trim();

            Assert.assertTrue(
                    normalizedActual.contains(normalizedExpected),
                    "Expected row data not found for Load: " + loadNumber +
                            "\nExpected: " + normalizedExpected +
                            "\nActual: " + normalizedActual
            );
        }
    }

    private String normalizeCellText(String text) {
        return text
                .replace("\n", "")          // handle multiline
                .replaceAll("\\s+", "")      // remove extra spaces
                .trim();
    }
    private String normalizeCurrency(String text) {
        return text.replaceAll("[^0-9.-]", "");
    }
    @Then("the Freight Plan Financial Summary totals should be displayed as")
    public void verifyFinancialSummaryTotals(DataTable table) throws DocumentException, InterruptedException {

        Map<String, String> expected = table.asMaps().get(0);
        List<WebElement> footerValues = webDriver.getwebelements(pageObject.getlocator("FreightPlanFinancialFooterSummaryText"));
        String actualValues = footerValues.stream()
                .map(WebElement::getText)
                .map(this::normalizeCellText)
                .reduce("", String::concat);

        System.out.println("Actual: "+actualValues);
        Assert.assertTrue(actualValues.contains(expected.get("Customer Quote Total").replaceAll("\\s+", "")));
        Assert.assertTrue(actualValues.contains(expected.get("Carrier Quote Total").replaceAll("\\s+", "")));
        Assert.assertTrue(actualValues.contains(expected.get("Quoted Margin").replaceAll("\\s+", "")));
        Assert.assertTrue(actualValues.contains(expected.get("Customer Invoice Total").replaceAll("\\s+", "")));
        Assert.assertTrue(actualValues.contains(expected.get("Carrier Invoice Total").replaceAll("\\s+", "")));
        Assert.assertTrue(actualValues.contains(expected.get("Invoiced Margin").replaceAll("\\s+", "")));
    }

    @Then("Select First Freight Plan from list")
    public void selectFirstFreightPlanFromList() throws Exception {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("SelectFirstFreightPlan"));
        webDriver.safeJavaScriptClick(webDriver.passwebelement(pageObject.getlocator("SelectFirstFreightPlan")));
        webDriver.waitForElementLoad(2);
    }

    @Then("Verify Financial Summary Modal is displaying with Details")
    public void verifyFinancialSummaryModalIsDisplayingWithDetails() throws Exception {
        webDriver.waitForElementLoad(10);
        int count = webDriver.getwebelementscount(pageObject.getlocator("FreightPlanFinancialSummaryText"));
        if(count==0)
        {
            Common_Steps cm = new Common_Steps(DriverInstance);
            cm.clickOnButtonWithTitle("Close");
            cm.waitForSeconds("3");
            cm.clickOnButtonWithTitle("Financial Summary");
            cm.waitForSeconds("2");
        }

    }

    @Then("Enter value {string} with Input having {string} as {string} for {string} Stop")
    public void enterValueWithInputHavingAsForSecondStop(String arg0, String arg1, String arg2, String arg3) throws DocumentException, InterruptedException, IOException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("InputFieldValue").replace("{paramlink1}",arg1).replace("{paramlink2}",arg2).replace("{index}",arg3)));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("InputFieldValue").replace("{paramlink1}",arg1).replace("{paramlink2}",arg2).replace("{index}",arg3));
        webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("InputFieldValue").replace("{paramlink1}",arg1).replace("{paramlink2}",arg2).replace("{index}",arg3)), arg0);
    }

    @Then("Freight Plan - Click on Template Panel")
    public void freightPlanClickOn() throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("Template_Panel_Icon")));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("Template_Panel_Icon"));
        webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("Template_Panel_Icon")));

    }

    @Then("Freight Plan - Click on Checkbox with Location {string}")
    public void freightPlanClickOnCheckboxWithLocation(String arg0) throws Exception {
        int index = 1;
        if(arg0.contains("_"))
        {
            index = Integer.parseInt(arg0.split("_")[1]);
            arg0 = arg0.split("_")[0];
        }
    //    webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("LocationCheckbox").replace("{paramlink}",arg0).replace("{index}", String.valueOf(index))));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("LocationCheckbox").replace("{paramlink}",arg0).replace("{index}", String.valueOf(index)));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("LocationCheckbox").replace("{paramlink}",arg0).replace("{index}", String.valueOf(index))));
        webDriver.waitForElementLoad(1);
    }

    @Then("Freight Plan - Click on {int} Cloned Load Checkbox")
    public void freightPlanClickOnClonedLoadCheckbox(Integer arg0) throws Exception {
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("SelectCloneCheckbox").replace("{index}", String.valueOf(arg0)));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("SelectCloneCheckbox").replace("{index}", String.valueOf(arg0))));
        webDriver.waitForElementLoad(1);
    }

    @Then("Freight Plan - Click on Dropdown with Location {string}")
    public void freightPlanClickOnDropDownWithLocation(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("LocationDropdown").replace("{paramlink}",arg0)));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("LocationDropdown").replace("{paramlink}",arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("LocationDropdown").replace("{paramlink}",arg0)));
        webDriver.waitForElementLoad(1);
    }

    @Then("Freight Plan - Click on Dropdown with Location {string} inline with {string}")
    public void freightPlanClickOnDropDownWithLocationInlienWith(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("LocationDropdownWithSelectedCheckbox").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0)));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("LocationDropdownWithSelectedCheckbox").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("LocationDropdownWithSelectedCheckbox").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0)));
        webDriver.waitForElementLoad(1);
    }

    @Then("Freight Plan - Select Option {string} from Dropdown")
    public void freightPlanSelectOptionFromDropdown(String arg0) throws Exception {
        if (arg0.contains("SysData")) {
            arg0 = DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        webDriver.waitForElementLoad(1);
        String locator = pageObject.getlocator("FreightPlanDropdownOption").replace("{paramlink}", arg0);
        webDriver.waitUntilElementIsVisible(locator);
        webDriver.WaitforElementtobeclickable(locator);
        webDriver.safeJavaScriptClick(webDriver.getwebelement(locator));
        webDriver.waitForElementLoad(2);
    }

    @Then("Click on button with Title Text {string} within {string}")
    public void clickOnButtonWithTitleTextWithin(String arg0, String arg1) throws DocumentException, InterruptedException {
        int index = 1;
        if(arg0.contains("_"))
            {
                index = Integer.parseInt(arg0.split("_")[1]);
                arg0 = arg0.split("_")[0];
            }
        try {
             webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("FP_WithTitleButton").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0).replace("{index}", String.valueOf(index))));
             webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("FP_WithTitleButton").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0).replace("{index}", String.valueOf(index))));
            }
        catch (Exception e1)
            {
            webDriver.waitForElementLoad(2);
      //      webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("FP_WithTitleButton").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0).replace("{index}", String.valueOf(index))));
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("FP_WithTitleButton").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0).replace("{index}", String.valueOf(index)));
            webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("FP_WithTitleButton").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0).replace("{index}", String.valueOf(index))));
            }
        }

    @Then("Verify {string} tab is active")
    public void verifyTabIsActive(String arg0) throws Exception {
            List<WebElement> visibleTabs = webDriver.getwebelements(pageObject.getlocator("FP_Tabs"));
            System.out.println(visibleTabs);
        boolean tabFound = false;

        for(WebElement tab : visibleTabs) {
                System.out.println("Tab Text = [" + tab.getText() + "]");
                if(tab.getText().equalsIgnoreCase(arg0)){
                    tabFound=true;
                    tab.click();
                }
            }
            System.out.println("Expected = [" + arg0 + "]");
            //boolean tabFound = visibleTabs.stream().anyMatch(tab -> tab.getText().trim().equalsIgnoreCase(arg0));
            if (!tabFound) {
                webDriver.Clickon(webDriver.getwebelement(xml.getlocator("ButtonTitle").replace("{paramlink}","More Tabs")));
                webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("FP_MoreOptionLink").replace("{paramlink}",arg0)));
            }
        }

    @Then("Click on {string} icon under {string} within {string}")
    public void clickOnIconUnderWithin(String action, String sectionName, String tabName) throws Exception {
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("FP_FilterSection").replace("{paramlink1}",sectionName)));
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("FP_FilterSection").replace("{paramlink1}",sectionName)));
        webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("FP_Action").replace("{paramlink1}",tabName).replace("{paramlink2}",action)));
    }
}