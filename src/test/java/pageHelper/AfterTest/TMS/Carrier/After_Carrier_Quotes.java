package pageHelper.AfterTest.TMS.Carrier;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Admin.Admin_Global_Services;
import pageHelper.Test.TMS.Admin.Home_Page;
import pageHelper.Test.TMS.Object_Manager.Field_Set;
import pageHelper.Utility.*;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

import static pageHelper.bddDriver.log;

/**
 * @author manish.m
 */
@Slf4j
public class After_Carrier_Quotes {

    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    int maxAttempts = 3;  // Safety limit
    int attempt = 0;
    Common_Apis ca;
    boolean success = false;
    Common_Steps cm;
    Common_Steps_Frame cf;
    CommonFunction_Frame cff;
    CommonFunction cmf;
    Home_Page hm;
    public After_Carrier_Quotes(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
         cm = new Common_Steps(DriverInstance);
         cf=new Common_Steps_Frame(DriverInstance);
         ca = new Common_Apis(DriverInstance);
         cff=new CommonFunction_Frame(DriverInstance);
         cmf= new CommonFunction(DriverInstance);
        hm= new Home_Page(DriverInstance);
    }

    @After(value = "@2117",order=2)
    public void CarrierQuotes2117(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("TMS Admin > Document Options > Global > document -specific Settings > drop down the list to customer invoice > adjust the Customer Default Invoice Terms to 15 > save");
                Admin_Global_Services as = new Admin_Global_Services(DriverInstance);
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Document Options");
                cm.switchToFrameByTitle("accessibility title");
                cf.clickOnLinkTextOnPage("Link","Global Defaults");
                cm.switchToParentFrame();
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Enable Assign Carrier On Tender Option","True");
                cf.clickOnButtonWithValue("Save");
                cm.waitForSeconds("2");
                cm.switchToParentFrame();
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
                System.out.println(e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2258",order=2)
    public void CarrierQuotes2258(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
    }

    @After(value = "@398",order=2)
    public void CarrierQuotes398(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1L1CRI"));
        ca.DeleteRecords("rtms__RateEntry__c", DriverInstance.getVariable("Rate_Entry_1"));
        ca.DeleteRecords("rtms__RateEntry__c", DriverInstance.getVariable("Rate_Entry_2"));
        ca.DeleteRecords("rtms__RateEntry__c", DriverInstance.getVariable("Rate_Entry_3"));
        ca.DeleteRecords("rtms__CarrierLiabilityLimit__c", DriverInstance.getVariable("Liability"));
    }

    @After(value = "@2748",order=2)
    public void CarrierQuotes2748(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
    }
}
