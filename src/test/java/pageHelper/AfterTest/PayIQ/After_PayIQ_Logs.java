package pageHelper.AfterTest.PayIQ;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import org.testng.Assert;
import pageHelper.Test.PayIQ.PayIQ_Admin;
import pageHelper.Test.TMS.Load.Load_Summary;
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
public class After_PayIQ_Logs {

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
    Load_Summary ls ;

    public After_PayIQ_Logs(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        pageObject = new xmlreader("PayIQ" + File.separator + "PayIQ_Admin.xml");
        ca = new Common_Apis(DriverInstance);
        cff = new CommonFunction_Frame(DriverInstance);
        pa = new PayIQ_Admin(DriverInstance);
        ls= new Load_Summary(DriverInstance);

    }

    @After(value = "@2082", order = 2)
    public void After2082(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");
                cm.navigateStoredURL("PaySchedule_URL");
                cm.clickOnEditIconOnLabel("Active");
                cff.updateServicesData1("Active", "true");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
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



    @After(value = "@2081",order=2)
    public void After2081(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status","Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status","Pending");

                cm.navigateStoredURL("PaySchedule_URL");
                cm.clickOnEditIconOnLabel("Period Status");
                cff.updateServicesData1("Period Status","Open");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Period Status","Open");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log","Completed");
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

    @After(value = "@2080",order=2)
    public void After2080(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status","Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status","Pending");

                cm.navigateStoredURL("Load_URL");
                cm.clickOnEditIconOnLabel("Custom PayIQ Eligible Date");
                cff.updateServicesData1("Custom PayIQ Eligible Date","2/1/2024");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Custom PayIQ Eligible Date","2/1/2024");

                //Reset Expected Date
                cm.goToTab("Shipment");
                ls.expendForLoad("Details","1");
                cm.waitForSeconds("1");
                ls.clickOnEditIconWithFieldName("1P","Expected Date");
                cff.updateServicesData1("Expected Date","1/1/2024 ");
                cm.waitForSeconds("1");
                cm.clickOnButtonWithType("Save","submit");
                cm.waitForSeconds("4");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log","Completed");
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

    @After(value = "@2091",order=2)
    public void After2091(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status","Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status","Pending");

                cm.navigateStoredURL("Load_URL");
                cm.clickOnEditIconOnLabel("Sales Lead (Contact)");
                cff.updateServicesData1("Sales Lead (Contact)","Joe Revenova PayIQ");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Sales Lead (Contact)","Joe Revenova PayIQ");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log","Completed");
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

    @After(value = "@2203",order=2)
    public void After2203(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status","Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status","Pending");

                cm.navigateStoredURL("Participant_Page");
                cm.scrollIntoSection("Duration");
                cm.clickOnEditIconOnLabel("Effective Date");
                cff.updateServicesData1("Effective Date","NA");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log","Completed");
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

    @After(value = "@2206", order = 2)
    public void TCXXXX_2206_PayIQ_Logs_Currency_Conversion_Margin_Quoted(
            Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                // Post-Test Step 1
                cm.navigateStoredURL("PayIQ_Program_1");
                // Set Status to Pending
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                // Post-Test Step 2
                // Execute Delete PayIQ Logs
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");

                // Post-Test Step 3
                // Restore Contact Currency to USD
                cm.navigateStoredURL("Contact_Page");
                cm.waitForSeconds("2");
                cm.clickOnEditIconOnLabel("Contact Currency");
                cff.updateServicesData1(
                        "Contact Currency",
                        "USD - U.S. Dollar"
                );

                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

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

    @After(value = "@2207", order = 2)
    public void TC2207_PayIQ_Logs_Currency_Conversion_Margin_Invoiced(
            Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);

        while (!success && attempt < maxAttempts) {

            attempt++;
            try {
                // Post-Test Step 1
                // Navigate to stored PayIQ Program
                cm.navigateStoredURL("PayIQ_Program_1");

                // Set Status to Pending
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");


                // Post-Test Step 2
                // Execute Delete PayIQ Logs
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");


                // Post-Test Step 3
                // Restore Contact Currency to USD
                cm.navigateStoredURL("Contact_Page");
                cm.waitForSeconds("2");
                cm.clickOnEditIconOnLabel("Contact Currency");
                cff.updateServicesData1(
                        "Contact Currency",
                        "USD - U.S. Dollar"
                );

                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                success = true;

            } catch (AssertionError | Exception e) {

                System.out.println(
                        "Post execution failed on attempt "
                                + attempt
                                + ": "
                                + e.getMessage()
                );
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

    @After(value = "@2208", order = 2)
    public void TC2208_PayIQ_Logs_Currency_Conversion_Revenue_Quoted(
            Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);

        while (!success && attempt < maxAttempts) {

            attempt++;

            try {

                // Post-Test Step 1
                // Navigate to stored PayIQ Program
                cm.navigateStoredURL("PayIQ_Program_1");

                // Set Status to Pending
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");


                // Post-Test Step 2
                // Execute Delete PayIQ Logs
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");


                cm.navigateStoredURL("Contact_Page");
                cm.waitForSeconds("2");
                cm.clickOnEditIconOnLabel("Contact Currency");
                cff.updateServicesData1(
                        "Contact Currency",
                        "USD - U.S. Dollar"
                );

                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                success = true;

            } catch (AssertionError | Exception e) {

                System.out.println(
                        "Post execution failed on attempt "
                                + attempt
                                + ": "
                                + e.getMessage()
                );
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
    @After(value = "@2209", order = 2)
    public void TC2209_PayIQ_Logs_Currency_Conversion_Revenue_Invoiced(
            Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);

        while (!success && attempt < maxAttempts) {

            attempt++;

            try {

                // Post-Test Step 1
                // Navigate to stored PayIQ Program
                cm.navigateStoredURL("PayIQ_Program_1");

                // Set Status to Pending
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");


                // Post-Test Step 2
                // Execute Delete PayIQ Logs
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");


                cm.navigateStoredURL("Contact_Page");
                cm.waitForSeconds("2");
                cm.clickOnEditIconOnLabel("Contact Currency");
                cff.updateServicesData1(
                        "Contact Currency",
                        "USD - U.S. Dollar"
                );
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                success = true;

            } catch (AssertionError | Exception e) {

                System.out.println(
                        "Post execution failed on attempt "
                                + attempt
                                + ": "
                                + e.getMessage()
                );
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
    @After(value = "@2204",order=2)
    public void L2204_PayIQ_Logs_Qualification_Eligible_Date_Not_Within_Date_Range_for_Contact(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status","Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status","Pending");
                cm.waitForSeconds("2");
                cm.navigateStoredURL("Participant");
                cm.scrollIntoSection("Duration");
                cm.clickOnEditIconOnLabel("Expiration Date");
                cff.updateServicesData1("Expiration Date","NA");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log","Completed");
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

    @After(value = "@2205",order=2)
    public void L2205_PayIQ_Logs_Qualification_Eligible_Date_Not_Within_Date_Range_for_Team(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms9__Participant__c",DriverInstance.getVariable("TeamMember_SFID"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status","Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status","Pending");

                cm.navigateStoredURL("Team_Member2");
                cm.scrollIntoSection("Duration");
                cm.clickOnEditIconOnLabel("Expiration Date");
                cff.updateServicesData1("Expiration Date","NA");
                cff.updateServicesData1("Effective Date","NA");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                cm.navigateStoredURL("Team_Member3");
                cm.scrollIntoSection("Duration");
                cm.clickOnEditIconOnLabel("Expiration Date");
                cff.updateServicesData1("Expiration Date","NA");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log","Completed");
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
}