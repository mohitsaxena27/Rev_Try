package pageHelper.AfterTest.TMS.Carrier;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Admin.Admin_Global_Services;
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
public class After_Carrier_invoice {

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

    public After_Carrier_invoice(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
         cm = new Common_Steps(DriverInstance);
         cf=new Common_Steps_Frame(DriverInstance);
         ca = new Common_Apis(DriverInstance);
         cff=new CommonFunction_Frame(DriverInstance);
         cmf= new CommonFunction(DriverInstance);
    }

    @After(value = "@2232",order=2)
    public void CarrierInvoice2232(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L1CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L2CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L3CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L4CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L5CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L6CRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("TMS Admin> Configuration > Invoice Processing > Set the Carrier Invoice Creation Trigger picklist value to Delivered");
                Admin_Global_Services as = new Admin_Global_Services(DriverInstance);
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.waitForSeconds("2");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Invoice Processing");
                as.updateTheCustomSelectOptionAs("Carrier Invoice Creation Trigger","Delivered");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
                System.out.println(e.getMessage());
            }

        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }


}
