package pageHelper.Test.TMS.Transportation_Profile;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.Keys;
import org.testng.Assert;
import pageHelper.bddDriver;
import utils.DriverController;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.util.List;
import java.util.Map;

@Log4j
public class Transportation {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    public Transportation(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
        pageObject=new xmlreader("TMS"+ File.separator+"Transportation_Profile"+File.separator+"Transportation.xml");
    }
    @Then("Go to {string} Tab on Transportation Profile Page")
    public void goToTabOnTransporationProfilePage(String arg0) throws Exception {

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

    @Then("Open Carrier Rate Entry for {string}")
    public void openCarrierRateEntryFor(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("RateEntryRecords").replace("{paramlink}", arg0)));
        webDriver.waitforElementtobeclickable(pageObject.getlocator("RateEntryRecords").replace("{paramlink}", arg0));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("RateEntryRecords").replace("{paramlink}", arg0)));

    }

    @Then("Click on More next to {string}")
    public void clickOnNextTo(String arg1) throws Exception {
        webDriver.waitForElementLoad(1);
        if(webDriver.getwebelementscount(pageObject.getlocator("MoreTab").replace("{paramlink}",arg1))>0) {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("MoreTab").replace("{paramlink}", arg1)));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("MoreTab").replace("{paramlink}", arg1)));
        }
    }

    @Then("View All Records for {string}")
    public void ViewAll(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("ViewAllWithTable").replace("{paramlink}", arg0)));
        webDriver.waitforElementtobeclickable(pageObject.getlocator("ViewAllWithTable").replace("{paramlink}", arg0));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("ViewAllWithTable").replace("{paramlink}", arg0)));
    }

        @Then("Select Records {string} for Delete for {string}")
       public void selectRecordsForDelete(String arg0,String arg1) throws Exception {
        webDriver.waitForElementLoad(1);
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("MoreMenu").replace("{paramlink}",arg1).replace("{paramlink1}",arg0)));
        webDriver.waitforElementtobeclickable(pageObject.getlocator("MoreMenu").replace("{paramlink}",arg1).replace("{paramlink1}",arg0));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("MoreMenu").replace("{paramlink}",arg1).replace("{paramlink1}",arg0)));

    }

    @Then("Verify No Records with {string} equal to {string}")
    public void verifyNoRecordsWithEqualTo(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.verifyElementNotToBePresent(pageObject.getlocator("TableDataWithValue").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1));
    }

    @Then("Click on {string} having {string} equal to {string}")
    public void clickOnHavingEqualTo(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException {
        System.out.println(pageObject.getlocator("ClickOnRecordsWithRef").replace("{paramlink1}",arg1).replace("{paramlink2}",arg2).replace("{paramlink3}",arg0));
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("ClickOnRecordsWithRef").replace("{paramlink1}",arg1).replace("{paramlink2}",arg2).replace("{paramlink3}",arg0)));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("ClickOnRecordsWithRef").replace("{paramlink1}",arg1).replace("{paramlink2}",arg2).replace("{paramlink3}",arg0));
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("ClickOnRecordsWithRef").replace("{paramlink1}",arg1).replace("{paramlink2}",arg2).replace("{paramlink3}",arg0)));
    }

    @Then("Go to {string} Tab next to {string} Tab")
    public void goToTabOnLRPPage(String arg0, String arg1) throws Exception {
            webDriver.waitForElementLoad(1);
            if(webDriver.getwebelementscount(xml.getlocator("LinkText").replace("{paramlink}",arg0))>0) {
                webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LinkText").replace("{paramlink}", arg0)));
                webDriver.waitforElementtobeclickable(xml.getlocator("LinkText").replace("{paramlink}", arg0));
                webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("LinkText").replace("{paramlink}", arg0)));
            }
            else{
                webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("More_Tab_LRP").replace("{paramlink}",arg1)));
                webDriver.waitforElementtobeclickable(pageObject.getlocator("More_Tab_LRP").replace("{paramlink}",arg1));
                webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("More_Tab_LRP").replace("{paramlink}",arg1)));
                webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
                webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
                webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg0)));
            }

    }


}
