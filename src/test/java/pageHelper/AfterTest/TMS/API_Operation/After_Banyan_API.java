package pageHelper.AfterTest.TMS.API_Operation;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.FMS.Fleet_Common;
import pageHelper.Test.TMS.Admin.Admin_Global_Services;
import pageHelper.Test.TMS.Admin.Configuration;
import pageHelper.Test.TMS.Admin.Home_Page;
import pageHelper.Test.TMS.Transportation_Profile.Transportation;
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
public class After_Banyan_API {

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

    public After_Banyan_API(bddDriver contextSteps) throws Exception {
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

    @After(value = "@2447",order=2)
    public void Banyan_2447(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));
        ca.DeleteRecords("rtms__RateEntry__c",DriverInstance.getVariable("Rate_Entry_1"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                //Step 1
                log("Resetting Global credentials for Project44");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("Project44", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Project44");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");
                AGS.searchTextInTheSearchBox("SMC3 EVA", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("SMC3 EVA");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2450",order=2)
    public void Banyan_2450(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));
        ca.DeleteRecords("rtms__RateEntry__c",DriverInstance.getVariable("Rate_Entry_1"));
        ca.deleteFieldWithTitle("BanyanQuoteOperation");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                //Step 1
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Customer Optional on Load Creation","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                //Step 2
                cm.navigateStoredURL("TP_Link");
                cm.goToTab("Rates");
                cm.clickOnEditIconOnLabel("Carrier API Login Group");
                cff.updateServicesData1("Carrier API Login Group", "");
                cm.clickOn("Save");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2451",order=2)
    public void Banyan_2451(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);

        ca.deleteFieldWithTitle("BanyanTenderOperation");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                //Step 1

                log("Disabling Debugging Settings");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");

                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");

                cff.updateServicesData1("Logging Enabled", "False");
                cff.updateServicesData1("Enable Packet Replay", "False");

                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                success = true;
                } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@769", order = 3)
    public void Banyan_Post_Test_Cleanup(Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);

        attempt = 0;
        success = false;

        // Step 1: Delete  (Load)
        String loadId = DriverInstance.getVariable("1LRI");
        if (loadId != null) {
            ca.DeleteRecords("rtms__Load__c", loadId);
        }

        // Step 2: Delete Scheduled Job

        hm.DeleteJob("QueuedTransactionJob");
        cm.waitForSeconds("2");
        // Step 3: Delete Banyan Files
        ca.deleteFieldWithTitle("BanyanStatusAllOperation");
        ca.deleteFieldWithTitle("BanyanGetDocumentOperation");

        cm.waitForSeconds("2");

        // Step 4: Disable Debugging Settings
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Disabling Debugging Settings");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");

                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");

                cff.updateServicesData1("Logging Enabled", "False");
                cff.updateServicesData1("Enable Packet Replay", "False");

                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Retry " + attempt + " failed: " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("Post  cleanup failed after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3505",order=2)
    public void Banyan_3505(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                hm.DeleteJob("LoadStatusUpdateJob");
                cm.waitForSeconds("2");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                Admin_Global_Services AGS=new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("Banyan", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Banyan");
                cff.updateServicesData1("Proxy URL","");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
}