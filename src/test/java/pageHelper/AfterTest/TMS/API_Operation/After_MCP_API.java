package pageHelper.AfterTest.TMS.API_Operation;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Admin.Admin_Global_Services;
import pageHelper.Test.TMS.Admin.Home_Page;
import pageHelper.Test.TMS.Load.Load_Config;
import pageHelper.Utility.*;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

import static pageHelper.bddDriver.log;

/**
 * @author Sufiya
 */
@Slf4j
public class After_MCP_API {

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
    public After_MCP_API(bddDriver contextSteps) throws Exception {
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

    @After(value = "@2947", order = 2)
    public void MCP_API_Post_Test_Cleanup(Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);
        attempt = 0;
        success = false;

        // Step 2: Delete MCP uploaded Files
        ca.deleteFieldWithTitle("MCPGetCarrierOperation");
        ca.deleteFieldWithTitle("MCPGetCompletedPacketsOperation");
        ca.deleteFieldWithTitle("MCPGetCarrierChangesOperation");
        ca.deleteFieldWithTitle("MCPGetMonitoredCarriersOperation");
        ca.deleteFieldWithTitle("Sample Broker Agreement V2.pdf");
        ca.deleteFieldWithTitle("Carrier Customer Agreement.pdf");

        cm.waitForSeconds("2");
        //Step 3: Delete "QA Shipment LLC 2740" carrier service
        ca.deleteAllRecordsAssociatedToName("MCP Carrier 2947","rtms__CarrierService__c");

        // Step 4: Delete "QA Shipment LLC 2740" Transportation Profile
        ca.deleteAllRecordsAssociatedToName("MCP Carrier 2947","rtms__TransportationProfile__c");

        // Step 5: Delete "QA Shipment LLC 2740" Account
        ca.deleteAllRecordsAssociatedToName("MCP Carrier 2947","Account");

        //Step 6: Delete "QA Shipment LLC 2740" carrier service
        ca.deleteAllRecordsAssociatedToName("MCP Carrier 2947 Blocked Carrier","rtms__CarrierService__c");

        // Step 7: Delete "QA Shipment LLC 2740" Transportation Profile
        ca.deleteAllRecordsAssociatedToName("MCP Carrier 2947 Blocked Carrier","rtms__TransportationProfile__c");

        // Step 8: Delete "QA Shipment LLC 2740" Account
        ca.deleteAllRecordsAssociatedToName("MCP Carrier 2947 Blocked Carrier","Account");

        // Step 1: Disable Debugging Settings
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Disabling Debugging Settings");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");

                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");

                cff.updateServicesData1("Logging Enabled", "False");
                cff.updateServicesData1("Enable Packet Replay", "False");

                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                log("Reset Global settings");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Global Services");
                Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
                AGS.searchTextInTheSearchBox("SaferWatch", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("SaferWatch");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                AGS.searchTextInTheSearchBox("RMIS", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("RMIS");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                AGS.searchTextInTheSearchBox("Highway", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("Highway");
                cff.updateServicesData1("Enabled", "true");
                AGS.ClickonNativeSalesforceButton("Save");
                cm.waitForSeconds("2");

                hm.DeleteJob("CarrierMonitorMCPJob");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Retry " + attempt + " failed: " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("Post  cleanup failed after " + maxAttempts + " attempts.");
        }
    }

}
