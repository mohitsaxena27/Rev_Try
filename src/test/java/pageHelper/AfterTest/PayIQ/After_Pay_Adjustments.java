package pageHelper.AfterTest.PayIQ;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import org.testng.Assert;
import pageHelper.Test.PayIQ.PayIQ_Admin;
import pageHelper.Test.TMS.Load.Load_Quote_And_Invoice;
import pageHelper.Utility.CommonFunction;
import pageHelper.Utility.CommonFunction_Frame;
import pageHelper.Utility.Common_Apis;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

import static org.testng.Reporter.log;

/**
 * @author Sufiya
 */
public class After_Pay_Adjustments {

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
    Common_Steps cm;
    Load_Quote_And_Invoice lqi;

    public After_Pay_Adjustments(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
        pageObject = new xmlreader("PayIQ" +  File.separator + "PayIQ_Admin.xml");        ca = new Common_Apis(DriverInstance);
        cff=new CommonFunction_Frame(DriverInstance);
        pa= new PayIQ_Admin(DriverInstance);
        cm = new Common_Steps(DriverInstance);
        lqi=new Load_Quote_And_Invoice(DriverInstance);

    }
    @After(value = "@2751", order = 2)
    public void Pay_Adjustment_2751(Scenario s) throws Exception {

        ca.DeleteRecords("rtms9__Pay_Adjustment__c",DriverInstance.getVariable("Pay_Adj_Deduction"));

        ca.GetIDUsingName("ID1","rtms9__Pay_Adjustment__c","SysData=>PayAdj1");
        ca.DeleteRecords1("rtms9__Pay_Adjustment__c","ID1");

        ca.GetIDUsingName("ID2","rtms9__Pay_Adjustment__c","SysData=>PayAdj2");
        ca.DeleteRecords1("rtms9__Pay_Adjustment__c","ID2");


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

    @After(value = "@2928", order = 2)
    public void L2928Pay_Advance_Driver_Flat_Amount(Scenario s) throws Exception {
        ca.DeleteRecords("rtms9__Pay_Advance__c", DriverInstance.getVariable("Pay_Advance_SFID1"));
        ca.DeleteRecords("rtms9__Pay_Advance__c", DriverInstance.getVariable("Pay_Advance_SFID2"));
        ca.GetIDUsingName("Trip_Plan_ID","rtms__TripPlan__c","SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c","Trip_Plan_ID");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.navigateStoredURL("Roles_Page");
                cm.clickOnEditIconOnLabel("Eligible Date Field");
                cff.updateServicesData1("Eligible Date Field", "Arrival Date");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Eligible Date Field", "Arrival Date");

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