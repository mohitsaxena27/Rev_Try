package pageHelper.AfterTest.TMS.API_Operation;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Admin.Home_Page;
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
public class After_WWexSpeedShip_API {

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

    public After_WWexSpeedShip_API(bddDriver contextSteps) throws Exception {
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

    @After(value = "@2049",order=2)
    public void WWExSpeedShipAPI2049(Scenario s) throws Exception {
        //Step 2 & 3
        log("Deleting File & Load");
        ca.deleteFieldWithTitle("WWEXSpeedShipStatusOperation");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                //Step1
                log("Reset Configuration settings");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                //Step 4
                log("Delete Queued Transection job");
                hm.DeleteJob("LoadStatusUpdateJob");
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

    @After(value = "@2023",order=2)
    public void WWExSpeedShipAPI2023(Scenario s) throws Exception {

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                //Step1
                log("Reset Configuration settings");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Logging Enabled","False");
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