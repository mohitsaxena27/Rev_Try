package pageHelper.AfterTest.FMS.Fleet_Driver;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import pageHelper.Test.TMS.Admin.Configuration;
import pageHelper.Utility.*;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

/**
 * @author manish.m
 */
@Slf4j
public class After_Fleet_Driver {

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

    public After_Fleet_Driver(bddDriver contextSteps) throws Exception {
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

    @After(value = "@2635",order=2)
    public void Test2635(Scenario s) throws Exception {
       ca.deleteAllRecordsAssociatedToName("Assignment","rtms__DriverAssignment__c");
    }
    @After(value = "@3204", order = 2)
    public void Driver3204Cleanup(Scenario s) throws Exception {
        Exception cleanupFailure = null;
        try {
            ca.deleteAllRecordsAssociatedToName("Test Driver 3204A", "rtms__Driver__c");
            ca.deleteAllRecordsAssociatedToName("Test Driver 3204B", "rtms__Driver__c");
            ca.deleteAllRecordsAssociatedToName("Test Contact 3204A", "Contact");
            ca.deleteAllRecordsAssociatedToName("Test Contact 3204B", "Contact");
        } catch (Exception e) {
            cleanupFailure = e;
        } finally {
            cm.openFromAppLauncher("TMS Admin");
            cm.goToTab("Configuration");
            cm.switchToFrameByTitle("accessibility title");
            cf.scrollIntoSection("Fleet Management");
            Configuration configuration = new Configuration(DriverInstance);
            configuration.selectFleetManagementJobAs("FleetManagementJob");
            cf.clickOnButtonWithValue("Save");
            cm.switchToParentFrame();
        }
        if (cleanupFailure != null) {
            throw cleanupFailure;
        }
    }


}
