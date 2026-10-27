package pageHelper.Test.TMS.Load;

import com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter;
import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pageHelper.Utility.Common_Steps;
import pageHelper.Utility.TableVerifier;
import pageHelper.bddDriver;
import utils.DriverController;
import utils.PropertyReader;
//import utils.TableVerifier;
import utils.xmlreader;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Log4j
public class Load_FQA {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();

    public Load_FQA(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("TMS" + File.separator + "Load" + File.separator + "Load_FQA.xml");
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
    }


    @Then("Enter Carrier Service as {string}")
    public void selectCarrierServiceAs( String arg0) throws Exception {
        DriverInstance.setVariable("Carrier_Service", arg0);
        try {
            webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("Carrier_Service")));
            webDriver.waitUntilElementIsVisible(pageObject.getlocator("Carrier_Service"));
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("Carrier_Service"));
            webDriver.EnterTextUsingJS(webDriver.passwebelement(pageObject.getlocator("Carrier_Service")), arg0);
            webDriver.waitForElementLoad(1);
            webDriver.waitUntilElementIsVisible(xml.getlocator("Search_Result").replace("{paramlink}", arg0));
            webDriver.ClickOnElement(webDriver.passwebelement(xml.getlocator("Search_Result").replace("{paramlink}", arg0)));
        }
        catch (Exception e)
        {
            try {
                webDriver.waitForElementLoad(10);
                webDriver.EnterTextUsingJS(webDriver.passwebelement(pageObject.getlocator("Carrier_Service")), arg0);
                webDriver.waitForElementLoad(1);
                webDriver.waitUntilElementIsVisible(xml.getlocator("Search_Result").replace("{paramlink}", arg0));
                webDriver.ClickOnElement(webDriver.passwebelement(xml.getlocator("Search_Result").replace("{paramlink}", arg0)));
            }
            catch (Exception e1)
            {
                Assert.fail("Issue with selecting Carrier Service on FQA Page");
            }
        }
    }
    @Then("Enter Vendor Service as {string}")
    public void selectVendorServiceAs( String arg0) throws Exception {
        DriverInstance.setVariable("Carrier_Service", arg0);
        //Select Carrier
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(pageObject.getlocator("Vendor_Service")));
        webDriver.EnterTextUsingJS(webDriver.passwebelement(pageObject.getlocator("Vendor_Service")), arg0);
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("Search_Result").replace("{paramlink}", arg0)));
        webDriver.ClickOnElement(webDriver.passwebelement(xml.getlocator("Search_Result").replace("{paramlink}", arg0)));
    }
    @Then("Verify Available Option displaying as {string}")
    public void OptionDisplaying( String arg0) throws Exception {
        webDriver.waitforElementtobeclickable(xml.getlocator("Search_Result").replace("{paramlink}", arg0));
        webDriver.verifyElementToBePresent(xml.getlocator("Search_Result").replace("{paramlink}", arg0));
    }
    @Then("Verify Available Option Not displaying as {string}")
    public void OptionNotDisplaying( String arg0) throws Exception {
        webDriver.verifyElementNotToBePresent(xml.getlocator("Search_Result").replace("{paramlink}", arg0));
    }
    @Then("{string} Carrier")
    public void carrier(String arg0) throws Exception {
            webDriver.verifyElementToBePresent(pageObject.getlocator("Carrier_Action").replace("{paramlink}", arg0));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("Carrier_Action").replace("{paramlink}", arg0)));

    }
    @Then("{string} Vendor Quotes")
    public void VendorQuote(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("Vendor_Action").replace("{paramlink}", arg0)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("Vendor_Action").replace("{paramlink}", arg0)));

        webDriver.verifyElementToBePresent(pageObject.getlocator("Vendor_Action").replace("{paramlink}", arg0));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("Vendor_Action").replace("{paramlink}", arg0)));

    }

    @Then("{string} Customer Quotes")
    public void CustomerQuotes(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("Customer_Action").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(pageObject.getlocator("Customer_Action").replace("{paramlink}", arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("Customer_Action").replace("{paramlink}", arg0)));

    }

    public void FQA_Charge_Details(String Name, String ChargeName,String Value) throws DocumentException, InterruptedException {

        if(Value.equalsIgnoreCase("NA"))
        {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("Carrier_Unit_Price").replace("{NameField}",Name).replace("{paramlink}", ChargeName)));
            String Carrier_Unit_Price = webDriver.returnElementAttrubuteValue(webDriver.getwebelement(pageObject.getlocator("Carrier_Unit_Price").replace("{NameField}",Name).replace("{paramlink}", ChargeName)), "value");
            webDriver.Stringcomparator(Carrier_Unit_Price,"");
        }
        else {
            String[] Value1 = Value.split(",,");
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("Carrier_Unit").replace("{NameField}", Name).replace("{paramlink}", ChargeName)));
            String Unit = webDriver.getText(webDriver.getwebelement(pageObject.getlocator("Carrier_Unit").replace("{NameField}", Name).replace("{paramlink}", ChargeName)));
            String Total = webDriver.getText(webDriver.getwebelement(pageObject.getlocator("Total_Price").replace("{NameField}", Name).replace("{paramlink}", ChargeName)));

            String Carrier_Qty = webDriver.returAttrubuteValue(webDriver.passwebelement(pageObject.getlocator("Carrier_Qty").replace("{NameField}", Name).replace("{paramlink}", ChargeName)), "value");
            String Carrier_Unit_Price = webDriver.returAttrubuteValue(webDriver.passwebelement(pageObject.getlocator("Carrier_Unit_Price").replace("{NameField}", Name).replace("{paramlink}", ChargeName)), "value");

            String ExpectedUnitPrice = Value1[2];
            if (ExpectedUnitPrice.contains("SysData"))
            {
                ExpectedUnitPrice = DriverInstance.getVariable(ExpectedUnitPrice.split("=>")[1]);
            }
            String ExpectedTotal = Value1[3];
            if (ExpectedTotal.contains("SysData"))
            {
                ExpectedTotal = DriverInstance.getVariable(ExpectedTotal.split("=>")[1]);
            }

            webDriver.Stringcomparator(Unit,Value1[0]);
            webDriver.Stringcomparator(Carrier_Qty,Value1[1]);
            webDriver.Partialstringcomparator(Carrier_Unit_Price,ExpectedUnitPrice);
            webDriver.Partialstringcomparator(Total,ExpectedTotal);
        }
      }

    @Then("Verify Carrier {string} displaying as {string}")
    public void verifyCarrierDisplayingAs(String arg0, String arg1) throws DocumentException, InterruptedException {
       webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("SummaryCharges").replace("{paramlink}", arg0)));
       webDriver.waitUntilElementIsVisible(pageObject.getlocator("SummaryCharges").replace("{paramlink}", arg0));
        String Act_Charge = webDriver.getText(webDriver.passwebelement(pageObject.getlocator("SummaryCharges").replace("{paramlink}", arg0)));
        System.out.println("Actual Charge"+ Act_Charge);
        webDriver.Partialstringcomparator(Act_Charge, arg1);
    }

    @Then("Get Carrier {string}")
    public void getCarrierDetails(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("SummaryCharges").replace("{paramlink}", arg0)));
        String Act_Charge = webDriver.getText(webDriver.getwebelement(pageObject.getlocator("SummaryCharges").replace("{paramlink}", arg0)));
        DriverInstance.setVariable(arg0, Act_Charge);
    }

    @Then("Verify Customer {string} displaying as {string}")
    public void verifyCustomerDisplayingAs(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("CustomerSummaryText").replace("{paramlink}", arg0)));
        String Act_Charge = webDriver.getText(webDriver.getwebelement(pageObject.getlocator("CustomerSummaryText").replace("{paramlink}", arg0)));
        System.out.println("Actual Charge"+ Act_Charge);
        webDriver.Partialstringcomparator(Act_Charge, arg1);
    }

    @Then("Verify {string} {string} with details {string}")
    public void verifyCarrierQuoteItemWithDetails(String Name,String arg0, String arg1) throws DocumentException, InterruptedException {
        FQA_Charge_Details(Name,arg0,arg1);
    }

    @Then("Verify Carrier Pricing Notes displaying as {string}")
    public void verifyCarrierPricingNotesDisplayingAs(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementToBePresent(pageObject.getlocator("PricingNotesText").replace("{paramlink}", arg0));
    }
    @Then("Verify Carrier Pricing Notes not displaying as {string}")
    public void verifyCarrierPricingNotesNotDisplayingAs(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementNotToBePresent(pageObject.getlocator("PricingNotesText").replace("{paramlink}", arg0));
    }
    @Then("Verify Customer Pricing Notes displaying as {string}")
    public void verifyCustomerPricingNotesDisplayingAs(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementToBePresent(pageObject.getlocator("CustomerPricingNotesText").replace("{paramlink}", arg0));
    }


    @Then("Enter {string} {string} as {string}")
    public void enterCarrierAs(String Name,String arg0, String arg1) throws DocumentException, InterruptedException, IOException {
       webDriver.waitforElementtobeclickable(pageObject.getlocator("Carrier_Unit_Price").replace("{NameField}",Name).replace("{paramlink}", arg0));
       webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("Carrier_Unit_Price").replace("{NameField}",Name).replace("{paramlink}", arg0)),arg1);
    }
    @Then("Add Note for {string} {string} as {string}")
    public void addNoteForAs(String arg0, String arg1, String arg2) throws Exception {
        webDriver.waitforElementtobeclickable(pageObject.getlocator("QuoteItemMenu").replace("{NameField}",arg0).replace("{paramlink}", arg1));
        webDriver.safeJavaScriptClick(webDriver.passwebelement(pageObject.getlocator("QuoteItemMenu").replace("{NameField}",arg0).replace("{paramlink}", arg1)));
        webDriver.waitForElementLoad(2);
        webDriver.waitforElementtobeclickable(pageObject.getlocator("QuoteAddNotesButton").replace("{NameField}",arg0).replace("{paramlink}", arg1));
        webDriver.safeJavaScriptClick(webDriver.passwebelement(pageObject.getlocator("QuoteAddNotesButton").replace("{NameField}",arg0).replace("{paramlink}", arg1)));
        webDriver.waitForElementLoad(2);
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("QuoteNotes").replace("{NameField}",arg0).replace("{paramlink}", arg1));
        webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("QuoteNotes").replace("{NameField}",arg0).replace("{paramlink}", arg1)),arg2);
    }
    @Then("Set Carrier Quote value on to {string}")
    public void setFromFQAPage(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("Carrier_Quote")));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("Carrier_Quote")));
        String getText= webDriver.getText(webDriver.getwebelement(pageObject.getlocator("Carrier_Quote")));
        DriverInstance.setVariable(arg0,getText);
    }

    @Then("Set Vendor Quote value on to {string}")
    public void setVendorQuote(String arg0) throws DocumentException, InterruptedException {
        String getText= webDriver.getText(webDriver.getwebelement(pageObject.getlocator("Vendor_Quote")));
        DriverInstance.setVariable(arg0,getText);
    }

    //Vendor Methods

    @Then("Verify Vendor {string} displaying as {string}")
    public void verifyVendorDisplayingAs(String arg0, String arg1) throws DocumentException, InterruptedException {
        String Act_Charge = webDriver.getText(webDriver.getwebelement(pageObject.getlocator("VendorSummaryCharges").replace("{paramlink}", arg0)));
        webDriver.Partialstringcomparator(Act_Charge, arg1);
    }

    @Then("Click on Carrier Quote from FQA Page")
    public void clickOnCarrierQuoteFromFQAPage() throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("Carrier_Quote")));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("Carrier_Quote"));
        webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("Carrier_Quote")));
    }
    @Then("Store Carrier Quote value on {string}")
    public void StoreCarrierQuoteFromFQAPage(String args) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("Carrier_Quote")));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("Carrier_Quote"));
        String Quote=webDriver.getText(webDriver.getwebelement(pageObject.getlocator("Carrier_Quote")));
        DriverInstance.setVariable(args,Quote);
    }
    @Then("Click on Customer Quote from FQA Page")
    public void clickOnCustomerQuoteFromFQAPage() throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("Customer_Quote")));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("Customer_Quote"));
        webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("Customer_Quote")));
    }
    @Then("Store Customer Quote value on {string}")
    public void StoreCustomerQuoteFromFQAPage(String args) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("Customer_Quote")));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("Customer_Quote"));
        String Quote=webDriver.getText(webDriver.getwebelement(pageObject.getlocator("Customer_Quote")));
        DriverInstance.setVariable(args,Quote);
    }
    @Then("Click on Vendor Quote from FQA Page")
    public void clickOnVendorQuoteFromFQAPage() throws Exception {
       webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("Vendor_Quote")));
       webDriver.WaitforElementtobeclickable(pageObject.getlocator("Vendor_Quote"));
       webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("Vendor_Quote")));
    }
    @Then("Click on {string} link under {string} tab")
    public void clickOnLinkUnderTab(String arg0, String arg1) throws Exception {

        //Read the Attributes of "aria-controls"
        WebElement element= webDriver.getwebelement(xml.getlocator("LinkText").replace("{paramlink}",arg1));
        webDriver.Clickon(element);
        Thread.sleep(1000);
        WebElement element2= webDriver.getwebelement(xml.getlocator("LinkText").replace("{paramlink}",arg0));
        webDriver.Clickon(element2);
    }

    @Then("Click on {string} header link under {string} tab")
    public void clickOnHeaderLinkUnderTab(String arg0, String arg1) throws Exception {
        //Read the Attributes of "aria-controls"
        WebElement element= webDriver.getwebelement(xml.getlocator("LinkText").replace("{paramlink}",arg1));
        String paramlink1= webDriver.Getattribute(element,"aria-controls" );
        System.out.println("Updated paramlink1:"+paramlink1);
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("TabLink").replace("{Paramlink2}", paramlink1).replace("{Paramlink3}",arg0)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("TabLink").replace("{Paramlink2}", paramlink1).replace("{Paramlink3}",arg0)));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("TabLink").replace("{Paramlink2}", paramlink1).replace("{Paramlink3}",arg0)));
    }

    @And("Verify below Attributes on {string} Tab")
    public void verifyBelowAttributesOnTab(String arg0,DataTable dt) throws Exception {
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        WebElement element= webDriver.getwebelement(xml.getlocator("LinkText").replace("{paramlink}",arg0));
        String paramlink1= webDriver.Getattribute(element,"aria-controls" );
        webDriver.Clickon(element);
        Thread.sleep(5000);
        webDriver.Scrolltobottom();
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                WebElement targetedfieldlebel= webDriver.getwebelement(xml.getlocator("EntityAttributeDetail").replace("{paramlink1}",paramlink1).replace("{paramlink2}", entry.getKey()));
                Thread.sleep(1000);
                webDriver.ScrollIntoComplexView(xml.getlocator("Global_Text").replace("{paramlink}", arg0));
                webDriver.VerifyText(targetedfieldlebel,entry.getValue());
            }

