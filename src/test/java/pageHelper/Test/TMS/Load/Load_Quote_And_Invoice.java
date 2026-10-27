package pageHelper.Test.TMS.Load;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.codehaus.plexus.personality.plexus.lifecycle.phase.Suspendable;
import org.dom4j.DocumentException;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pageHelper.Utility.CommonFunction;
import pageHelper.bddDriver;
import utils.DriverController;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import static pageHelper.bddDriver.isDouble;
import static pageHelper.bddDriver.isInteger;

@Log4j
public class Load_Quote_And_Invoice {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader iframexml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();

    public Load_Quote_And_Invoice(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("TMS" + File.separator + "Load" + File.separator + "Load_Quote_And_Invoice.xml");
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        iframexml = new xmlreader("Generics" + File.separator + "CommonFrame.xml");
    }

    @Then("Go to {string} Tab on Next to {string} Tab")
    public void goToTabOnNextToTab(String arg0, String arg1) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("TabWithSibling").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0)));
        webDriver.waitforElementtobeclickable(pageObject.getlocator("TabWithSibling").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("TabWithSibling").replace("{paramlink1}",arg1).replace("{paramlink2}",arg0)));

    }

    @Then("Open {string} from QuoteInvoice Tab")
    public void openFromQuoteInvoiceTab(String arg0) throws Exception {
    }

    @Then("Scroll into {string} on QuoteInvoice Tab")
    public void scrollIntoOnQuoteInvoiceTab(String arg0) throws InterruptedException, DocumentException {
        webDriver.scrollDownWithJS(2);
        try {
            webDriver.ScrollUsingJSUntilElementIsNotFound(xml.getlocator("Global_Text").replace("//*", "//h2//*").replace("{paramlink}", arg0));
            webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("//*", "//h2//*").replace("{paramlink}", arg0)));
        }
        catch(Exception e)
        {
            webDriver.ScrollUsingJSUntilElementIsNotFound(xml.getlocator("Global_Text").replace("//*", "//h2//*").replace("{paramlink}", arg0));
            webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("//*", "//h2//*").replace("{paramlink}", arg0)));
        }
    }

    @Then("Open {string} using value from {string} on QuoteInvoice Tab")
    public void openFromOnQuoteInvoiceTab(String arg0, String arg1) throws Exception {
        webDriver.scrollDownWithJS(2);
        try {
            webDriver.ScrollUsingJSUntilElementIsNotFound(xml.getlocator("Global_Text").replace("//*", "//h2//*").replace("{paramlink}", arg0));
            webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("//*", "//h2//*").replace("{paramlink}", arg0)));
            webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("//*", "//a//span").replace("{paramlink}", DriverInstance.getVariable(arg1))));
            webDriver.waitforElementtobeclickable(xml.getlocator("Global_Text").replace("//*", "//a//span").replace("{paramlink}", DriverInstance.getVariable(arg1)));
            webDriver.ClickOnElement(webDriver.passwebelement(xml.getlocator("Global_Text").replace("//*", "//a//span").replace("{paramlink}", DriverInstance.getVariable(arg1))));
        }
        catch(Exception e)
        {
            webDriver.ScrollUsingJSUntilElementIsNotFound(xml.getlocator("Global_Text").replace("//*", "//h2//*").replace("{paramlink}", arg0));
            webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("//*", "//h2//*").replace("{paramlink}", arg0)));
            webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("//*", "//a//span").replace("{paramlink}", DriverInstance.getVariable(arg1))));
            webDriver.waitforElementtobeclickable(xml.getlocator("Global_Text").replace("//*", "//a//span").replace("{paramlink}", DriverInstance.getVariable(arg1)));
            webDriver.ClickOnElement(webDriver.passwebelement(xml.getlocator("Global_Text").replace("//*", "//a//span").replace("{paramlink}", DriverInstance.getVariable(arg1))));

        }
        }

    @Then("Open {string} from QuoteInvoice Tab with Vendor Price {string}")
    public void openFromQuoteInvoiceTabWithVendorPrice(String arg0, String arg1) throws Exception {
        webDriver.scrollDownWithJS(8);
        webDriver.waitForElementLoad(2);
        webDriver.ScrollIntoComplexView(xml.getlocator("Global_Text").replace("//*","//h2//*").replace("{paramlink}", arg0));
        webDriver.waitforElementtobeclickable(pageObject.getlocator("VendorQuoteByPrice").replace("{paramlink}",arg1));
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("VendorQuoteByPrice").replace("{paramlink}",arg1)));
    }

    @Then("Verify Quote Banner Details")
    public void verifyBannerDetails(DataTable dt) throws Exception {
        CommonFunction cf = new CommonFunction(DriverInstance);
        Thread.sleep(3000);
        cf.ValidateBanner(dt);
    }
    public void ValidateBanner(DataTable dt) throws DocumentException, InterruptedException {

        java.util.List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                try{
                    webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("VerifySummaryFields").replace("{paramlink}", entry.getKey())));
                    WebElement element = webDriver.getwebelement(pageObject.getlocator("VerifySummaryFields").replace("{paramlink}", entry.getKey()));
                    String Text=webDriver.getText(element);
                    System.out.println("Values Fetched is : " + Text);
                    if(entry.getValue().equalsIgnoreCase("NA"))
                    {
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, "");
                    }
                    else if(entry.getValue().contains("Number"))
                    {
                        System.out.println("Values are: " + Text);
                        if(Text.contains(".")) {
                            Assert.assertTrue(isDouble(Text.replace(",","")));
                        }
                        else{
                            Assert.assertTrue(isInteger(Text.replace(",","")));

                        }
                    }

                    else if (entry.getKey().contains("Date"))
                    {
                        webDriver.Partialstringcomparator(Text,webDriver.ReturnDate( entry.getValue()));
                    }
                    else {
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, entry.getValue());
                    }}
                catch(Exception e)
                {
                    webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("VerifySummaryFields").replace("{paramlink}", entry.getKey())));
                    WebElement element = webDriver.passwebelement(pageObject.getlocator("VerifySummaryFields").replace("{paramlink}", entry.getKey()));
                    String Text = element.getText();
                    if(entry.getValue().equalsIgnoreCase("NA"))
                    {
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, "");
                    }
                    else {
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, entry.getValue());
                    }
                }
            }
        }
    }

    @Then("Edit the {string} from grid")
    public void editTheGridData(String AccessorialName) throws Exception {
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("AccessorialNameRecord").replace("{paramlink}", AccessorialName));
        webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("AccessorialNameRecord").replace("{paramlink}", AccessorialName)));
        Thread.sleep(2000);
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("Global_Text").replace("//*", "//button").replace("{paramlink}", "Edit")));
        Thread.sleep(2000);
    }
    @Then("Click the {string} from grid")
    public void ClickTheGridData(String AccessorialName) throws Exception {
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("AccessorialNameRecord").replace("{paramlink}", AccessorialName));
        webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("AccessorialNameRecord").replace("{paramlink}", AccessorialName)));
        Thread.sleep(2000);
    }

    @Then("Update the {string} accessorial data")
    public void updateTheAccessoialData(String AccessorialName, DataTable dt) throws Exception {
        webDriver.SwitchToFrameByElement(webDriver.getwebelement("//div[contains(@class,'active')]//iframe"));

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);

        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                String initialHeaderName = webDriver.passwebelement(pageObject.getlocator("TableColumnHeader").replace("{paramlink}", entry.getKey())).getAttribute("id");
                String HeaderName = initialHeaderName.replace("header:sortDiv","");
                HeaderName=HeaderName.substring(HeaderName.lastIndexOf(":")+1);
                webDriver.waitForElementLoad(1);
                webDriver.waitUntilElementIsVisible(pageObject.getlocator("RowData").replace("{paramlink}",AccessorialName));
                webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("RowData").replace("{paramlink}",AccessorialName)));
                String InitialRowID= webDriver.getwebelement(pageObject.getlocator("RowData").replace("{paramlink}",AccessorialName)).getAttribute("id");
                System.out.println("Row ID "+ InitialRowID);
                String RowID= InitialRowID.substring(0,InitialRowID.lastIndexOf(":"));
                System.out.println("Updated Row ID "+ RowID);

                String FinalElement =RowID +":"+HeaderName;
                System.out.println("Final Element "+ FinalElement);
                WebElement element = webDriver.getwebelement(pageObject.getlocator("InputField").replace("{paramlink}", FinalElement));
                webDriver.waitForElementLoad(1);
                webDriver.ScrollIntoView(element);
                String Tag = element.getTagName();
                String type = element.getAttribute("type");

                if (Tag.equalsIgnoreCase("input") && type.equalsIgnoreCase("text")) {
                    //   webDriver.SendKeys(element, DriverInstance.getThreadLocalMapValue(entry.getKey()));
                    webDriver.SendKeys(element,entry.getValue());
                    Thread.sleep(2000);

                } else if (Tag.equalsIgnoreCase("select")) {
                    System.out.println(1);
                    webDriver.selectOptionByValue(element,entry.getValue());
                    System.out.println(2);

                }
                webDriver.waitForElementLoad(1);
            }
            webDriver.ScrollIntoView(webDriver.getwebelement(iframexml.getlocator("InputValue").replace("{paramlink}","Save")));
            webDriver.waitforElementtobeclickable(iframexml.getlocator("InputValue").replace("{paramlink}","Save"));
            webDriver.Clickon(webDriver.getwebelement(iframexml.getlocator("InputValue").replace("{paramlink}","Save")));
            Thread.sleep(2000);
            webDriver.SwitchToParentFrame();
        }
    }

    @Then("Update {string} accessorial data")
    public void updateAccessoialData(String AccessorialName, DataTable dt) throws Exception {
        webDriver.SwitchToFrameByElement(webDriver.getwebelement("//div[contains(@class,'active')]//iframe"));

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);

        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                String initialHeaderName = webDriver.passwebelement(pageObject.getlocator("TableColumnHeader").replace("{paramlink}", entry.getKey())).getAttribute("id");
                String HeaderName = initialHeaderName.replace("header:sortDiv","");
                HeaderName=HeaderName.substring(HeaderName.lastIndexOf(":")+1);
                webDriver.waitUntilElementIsVisible(pageObject.getlocator("RowData").replace("{paramlink}",AccessorialName));
                webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("RowData").replace("{paramlink}",AccessorialName)));
                String InitialRowID= webDriver.getwebelement(pageObject.getlocator("RowData").replace("{paramlink}",AccessorialName)).getAttribute("id");
                System.out.println("Row ID "+ InitialRowID);
                String RowID= InitialRowID.substring(0,InitialRowID.lastIndexOf(":"));
                System.out.println("Updated Row ID "+ RowID);

                String FinalElement =RowID +":"+HeaderName;
                System.out.println("Final Element "+ FinalElement);
                WebElement element = webDriver.getwebelement(pageObject.getlocator("InputField").replace("{paramlink}", FinalElement));
                webDriver.waitForElementLoad(1);
                webDriver.ScrollIntoView(element);
                String Tag = element.getTagName();
                String type = element.getAttribute("type");

                if (Tag.equalsIgnoreCase("input") && type.equalsIgnoreCase("text")) {
                    //   webDriver.SendKeys(element, DriverInstance.getThreadLocalMapValue(entry.getKey()));
                    webDriver.SendKeys(element,entry.getValue());
                    Thread.sleep(2000);

                } else if (Tag.equalsIgnoreCase("select")) {
                    System.out.println(1);
                    webDriver.selectOptionByValue(element,entry.getValue());
                    System.out.println(2);

                }
                webDriver.waitForElementLoad(1);
            }
            Thread.sleep(3000);
            webDriver.SwitchToParentFrame();
        }
    }

    @Then("Delete {string} record from grid")
    public void deleteRecordFromGrid(String AccessorialName) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("AccessorialNameRecord").replace("{paramlink}", AccessorialName)));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("AccessorialNameRecord").replace("{paramlink}", AccessorialName));
        webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("AccessorialNameRecord").replace("{paramlink}", AccessorialName)));
        Thread.sleep(2000);
        webDriver.waitforElementtobeclickable(xml.getlocator("Global_Text").replace("//*","//button").replace("{paramlink}","Delete"));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("Global_Text").replace("//*","//button").replace("{paramlink}","Delete")));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("ModalButtons").replace("{paramlink}","Delete")));
        Thread.sleep(4000);
    }

    @Then("Verify {string} count displaying as {string}")
    public void verifyCountDisplayingAs(String arg0, String arg1)  throws Exception{
      webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("Verify_count").replace("{paramlink}", arg0)));
      webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("Verify_count").replace("{paramlink}", arg0)));
      String count=  webDriver.getText(webDriver.getwebelement(pageObject.getlocator("Verify_count").replace("{paramlink}", arg0)));
      webDriver.Stringcomparator(count.replace("(","").replace(")",""),arg1);

    }


    @Then("Open Records of {string} for {string}")
    public void openRecordsOfFor(String arg0, String arg1) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("OpenTabularRecords").replace("{paramlink}", arg1).replace("{paramlink1}", arg0)));
        webDriver.waitforElementtobeclickable(pageObject.getlocator("OpenTabularRecords").replace("{paramlink}", arg1).replace("{paramlink1}", arg0));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("OpenTabularRecords").replace("{paramlink}", arg1).replace("{paramlink1}", arg0)));
    }

    @Then("Click on {string} Button on {string}")
    public void clickOnButtonOn(String arg0, String arg1) throws Exception {
        webDriver.ScrollUsingJSUntilElementIsNotFound(pageObject.getlocator("ButtonOnRelatedList").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0));
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("ButtonOnRelatedList").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("ButtonOnRelatedList").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
        webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("ButtonOnRelatedList").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));

    }

    @And("Scroll Until Related List for {string}")
    public void clickOnLink(String arg0) throws Exception {
        webDriver.ScrollUsingJSUntilElementIsNotFound(xml.getlocator("Global_Text").replace("//*", "//h2//*").replace("{paramlink}", arg0));
         }

    @Then("Click on Remove action for Accessorials {string}")
    public void clickOnActionForAccessorials(String arg0) throws Exception {
        webDriver.SwitchToFrameByElement(webDriver.getwebelement("//div[contains(@class,'active')]//iframe"));
        webDriver.BrowserZoom("70");
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("RemoveAccessorials").replace("{paramlink}", arg0)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("RemoveAccessorials").replace("{paramlink}", arg0)));
        webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("RemoveAccessorials").replace("{paramlink}", arg0)));
        webDriver.waitForElementLoad(1);
        webDriver.ScrollIntoView(webDriver.getwebelement(iframexml.getlocator("InputValue").replace("{paramlink}","Save")));
        webDriver.waitforElementtobeclickable(iframexml.getlocator("InputValue").replace("{paramlink}","Save"));
        webDriver.Clickon(webDriver.getwebelement(iframexml.getlocator("InputValue").replace("{paramlink}","Save")));
        Thread.sleep(1000);
        webDriver.BrowserZoom("100");
        webDriver.SwitchToParentFrame();
    }

    @Then("Verify No Records Available with {string}")
    public void verifyNoRecordsAvailableWith(String arg0) throws DocumentException, InterruptedException {
      webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("VerifyNoRecords").replace("{paramlink}", arg0)));
      webDriver.waitUntilElementIsVisible(pageObject.getlocator("VerifyNoRecords").replace("{paramlink}", arg0));
      webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyNoRecords").replace("{paramlink}", arg0));



    }

    @Then("Go to {string} Tab with More Menu")
    public void goToTabWithMoreMenu(String arg0) throws Exception {
        webDriver.waitForElementLoad(1);
        if(webDriver.getwebelementscount(xml.getlocator("LinkText").replace("{paramlink}",arg0))>0) {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LinkText").replace("{paramlink}", arg0)));
            webDriver.waitforElementtobeclickable(xml.getlocator("LinkText").replace("{paramlink}", arg0));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("LinkText").replace("{paramlink}", arg0)));
        }
        else{
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("MoreTab")));
            webDriver.waitforElementtobeclickable(pageObject.getlocator("MoreTab"));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("MoreTab")));
            webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
            webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
        }
    }
}