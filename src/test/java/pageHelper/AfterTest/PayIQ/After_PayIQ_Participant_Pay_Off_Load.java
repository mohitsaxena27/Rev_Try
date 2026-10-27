package pageHelper.AfterTest.PayIQ;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import org.testng.Assert;
import pageHelper.Test.PayIQ.PayIQ_Admin;
import pageHelper.Utility.CommonFunction_Frame;
import pageHelper.Utility.Common_Apis;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

/**
 * @author Gaurav
 */
public class After_PayIQ_Participant_Pay_Off_Load {

    public webHelper webDriver;
    private bddDriver DriverInstance;

    public xmlreader xml;
    public xmlreader pageObject;

    public PropertyReader propertyReader = new PropertyReader();

    int maxAttempts = 3;
    int attempt = 0;
    boolean success = false;

    Common_Apis ca;
    CommonFunction_Frame cff;
    PayIQ_Admin pa;

    public After_PayIQ_Participant_Pay_Off_Load(
            bddDriver contextSteps) throws Exception {

        this.DriverInstance = contextSteps;

        System.out.println(this.DriverInstance);

        webDriver = new baseDriverHelper(
                bddDriver.getWebDriver());

        xml = new xmlreader(
                "Generics" + File.separator + "Common.xml");

        pageObject = new xmlreader(
                "PayIQ" + File.separator + "PayIQ_Admin.xml");

        ca = new Common_Apis(DriverInstance);

        cff = new CommonFunction_Frame(DriverInstance);

        pa = new PayIQ_Admin(DriverInstance);
    }

    @After(value = "@2843", order = 2)
    public void TC2843_Participant_PayOffLoadInsteadOfTripPlanLeg(
            Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords1("rtms9__Participant__c","Participants_SFID_1");
        ca.GetIDUsingName("Participant_Name_SFID","rtms9__Participant__c","SysData=>Participant_Name_2");
        ca.DeleteRecords1("rtms9__Participant__c","Participant_Name_SFID");
        ca.deleteAllRecordsAssociatedToName("Trip Event","rtms__TripEvent__c");
        ca.deleteAllRecordsAssociatedToName("Trip Plan","rtms__TripPlan__c");
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1(
                        "Status",
                        "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo(
                        "Status",
                        "Pending");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println(
                        "Post execution failed on attempt "
                                + attempt
                                + ": "
                                + e.getMessage());
            }
        }

        if (!success) {

            Assert.fail(
                    "Post execution did not pass after "
                            + maxAttempts
                            + " attempts.");
        }
    }

    @After(value = "@2084", order = 2)
    public void TC2084_PayIQ_Participant_Match_Team_One(
            Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));

        while (!success && attempt < maxAttempts) {

            attempt++;

            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status","Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status","Pending");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log","Completed");
                cm.waitForSeconds("2");
                success=true;

            } catch (AssertionError | Exception e) {

                System.out.println(
                        "Post execution failed on attempt "
                                + attempt
                                + ": "
                                + e.getMessage());
            }
        }

        if (!success) {

            Assert.fail(
                    "Post execution did not pass after "
                            + maxAttempts
                            + " attempts.");
        }
    }
    @After(value = "@2087", order = 2)
    public void TC2087_Qualification_No_Contact_Assigned(
            Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                // Post-Test Step 2
                cm.navigateStoredURL("Load_1");
                cm.clickOnEditIconOnLabel("Sales Lead (Contact)");
                cff.updateServicesData1(
                        "Sales Lead (Contact)",
                        "Joe Revenova PayIQ"
                );
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log","Completed");
                cm.waitForSeconds("2");

                success = true;

            } catch (AssertionError | Exception e) {

                System.out.println(
                        "Post execution failed on attempt "
                                + attempt
                                + ": "
                                + e.getMessage());
            }
        }

        if (!success) {

            Assert.fail(
                    "Post execution did not pass after "
                            + maxAttempts
                            + " attempts."
            );
        }
    }

    @After(value = "@2083", order = 2)
    public void TC2083_MatchLoadsToPayIQParticipants_Job_Team_Different_Eligible_Date_Pay_Period(
            Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {

            attempt++;

            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;
            } catch (AssertionError | Exception e) {

                System.out.println(
                        "Post execution failed on attempt "
                                + attempt
                                + ": "
                                + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail(
                    "Post execution did not pass after "
                            + maxAttempts
                            + " attempts.");
        }
    }
}