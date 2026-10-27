package pageHelper.AfterTest.FMS.TMS_Admin;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Admin.Admin_Global_Services;
import pageHelper.Test.TMS.Admin.Configuration;
import pageHelper.Test.TMS.Admin.Home_Page;
import pageHelper.Test.TMS.SetUp.Sharing_Settings;
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
public class After_TMS_Admin {

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
    Partner_APis pa;

    public After_TMS_Admin(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        cm = new Common_Steps(DriverInstance);
        cf = new Common_Steps_Frame(DriverInstance);
        ca = new Common_Apis(DriverInstance);
        cff = new CommonFunction_Frame(DriverInstance);
        cmf = new CommonFunction(DriverInstance);
        hm = new Home_Page(DriverInstance);
        pa= new Partner_APis(DriverInstance);
    }


    @After(value = "@3227", order = 2)
    public void Config_3225(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.deleteAllRecordsAssociatedToName("Account 3227","rtms__TransportationProfile__c");
        ca.deleteAllRecordsAssociatedToName("Account 3227","Account");
        ca.deleteAllRecordsAssociatedToName("Account 3227 Carrier","rtms__TransportationProfile__c");
        ca.deleteAllRecordsAssociatedToName("Account 3227 Carrier","Account");
        pa.DeleteSamSaraAddress("First_Address_ID");
        pa.DeleteSamSaraAddress("Second_Address_ID");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Setting Up Configuration");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Fleet Management");
                Configuration conf =new Configuration(DriverInstance);
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                //Delete from Samsara
//                cm.openNewTabWithUrl("https://cloud.samsara.com/o/82103/fleet/config/addresses");
//                cm.refreshCurrentPage();
//                cm.waitForSeconds("2");
//                Parter_Dashboard pd = new Parter_Dashboard(DriverInstance);
//                pd.DeleteAddedAddress("Account 3227");
//                pd.DeleteAddedAddress("Account 3227 Carrier");

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