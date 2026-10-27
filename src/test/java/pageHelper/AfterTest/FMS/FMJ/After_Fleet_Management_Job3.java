package pageHelper.AfterTest.FMS.FMJ;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.FMS.Fleet_Common;
import pageHelper.Test.FMS.Fleet_Management;
import pageHelper.Test.TMS.Admin.Admin_Global_Services;
import pageHelper.Test.TMS.Admin.Configuration;
import pageHelper.Test.TMS.Admin.Home_Page;
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
public class After_Fleet_Management_Job3 {

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
    Partner_APis partnerApis;
    public After_Fleet_Management_Job3(bddDriver contextSteps) throws Exception {
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
        partnerApis = new Partner_APis(DriverInstance);
    }


    @After(value = "@3228",order=2)
    public void FMJ_2417(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {

                cm.searchAndSelectFromTheGlobalSearch("Port of Rotterdam");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");
                cm.waitForSeconds("4");

                cm.searchAndSelectFromTheGlobalSearch("Timely Terminal");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");
                cm.waitForSeconds("4");

                log("Resetting Fleet Management details");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Fleet Management");
                Configuration conf =new Configuration(DriverInstance);
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Timezone Update Disabled","false");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                hm.DeleteJob("FleetManagementJob3");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3241",order=2)
    public void TrimbleAPI_2432(Scenario s) throws Exception {
        ca.deleteFieldWithTitle("SamsaraGetMessagesOperation");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                hm.DeleteJob("FleetManagementJob3");
                cm.waitForSeconds("1");
                cm.openFromAppLauncher("Drivers");
                cm.SelectTPFromRecentlyView("Bruce Fleet Carrier Two 44");
                cm.waitForSeconds("2");
                cm.scrollIntoSection("ELD Configuration");
                cm.clickOnEditIconOnLabel("ELD ID");
                cff.updateServicesData1("ELD ID","");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("ELD ID", "");
                cm.waitForSeconds("2");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay","False");
                cf.scrollIntoSection("Fleet Management");
                Configuration conf =new Configuration(DriverInstance);
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Job Last Run", "");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                //Catena - True
                log("Reset Global settings");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("Catena", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Catena");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3229",order=2)
    public void FMJ3_3229(Scenario s) throws Exception {


        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.openFromAppLauncher("Fleet Assets");
                cm.searchAndSelectTP("SysData=>Fleets_Name");
                cm.waitForSeconds("3");
                cm.scrollIntoSection("Equipment Information");

                cm.clickOnEditIconOnLabel("License Plate Number");
                cm.enterLabelText("License Plate Number", "SysData=>Vehicle_licensePlate");
                cm.clickOnButton("Save");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("License Plate Number", "SysData=>Vehicle_licensePlate");

                cm.Homepage();
                hm.runJob("FleetManagementJob3");
                cm.waitForSeconds("6");
                hm.DeleteJob("FleetManagementJob3");
                cm.waitForSeconds("1");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Fleet Management");
                Configuration conf =new Configuration(DriverInstance);
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Job Last Run", "");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                cm.waitForSeconds("2");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
            ca.deleteAllRecordsAssociatedToName("SysData=>Fleets_Name", "rtms__FleetAsset__c");
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3232",order=2)
    public void FMJ3_3232(Scenario s) throws Exception {
        ca.deleteFieldWithTitle("SamsaraGetVehicleStatisticsOperation");
//        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("1. Delete FleetManagementJob3 from Scheduled Jobs");
                cm.Homepage();
                hm.runJob("FleetManagementJob3");
                cm.waitForSeconds("6");
                hm.DeleteJob("FleetManagementJob3");
                cm.waitForSeconds("1");

                log("3. Reset Latitude & Lognitude for Fleet Asset");
                cm.openFromAppLauncher("Fleet Assets");
                cm.searchAndSelectTP("Tractor ThreeTwoThreeZero");
                cm.waitForSeconds("3");
                cm.scrollIntoSection("ELD Information");

                cm.clickOnEditIconOnLabel("Geolocation");
                cm.enterLabelText("Latitude", "39.7817213");
                cm.enterLabelText("Longitude", "-89.6501481");
                cm.clickOnButton("Save");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("License Plate Number", "SysData=>Vehicle_licensePlate");

                log("4. Reset Admin section");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Fleet Management");
                Configuration conf =new Configuration(DriverInstance);
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Job Last Run", "");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                cm.waitForSeconds("2");

                log("5. Reset Global settings>>Catena");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("Catena", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Catena");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3242",order=2)
    public void FMJ3_3242(Scenario s) throws Exception {
        ca.deleteFieldWithTitle("SamsaraGetDocumentsOperation");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                hm.DeleteJob("FleetManagementJob3");
                cm.waitForSeconds("1");
                cm.openFromAppLauncher("Drivers");
                cm.SelectTPFromRecentlyView("Bruce Fleet Carrier Two 8");
                cm.waitForSeconds("2");
                cm.scrollIntoSection("ELD Configuration");
                cm.clickOnEditIconOnLabel("ELD ID");
                cff.updateServicesData1("ELD ID","");
                cff.updateServicesData1("ELD Enabled", "False");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("ELD ID", "");
                cm.waitForSeconds("2");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay","False");
                cf.scrollIntoSection("Fleet Management");
                Configuration conf =new Configuration(DriverInstance);
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Job Last Run", "");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                //Catena - True
                log("Reset Global settings");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("Catena", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Catena");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3230",order=2)
    public void FMJ3_3230(Scenario s) throws Exception {
        Fleet_Management fm = new Fleet_Management(DriverInstance);
        Fleet_Common fc = new Fleet_Common(DriverInstance);

        if (hasVariable("Account_3230")) {
            partnerApis.DeleteSamSaraAddress("Account_3230");
        }
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                hm.DeleteJob("FleetManagementJob3");
                cm.waitForSeconds("1");

                cm.openFromAppLauncher("Drivers");
                cm.SelectTPFromRecentlyView("Bruce Fleet Carrier Two 8");
                cm.waitForSeconds("2");
                cm.scrollIntoSection("ELD Configuration");
                cm.clickOnEditIconOnLabel("ELD ID");
                cff.updateServicesData1("ELD Enabled", "False");
                cm.clickOnButton("Save");
                cm.waitForSeconds("2");
                cm.verifyIsSetTo("ELD ID", "");
                cm.waitForSeconds("2");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Enable Routing Consolidate Locations", "false");
                cf.scrollIntoSection("Fleet Management");
                Configuration configuration = new Configuration(DriverInstance);
                configuration.selectFleetManagementJobAs("FleetManagementJob");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                cm.waitForSeconds("2");

                cm.openFromAppLauncher("Fleet Management Console");
                fm.fleetManagementConsoleWaitForPageLoad();
                cff.updateServicesData1("Page","Trip Planning");
                cm.waitForSeconds("2");
                cm.scrollIntoSection("View - Trip Plan");
                cm.scrollDownWithTimes("4");
                cff.updateServicesData1("Trip Plan(s)","SysData=>Trip_Plan_ID");
                fc.clickOnUnderSection("Refresh","View - Trip Plan");
                cf.verifyMessageAreDisplayingAs("Plan Trip - Trip Plan");
                fc.clickOnButtonOnTripPlan("Delete");
                cm.clickOnButtonWithTitle("Undispatch");
                cm.verifyMessageAreDisplaying("The driver was undispatched successfully.");
                fc.clickOnButtonOnTripPlan("Close");
                cm.waitForSeconds("10");
                cff.updateServicesData1("Trip Plan(s)","SysData=>Trip_Plan_ID_2");
                fc.clickOnUnderSection("Refresh","View - Trip Plan");
                cf.verifyMessageAreDisplayingAs("Plan Trip - Trip Plan");
                fc.clickOnButtonOnTripPlan("Delete");
                cm.clickOnButtonWithTitle("Undispatch");
                cm.verifyMessageAreDisplaying("The driver was undispatched successfully.");
                fc.clickOnButtonOnTripPlan("Close");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
            ca.GetIDUsingName("Trip_Plan_ID","rtms__TripPlan__c","SysData=>Trip_Plan_ID");
            ca.DeleteRecords1("rtms__TripPlan__c","Trip_Plan_ID");
            ca.GetIDUsingName("Trip_Plan_ID_2","rtms__TripPlan__c","SysData=>Trip_Plan_ID_2");
            ca.DeleteRecords1("rtms__TripPlan__c","Trip_Plan_ID_2");
            ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
            ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));
            ca.deleteAllRecordsAssociatedToName("Account 3230","rtms__TransportationProfile__c");
            ca.deleteAllRecordsAssociatedToName("Account 3230","Account");

        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
    private boolean hasVariable(String variableName) {
        String value = DriverInstance.getVariable(variableName);
        return value != null && !value.trim().isEmpty();
    }


}