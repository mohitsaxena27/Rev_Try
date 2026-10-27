package pageHelper.AfterTest.TMS.Admin;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Admin.Configuration;
import pageHelper.Test.TMS.Admin.Home_Page;
import pageHelper.Utility.*;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

/**
 * @author Sufiya
 */
@Slf4j
public class After_Job {

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
    public After_Job(bddDriver contextSteps) throws Exception {
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

    @After(value = "@2089", order = 2)
    public void HubTran_API_Post_Test_Cleanup(Scenario s) throws Exception {

        ca.deleteAllRecordsAssociatedToName("2089","rtms__RecurringLoadSchedule__c");
        hm.deleteAllScheduledJob();
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.waitForSeconds("2");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cm.waitForSeconds("1");
                cff.updateServicesData1("Enforce Customer Credit Limits", "False");
                cff.updateServicesData1("IFTA Mileage Reporting Enabled", "False");
                cf.scrollIntoSection("Fleet Management");
                Configuration conf =new Configuration(DriverInstance);
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cf.clickOnButtonWithValue("Save");
                cm.waitForSeconds("2");
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

    @After(value = "@3372", order = 2)
    public void BankAccount3372(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
             //   cm.openFromAppLauncher("Accounts");
                cm.searchAndSelectFromTheGlobalSearch("Email Carrier Three");
                cm.goToTab("Details");
                cm.scrollIntoSection("General Information");
                cm.clickOnEditIconOnLabel("Default Payment Method");
                cmf.updateServicesDataWithKeyValue("Default Payment Method", "--None--");
                cm.clickOnButton("Save");
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

    @After(value = "@3744", order = 2)
    public void SMC3EVA3744Cleanup(Scenario s) throws Exception {
        boolean cleanupComplete = false;
        int cleanupAttempt = 0;
        while (!cleanupComplete && cleanupAttempt < maxAttempts) {
            cleanupAttempt++;
            try {
                hm.DeleteJob("QueuedTransactionJob");
                cleanupComplete = true;
            } catch (AssertionError | Exception e) {
                System.out.println("3744 cleanup attempt " + cleanupAttempt + " failed: " + e.getMessage());
                if (cleanupAttempt < maxAttempts) {
                    cm.waitForSeconds("2");
                }
            }
        }
        if (!cleanupComplete) {
            Assert.fail("Unable to delete QueuedTransactionJob after " + maxAttempts + " attempts.");
        }

        String loadId = DriverInstance.getVariable("1LRI");
        if (loadId == null || loadId.trim().isEmpty()) {
            System.out.println("3744 cleanup skipped load deletion because 1LRI was not stored.");
            return;
        }

        boolean loadCleanupComplete = false;
        int loadCleanupAttempt = 0;
        while (!loadCleanupComplete && loadCleanupAttempt < maxAttempts) {
            loadCleanupAttempt++;
            try {
                ca.DeleteRecords("rtms__Load__c", loadId);
                loadCleanupComplete = true;
            } catch (AssertionError | Exception e) {
                System.out.println("3744 load cleanup attempt " + loadCleanupAttempt + " failed: " + e.getMessage());
                if (loadCleanupAttempt < maxAttempts) {
                    cm.waitForSeconds("2");
                }
            }
        }
        if (!loadCleanupComplete) {
            Assert.fail("Unable to delete load " + loadId + " after " + maxAttempts + " attempts.");
        }
    }
}
