package pageHelper.AfterTest.TMS.API_Operation;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Admin.Admin_Global_Services;
import pageHelper.Test.TMS.Admin.Home_Page;
import pageHelper.Utility.*;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

import static pageHelper.bddDriver.log;

/**
 * @author Sufiya
 */
@Slf4j
public class After_HighWay_API {

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
    public After_HighWay_API(bddDriver contextSteps) throws Exception {
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

    @After(value = "@2740", order = 2)
    public void HighWay_API_2740(Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);
        attempt = 0;
        success = false;

        cm.waitForSeconds("2");

        //Step 3: Delete "QA Shipment LLC 2740" carrier service
        ca.deleteAllRecordsAssociatedToName("QA Shipment LLC 2740","rtms__CarrierService__c");

        // Step 4: Delete "QA Shipment LLC 2740" Transportation Profile
        ca.deleteAllRecordsAssociatedToName("QA Shipment LLC 2740","rtms__TransportationProfile__c");

        // Step 5: Delete "QA Shipment LLC 2740" Account
        ca.deleteAllRecordsAssociatedToName("QA Shipment LLC 2740","Account");


        // Step 1: Disable Debugging Settings
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {

                log("Reset Global settings");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("SaferWatch", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("SaferWatch");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                AGS.searchTextInTheSearchBox("RMIS", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("RMIS");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                AGS.searchTextInTheSearchBox("MyCarrierPackets", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("MyCarrierPackets");
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

    @After(value = "@2737", order = 2)
    public void HighWay_API_2737(Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);
        attempt = 0;
        success = false;

        cm.waitForSeconds("2");

        //Step 3: Delete "QA Shipment LLC 2740" carrier service
        ca.deleteAllRecordsAssociatedToName("QA Trans LLC 2737","rtms__CarrierService__c");

        // Step 4: Delete "QA Shipment LLC 2740" Transportation Profile
        ca.deleteAllRecordsAssociatedToName("QA Trans LLC 2737","rtms__TransportationProfile__c");

        // Step 5: Delete "QA Shipment LLC 2740" Account
        ca.deleteAllRecordsAssociatedToName("QA Trans LLC 2737","Account");


        // Step 1: Disable Debugging Settings
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {

                log("Reset Global settings");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Allow Carrier Address Updates","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                cm.waitForSeconds("2");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("SaferWatch", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("SaferWatch");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                AGS.searchTextInTheSearchBox("RMIS", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("RMIS");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                AGS.searchTextInTheSearchBox("MyCarrierPackets", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("MyCarrierPackets");
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

    @After(value = "@2721", order = 2)
    public void HighWay_API_2721(Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);
        attempt = 0;
        success = false;

        cm.waitForSeconds("2");

        //Step 3: Delete "QA Shipment LLC 2740" carrier service
        ca.deleteAllRecordsAssociatedToName("Quality Assurance Trans LLC 2721","rtms__CarrierService__c");
        ca.deleteAllRecordsAssociatedToName("Quality Assurance Trans LLC 2721","rtms__TransportationProfile__c");
        ca.deleteAllRecordsAssociatedToName("Quality Assurance Trans LLC 2721","Account");

        ca.deleteAllRecordsAssociatedToName("Quality Assurance Service Inc 2721","rtms__CarrierService__c");
        ca.deleteAllRecordsAssociatedToName("Quality Assurance Service Inc 2721","rtms__TransportationProfile__c");
        ca.deleteAllRecordsAssociatedToName("Quality Assurance Service Inc 2721","Account");

        ca.deleteAllRecordsAssociatedToName("Quality Assurance Express 2721","rtms__CarrierService__c");
        ca.deleteAllRecordsAssociatedToName("Quality Assurance Express 2721","rtms__TransportationProfile__c");
        ca.deleteAllRecordsAssociatedToName("Quality Assurance Express 2721","Account");

        ca.deleteAllRecordsAssociatedToName("18 WHEEL FUNDING LLC","Account");
        ca.deleteAllRecordsAssociatedToName("7-Day Quick Pay (ACH, Check issued on 7th Day)","rtms__PaymentTerms__c");


        // Step 1: Disable Debugging Settings
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {

                log("Reset Global settings");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("SaferWatch", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("SaferWatch");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                AGS.searchTextInTheSearchBox("RMIS", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("RMIS");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                AGS.searchTextInTheSearchBox("MyCarrierPackets", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("MyCarrierPackets");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Modes");
                cm.switchToFrameByTitle("accessibility title");
                cf.clickOnLinkTextOnPage("Mode","Air Freight");
                cm.switchToParentFrame();
                cm.clickOnEditIconOnLabel("Name");
                cff.updateServicesData1("Enabled", "true");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("2");
                cmf.VerifyLabelCheckboxWithParam("Enabled","true");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Modes");
                cm.switchToFrameByTitle("accessibility title");
                cf.clickOnLinkTextOnPage("Mode","Parcel");
                cm.switchToParentFrame();
                cm.scrollIntoSection("Carrier Onboarding Settings");
                cm.clickOnEditIconOnLabel("Highway Mode");
                cm.enterLabelText("Highway Mode", "Parcel");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("2");
                cmf.ValidateDetailsWithParam("Highway Mode", "Parcel");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Modes");
                cm.switchToFrameByTitle("accessibility title");
                cf.clickOnLinkTextOnPage("Mode","Truckload");
                cm.switchToParentFrame();
                cm.scrollIntoSection("Carrier Onboarding Settings");
                cm.clickOnEditIconOnLabel("Highway Mode");
                cm.enterLabelText("Highway Mode", "Truckload");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("2");
                cmf.ValidateDetailsWithParam("Highway Mode","Truckload");
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
    @After(value = "@2739", order = 2)
    public void HighWay_API_2739(Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);
        attempt = 0;
        success = false;

        cm.waitForSeconds("2");

        // Delete Carrier Service
        ca.deleteAllRecordsAssociatedToName("QA Trans LLC 2739","rtms__CarrierService__c");

        // Delete Transportation Profile
        ca.deleteAllRecordsAssociatedToName("QA Trans LLC 2739","rtms__TransportationProfile__c");

        // Delete Account
        ca.deleteAllRecordsAssociatedToName("QA Trans LLC 2739","Account");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {

                log("Reset Global settings");

                // Reset Allow Carrier Address Updates
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Allow Carrier Address Updates","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                cm.waitForSeconds("2");

                // Re-enable Credentials
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");

                Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);

                AGS.searchTextInTheSearchBox("SaferWatch", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("SaferWatch");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                AGS.searchTextInTheSearchBox("RMIS", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("RMIS");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                AGS.searchTextInTheSearchBox("MyCarrierPackets", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("MyCarrierPackets");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                // Delete Queued Transaction Job
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

    @After(value = "@2723", order = 2)
    public void HighWay_API_2723(Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);
        attempt = 0;
        success = false;

        cm.waitForSeconds("2");

        ca.deleteAllRecordsAssociatedToFieldName("rtms__Processor__c", "HighwayInbound", "rtms__QueuedTransaction__c");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {

                log("Reset Global settings");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("SaferWatch", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("SaferWatch");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                AGS.searchTextInTheSearchBox("RMIS", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("RMIS");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                AGS.searchTextInTheSearchBox("MyCarrierPackets", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("MyCarrierPackets");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                hm.DeleteJob("CarrierMonitorHighwayJob");
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
}