//            }

        }
    }

    @Then("Add {string} {string} {string} Accessorial with Unit as {string} Qty as {string} and Price {string}")
    public void AddAccessorial(String Type, String Name,String arg0, String Unit,String qty, String price) throws Exception {
        //Add Accossoral Button
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("AddAccessorialButton").replace("{NameField}",Name)));
        webDriver.waitforElementtobeclickable(pageObject.getlocator("AddAccessorialButton").replace("{NameField}",Name));
        webDriver.Clickon(webDriver.passwebelement(pageObject.getlocator("AddAccessorialButton").replace("{NameField}",Name)));
        webDriver.waitForElementLoad(1);

        SelectDropdown(webDriver.passwebelement(pageObject.getlocator("SelectType").replace("{NameField}",Name)),Type);
        Thread.sleep(1000);
        SelectDropdown(webDriver.passwebelement(pageObject.getlocator("SelectAccessorial").replace("{NameField}",Name)),arg0);
        if(!Unit.equalsIgnoreCase("Fixed Cost")) {
            SelectDropdown(webDriver.passwebelement(pageObject.getlocator("SelectUnit").replace("{NameField}", Name).replace("{paramlink}", arg0)), Unit);
        }
        if(!qty.equalsIgnoreCase("1")) {
            webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("Carrier_Qty").replace("{NameField}", Name).replace("{paramlink}", arg0)));
            webDriver.waitforElementtobeclickable(pageObject.getlocator("Carrier_Qty").replace("{NameField}", Name).replace("{paramlink}", arg0));
            Thread.sleep(1000);
            webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("Carrier_Qty").replace("{NameField}", Name).replace("{paramlink}", arg0)), qty);
        }
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("Carrier_Unit_Price").replace("{NameField}",Name).replace("{paramlink}", arg0)));
        webDriver.waitforElementtobeclickable(pageObject.getlocator("Carrier_Unit_Price").replace("{NameField}",Name).replace("{paramlink}", arg0));
        Thread.sleep(1000);
        webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("Carrier_Unit_Price").replace("{NameField}",Name).replace("{paramlink}", arg0)),price);
        Thread.sleep(1000);
    }
    @Then("Add {string} {string} {string} with Unit as {string} Qty as {string} and Price {string}")
    public void Addquotedetails(String Type, String Name,String arg0, String Unit,String qty, String price) throws Exception {
        SelectDropdown(webDriver.passwebelement(pageObject.getlocator("SelectType").replace("{NameField}",Name)),Type);
        Thread.sleep(1000);
        SelectDropdown(webDriver.passwebelement(pageObject.getlocator("SelectAccessorial").replace("{NameField}",Name)),arg0);
        if(!Unit.equalsIgnoreCase("Fixed Cost")) {
            SelectDropdown(webDriver.passwebelement(pageObject.getlocator("SelectUnit").replace("{NameField}", Name).replace("{paramlink}", arg0)), Unit);
        }
        if(!qty.equalsIgnoreCase("1")) {
            webDriver.waitforElementtobeclickable(pageObject.getlocator("Carrier_Qty").replace("{NameField}", Name).replace("{paramlink}", arg0));
            Thread.sleep(1000);
            webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("Carrier_Qty").replace("{NameField}", Name).replace("{paramlink}", arg0)), qty);
        }

        webDriver.waitforElementtobeclickable(pageObject.getlocator("Carrier_Unit_Price").replace("{NameField}",Name).replace("{paramlink}", arg0));
        Thread.sleep(1000);
        webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("Carrier_Unit_Price").replace("{NameField}",Name).replace("{paramlink}", arg0)),price);
        Thread.sleep(1000);
    }

    @Then("Add {string} {string} {string} with Unit as {string} Qty as {string} and Price {string} with all details")
    public void AddquotedetailsForNetFreightChargeAndFS(String Type, String Name,String arg0, String Unit,String qty, String price) throws Exception {

        if(!Unit.equalsIgnoreCase("Fixed Cost")) {
            SelectDropdown(webDriver.passwebelement(pageObject.getlocator("SelectUnit").replace("{NameField}", Name).replace("{paramlink}", arg0)), Unit);
        }
        if(!qty.equalsIgnoreCase("1")) {
            webDriver.waitforElementtobeclickable(pageObject.getlocator("Carrier_Qty").replace("{NameField}", Name).replace("{paramlink}", arg0));
            Thread.sleep(1000);
            webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("Carrier_Qty").replace("{NameField}", Name).replace("{paramlink}", arg0)), qty);
        }

        webDriver.waitforElementtobeclickable(pageObject.getlocator("Carrier_Unit_Price").replace("{NameField}",Name).replace("{paramlink}", arg0));
        Thread.sleep(1000);
        webDriver.SendKeys(webDriver.passwebelement(pageObject.getlocator("Carrier_Unit_Price").replace("{NameField}",Name).replace("{paramlink}", arg0)),price);
        Thread.sleep(1000);
    }

    public void SelectDropdown(WebElement wl,String Options) throws Exception {

        String fieldName = wl.getAttribute("for");
        System.out.println(fieldName);
        WebElement element = webDriver.passwebelement(xml.getlocator("FormFields").replace("{paramlink}", fieldName));
        webDriver.ScrollIntoView(element);
        webDriver.Clickon(element);
        String SelectDiv = element.getAttribute("aria-controls");
        WebElement element1 = webDriver.passwebelement(xml.getlocator("FormFields").replace("{paramlink}", SelectDiv));
        webDriver.waitForElementLoad(1);
        WebElement Optionss= webDriver.getwebelement(xml.getlocator("Div_id_span_text").replace("{paramlink1}",SelectDiv).replace("{paramlink2}",Options));
        webDriver.SelectComboBoxOption(element1,Optionss);

    }

    @Then("Verify Quotes returned")
    public void verifyQuotesReturned() throws Exception {
       webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("ViewQuoteBtn")));
       int Count =  webDriver.getwebelementscount(pageObject.getlocator("QuotesCount"));
       Assert.assertTrue(Count>0);
       ExtentCucumberAdapter.addTestStepLog("Quotes returned:"+Count);
       System.out.println("Quotes returned:"+Count);
       webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("ViewQuoteBtn")));
       webDriver.waitForElementLoad(1);
    }
    @Then("Verify Quotes returned more than {string}")
    public void verifyQuotesReturnedmorethan(String arg0) throws Exception {
        webDriver.WaitForLongElementClickable(pageObject.getlocator("ViewQuoteBtn"));
        try {
            webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("ViewQuoteBtn")));
        }
        catch (Exception e)
        {
            webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("ViewQuoteBtn")));

        }
        int Count =  webDriver.getwebelementscount(pageObject.getlocator("QuotesCount"));
        Assert.assertTrue(Count>Integer.parseInt(arg0));
        ExtentCucumberAdapter.addTestStepLog("Quotes returned:"+Count);
        System.out.println("Quotes returned:"+Count);
        webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("ViewQuoteBtn")));


    }
    @Then("Set Vendor Invoice Number with Carrier Quote and {string} on {string}")
    public void setVendorInvoiceNumberWithCarrierQuoteOn(String arg0, String arg1) {
         System.out.println(DriverInstance.getVariable(arg0));
         System.out.println(DriverInstance.getVariable(arg0).length() - 1);
        String[] parts= DriverInstance.getVariable(arg0).trim().split(" ");
        String QuoteNum = parts[parts.length - 1];  // get last element
        DriverInstance.setVariable(arg1,"Carrier Quote "+QuoteNum);
    }

    @Then("Select {string} With Carrier Total as {string} from View Quotes")
    public void selectWithCarrierTotalAsFromViewQuotes(String arg0, String arg1) throws Exception {
        try {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("SelectCarrierServiceWithCarrierTotal").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("SelectCarrierServiceWithCarrierTotal").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
            webDriver.safeJavaScriptClick(webDriver.passwebelement(pageObject.getlocator("SelectCarrierServiceWithCarrierTotal").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
        }
        catch (Exception e)
        {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("SelectCarrierServiceWithCarrierTotal").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("SelectCarrierServiceWithCarrierTotal").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
            webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("SelectCarrierServiceWithCarrierTotal").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));

        }
    }
    @Then("Verify View Quotes for")
    public void verifyViewQuotesFor(DataTable dt) throws DocumentException, InterruptedException {
        List<Map<String, String>> data = dt.asMaps(String.class, String.class);
             for (Map<String, String> row : data) {
            String carrierService = row.get("Carrier_Service");
            String carrierTotal = row.get("Carrier Total");
            String transitTime = row.get("Estimated_Transit_Time");
            boolean accepted = Boolean.parseBoolean(row.get("Accepted"));
            boolean tenderHold = Boolean.parseBoolean(row.get("Tender_Hold"));
            webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("VerifyCarrierTotal").replace("{paramlink1}",carrierService).replace("{paramlink2}",carrierTotal)));
            webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyCarrierTotal").replace("{paramlink1}",carrierService).replace("{paramlink2}",carrierTotal));
            webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyEstimateTransitTime").replace("{paramlink1}",carrierService).replace("{paramlink2}",transitTime));
            WebElement wl = webDriver.passwebelement(pageObject.getlocator("VerifyAccepted").replace("{paramlink1}",carrierService));
            boolean isChecked  = "true".equalsIgnoreCase(wl.getAttribute("title"));
            Assert.assertEquals(isChecked,accepted);
            WebElement wl1 = webDriver.passwebelement(pageObject.getlocator("VerifyTenderHold").replace("{paramlink1}",carrierService));
            boolean isChecked1  = "true".equalsIgnoreCase(wl1.getAttribute("title"));
            Assert.assertEquals(isChecked1,tenderHold);

        }


    }

    @Then("Click on View Quotes")
    public void clickOnViewQuotes() throws DocumentException, InterruptedException {
        try {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("ViewQuoteBtn")));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("ViewQuoteBtn")));
            webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("ViewQuoteBtn")));
        }
        catch(Exception e)
        {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("ViewQuoteBtn")));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("ViewQuoteBtn")));
            webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("ViewQuoteBtn")));

        }
        }

    @And("Verify Carrier Service displaying as {string}")
    public void verifyCarrierServiceDisplayingAs(String arg0) throws DocumentException, InterruptedException {
        if(arg0.contains("SysData"))
        {
            arg0=DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("VerifyCarrierService").replace("{paramlink}",arg0)));
        webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyCarrierService").replace("{paramlink}",arg0));
    }

    @Then("Verify {string} Table With Details")
    public void verifyTableWithDetails(String arg0,DataTable dt) throws Exception {
        String tableXpath = xml.getlocator("TableName").replace("{paramlink}",arg0);
        webDriver.ScrollUsingJSUntilElementIsNotFound(tableXpath);
        List<Map<String, String>> expectedData = dt.asMaps(String.class, String.class);
//        TableVerifier verifier = new TableVerifier(bddDriver.getWebDriver());
        TableVerifier verifier = new TableVerifier(DriverInstance);
        // Specify which columns to verify — customize as needed
        List<String> columnsToVerify = new ArrayList<>(dt.row(0));
        verifier.verifyTableDetails1(tableXpath, expectedData, columnsToVerify);
    }

    @Then("Get {string} and store in {string}")
    public void getAndStoreIn(String label, String value) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("CarrierServiceValue").replace("{paramlink1}", label)));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("CarrierServiceValue").replace("{paramlink1}", label));
        String txt = webDriver.getText(webDriver.passwebelement(pageObject.getlocator("CarrierServiceValue").replace("{paramlink1}", label)));
        DriverInstance.setVariable(value,txt);
    }

    @Then("Click on Rate Entry within {string}")
    public void clickOnRateEntryWithin(String arg0) throws Exception {
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("RateEntryLink").replace("{paramlink1}",arg0)));
        webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("RateEntryLink").replace("{paramlink1}",arg0)));

    }

    @Then("Select {string} from View Quotes")
    public void selectAsFromViewQuotes(String arg0) throws Exception {
        if(arg0.contains("SysData")){
            String Value=arg0.split("=>")[1];
            webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("SelectCarrierServiceFromViewQuote").replace("{paramlink1}", DriverInstance.getVariable(Value))));
            webDriver.safeJavaScriptClick(webDriver.passwebelement(pageObject.getlocator("SelectCarrierServiceFromViewQuote").replace("{paramlink1}", DriverInstance.getVariable(Value))));
        }
        else{
        try {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("SelectCarrierServiceFromViewQuote").replace("{paramlink1}", arg0)));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("SelectCarrierServiceFromViewQuote").replace("{paramlink1}", arg0)));
            webDriver.safeJavaScriptClick(webDriver.passwebelement(pageObject.getlocator("SelectCarrierServiceFromViewQuote").replace("{paramlink1}", arg0)));
        }
        catch (Exception e)
        {
       //     webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("SelectCarrierServiceFromViewQuote").replace("{paramlink1}", arg0)));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("SelectCarrierServiceFromViewQuote").replace("{paramlink1}", arg0)));
            webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("SelectCarrierServiceFromViewQuote").replace("{paramlink1}", arg0)));

        }
        }
    }

    @Then("Select exact {string} from View Quotes")
    public void selectExactAsFromViewQuotes(String arg0) throws Exception {
        if(arg0.contains("SysData")){
            String Value=arg0.split("=>")[1];
            webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("SelectCarrierServiceFromViewQuote").replace("{paramlink1}", DriverInstance.getVariable(Value))));
            webDriver.safeJavaScriptClick(webDriver.passwebelement(pageObject.getlocator("SelectCarrierServiceFromViewQuote").replace("{paramlink1}", DriverInstance.getVariable(Value))));
        }
        else{
            try {
                webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("SelectCarrierServiceFromViewQuote1").replace("{paramlink1}", arg0)));
                webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("SelectCarrierServiceFromViewQuote1").replace("{paramlink1}", arg0)));
                webDriver.safeJavaScriptClick(webDriver.passwebelement(pageObject.getlocator("SelectCarrierServiceFromViewQuote1").replace("{paramlink1}", arg0)));
            }
            catch (Exception e)
            {
                //     webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("SelectCarrierServiceFromViewQuote").replace("{paramlink1}", arg0)));
                webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("SelectCarrierServiceFromViewQuote1").replace("{paramlink1}", arg0)));
                webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("SelectCarrierServiceFromViewQuote1").replace("{paramlink1}", arg0)));

            }
        }
    }

    @Then("Click on {string} link")
    public void clickOn_Link(String arg0) throws Exception {

        if(arg0.contains("SysData")){
            String value = arg0.split("=>")[1];
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("CarrierServiceFromCarrierQuote").replace("{paramlink}", DriverInstance.getVariable(value))));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("CarrierServiceFromCarrierQuote").replace("{paramlink}", DriverInstance.getVariable(value))));
            webDriver.waitForElementLoad(1);
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("CarrierServiceFromCarrierQuote").replace("{paramlink}", DriverInstance.getVariable(value))));
        }else
        {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("CarrierServiceFromCarrierQuote").replace("{paramlink}", arg0)));
            webDriver.waitUntilElementIsVisible(pageObject.getlocator("CarrierServiceFromCarrierQuote").replace("{paramlink}", arg0));
            webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("CarrierServiceFromCarrierQuote").replace("{paramlink}", arg0)));
        }

    }

    @Then("Verify Margin Text on Customer Quote is {string}")
    public void verifyMarginTextOnCustomerQuoteIs(String arg0) throws DocumentException, InterruptedException {
        String text=webDriver.GetText((webDriver.getwebelement(pageObject.getlocator("MarginText")))).replaceAll("\\s+", " ");
        webDriver.Partialstringcomparator(text,arg0);
    }

    @Then("Verify No Customer Quote Returned")
    public void verifyNoCustomerQuoteReturned() throws Exception {
       Common_Steps cm = new Common_Steps(this.DriverInstance);
       cm.verifyMessageAreDisplayingAs("New Customer Quote");
    }

    @Then("Verify No Carrier Quote Returned")
    public void verifyNoCarrierQuoteReturned() throws Exception {
        Common_Steps cm = new Common_Steps(this.DriverInstance);
        cm.verifyMessageAreDisplayingAs("New Carrier Quote");
    }

    @Then("Verify Customer Rate Entry {string} on Customer Quotes")
    public void verifyCustomerRateEntryOnCustomerQuotes(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("CustomerQuoteRateEntry")));
        String Act_Charge = webDriver.getText(webDriver.getwebelement(pageObject.getlocator("CustomerQuoteRateEntry")));
        System.out.println("Actual Charge"+ Act_Charge);
        webDriver.Partialstringcomparator(Act_Charge, DriverInstance.getVariable(arg0));
    }
    @Then("Verify Carrier Rate Entry {string} on Carrier Quotes")
    public void verifyCarrierRateEntryOnCarrierQuotes(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("CarrierQuoteRateEntry")));
        String Act_Charge = webDriver.getText(webDriver.getwebelement(pageObject.getlocator("CarrierQuoteRateEntry")));
        System.out.println("Actual Charge"+ Act_Charge);
        webDriver.Partialstringcomparator(Act_Charge, DriverInstance.getVariable(arg0));
    }



    @Then("To open the preview attachments")
    public void toOpenThePreviewAttachments() throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Global_Text").replace("{paramlink}","Preview Attachments")));
        webDriver.waitforElementtobeclickable(xml.getlocator("Global_Text").replace("{paramlink}","Preview Attachments"));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Global_Text").replace("{paramlink}","Preview Attachments")));
        webDriver.waitForElementLoad(8);
        try {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Preview_file")));
            webDriver.waitforElementtobeclickable(xml.getlocator("Preview_file"));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Preview_file")));
        } catch (Exception e) {
            webDriver.waitForElementLoad(8);
            try {
                webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Preview_file")));
                webDriver.waitforElementtobeclickable(xml.getlocator("Preview_file"));
                webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Preview_file")));
            }
            catch (Exception e1) {
               Assert.fail("Unable to Click Preview Attachment");
            }

        }
        }

    @Then("Select radio button for {string}")
    public void selectRadioButtonFor(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("radioButtonWithoutLabe")));
        webDriver.waitforElementtobeclickable(xml.getlocator("radioButtonWithoutLabe"));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("radioButtonWithoutLabe")));
    }

    @Then("Click on {string} button at Carrier Quote List LWC")
    public void clickOnButtonAtCarrierQuoteListLWC(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("CarrierQuoteListButton").replace("{paramlink}",arg0)));
        webDriver.waitforElementtobeclickable(xml.getlocator("CarrierQuoteListButton").replace("{paramlink}",arg0));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("CarrierQuoteListButton").replace("{paramlink}",arg0)));
    }

    @Then("Get Carrier Name from Carrier Service {string} and store into {string}")
    public void getCarrierNameFromCarrierService(String arg0, String arg1) {
        DriverInstance.setVariable(arg1,DriverInstance.getVariable(arg0).split("-")[0].trim());
    }

    @Then("Select radio button for value {string} in Carrier Quote List")
    public void selectRadioButtonForValueInCarrierQuoteList(String arg1) throws Exception {
        String locator = pageObject.getlocator("radioButtonWithValue").replace("{paramlink}", arg1);
        webDriver.ScrollIntoView(webDriver.getwebelement(locator));
        webDriver.waitforElementtobeclickable(locator);
        webDriver.Clickon(webDriver.getwebelement(locator));
    }

    @Then("Click on checkbox toggle {string}")
    public void clickOnCheckboxToggle(String arg0) throws Exception {
        String locator = pageObject.getlocator("AutoTenderOff").replace("{paramlink}", arg0);
        webDriver.ScrollIntoView(webDriver.getwebelement(locator));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("AutoTenderOff").replace("{paramlink}", arg0)));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("AutoTenderOff").replace("{paramlink}", arg0)));
    }

    @Then("Click on {string} button at Carrier Quote List LWC and select {string} from Show More Dropdown")
    public void clickOnButtonAtCarrierQuoteListLWCAndSelectFromShowMoreDropdown(String button, String option) throws Exception {
        // Click Show menu
        String buttonLocator = xml.getlocator("CarrierQuoteListButton").replace("{paramlink}", button);
        webDriver.ScrollIntoView(webDriver.getwebelement(buttonLocator));
        webDriver.waitforElementtobeclickable(buttonLocator);
        webDriver.Clickon(webDriver.getwebelement(buttonLocator));
        webDriver.waitForElementLoad(1);
        // Select option from Show Menu
        String optionLocator = pageObject.getlocator("CarrierQuoteListMenuOption").replace("{paramlink}", option);
        webDriver.waitUntilElementIsVisible(optionLocator);
        webDriver.Clickon(webDriver.getwebelement(optionLocator));
    }

}