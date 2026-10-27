package pageHelper.AfterTest.TMS.API_Operation;

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
public class After_Project44_Tracking_API {

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

    public After_Project44_Tracking_API(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        cm = new Common_Steps(DriverInstance);
        cf = new Common_Steps_Frame(DriverInstance);
        ca = new Common_Apis(DriverInstance);
        cff = new CommonFunction_Frame(DriverInstance);
        cmf = new CommonFunction(DriverInstance);
        hm = new Home_Page(DriverInstance);
    }

    @After(value = "@3575", order = 2)
    public void P44_Unified_Tracking_API_Test_Cleanup(Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);
        Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
        attempt = 0;
        success = false;

        cm.waitForSeconds("2");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                String[] containerNumbers = {"TRHU4563575", "TRHU5563575", "TRHU6563575", "TRHU7563575",
                        "TRHU9563575", "TRHU1063575", "TRHU1163575"};

                for (String container : containerNumbers) {

                    log("Reset Tracking Off for: " + container);
                    cm.navigateStoredURL("Load_1");
                    cm.waitForSeconds("2");
                    cm.goToTab("Shipment");
                    cm.scrollIntoSection("Containers");
                    cm.waitForSeconds("1");
                    cm.clickOn(container);
                    cm.waitForSeconds("2");
                    cm.scrollIntoSection("Tracking Information");
                    cm.clickOnEditIconOnLabel("Tracking");
                    cff.updateServicesData1("Tracking", "Off");
                    AGS.ClickonNativeSalesforceButton("Save");
                    cm.waitForSeconds("2");
                }


                log("Reset Global settings");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");

                AGS.searchTextInTheSearchBox("Project44 Tracking", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Project44 Tracking");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                AGS.searchTextInTheSearchBox("OpenTrack", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("OpenTrack");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                hm.DeleteJob("Queued Transactions");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Retry " + attempt + " failed: " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("Post cleanup failed after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@902", order = 2)
    public void P44_Unified_Tracking_API_Event_Processor_Test_Cleanup(Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);
        Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
        attempt = 0;
        success = false;

        cm.waitForSeconds("2");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                String container = "TRHU1233902";
                log("Reset Tracking Off for: " + container);
                cm.navigateStoredURL("Load_1");
                cm.waitForSeconds("2");
                cm.goToTab("Shipment");
                cm.scrollIntoSection("Containers");
                cm.waitForSeconds("1");
                cm.clickOn(container);
                cm.waitForSeconds("2");
                cm.scrollIntoSection("Tracking Information");
                cm.clickOnEditIconOnLabel("Tracking");
                cff.updateServicesData1("Tracking", "Off");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");


                log("Reset Global settings");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");

                AGS.searchTextInTheSearchBox("Project44 Tracking", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Project44 Tracking");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                AGS.searchTextInTheSearchBox("OpenTrack", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("OpenTrack");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                hm.DeleteJob("Queued Transactions");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Retry " + attempt + " failed: " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("Post  cleanup failed after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@1621", order = 2)
    public void P44_Unified_Tracking_API_1621(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("1. Email Carrier Two's TP > Carrier Operations tab > clear the DOT Number and SCAC values > save");
                cm.goToModule("Transportation Profiles");
                cm.SelectTPFromRecentlyView("Email Carrier Two");
                cm.scrollIntoSection("Fleet Summary");
                cm.clickOnEditIconOnLabel("SCAC");
                cm.enterLabelText("SCAC", "");
                cm.scrollIntoSection("US Registration");
                cm.enterLabelText("US DOT Number", "");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("US DOT Number", "");

                log("2. Load Tracking Administration Off");
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
        }
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));

        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3516", order = 2)
    public void P44_Unified_Tracking_API_3516(Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);
        Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
        attempt = 0;
        success = false;

        cm.waitForSeconds("2");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("1. Reset Tracking for Container");
                cm.navigateStoredURL("Container_1");
                cm.scrollIntoSection("Tracking Information");
                cm.clickOnEditIconOnLabel("Tracking");
                cff.updateServicesData1("Tracking", "Off");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");
                cm.verifyIsSetTo("Tracking", "Off");
                cf.clickOnButton("Delete");
                cf.clickOnLinkTextOnPage("Confirm","Delete");
                cm.verifyMessageAreDisplaying("was deleted.");

                log("2. Disabling Debugging Settings");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Retain API Response Packets", "False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                log("3. Reset Global settings");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");

                AGS.searchTextInTheSearchBox("OpenTrack", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("OpenTrack");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                log("4. Delete Scheduled Job");
                hm.DeleteJob("Queued Transactions");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Retry " + attempt + " failed: " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Post  cleanup failed after " + maxAttempts + " attempts.");
        }
    }
    @After(value = "@3537", order = 2)
    public void P44_Unified_Tracking_API_3537_Cleanup(Scenario scenario) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);
        Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);

        int cleanupAttempt = 0;
        boolean cleanupSuccessful = false;

        while (!cleanupSuccessful && cleanupAttempt < maxAttempts) {
            cleanupAttempt++;

            try {
                log("3537 cleanup: Turn container tracking off");

                cm.navigateStoredURL("Load_1");
                cm.waitForSeconds("2");
                cm.goToTab("Shipment");
                cm.scrollIntoSection("Containers");
                cm.waitForSeconds("1");

                // The SCAC container is created first in the feature file.
                cm.clickOn("TRHU1233537");
                cm.waitForSeconds("2");
                cm.scrollIntoSection("Tracking Information");
                cm.clickOnEditIconOnLabel("Tracking");
                cff.updateServicesData1("Tracking", "Off");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                log(" cleanup: Delete Queued Transaction scheduled job");
                hm.DeleteJob("Queued Transactions");
                cm.waitForSeconds("2");

                log(" cleanup: Enable OpenTrack");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");

                AGS.searchTextInTheSearchBox(
                        "OpenTrack",
                        "Search Credentials..."
                );
                AGS.selectTheRecordFromTheLookupFieldResults("OpenTrack");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                log(" cleanup: Enable Project44 Tracking");

                AGS.searchTextInTheSearchBox(
                        "Project44 Tracking",
                        "Search Credentials..."
                );
                AGS.selectTheRecordFromTheLookupFieldResults("Project44 Tracking");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                log(" cleanup: Restore Drayage mode configuration");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Modes");
                cm.switchToFrameByTitle("accessibility title");
                cf.clickOnLinkTextOnPage("Mode", "Drayage");
                cm.switchToParentFrame();

                cm.scrollIntoSection("General Settings");
                cm.clickOnEditIconOnLabel("Show Containers on Load Creation");
                cff.updateServicesData1(
                        "Show Containers on Load Creation",
                        "False"
                );
                cf.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                cleanupSuccessful = true;

            } catch (AssertionError | Exception e) {
                log(" cleanup attempt " + cleanupAttempt + " failed: " + e.getMessage());
            }
        }

        if (!cleanupSuccessful) {
            Assert.fail(" post-execution cleanup failed after "
                    + maxAttempts + " attempts.");
        }

        ca.deleteAllRecordsAssociatedToName(
                "TRHU1233537",
                "rtms__Container__c"
        );
    }
}