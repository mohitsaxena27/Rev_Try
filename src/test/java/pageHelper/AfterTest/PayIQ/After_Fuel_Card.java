package pageHelper.AfterTest.PayIQ;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import org.testng.Assert;
import pageHelper.Test.PayIQ.PayIQ_Admin;
import pageHelper.Utility.*;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

/**
 * @author Sufiya
 */
public class After_Fuel_Card {

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
    Common_Steps_Frame cf;
    PayIQ_Admin pa;

    public After_Fuel_Card(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        pageObject = new xmlreader("PayIQ" + File.separator + "PayIQ_Admin.xml");
        ca = new Common_Apis(DriverInstance);
        cff = new CommonFunction_Frame(DriverInstance);
        pa = new PayIQ_Admin(DriverInstance);

    }

    @After(value = "@2984",order=2)
    public void After_2984(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));

        ca.GetIDUsingName("Participant", "rtms9__Participant__c", "SysData=>Participants");
        ca.DeleteRecords1("rtms9__Participant__c", "Participant");
        ca.DeleteRecords("rtms9__Pay_Header__c", DriverInstance.getVariable("Pay_Header_SFID_1"));


        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status","Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status","Pending");

                cm.navigateStoredURL("Fuel_Card");
                cm.clickOnEditIconOnLabel("Currency");
                cff.updateServicesData1("Currency", "USD - U.S. Dollar");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Currency", "USD - U.S. Dollar");
                success=true;

            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
    @After(value = "@2769",order=2)
    public void After_2769(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.GetIDUsingName("Participant", "rtms9__Participant__c", "SysData=>Participants");
        ca.DeleteRecords1("rtms9__Participant__c", "Participant");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status","Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status","Pending");

                cm.navigateStoredURL("Driver_1");
                cm.clickOnEditIconOnLabel("Contact");
                cff.updateServicesData1("Contact","Joe Revenova PayIQ");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Contact","Joe Revenova PayIQ");

                cm.navigateStoredURL("Fuel_Card");
                cm.clickOnEditIconOnLabel("Deductible");
                cm.waitForSeconds("1");
                cff.updateServicesData1("Deductible", "false");
                cm.waitForSeconds("1");
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