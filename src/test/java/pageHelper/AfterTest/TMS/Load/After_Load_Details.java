package pageHelper.AfterTest.TMS.Load;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Utility.CommonFunction;
import pageHelper.Utility.Common_Apis;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

import static pageHelper.bddDriver.log;

/**
 * @author manish.m
 */
@Slf4j
public class After_Load_Details {

    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    int maxAttempts = 3;  // Safety limit
    int attempt = 0;
    boolean success = false;
    Common_Apis ca;
    public After_Load_Details(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
        pageObject = new xmlreader("TMS" + File.separator + "Load" + File.separator + "Load_Summary.xml");
        ca = new Common_Apis(DriverInstance);
    }
    @After(value = "@2710",order=2)
    public void Matching_Maximum_HU_Height(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        CommonFunction cf = new CommonFunction(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.searchAndSelectFromTheGlobalSearch("Boston Red Sox");
                cm.goToTab("Contacts");
                cm.clickOn("Joe Boston Red Sox");
                cm.waitForSeconds("2");
                cm.clickOnEditIconOnLabel("Transportation Role");
                cm.waitForSeconds("2");
                cf.ListViewControlDualWithoutDataTable("Move selection to Chosen","Shipping");
                cm.clickOnButton("Save");
                cm.waitForSeconds("4");
                cm.verifyIsSetTo("Transportation Role","Shipping");


                cm.openFromAppLauncher("Transportation Profiles");
                cm.SelectTPFromRecentlyView("Boston Red Sox");
                cm.clickOnEditIconOnLabel("Shipping Hours");
                cm.enterLabelText("Shipping Hours", "09:00-22:00");
                cf.updateServicesData1("Pickup Appointment Required","False");
                cm.scrollIntoSection("Load Defaults");
                cm.waitForSeconds("1");
                cm.enterLabelTextArea("Default Pickup Instructions"," Pickup Instructions");
                cm.clickOnButton("Save");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Shipping Hours", "09:00-22:00");

                cm.openFromAppLauncher("Transportation Profiles");
                cm.SelectTPFromRecentlyView("Cincinnati Reds");
                cm.clickOnEditIconOnLabel("Shipping Hours");
                cm.enterLabelText("Shipping Hours", "09:00-22:00");
                cm.clickOnButton("Save");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Shipping Hours", "09:00-22:00");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3085",order=2)
    public void CarrierService3085(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__CarrierService__c",DriverInstance.getVariable("Carrier_Service"));
    }

    @After(value = "@1166",order=2)
    public void DeleteLoads_1166(Scenario s) throws Exception {
        log("Deleting Load");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("3LRI"));
        success=true;
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2336",order=2)
    public void DeleteLoads_2236(Scenario s) throws Exception {
        log("Deleting Load");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("3LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("4LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("5LRI"));
        success=true;
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
}
