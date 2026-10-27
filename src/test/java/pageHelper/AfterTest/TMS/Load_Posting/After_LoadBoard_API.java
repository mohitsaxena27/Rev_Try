package pageHelper.AfterTest.TMS.Load_Posting;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Admin.Admin_Authorized_Users;
import pageHelper.Test.TMS.Admin.Admin_Global_Services;
import pageHelper.Test.TMS.Load.Load_Summary;
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
public class After_LoadBoard_API {

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
    Load_Summary ls;

    public After_LoadBoard_API(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
         cm = new Common_Steps(DriverInstance);
         cf=new Common_Steps_Frame(DriverInstance);
         ca = new Common_Apis(DriverInstance);
         cff=new CommonFunction_Frame(DriverInstance);
         cmf= new CommonFunction(DriverInstance);
         ls = new Load_Summary(DriverInstance);
    }


    @After(value = "@2934",order=2)
    public void LoadBoard_2934(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                //Step 1
                log("Resetting Configuration Settings");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Logging Enabled","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                //Step 2
                log("Resetting User Settings");
                cm.navigateStoredURL("User_Details");
                cm.clickOnButtonWithTitle("Edit");
                cm.enterLabelTextOnModal("Phone","");
                cm.clickOn("Save");
                cm.waitForSeconds("2");

                log("Resetting Load Post Status");
                cm.navigateStoredURL("Load Posting");
                cm.scrollIntoSection("General Information");
                cm.clickOnEditIconOnLabel("Posting Status");
                cff.updateServicesData1("Posting Status","Unposted");
                cm.clickOn("Save");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2935",order=2)
    public void LoadBoard_2935(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                //Step 1
                log("Resetting Configuration Settings");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Freeze Load Number","True");
                cff.updateServicesData1("Logging Enabled","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                //Step 2
                log("Resetting Load Post");
                cm.navigateStoredURL("Load_Num");
                ls.selectTheRemoveActionNextToTheIntegrationListing("LoadBoard Network");
                cm.verifyMessageAreDisplayingWithText("LoadBoard Network: This load posting was removed from the load board.");
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
}