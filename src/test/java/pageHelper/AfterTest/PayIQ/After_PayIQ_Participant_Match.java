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
public class After_PayIQ_Participant_Match {

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
    public After_PayIQ_Participant_Match(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
        pageObject = new xmlreader("PayIQ" +  File.separator + "PayIQ_Admin.xml");        ca = new Common_Apis(DriverInstance);
        cff=new CommonFunction_Frame(DriverInstance);
        pa= new PayIQ_Admin(DriverInstance);

    }
    @After(value = "@1940",order=2)
    public void L2199_Qualification_PayIQ_Program_Not_Open(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status","Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status","Pending");

                cm.navigateStoredURL("Participants_page_1");
                cm.clickOnEditIconOnLabel("Effective Date");
                cff.updateServicesData1("Effective Date","NA");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                cm.navigateStoredURL("Participants_page_2");
                cm.clickOnEditIconOnLabel("Expiration Date");
                cff.updateServicesData1("Expiration Date","NA");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log","Completed");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@1939",order=2)
    public void L1939_MatchLoadsToPayIQParticipants_Job_Participant_Effective_Expiration_Date(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
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
                cm.navigateStoredURL("Participant1");
                cm.clickOnEditIconOnLabel("Effective Date");
                cff.updateServicesData1("Effective Date","NA");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Effective Date","");
                cm.navigateStoredURL("Participant2");
                cm.clickOnEditIconOnLabel("Expiration Date");
                cff.updateServicesData1("Expiration Date","NA");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Expiration Date","");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@1936",order=2)
    public void L1936_MatchLoadsToPayIQParticipants_Job_Role_Parent_Object_Load(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L1CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2L1CRI"));
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
                success=true;
                    } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2907",order=2)
    public void L2907_MatchLoadsToPayIQParticipants_Job_Role_Parent_Object_Trip_Plan(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.GetIDUsingName("Trip_Plan_ID_1", "rtms__TripPlan__c", "SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c", "Trip_Plan_ID_1");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status","Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status","Pending");
                pa.clickOnWithAs("Participant-","Name","Dave Fleet Carrier One 7");
                cm.clickOnEditIconOnLabel("Pay Off Load Instead of Trip Plan Leg");
                cff.updateServicesData1("Pay Off Load Instead of Trip Plan Leg","False");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.navigateStoredURL("PayIQ_Program_1");
                pa.clickOnWithAs("Participant-","Name","Tractor 1007");
                cm.clickOnEditIconOnLabel("Pay Off Load Instead of Trip Plan Leg");
                cff.updateServicesData1("Pay Off Load Instead of Trip Plan Leg","False");
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

    @After(value = "@2768",order=2)
    public void After_2768(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status","Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status","Pending");

                cm.navigateStoredURL("PayIQ_Program_2");
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
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2788",order=2)
    public void After_2788(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
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
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2757",order=2)
    public void After_2757(Scenario s) throws Exception {
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
                cm.waitForSeconds("5");
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

    @After(value = "@2752", order = 2)
    public void After_2752(Scenario s) throws Exception {
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
    @After(value = "@2762", order = 2)
    public void After_2762(Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {

                //Set Program back to Pending
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                //Delete PayIQ Logs
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

    @After(value = "@3593",order=2)
    public void After_3593(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms9__PayIQ_Program__c", DriverInstance.getVariable("PayIQ_Program_SFID_1"));
        ca.GetIDUsingName("Trip_Plan_ID_1", "rtms__TripPlan__c", "SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c", "Trip_Plan_ID_1");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log","Completed");
                cm.waitForSeconds("2");

                cm.goToTab("Configuration");
                cff.updateServicesData1("Match Trip Plan Legs to PayIQ Participants Batch Size", "200");
                cm.clickOn("Save");
                cm.verifyMessageAreDisplaying("PayIQ Configuration Saved");

                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2784", order = 2)
    public void L2784_MatchLoadsToPayIQParticipants_Job_Freight_Plan_Matching(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);

        ca.DeleteRecords("rtms9__Participant__c", DriverInstance.getVariable("Participant_SFID"));
        ca.GetIDUsingName("Participant_ID", "rtms9__Participant__c", "SysData=>Participant_Name_1");
        ca.DeleteRecords1("rtms9__Participant__c", "Participant_ID");

        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("2LRI"));

        ca.GetIDUsingName("Load_3", "rtms__Load__c", "SysData=>FP_Carrier_Load_1");
        ca.DeleteRecords1("rtms__Load__c", "Load_3");

        ca.GetIDUsingName("Load_4", "rtms__Load__c", "SysData=>FP_Carrier_Load_2");
        ca.DeleteRecords1("rtms__Load__c", "Load_4");

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
}