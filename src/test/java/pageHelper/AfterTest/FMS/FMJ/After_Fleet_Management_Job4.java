package pageHelper.AfterTest.FMS.FMJ;

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
public class After_Fleet_Management_Job4 {

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

    public After_Fleet_Management_Job4(bddDriver contextSteps) throws Exception {
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

    @After(value = "@3594", order = 2)
    public void FMJ_3594(Scenario s) throws Exception {

        success = false;
        attempt = 0;

        Common_Steps cm = new Common_Steps(DriverInstance);
        Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
        Configuration conf = new Configuration(DriverInstance);
        ca.GetIDUsingName("Trip_Plan_ID_1","rtms__TripPlan__c","SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c","Trip_Plan_ID_1");
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {

                log("3594 - Resetting Fleet Management configuration");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");

                cf.scrollIntoSection("Fleet Management");
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Pass Counter", "");
                cff.updateServicesData1("Fleet Management Job Last Run", "");

                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                log("3594 - Resetting Samsara credential");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");

                AGS.searchTextInTheSearchBox("Samsara", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Samsara");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");


                log("3594 - Resetting Fleet Asset ELD / Geolocation values");

                cm.openFromAppLauncher("Fleet Assets");
                cm.SelectTPFromRecentlyView("T THREEFIVENINE-FOUR");

                cm.scrollIntoSection("Odometer Information");
                cm.clickOnEditIconOnLabel("Last Location Change");
                cff.updateServicesData1("Date", "NA");

                cm.scrollIntoSection("ELD Information");
                cff.updateServicesData1("Date_2", "NA");
                cff.updateServicesData1("Latitude", "");
                cff.updateServicesData1("Longitude", "");
                cm.clickOnButtonOnDetailsPage("SaveEdit");
                cm.waitForSeconds("2");


                log("3594 - Resetting Bruce Fleet Carrier Two 8 ELD values");

                cm.openFromAppLauncher("Drivers");
                cm.SelectTPFromRecentlyView("Bruce Fleet Carrier Two 8");

                cm.scrollIntoSection("ELD Configuration");
                cm.clickOnEditIconOnLabel("ELD ID");
                cff.updateServicesData1("ELD ID", "");
                cff.updateServicesData1("ELD Enabled", "False");
                cff.updateServicesData1("ELD Brand", "--None--");

                cm.clickOnButtonOnDetailsPage("Save");
                cm.waitForSeconds("2");
                cm.verifyIsSetTo("ELD ID", "");


                log("3594 - Deleting Trip Plan created during test");

                try {
                    ca.GetIDUsingName("Trip_Plan_ID_1", "rtms__TripPlan__c", "SysData=>Trip_Plan_ID");
                    ca.DeleteRecords1("rtms__TripPlan__c", "Trip_Plan_ID_1");
                } catch (AssertionError | Exception e) {
                    System.out.println("3594 Trip Plan cleanup skipped/failed: " + e.getMessage());
                }

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("3594 AfterTest failed on attempt " + attempt + ": " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("3594 AfterTest did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3587", order = 2)
    public void FMJ_3587(Scenario s) throws Exception {

        success = false;
        attempt = 0;
        Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
        Configuration conf = new Configuration(DriverInstance);

        log("3587 - Deleting uploaded packet replay files");
        ca.deleteFieldWithTitle("AxleGetDriversOperation");
        ca.deleteFieldWithTitle("AxleGetFleetDataFromFleetCodeOperation");
        ca.deleteFieldWithTitle("AxleGetHOSAvailabilityOperation");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {

                log("3587 - Resetting Fleet Management configuration");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay", "False");
                cf.scrollIntoSection("Fleet Management");
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Pass Counter", "");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();


                log("3587 - Resetting Samsara credential");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                AGS.searchTextInTheSearchBox("Samsara", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Samsara");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");


                log("3587 - Resetting Driver Three Five Eight Seven HOS values");
                cm.navigateStoredURL("Driver_1");
                cm.scrollIntoSection("HOS");
                cm.clickOnEditIconOnLabel("Shift Time Remaining");
                cff.updateServicesData1("Shift Time Remaining", "");
                cff.updateServicesData1("Cycle Time Remaining", "");
                cff.updateServicesData1("Time Until Break", "");
                cff.updateServicesData1("Drive Time Remaining", "");
                cm.scrollIntoSection("ELD Configuration");
                cff.updateServicesData1("ELD ID", "");
                cff.updateServicesData1("ELD Enabled", "False");
                cff.updateServicesData1("ELD Brand", "--None--");
                cm.clickOnButtonOnDetailsPage("Save");
                cm.waitForSeconds("2");
                cm.verifyIsSetTo("ELD ID", "");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("3587 AfterTest failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("3587 AfterTest did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3591", order = 2)
    public void FMJ_3591(Scenario s) throws Exception {

        success = false;
        attempt = 0;
        Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
        Configuration conf = new Configuration(DriverInstance);
        ca.deleteFieldWithTitle("AxleGetDriverHOSLogsOperation");
        ca.deleteFieldWithTitle("AxleGetFleetDataFromFleetCodeOperation");
        ca.deleteAllRecordsAssociatedToName("Driver Three Five Nine One -","rtms__DriverLog__c");

        while (!success && attempt < maxAttempts) {
            attempt++;

            try {
                // Post Step 4 - Reset TMS Admin > Configuration
                log("3591 - Resetting Fleet Management configuration");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay", "False");
                cf.scrollIntoSection("Fleet Management");
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Pass Counter", "");
                cff.updateServicesData1("Fleet Management Job Last Run", "");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                log("3591 - Enabling Samsara credential");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                AGS.searchTextInTheSearchBox("Samsara", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Samsara");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");
                hm.DeleteJob("FleetManagementJob4");

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("3591 AfterTest failed on attempt " + attempt + ": " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("3591 AfterTest did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3590", order = 2)
    public void FMJ_3590(Scenario s) throws Exception {

        success = false;
        attempt = 0;
        Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
        Configuration conf = new Configuration(DriverInstance);
        ca.deleteFieldWithTitle("AxleGetDriverHOSLogsOperation");
        ca.deleteFieldWithTitle("AxleGetFleetDataFromFleetCodeOperation");
        ca.GetIDUsingName("DriverLog3590_0714", "rtms__DriverLog__c", "Driver Three Five Nine Zero - 2024-07-14");
        ca.DeleteRecords1("rtms__DriverLog__c", "DriverLog3590_0714");
        ca.GetIDUsingName("DriverLog3590_0715", "rtms__DriverLog__c", "Driver Three Five Nine Zero - 2024-07-15");
        ca.DeleteRecords1("rtms__DriverLog__c", "DriverLog3590_0715");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                // Reset TMS Admin > Configuration
                log("3590 - Resetting Fleet Management configuration");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay", "False");
                cf.scrollIntoSection("Fleet Management");
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Pass Counter", "");
                cff.updateServicesData1("Fleet Management Job Last Run", "");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                // Re-enable Samsara credential
                log("3590 - Enabling Samsara credential");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                AGS.searchTextInTheSearchBox("Samsara", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Samsara");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");
                hm.DeleteJob("FleetManagementJob4");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("3590 AfterTest failed on attempt " + attempt + ": " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("3590 AfterTest did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3586", order = 2)
    public void FMJ_3586(Scenario s) throws Exception {

        success = false;
        attempt = 0;
        Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
        Configuration conf = new Configuration(DriverInstance);
        ca.deleteFieldWithTitle("AxleGetFleetDataFromFleetCodeOperation");
        ca.GetIDUsingName("Driver3586", "rtms__Driver__c", "SysData=>Driver_Name");
        ca.DeleteRecords1("rtms__Driver__c", "Driver3586");


        while (!success && attempt < maxAttempts) {
            attempt++;

            try {
                log("3586 - Resetting Fleet Management configuration");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay", "False");
                cf.scrollIntoSection("Fleet Management");
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Pass Counter", "");
                cff.updateServicesData1("Fleet Management Job Last Run", "");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                log("3586 - Enabling Samsara credential");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                AGS.searchTextInTheSearchBox("Samsara", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Samsara");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");
                hm.DeleteJob("FleetManagementJob4");

                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("3586 AfterTest failed on attempt " + attempt + ": " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("3586 AfterTest did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3551", order = 2)
    public void FMJ_3551(Scenario s) throws Exception {

        success = false;
        attempt = 0;
        ca.deleteFieldWithTitle("AxleGetVehiclesOperation");
        ca.deleteFieldWithTitle("AxleGetFleetDataFromFleetCodeOperation");
        ca.GetIDUsingName("FleetAsset3551Dynamic", "rtms__FleetAsset__c", "SysData=>name");
        ca.DeleteRecords1("rtms__FleetAsset__c", "FleetAsset3551Dynamic");

        Common_Steps cm = new Common_Steps(DriverInstance);
        Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
        Configuration conf = new Configuration(DriverInstance);

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("3551 - Resetting Fleet Management configuration");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay", "False");
                cf.scrollIntoSection("Fleet Management");
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Pass Counter", "");
                cff.updateServicesData1("Fleet Management Job Last Run", "");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                log("3551 - Enabling Samsara credential");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                AGS.searchTextInTheSearchBox("Samsara", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Samsara");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                log("3551 - Resetting T THREEFIVEFIVE-ONE VIN Fleet Asset ELD values");
                   cm.navigateStoredURL("Fleet_Asset_2");
                   cm.waitForSeconds("2");
                    cm.scrollIntoSection("ELD Information");
                    cm.clickOnEditIconOnLabel("ELD ID");
                    cff.updateServicesData1("ELD ID", "3551ELD1");
                    cff.updateServicesData1("ELD Brand", "--None--");
                    cff.updateServicesData1("ELD Serial Number", "3551A");
                    cm.clickOnButtonOnDetailsPage("SaveEdit");
                    cm.waitForSeconds("2");

                log("3551 - Resetting T THREEFIVEFIVE-ONE ELD Fleet Asset ELD values");
                    cm.navigateStoredURL("Fleet_Asset_3");
                    cm.waitForSeconds("2");
                    cm.scrollIntoSection("ELD Information");
                    cm.clickOnEditIconOnLabel("ELD ID");
                    cff.updateServicesData1("ELD ID", "3551ELD2");
                    cff.updateServicesData1("ELD Brand", "Motive");
                    cff.updateServicesData1("ELD Serial Number", "3551B");
                    cm.clickOnButtonOnDetailsPage("SaveEdit");
                    cm.waitForSeconds("2");
                   hm.DeleteJob("FleetManagementJob4");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("3551 AfterTest failed on attempt " + attempt + ": " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("3551 AfterTest did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3560", order = 2)
    public void FMJ_3560(Scenario s) throws Exception {

        success = false;
        attempt = 0;
        Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
        Configuration conf = new Configuration(DriverInstance);

        log("3560 - Deleting uploaded packet replay files");
        ca.deleteFieldWithTitle("AxleGetFleetDataFromFleetCodeOperation");
        ca.deleteFieldWithTitle("AxleGetVehicleLocationsOperation");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("3560 - Resetting Fleet Management configuration");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay", "False");
                cf.scrollIntoSection("Fleet Management");
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Pass Counter", "");
                cff.updateServicesData1("Fleet Management Job Last Run", "1/1/2024 12:00 AM");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                cm.waitForSeconds("2");

                log("3560 - Resetting Samsara credential");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                AGS.searchTextInTheSearchBox("Samsara", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Samsara");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                log("3587 - Resetting Driver Three Five Eight Seven HOS values");
                cm.navigateStoredURL("Fleet_Asset_1");
                cm.scrollIntoSection("Odometer Information");
                cm.clickOnEditIconOnLabel("Last Odometer Reading");
                cff.updateServicesData1("Last Odometer Reading", "");
                cff.updateServicesData1("Odometer Unit", "--None--");
                cff.updateServicesData1("Date", "NA");
                cm.scrollIntoSection("ELD Information");
                cff.updateServicesData1("Date_2", "NA");
                cff.updateServicesData1("Latitude", "");
                cff.updateServicesData1("Longitude", "");
                cff.updateServicesData1("Current Location", "");
                cff.updateServicesData1("Speed (mph)", "");
                cff.updateServicesData1("Speed (kph)", "");
                cm.clickOnButtonOnDetailsPage("Save");
                cm.waitForSeconds("2");
                hm.DeleteJob("FleetManagementJob4");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("3587 AfterTest failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("3587 AfterTest did not pass after " + maxAttempts + " attempts.");
        }
    }
}