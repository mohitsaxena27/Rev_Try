package pageHelper.AfterTest.TMS.Load_Posting;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Load.Load_Summary;
import pageHelper.Utility.*;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

/**
 * @author manish.m
 */
@Slf4j
public class After_TransCore_API {

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

    public After_TransCore_API(bddDriver contextSteps) throws Exception {
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

    @After(value = "@2925",order=2)
    public void TransCore_2447(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            Load_Summary ls = new Load_Summary(DriverInstance);
            try {
                cm.navigateStoredURL("Load_Details");
                cm.waitForSeconds("2");
                ls.selectTheRemoveActionNextToTheIntegrationListing("TransCore");
                cm.verifyMessageAreDisplayingWith("TransCore: This load posting was removed from the load board.");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }

    }

    @After(value = "@2513",order=2)
    public void TransCore_2513(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.deleteFieldWithTitle("TransCoreGetTruckPostingsOperation");
        while (!success && attempt < maxAttempts) {
            attempt++;
            Load_Summary ls = new Load_Summary(DriverInstance);
            try {
                cm.navigateStoredURL("Load_Details");
                cm.waitForSeconds("2");
                ls.selectTheRemoveActionNextToTheIntegrationListing("TransCore");
                cm.verifyMessageAreDisplayingWith("TransCore: This load posting was removed from the load board.");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }

    }

    @After(value = "@2936",order=2)
    public void Core_2936(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            Load_Summary ls = new Load_Summary(DriverInstance);
            try {
                cm.navigateStoredURL("Load_Details");
                cm.waitForSeconds("2");
                ls.selectTheRemoveActionNextToTheIntegrationListing("TransCore");
                cm.verifyMessageAreDisplayingWith("TransCore: This load posting was removed from the load board.");
                cm.waitForSeconds("1");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Freeze Load Number","True");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }

    }
}