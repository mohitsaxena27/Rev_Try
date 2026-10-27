package pageHelper.AfterTest.FMS.API_Operation;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.FMS.Fleet_Common;
import pageHelper.Test.TMS.Admin.Admin_Global_Services;
import pageHelper.Test.TMS.Admin.Configuration;
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
public class After_Trimble_API {

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

    public After_Trimble_API(bddDriver contextSteps) throws Exception {
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

    @After(value = "@2407",order=2)
    public void TrimbleAPI(Scenario s) throws Exception {
        ca.GetIDUsingName("Trip_Plan_ID_1","rtms__TripPlan__c","SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c","Trip_Plan_ID_1");
    }

    @After(value = "@2446",order=2)
    public void TrimbleAPI_2446(Scenario s) throws Exception {
        ca.GetIDUsingName("Trip_Plan_ID","rtms__TripPlan__c","SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c","Trip_Plan_ID");
        ca.GetIDUsingName("Trip_Plan_ID_2","rtms__TripPlan__c","SysData=>Trip_Plan_ID_2");
        ca.DeleteRecords1("rtms__TripPlan__c","Trip_Plan_ID_2");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                //Step 1
                log("Resetting Fleet Management details");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Fleet Management");
                cff.updateServicesData1("Enable Routing Consolidate Locations","false");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                log("Resetting Fleet Management details");
                hm.DeleteJob("QueuedTransactionJob");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2432",order=2)
    public void TrimbleAPI_2432(Scenario s) throws Exception {
        ca.deleteFieldWithTitle("SamsaraGetVehicleStatisticsOperation");
        ca.GetIDUsingName("Trip_Plan_ID","rtms__TripPlan__c","SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c","Trip_Plan_ID");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                hm.DeleteJob("FleetManagementJob3");
                cm.waitForSeconds("1");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay","False");
                cf.scrollIntoSection("Fleet Management");
                Configuration conf =new Configuration(DriverInstance);
                conf.selectFleetManagementJobAs("FleetManagementJob");
                cff.updateServicesData1("Fleet Management Job Last Run", "");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                //Catena - True
                log("Reset Global settings");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("Catena", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Catena");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");
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
