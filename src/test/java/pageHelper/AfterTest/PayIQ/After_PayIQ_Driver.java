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
public class After_PayIQ_Driver {

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

    public After_PayIQ_Driver(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        pageObject = new xmlreader("PayIQ" + File.separator + "PayIQ_Admin.xml");
        ca = new Common_Apis(DriverInstance);
        cff = new CommonFunction_Frame(DriverInstance);
        pa = new PayIQ_Admin(DriverInstance);

    }

    @After(value = "@2912", order = 2)
    public void L2912_MatchDriverLogs_To_PayIQ_Participants_Job(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords1("rtms__DriverLog__c", "DriverLog_SFID");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");
                pa.clickOnWithAnd("Role-","Parent Object","Driver Log","Lookup Type","Driver");
                cm.clickOnEditIconOnLabel("Parent Object");
                cff.updateServicesData1("Parent Object", "Trip Plan Leg");
                cff.updateServicesData1("Eligible Date Field", "Arrival Date");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Parent Object", "Trip Plan Leg");
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

    @After(value = "@2978", order = 2)
    public void L2978_Pay_Detail_Driver_Log_Currency_Conversion(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords1("rtms__DriverLog__c", "DriverLog_SFID");
        ca.DeleteRecords("rtms9__Pay_Header__c",DriverInstance.getVariable("Pay_Header_SFID"));
        ca.deleteAllRecordsAssociatedToName("Pay Header-","rtms9__Pay_Header__c");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.navigateStoredURL("Driver");
                cm.clickOnEditIconOnLabel("Currency");
                cff.updateServicesData1("Currency", "USD - U.S. Dollar");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Currency", "USD - U.S. Dollar");

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