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
public class After_Pay_Header {

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
    public After_Pay_Header(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
        pageObject = new xmlreader("PayIQ" +  File.separator + "PayIQ_Admin.xml");        ca = new Common_Apis(DriverInstance);
        cff=new CommonFunction_Frame(DriverInstance);
        pa= new PayIQ_Admin(DriverInstance);

    }
    @After(value = "@2939",order=2)
    public void TC2939_Pay_Header_Statuses_Aggregate_Calculation_Criteria(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("2LRI"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("3LRI"));

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

    @After(value = "@2904", order = 2)
    public void TC2904_Pay_Header_Email_Pay_Settlements_Fleet_Asset(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        attempt = 0;
        success = false;

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.openFromAppLauncher("Fleet Assets");
                cm.searchAndSelectTP("Tractor 1008");
//                cm.goToTab("PayIQ");
                cm.clickOnEditIconOnLabel("Pay Settlement Email To");
                cff.updateServicesData1("Pay Settlement Email To", "");
                cff.updateServicesData1("Pay Settlement Email CC", "");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("2");

                cm.openFromAppLauncher("PayIQ Programs");
                cm.searchAndSelectTP("PayIQProgram Individual Load Revenue (Quoted)");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.goToTab("Configuration");
                cff.updateServicesData1("Error Email", "test@revenova.com");
                cm.clickOn("Save");
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

    @After(value = "@2905", order = 2)
    public void TC2905_Pay_Header_Email_Pay_Settlements_Driver(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        attempt = 0;
        success = false;

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Driver_Url_2");
                cm.scrollIntoSection("Employment / Personal Information");
                cm.clickOnEditIconOnLabel("Email");
                cm.enterLabelText("Email", "SysData=>OrgEmail");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");


                cm.navigateStoredURL("Driver_Url_1");
                cm.clickOnEditIconOnLabel("User");
                cff.updateServicesData1("User", "");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                cm.openFromAppLauncher("PayIQ Programs");
                cm.searchAndSelectTP("PayIQProgram Individual Load Revenue (Quoted)");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log","Completed");
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




    @After(value = "@2982",order=2)
    public void TC2982_Pay_Header_Statuses_Aggregate_Calculation_Criteria(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms9__Pay_Header__c", DriverInstance.getVariable("Pay_Header_SFID_1"));
        ca.DeleteRecords("rtms9__Pay_Header__c", DriverInstance.getVariable("Pay_Header_SFID_2"));
        ca.deleteAllRecordsAssociatedToName("Pay Header-","rtms9__Pay_Header__c");
        ca.GetIDUsingName("Trip_Plan_ID","rtms__TripPlan__c","SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c","Trip_Plan_ID");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));


        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Driver_1");
                cm.scrollIntoSection("General Information");
                cm.clickOnEditIconOnLabel("Currency");
                cff.updateServicesData1("Currency","USD - U.S. Dollar");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                cm.navigateStoredURL("Fleet_Assets_1");
                cm.scrollIntoSection("System Information");
                cm.clickOnEditIconOnLabel("Currency");
                cff.updateServicesData1("Currency","USD - U.S. Dollar");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

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
    @After(value = "@3174",order=2)
    public void TC3174_Pay_Header_Statuses_Aggregate_Calculation_Criteria(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms9__Pay_Header__c", DriverInstance.getVariable("Pay_Header_SFID_1"));
        ca.DeleteRecords("rtms9__Pay_Header__c", DriverInstance.getVariable("Pay_Header_SFID_2"));
        ca.DeleteRecords("rtms9__Pay_Advance__c", DriverInstance.getVariable("Pay_Advance_SFID_1"));
        ca.DeleteRecords("rtms9__Pay_Advance__c", DriverInstance.getVariable("Pay_Advance_SFID_2"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status","Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status","Pending");

                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2931",order=2)
    public void TC2931_Pay_Header_Statuses_Aggregate_Calculation_Criteria(Scenario s) throws Exception {
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
}
