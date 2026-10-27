package pageHelper.AfterTest.PayIQ;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import org.testng.Assert;
import pageHelper.Test.PayIQ.PayIQ_Admin;
import pageHelper.Utility.CommonFunction;
import pageHelper.Utility.CommonFunction_Frame;
import pageHelper.Utility.Common_Apis;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

/**
 * @author Sufiya
 */
public class After_PayIQ_PayEstimate {

    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    int maxAttempts = 3;  // Safety limit
    int attempt = 0;
    boolean success = false;
    Common_Apis ca;
    CommonFunction cmf;
    CommonFunction_Frame cff;
    PayIQ_Admin pa;

    public After_PayIQ_PayEstimate(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        pageObject = new xmlreader("PayIQ" + File.separator + "PayIQ_Admin.xml");
        ca = new Common_Apis(DriverInstance);
        cff = new CommonFunction_Frame(DriverInstance);
        pa = new PayIQ_Admin(DriverInstance);

    }

    @After(value = "@2900", order = 2)
    public void L2900_Pay_Estimate_CopyOverPayEstimateAdjustmentsJob(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.GetIDUsingName("Trip_Plan_ID_1", "rtms__TripPlan__c", "SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c", "Trip_Plan_ID_1");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.navigateStoredURL("Participant_1");
                cm.clickOnEditIconOnLabel("Allow Pay Estimates");
                cff.updateServicesData1("Allow Pay Estimates","False");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Allow Pay Estimates","False");

                cm.navigateStoredURL("Participant_2");
                cm.clickOnEditIconOnLabel("Allow Pay Estimates");
                cff.updateServicesData1("Allow Pay Estimates","False");
                cff.updateServicesData1("Pay Off Load Instead of Trip Plan Leg","False");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Allow Pay Estimates","False");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");

                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }


    @After(value = "@3159", order = 2)
    public void After_3159(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms9__Pay_Advance__c", DriverInstance.getVariable("Pay_Advance_SFID_1"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");


                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }

    }

    @After(value = "@3161", order = 2)
    public void After_3161(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.GetIDUsingName("Filter_Name", "rtms9__Load_Filter__c", "SysData=>Filter_1");
        ca.DeleteRecords1("rtms9__Load_Filter__c", "Filter_Name");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");
                cm.waitForSeconds("2");
                cm.navigateStoredURL("Participant_1");
                cm.clickOnEditIconOnLabel("Pay Off Load Instead of Trip Plan Leg");
                cff.updateServicesData1("Pay Off Load Instead of Trip Plan Leg", "false");
                cm.waitForSeconds("1");

                cff.updateServicesData1("Allow Pay Estimates", "false");
                cm.waitForSeconds("1");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                cm.navigateStoredURL("Participant_2");
                cm.clickOnEditIconOnLabel("Allow Pay Estimates");
                cff.updateServicesData1("Allow Pay Estimates", "false");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");


                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2951", order = 2)
    public void After_2951(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.deleteAllRecordsAssociatedToName("Pay Header-","rtms9__Pay_Header__c");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cff.updateServicesData1("Pay Schedule", "Test Pay Schedule");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.navigateStoredURL("Pay_Schedule_URL");
                cm.clickOnEditIconOnLabel("Period Beginning");
                cff.updateServicesData1("Period Beginning", "1/1/2024");
                cm.waitForSeconds("1");
                cm.clickOnButtonOnDetailsPage("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Period Beginning", "1/1/2024");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2868", order = 2)
    public void after_2868(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.GetIDUsingName("Trip_Plan_ID_1", "rtms__TripPlan__c", "SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c", "Trip_Plan_ID_1");
        ca.DeleteRecords("rtms9__Accessorial_Rule__c", DriverInstance.getVariable("Accessorial_Rules_SFID_1"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");
                cm.navigateStoredURL("Participant_1");
                cm.clickOnEditIconOnLabel("Allow Pay Estimates");
                cff.updateServicesData1("Allow Pay Estimates","False");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Allow Pay Estimates","False");
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