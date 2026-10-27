package pageHelper.AfterTest.FMS.Fleet_Trip_Planner;

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

/**
 * @author manish.m
 */
@Slf4j
public class After_Trip_Plan_Dispatch {

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

    public After_Trip_Plan_Dispatch(bddDriver contextSteps) throws Exception {
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

    @After(value = "@2588",order=2)
    public void Fleet_2588(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.openFromAppLauncher("Drivers");
                cm.SelectTPFromRecentlyView("QA Driver Two Five Eight Eight");
                cm.scrollIntoSection("ELD Configuration");
                cm.clickOnEditIconOnLabel("ELD ID");
                cff.updateServicesData1("ELD ID","");
                cff.updateServicesData1("ELD Enabled","False");
                cff.updateServicesData1("ELD Exempt","False");
                cff.updateServicesData1("ELD Brand","--None--");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("ELD ID", "");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                Admin_Global_Services ags = new Admin_Global_Services(this.DriverInstance);
                ags.searchTextInTheSearchBox("Catena","Search Credentials...");
                ags.selectTheRecordFromTheLookupFieldResults("Catena");
                cff.updateServicesData1("Enabled","True");
                ags.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");
                ags.searchTextInTheSearchBox("Samsara","Search Credentials...");
                ags.selectTheRecordFromTheLookupFieldResults("Samsara");
                cff.updateServicesData1("Enabled","True");
                ags.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("1");
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
