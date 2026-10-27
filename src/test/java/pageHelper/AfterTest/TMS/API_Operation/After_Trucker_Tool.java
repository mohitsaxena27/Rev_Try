package pageHelper.AfterTest.TMS.API_Operation;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Admin.Home_Page;
import pageHelper.Test.TMS.Load.Load_Config;
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
public class After_Trucker_Tool {

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
    Home_Page hm;
    public After_Trucker_Tool(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
         cm = new Common_Steps(DriverInstance);
         cf=new Common_Steps_Frame(DriverInstance);
         ca = new Common_Apis(DriverInstance);
         cff=new CommonFunction_Frame(DriverInstance);
         cmf= new CommonFunction(DriverInstance);
        hm= new Home_Page(DriverInstance);
    }

    @After(value = "@550",order=2)
    public void TruckerTool_550(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Go to the Carrier Banner LWC > select the tracking icon > adjust the tracking to OFF");
                cm.openFromAppLauncher("Loads");
                Load_Config lc = new Load_Config(DriverInstance);
                lc.openCreatedLoadFromList("1L");
                cm.waitForSeconds("2");
                cm.clickOnNativeIcon("Load Tracking");
                cf.verifyMessageAreDisplayingAs("Load Tracking Administration");
                cf.ClickonNativeSalesforceButton("Off");
                cm.verifyMessageAreDisplaying("Success - Carrier Banner");
                cm.closeToastMessage();

                log("TMS Admin Set up");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("TruckerTools","True");
                cff.updateServicesData1("Tracking Update Frequency (Minutes)","60");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                log("Delete Queued Transection job");
                hm.DeleteJob("QueuedTransactionJob");
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


    @After(value = "@3356",order=2)
    public void TruckerTool_3356(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Go to the Carrier Banner LWC > select the tracking icon > adjust the tracking to OFF");
                cm.openFromAppLauncher("Loads");
                Load_Config lc = new Load_Config(DriverInstance);
                lc.openCreatedLoadFromList("1L");
                cm.waitForSeconds("2");
                cm.clickOnNativeIcon("Load Tracking");
                cf.verifyMessageAreDisplayingAs("Load Tracking Administration");
                cf.ClickonNativeSalesforceButton("Off");
                cm.verifyMessageAreDisplaying("Success - Carrier Banner");
                cm.closeToastMessage();
                log("Delete Queued Transection job");
                hm.DeleteJob("QueuedTransactionJob");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
                System.out.println(e.getMessage());
            }
            ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
}
