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
public class After_Fleet_Management_Job {

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

    public After_Fleet_Management_Job(bddDriver contextSteps) throws Exception {
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

    @After(value = "@2409",order=2)
    public void FMJ_2409(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        // Step 1
        ca.deleteFieldWithTitle("AxleGetVehiclesOperation");
        ca.deleteFieldWithTitle("AxleGetFleetDataFromFleetCodeOperation");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                //Step 2a & 2b
                log("Resetting Fleet Management details");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay","False");
                cf.scrollIntoSection("Fleet Management");
                Configuration conf =new Configuration(DriverInstance);
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Pass Counter","");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                //Step 3
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                Admin_Global_Services AGS=new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("Samsara", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Samsara");
                cff.updateServicesData1("Enabled","true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");
                success=true;

                //Step4
                Fleet_Common fc = new Fleet_Common(this.DriverInstance);
                cm.openFromAppLauncher("Fleet Assets");
                cm.searchAndSelectTP("QA2409VIN");
                cm.scrollIntoSection("ELD Information");
                cm.clickOnEditIconOnLabel("ELD ID");
                cff.updateServicesData1("ELD ID","2409ELD1");
                cff.updateServicesData1("ELD Serial Number","3317A");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");
                //Step5
                cm.openFromAppLauncher("Fleet Assets");
                cm.searchAndSelectTP("QA2409ELD");
                cm.scrollIntoSection("ELD Information");
                cm.clickOnEditIconOnLabel("ELD ID");
                cff.updateServicesData1("ELD ID","2409ELD2");
                cff.updateServicesData1("ELD Brand","Motive");
                cff.updateServicesData1("ELD Serial Number","2409B");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2417",order=2)
    public void FMJ_2417(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.searchAndSelectFromTheGlobalSearch("Canada Border Services Agency");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Shipping State/Province","Ontario");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");

                cm.searchAndSelectFromTheGlobalSearch("John Deere Parts Distribution Center");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Shipping City","Milan");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");

                cm.searchAndSelectFromTheGlobalSearch("Manzanillo Port");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");

                cm.searchAndSelectFromTheGlobalSearch("North Platte Union Pacific Rail Yard");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");

                cm.searchAndSelectFromTheGlobalSearch("Outta Time Warehouse");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");

                cm.searchAndSelectFromTheGlobalSearch("Port of Rotterdam");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");

                cm.searchAndSelectFromTheGlobalSearch("Timed Waypoint");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");

                cm.searchAndSelectFromTheGlobalSearch("Timely Terminal");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");

                cm.searchAndSelectFromTheGlobalSearch("Timezone Trucking");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Shipping Street","23860 W MC 85");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");

                cm.searchAndSelectFromTheGlobalSearch("Wichita Eisenhower National Airport");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Shipping Country","United States");
                cff.updateServicesData1("Shipping State/Province","Kansas");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");

                log("Resetting Fleet Management details");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Fleet Management");

                Configuration conf =new Configuration(DriverInstance);
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Pass Counter","");
                cff.updateServicesData1("Timezone Update Disabled","false");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                log("Resetting Fleet Management details");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");

                Admin_Global_Services AGS=new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("Samsara", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Samsara");
                cff.updateServicesData1("Enabled","true");
                AGS.ClickonNativeSalesforceButton("Save");

                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3550",order=2)
    public void FMJ_3550(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("1.Reset Account for Canada Border Services Agency");
                cm.searchAndSelectFromTheGlobalSearch("Canada Border Services Agency");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Shipping State/Province","Ontario");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");

                log("2.Reset Account for John Deere Parts Distribution Center");
                cm.searchAndSelectFromTheGlobalSearch("John Deere Parts Distribution Center");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Shipping City","Milan");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");

                log("3.Reset Account for Manzanillo Port");
                cm.searchAndSelectFromTheGlobalSearch("Manzanillo Port");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");

                log("4.Reset Account for North Platte Union Pacific Rail Yard");
                cm.searchAndSelectFromTheGlobalSearch("North Platte Union Pacific Rail Yard");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");

                log("5.Reset Account for Outta Time Warehouse");
                cm.searchAndSelectFromTheGlobalSearch("Outta Time Warehouse");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");

                log("6.Reset Account for John Rotterdam");
                cm.searchAndSelectFromTheGlobalSearch("Port of Rotterdam");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");

                log("7.Reset Account for Timed Waypoint");
                cm.searchAndSelectFromTheGlobalSearch("Timed Waypoint");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");

                log("8.Reset Account for Timely Terminal");
                cm.searchAndSelectFromTheGlobalSearch("Timely Terminal");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");

                log("9.Reset Account for Timezone Trucking");
                cm.searchAndSelectFromTheGlobalSearch("Timezone Trucking");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Shipping Street","23860 W MC 85");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");

