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
public class After_Carrier_Markup {

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
    Admin_Global_Services AGS;

    public After_Carrier_Markup(bddDriver contextSteps) throws Exception {
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
        AGS= new Admin_Global_Services(DriverInstance);
    }

    @After(value = "@383",order=2)
    public void CarrierInvoice2232(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
            while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Global_Default_TP");
                cm.goToTab("Rates");
                cm.waitForSeconds("1");
                cm.clickOnEditIconOnLabel("Carrier Markup Group");
                cm.removeFromField("Carrier Service Markup","Carrier Markup Group");
                cf.clickOnButton("Save");
                cm.waitForSeconds("3");

                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
                System.out.println(e.getMessage());
            }

        }
        ca.DeleteRecords("rtms__RateEntry__c",DriverInstance.getVariable("Rate_Entry_1"));
        ca.DeleteRecords("rtms__CarrierMarkup__c",DriverInstance.getVariable("CarrierMarkup2"));
        ca.DeleteRecords("rtms__CarrierMarkup__c",DriverInstance.getVariable("CarrierMarkup"));
        ca.DeleteRecords("rtms__CarrierMarkupGroup__c",DriverInstance.getVariable("CarrierMarkupGroup"));

        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }

    }

    @After(value = "@3389",order=2)
    public void CarrierMarkup_RateIQ_3389(Scenario s) throws Exception {

        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("1. Reset Carrier Markup Group in Transportation Profile>Boston Beans ");
                cm.navigateStoredURL("TP_Link");
                cm.goToTab("Rates");
                cm.waitForSeconds("1");
                cm.clickOnEditIconOnLabel("Carrier Markup Group");
                cm.removeFromField("","Carrier Markup Group");
                cm.clickOnButtonOnDetailsPage("Save");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Carrier Markup Group", "");

                log("2. Reset RateIQ Rate Entry User to NULL in TMS Configuration");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Global Settings");
                AGS.updateTheCustomSelectOptionAs("RateIQ Rate Entry User","");
                cf.clickOnButtonWithValue("Save");
                cm.waitForSeconds("2");
                cm.switchToParentFrame();

                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
                System.out.println(e.getMessage());
            }
        }
        ca.DeleteRecords("rtms__RateEntry__c",DriverInstance.getVariable("Rate_Entry_1"));
        ca.DeleteRecords("rtms__CarrierMarkup__c",DriverInstance.getVariable("CarrierMarkup"));
        ca.DeleteRecords("rtms__CarrierMarkupGroup__c",DriverInstance.getVariable("CarrierMarkupGroup"));

        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }

    }
}
