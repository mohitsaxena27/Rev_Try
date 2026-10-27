package pageHelper.AfterTest.FMS.API_Operation;
import pageHelper.Test.TMS.Admin.Configuration;
import pageHelper.Test.TMS.Admin.Home_Page;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Utility.*;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

/**
 * @author manish.m
 */
@Slf4j
public class After_Samsara_API {

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

    public After_Samsara_API(bddDriver contextSteps) throws Exception {
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

    @After(value = "@2789",order=2)
    public void SamasaraAPI(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
//                cm.goToModule("Drivers");
                cm.openFromAppLauncher("Drivers");
                cm.SelectTPFromRecentlyView("Bruce Fleet Carrier Two 1");
                cm.scrollIntoSection("ELD Configuration");
                cm.clickOnEditIconOnLabel("ELD ID");
                cff.updateServicesData1("ELD ID","");
                cff.updateServicesData1("ELD Enabled","False");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("ELD ID", "");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2787",order=2)
    public void SamasaraAPI2787(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.goToModule("Transportation Profiles");
                cm.SelectTPFromRecentlyView("Kansas City Chiefs");
                cm.waitForSeconds("2");
                cm.SelectTPFromRecentlyView("Kansas City Chiefs");
                cm.goToTab("Related");
                cm.clickOnRowDropdownForTable("Account ELD");
                cf.clickOnDivText("Delete");
                cf.clickOnLinkTextOnPage("Confirm","Delete");
                cm.verifyMessageAreDisplaying("was deleted.");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3671", order = 2)
    public void CatenaAPI3671(Scenario s) throws Exception {
        success = false;
        attempt = 0;

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                // Post Step 1 - Delete FleetManagementJob4 from Scheduled Jobs
                Home_Page home = new Home_Page(DriverInstance);
                home.DeleteJob("FleetManagementJob4");

                // Post Step 2 - Reset TMS Admin > Configuration > Fleet Management Job
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");

                cf.scrollIntoSection("Fleet Management");

                Configuration config = new Configuration(DriverInstance);
                config.selectFleetManagementJobAs("FleetManagementJob");

                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("3671 after test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("3671 after test did not pass after " + maxAttempts + " attempts.");
        }
    }
}
