package pageHelper.AfterTest.TMS.Load_Posting;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Admin.Admin_Authorized_Users;
import pageHelper.Test.TMS.Admin.Admin_Global_Services;
import pageHelper.Test.TMS.Load.Load_Summary;
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
public class After_TruckerTool_API {

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

    public After_TruckerTool_API(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
         cm = new Common_Steps(DriverInstance);
         cf=new Common_Steps_Frame(DriverInstance);
         ca = new Common_Apis(DriverInstance);
         cff=new CommonFunction_Frame(DriverInstance);
         cmf= new CommonFunction(DriverInstance);
    }

    @After(value = "@2932",order=2)
    public void Banyan_2447(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            Load_Summary ls = new Load_Summary(DriverInstance);
            try {
                cm.navigateStoredURL("Load_Details");
                cm.waitForSeconds("2");
                ls.selectTheRemoveActionNextToTheIntegrationListing("Trucker Tools Load Board");
                cm.verifyMessageAreDisplayingWith("Trucker Tools Load Board: This load posting was removed from the load board.");
                cm.waitForSeconds("1");
                cm.navigateStoredURL("OwnerPage");
                cm.waitForSeconds("6");
                cm.switchToFrameByTitle("User: User User ~ Salesforce - Enterprise Edition");
                cf.clickOnButtonWithTitle("Edit");
                cm.waitForSeconds("3");
                cm.switchToFrameByTitle("User Edit: User User ~ Salesforce - Enterprise Edition");
                cf.EnterWithId("","Phone");
                cf.EnterWithId("","Extension");
                cm.waitForSeconds("1");
                cf.clickOnButtonWithTitle("Save");
                cm.waitForSeconds("3");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }

    }

    @After(value = "@2937",order=2)
    public void Banyan_2937(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            Load_Summary ls = new Load_Summary(DriverInstance);
            try {
                cm.navigateStoredURL("Load_Details");
                cm.waitForSeconds("2");
                ls.selectTheRemoveActionNextToTheIntegrationListing("Trucker Tools Load Board");
                cm.verifyMessageAreDisplayingWith("Trucker Tools Load Board: This load posting was removed from the load board.");
                cm.waitForSeconds("1");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Freeze Load Number","True");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }

    }

    @After(value = "@1581",order=2)
    public void MacroPoint_1564(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Load_1");
                cm.clickOnNativeIcon("Load Tracking");
                cf.verifyMessageAreDisplayingAs("Load Tracking Administration");
                cf.ClickonNativeSalesforceButton("Off");
                cm.verifyMessageAreDisplaying("Success - Carrier Banner");
                cm.closeToastMessage();
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
                System.out.println(e.getMessage());
            }
            ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));

        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@1597",order=2)
    public void TruckerTool_1597(Scenario s) throws Exception {
            ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));

    }

    @After(value = "@1596",order=2)
    public void TT_1596(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Load_1");
                cm.clickOnNativeIcon("Load Tracking");
                cf.verifyMessageAreDisplayingAs("Load Tracking Administration");
                cf.ClickonNativeSalesforceButton("Off");
                cm.verifyMessageAreDisplaying("Success - Carrier Banner");
                cm.closeToastMessage();
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
                System.out.println(e.getMessage());
            }
            ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));

        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
}