package pageHelper.AfterTest.TMS.TMSAdmin;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.FMS.Fleet_Common;
import pageHelper.Test.TMS.Admin.Admin_Authorized_Users;
import pageHelper.Test.TMS.Admin.Admin_Global_Services;
import pageHelper.Test.TMS.Admin.Configuration;
import pageHelper.Test.TMS.Admin.Home_Page;
import pageHelper.Test.TMS.SetUp.Sharing_Settings;
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
public class After_Configuration {

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

    public After_Configuration(bddDriver contextSteps) throws Exception {
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

    @After(value = "@443", order = 2)
    public void Config_443(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                //Step 2a & 2b
                log("TMS Admin> Configuration > Global Settings > Set the In Delivered Load Trigger to Last Stop Departure Date > Save");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Global Settings");
                Admin_Global_Services adg = new Admin_Global_Services(this.DriverInstance);
                adg.updateTheCustomSelectOptionAs("Delivered Load Trigger", "Last Stop Departure Date");
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

    @After(value = "@441", order = 2)
    public void Config_441(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                //Step 2a & 2b
                log("TMS Admin> Configuration > Global Settings > Set the In Transit Load Trigger to First Stop Departure Date > Save");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Global Settings");
                Admin_Global_Services adg = new Admin_Global_Services(this.DriverInstance);
                adg.updateTheCustomSelectOptionAs("In Transit Load Trigger", "First Stop Departure Date");
                cf.clickOnButtonWithValue("Save");
                cm.waitForSeconds("4");
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

    @After(value = "@3225", order = 2)
    public void Config_3225(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);

        ca.deleteFieldWithTitle("MCPGetCarrierOperation");
        ca.deleteFieldWithTitle("MCPGetMonitoredCarriersOperation");
        ca.deleteFieldWithTitle("MCPGetCarrierChangesOperation");
        ca.deleteFieldWithTitle("MCPGetCompletedPacketsOperation");

        ca.GetIDUsingName("TP_Service_1", "rtms__CarrierService__c", "MCP Carrier 2947");
        ca.DeleteRecords1("rtms__CarrierService__c", "TP_Service_1");

        ca.GetIDUsingName("TP_1", "rtms__TransportationProfile__c", "MCP Carrier 2947");
        ca.DeleteRecords1("rtms__TransportationProfile__c", "TP_1");

        ca.GetIDUsingName("Account_", "Account", "MCP Carrier 2947");
        ca.DeleteRecords1("Account", "Account_");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Setting Up Configuration");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Carrier Remit To Sync", "False");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay", "False");
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
                AGS.searchTextInTheSearchBox("Highway", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Highway");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");
                cm.Homepage();
                hm.DeleteJob("CarrierMonitorMCPJob");

                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2746", order = 2)
    public void Customer_2746(Scenario s) throws Exception {
        Sharing_Settings ss = new Sharing_Settings(DriverInstance);
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("2LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("JD_TP");
                cm.goToTab("Credit");
                cm.clickOnEditIconOnLabel("Credit Review Status");
                cff.updateServicesData1("Credit Review Status", "Approved");
                cm.clickOnButton("Save");
                cm.waitForSeconds("4");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3672", order = 2)
    public void Config_3672(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("1. Deleting Scheduled Job - FleetManagementJob4");
                Home_Page home = new Home_Page(DriverInstance);
                home.DeleteJob("FleetManagementJob4");

                log("1. Resetting Fleet Management details");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Fleet Management");
                Configuration conf = new Configuration(DriverInstance);
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("Samsara", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Samsara");
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

    @After(value = "@1265", order = 2)
    public void Config_1265(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        Admin_Authorized_Users aau = new Admin_Authorized_Users(DriverInstance);

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("TMS Admin > Credentials > Authorized Users > Deleting created users");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Authorized Users");
                cm.waitForSeconds("2");
                aau.deleteUserIfExists("Chatter Expert");
                cm.waitForSeconds("2");
                aau.deleteUserIfExists("API Site Guest User");
                cm.waitForSeconds("2");
                aau.deleteUserIfExists("Customer_Portal Site Guest User");
                cm.waitForSeconds("2");
                cm.verifyMessageAreNotDisplayingAs("Customer_Portal Site Guest User");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@1271", order = 2)
    public void Config_1271(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        Admin_Authorized_Users aau = new Admin_Authorized_Users(DriverInstance);

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("TMS Admin > Credentials > Authorized Users > Deleting created users");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Authorized Users");
                cm.waitForSeconds("3");
                aau.deleteUserIfExists("Integration User");
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
