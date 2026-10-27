package pageHelper.AfterTest.TMS.API_Operation;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
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
public class After_SMC3_EVA_API {

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
    Transportation tp;
    Home_Page hm;
    Admin_Global_Services agm;

    public After_SMC3_EVA_API(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        cm = new Common_Steps(DriverInstance);
        cf = new Common_Steps_Frame(DriverInstance);
        ca = new Common_Apis(DriverInstance);
        cff = new CommonFunction_Frame(DriverInstance);
        cmf = new CommonFunction(DriverInstance);
        tp = new Transportation(DriverInstance);
        hm = new Home_Page(DriverInstance);
        agm =  new Admin_Global_Services(DriverInstance);
    }

    @After(value = "@2221", order = 2)
    public void SMC3_2221(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
            while (!success && attempt < maxAttempts) {
                attempt++;
                try {
                    log("Resetting Configuration details");
                    cm.openFromAppLauncher("TMS Admin");
                    cm.goToTab("Configuration");
                    cm.switchToFrameByTitle("accessibility title");
                    cf.scrollIntoSection("Debugging");
                    cff.updateServicesData1("Logging Enabled", "False");
                    cf.clickOnButtonWithValue("Save");
                    cm.switchToParentFrame();

                    success = true;
                } catch (AssertionError | Exception e) {
                    System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
                    System.out.println(e.getMessage());
                }
            }
            if (!success) {
                Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
            }
        }
    }

    @After(value = "@2222", order = 2)
    public void SMC3_2480 (Scenario s) throws Exception {
            ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
            while (!success && attempt < maxAttempts) {
                attempt++;
                try {
                    cm.navigateStoredURL("Carrier_Service_SMC3");
                    cm.waitForSeconds("2");
                    cm.scrollIntoSection("Carrier Quote  & Settlement Contacts (Default)");
                    cm.clickOnEditIconOnLabel("Settlement Contact");
                    cm.waitForSeconds("2");
                    cff.updateServicesData1("Quote Contact", "");
                    cff.updateServicesData1("Quote Method", "API");
                    cm.clickOn("Save");
                    cm.verifyIsSetTo("Quote Method", "API");

                    success = true;
                } catch (AssertionError | Exception e) {
                    System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
                    System.out.println(e.getMessage());
                }
            }
            if (!success) {
                Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
            }
        }

    @After(value = "@2333", order = 2)
    public void SMC3_2333 (Scenario s) throws Exception {

        while (!success && attempt < maxAttempts) {
                attempt++;
                try {
                    log("Reset Document Polling Number to blank");
                    cm.navigateStoredURL("Load_2");
                    cm.waitForSeconds("2");
                    cm.goToTab("Details");
                    cm.scrollIntoSection("Tracking IDs");
                    cm.clickOnEditIconOnLabel("Document Polling Number");
                    cff.updateServicesData1("Document Polling Number", "");
                    agm.ClickonNativeSalesforceButton("Save");
                    cm.verifyIsSetTo("Document Polling Number", "");

                    log("Deleting Scheduled QueuedTransactionJob");
                    hm.DeleteJob("QueuedTransactionJob");
                    cm.waitForSeconds("2");

                    success = true;
                } catch (AssertionError | Exception e) {
                    System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
                    System.out.println(e.getMessage());
                }
            }

        if (!success) {
                Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
            }
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
    }

    @After(value = "@3660", order = 2)
    public void SMC3_3360 (Scenario s) throws Exception {
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        ca.deleteFieldWithTitle("SMC3EVAQuoteOperation");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Rate_Entry_1");
                cm.waitForSeconds("2");
                cff.updateServicesData1("Status", "Accepted");
                cm.clickOn("Save");
                cm.verifyMessageAreDisplaying("Save was successful.");

                cm.navigateStoredURL("Rate_Entry_2");
                cm.waitForSeconds("2");
                cff.updateServicesData1("Status", "Accepted");
                cm.clickOn("Save");
                cm.verifyMessageAreDisplaying("Save was successful.");

                cm.navigateStoredURL("Rate_Entry_3");
                cm.waitForSeconds("2");
                cff.updateServicesData1("Payment Terms", "Prepaid");
                cff.updateServicesData1("Bill To", "");
                cm.clickOn("Save");
                cm.verifyMessageAreDisplaying("Save was successful.");

                cm.navigateStoredURL("Document_Option");
                cm.waitForSeconds("2");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Payment Terms", "--None--");
                cf.clickOnButtonWithValue("Save");
                cm.verifyMessageAreDisplaying("Save was successful.");
                cm.switchToParentFrame();

                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
                System.out.println(e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3624", order = 2)
    public void SMC3_3624 (Scenario s) throws Exception {
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        ca.deleteFieldWithTitle("SMC3EVAQuoteOperation");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Rate_Entry_1");
                cm.waitForSeconds("2");
                cff.updateServicesData1("Status", "Accepted");
                cm.clickOn("Save");
                cm.verifyMessageAreDisplaying("Save was successful.");

                cm.navigateStoredURL("Rate_Entry_2");
                cm.waitForSeconds("2");
                cff.updateServicesData1("Status", "Accepted");
                cm.clickOn("Save");
                cm.verifyMessageAreDisplaying("Save was successful.");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
                System.out.println(e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3647", order = 2)
    public void SMC3_3647 (Scenario s) throws Exception {
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        ca.deleteFieldWithTitle("SMC3EVAQuoteOperation");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Rate_Entry_1");
                cm.waitForSeconds("2");
                cff.updateServicesData1("Status", "Accepted");
                cm.clickOn("Save");
                cm.verifyMessageAreDisplaying("Save was successful.");

                cm.navigateStoredURL("Rate_Entry_2");
                cm.waitForSeconds("2");
                cff.updateServicesData1("Status", "Accepted");
                cm.clickOn("Save");
                cm.verifyMessageAreDisplaying("Save was successful.");

                cm.navigateStoredURL("Rate_Entry_3");
                cm.waitForSeconds("2");
                cff.updateServicesData1("Payment Terms", "Prepaid");
                cff.updateServicesData1("Payer", "Shipper");
                cff.updateServicesData1("Bill To", "");
                cm.clickOn("Save");
                cm.verifyMessageAreDisplaying("Save was successful.");

                cm.navigateStoredURL("Document_Option");
                cm.waitForSeconds("2");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Payment Terms", "--None--");
                cff.updateServicesData1("Payer", "--None--");
                cf.clickOnButtonWithValue("Save");
                cm.verifyMessageAreDisplaying("Save was successful.");
                cm.switchToParentFrame();

                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
                System.out.println(e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3667", order = 2)
    public void SMC3_3367 (Scenario s) throws Exception {
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        ca.deleteFieldWithTitle("SMC3EVAQuoteOperation");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("1. Reset Configuration settings");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");

                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Logging Enabled", "false");
                cff.updateServicesData1("Enable Packet Replay", "false");
                cf.clickOnButtonWithValue("Save");
                cm.waitForSeconds("2");
                cm.switchToParentFrame();

                log("2. Reset rate entry for carrier service SMC3 EVA Carrier - SMC3 EVA - Broker");
                cm.navigateStoredURL("Rate_Entry_1");
                cm.waitForSeconds("2");
                cm.scrollIntoSection("General Information");
                cff.updateServicesData1("Carrier Account Number", "0123456789");
                cff.updateServicesData1("Payment Terms", "Prepaid");
                cm.clickOn("Save");
                cm.waitForSeconds("2");
                cm.verifyMessageAreDisplaying("Save was successful.");

                log("3. Reset rate entry for carrier service Jersey Express Lines - SMC3 EVA");
                cm.navigateStoredURL("Rate_Entry_2");
                cm.waitForSeconds("2");
                cm.scrollIntoSection("General Information");
                cff.updateServicesData1("Payment Terms", "Prepaid");
                cm.clickOn("Save");
                cm.waitForSeconds("2");
                cm.verifyMessageAreDisplaying("Save was successful.");

                log("4. Reset Global Defaults");
                cm.navigateStoredURL("Document_Option");
                cm.waitForSeconds("2");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Payment Terms", "--None--");
                cf.clickOnButtonWithValue("Save");
                cm.verifyMessageAreDisplaying("Save was successful.");
                cm.switchToParentFrame();

                log("5. Reset Code at Load Accessorials for Limited Access Pick up");
                cm.navigateStoredURL("API_Accessorial");
                cm.waitForSeconds("2");
                cm.clickOnEditIconOnLabel("Subcode");
                cff.updateServicesData1("Subcode", "");
                cf.clickOnButton("Save");
                cm.waitForSeconds("2");
//                cm.verifyMessageAreDisplaying("Save was successful.");

                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
                System.out.println(e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }



    @After(value = "@2304", order = 2)
    public void SMC3_EVA_2304 (Scenario s) throws Exception {

        ca.deleteFieldWithTitle("SMC3EVAStatusOperation");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Load_1");
                cm.waitForSeconds("2");
                cm.goToTab("Details");
                cm.clickOnEditIconOnLabel("Load Status");
                cff.updateServicesData1("Load Status", "Cancelled");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                cm.navigateStoredURL("Load_2");
                cm.waitForSeconds("2");
                cm.goToTab("Details");
                cm.clickOnEditIconOnLabel("Load Status");
                cff.updateServicesData1("Load Status", "Cancelled");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                hm.DeleteJob("SMC3EVAJob");
                cm.waitForSeconds("2");

                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
                System.out.println(e.getMessage());
            }
            ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
            ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("2LRI"));
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
    @After(value = "@2219", order = 2)
    public void disableDebugLoggingAfterTest(Scenario scenario) throws Exception {

        while (!success && attempt < maxAttempts) {
            attempt++;

            try {
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Logging Enabled", "False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Post-test cleanup attempt " + attempt + " failed: " + e.getMessage());

                try {
                    cm.switchToParentFrame();
                } catch (Exception ignored) {
                    // Continue retrying cleanup.
                }
            }
        }

        if (!success) {
            Assert.fail("Unable to disable Debugging Logging after " + maxAttempts + " attempts.");
        }
    }
}