                log("10.Reset Account for Wichita Eisenhower National Airport");
                cm.searchAndSelectFromTheGlobalSearch("Wichita Eisenhower National Airport");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cff.updateServicesData1("Shipping Country","United States");
                cff.updateServicesData1("Shipping State/Province","Kansas");
                cff.updateServicesData1("Timezone","--None--");
                cm.clickOnButtonWithTitle("Save");

                log("Delete Scheduled Job");
                hm.DeleteJob("FleetManagementJob4");

                log("11. Resetting Fleet Management details at Configuration page");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Fleet Management");

                Configuration conf =new Configuration(DriverInstance);
                conf.selectFleetManagementJobAs("FleetManagementJob");
//                cff.updateServicesData1("Fleet Management Pass Counter","");
//                cff.updateServicesData1("Timezone Update Disabled","false");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                log("12. Resetting Fleet Management details at Global Credentials");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");

                Admin_Global_Services AGS=new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("Samsara", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Samsara");
                cff.updateServicesData1("Enabled","true");
                AGS.ClickonNativeSalesforceButton("Save");

                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2433",order=2)
    public void FMJ_2433(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        log("Deleting Uploaded Files");
        ca.deleteFieldWithTitle("AxleGetVehicleLocationsOperation");
        ca.deleteFieldWithTitle("AxleGetFleetDataFromFleetCodeOperation");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Resetting Fleet Management details");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay","False");
                cf.scrollIntoSection("Fleet Management");
                Configuration conf =new Configuration(DriverInstance);
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Pass Counter","");
                cff.updateServicesData1("Fleet Management Job Last Run", "");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                log("Resetting Global Credentials");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");

                Admin_Global_Services AGS=new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("Samsara", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Samsara");
                cff.updateServicesData1("Enabled","true");
                AGS.ClickonNativeSalesforceButton("Save");

               // Fleet_Common fc = new Fleet_Common(this.DriverInstance);
                cm.openFromAppLauncher("Fleet Assets");
                cm.searchAndSelectTP("Tractor Two Thousand Four Hundred Thirty Three");
                cm.scrollIntoSection("ELD Information");
                cm.clickOnEditIconOnLabel("ELD Last Update");
                cmf.updateServicesData1("Date_2","");
                AGS.ClickonNativeSalesforceButton("Save");

                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2452",order=2)
    public void FMJ_2452(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        // Step 5
        ca.GetIDUsingName("Trip_Plan_ID_1","rtms__TripPlan__c","SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c","Trip_Plan_ID_1");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                //Step 1
                log("Resetting Fleet Management details");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Fleet Management");
                Configuration conf =new Configuration(DriverInstance);
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Pass Counter","");
                cff.updateServicesData1("Timezone Update Disabled","false");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                log("Resetting Fleet Management details");

                //Step 2
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                Admin_Global_Services AGS=new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("Samsara", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Samsara");
                cff.updateServicesData1("Enabled","true");
                AGS.ClickonNativeSalesforceButton("Save");

                //Step 3
                Fleet_Common fc = new Fleet_Common(this.DriverInstance);
                cm.openFromAppLauncher("Fleet Assets");
                cm.searchAndSelectTP("Tractor Two Thousand Four Hundred Fifty Two");
                cm.scrollIntoSection("ELD Information");
                cm.clickOnEditIconOnLabel("ELD Last Update");
                fc.setDateWithDays("ELD_Last_Update","");
                cff.updateServicesData1("Latitude","");
                cff.updateServicesData1("Longitude","");
                cm.clickOnButtonOnDetailsPage("SaveEdit");
                cm.waitForSeconds("2");
                cm.verifyIsSetTo("Geolocation", "");

                //Step 4
                cm.openFromAppLauncher("Drivers");
                cm.SelectTPFromRecentlyView("Bruce Fleet Carrier Two 8");
                cm.scrollIntoSection("ELD Configuration");
                cm.clickOnEditIconOnLabel("ELD ID");
                cff.updateServicesData1("ELD ID","");
                cff.updateServicesData1("ELD Brand","--None--");
                cff.updateServicesData1("ELD Enabled","False");
                cm.clickOnButtonOnDetailsPage("Save");
                cm.waitForSeconds("2");
                cm.verifyIsSetTo("ELD ID", "");
                success=true;



            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2445",order=2)
    public void FMJ_2445(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        // Step 1 & 4
        ca.deleteFieldWithTitle("AxleGetDriverHOSLogsOperation");
        ca.deleteFieldWithTitle("AxleGetFleetDataFromFleetCodeOperation");
        ca.GetIDUsingName("DriverLog","rtms__DriverLog__c","SysData=>LogName");
        ca.DeleteRecords1("rtms__DriverLog__c","DriverLog");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                //Step 2
                log("Resetting Fleet Management details");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay","False");
                cf.scrollIntoSection("Fleet Management");
                Configuration conf =new Configuration(DriverInstance);
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Pass Counter","");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                //Step 3
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                Admin_Global_Services AGS=new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("Samsara", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Samsara");
                cff.updateServicesData1("Enabled","true");
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

    @After(value = "@2420",order=2)
    public void FMJ_2420(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        // Step 1 & 4.a
        ca.deleteFieldWithTitle("AxleGetDriversOperation");
        ca.deleteFieldWithTitle("AxleGetFleetDataFromFleetCodeOperation");
        ca.GetIDUsingName("Driver_Terry_Trucker","rtms__Driver__c","Terry Trucker");
        ca.GetIDUsingName("Driver_Tom_Fleet_Carrier_Two","rtms__Driver__c","Tom Fleet Carrier Two");
        ca.DeleteRecords1("rtms__Driver__c","Driver_Tom_Fleet_Carrier_Two");
        ca.DeleteRecords1("rtms__Driver__c","Driver_Terry_Trucker");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                //Step 2
                log("Resetting Fleet Management details");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay","False");
                cf.scrollIntoSection("Fleet Management");
                Configuration conf =new Configuration(DriverInstance);
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Pass Counter","");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                //Step 3
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                Admin_Global_Services AGS=new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("Samsara", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Samsara");
                cff.updateServicesData1("Enabled","true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");
                success=true;

                //Step 4.b
                cm.openFromAppLauncher("Drivers");
                  cm.searchAndSelectTP("QA Driver Two Thousand Four Hundred Twenty");
                cm.scrollIntoSection("ELD Configuration");
                cm.clickOnEditIconOnLabel("Timezone");
                cff.updateServicesData1("Timezone","America/Chicago");
                cff.updateServicesData1("Cycle Override","USA Property (7/60)");
                cff.updateServicesData1("Restart Override","24-Hour Restart");
                cff.updateServicesData1("Rest Break Override","Property (off-duty/sleeper)");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("Timezone", "America/Chicago");

                //Step 5
                ca.GetIDUsingName("Contact","Contact","Terry Trucker");
                ca.DeleteRecords1("Contact","Contact");



            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2438",order=2)
    public void FMJ_2438(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        // Step 1
        ca.deleteFieldWithTitle("AxleGetDriverHOSLogsOperation");
        ca.deleteFieldWithTitle("AxleGetFleetDataFromFleetCodeOperation");
        ca.GetIDUsingName("DriverLog","rtms__DriverLog__c","QA Driver Two Thousand Four Hundred Thirty Eight - 2024-07-14");
        ca.DeleteRecords1("rtms__DriverLog__c","DriverLog");
        ca.GetIDUsingName("DriverLog","rtms__DriverLog__c","QA Driver Two Thousand Four Hundred Thirty Eight - 2024-07-15");
        ca.DeleteRecords1("rtms__DriverLog__c","DriverLog");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                //Step 2a & 2b
                log("Resetting Fleet Management details");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay","False");
                cf.scrollIntoSection("Fleet Management");
                Configuration conf =new Configuration(DriverInstance);
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Pass Counter","");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                //Step 3
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                Admin_Global_Services AGS=new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("Samsara", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Samsara");
                cff.updateServicesData1("Enabled","true");
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

    @After(value = "@2428",order=2)
    public void FMJ_2428(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        // Step 1 & 4.a
        ca.deleteFieldWithTitle("AxleGetFleetDataFromFleetCodeOperation");
        ca.DeleteRecords1("rtms__Driver__c","Driver_SFID");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                //Step 2
                log("Resetting Fleet Management details");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay","False");
                cf.scrollIntoSection("Fleet Management");
                Configuration conf =new Configuration(DriverInstance);
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Pass Counter","");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                //Step 3
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                Admin_Global_Services AGS=new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("Samsara", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Samsara");
                cff.updateServicesData1("Enabled","true");
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

    @After(value = "@2437", order = 2)
    public void FMJ_2437(Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);
        Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
        Configuration conf = new Configuration(DriverInstance);
        Fleet_Common fc = new Fleet_Common(this.DriverInstance);
        log("Deleting uploaded files...");
        ca.deleteFieldWithTitle("AxleGetDriversOperation");
        ca.deleteFieldWithTitle("AxleGetFleetDataFromFleetCodeOperation");
        ca.deleteFieldWithTitle("AxleGetHOSAvailabilityOperation");
        // ca.deleteFieldWithTitle("AxleGetHOSAvailabilityOperation-2437b");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                // STEP 2 – TMS Admin > Configuration
                log("Resetting TMS Admin Configuration...");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");

                // Debugging Section
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay","False");

                // Fleet Management Section
                cf.scrollIntoSection("Fleet Management");
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Pass Counter", "");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                // STEP 3 – TMS Admin > Credentials > Global Services
                log("Resetting Global Service Credentials...");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                AGS.searchTextInTheSearchBox("Samsara", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Samsara");
                cff.updateServicesData1("Enabled","true");
                AGS.ClickonNativeSalesforceButton("Save");

                // STEP 4 – Reset Driver Values
                // Driver: QA Driver Two Thousand Four Hundred Thirty Seven
                log("Resetting Driver HOS Values...");
                cm.openFromAppLauncher("Drivers");
                cm.searchAndSelectTP("QA Driver Two Thousand Four Hundred Thirty Seven");
                cm.scrollIntoSection("HOS");
                cm.clickOnEditIconOnLabel("Shift Time Remaining");
                cm.scrollDownWithTimes("3");
                cff.updateServicesData1("Shift Time Remaining", "");
                cff.updateServicesData1("Cycle Time Remaining", "");
                cff.updateServicesData1("Time Until Break", "");
                cff.updateServicesData1("Drive Time Remaining", "");
//                cff.updateServicesData1("ELD ID", "");
                cff.updateServicesData1("ELD Brand", "--None--");
                cm.clickOnButton("Save");
                cm.waitForSeconds("2");
                success = true;

            } catch (Exception e) {
                System.out.println("Test failed on attempt " + attempt + " failed: " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

}