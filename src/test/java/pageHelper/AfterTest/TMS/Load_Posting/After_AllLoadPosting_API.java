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
public class After_AllLoadPosting_API {

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

    public After_AllLoadPosting_API(bddDriver contextSteps) throws Exception {
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

    @After(value = "@1230",order=2)
    public void After_1230(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("EquipmentTypes");
                cm.goToTab("Load Posting Defaults");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("DAT Posting","Van");
                cff.updateServicesData1("LoadBoard Network","Van");
                cff.updateServicesData1("Trucker Tools Posting","Van");
                cff.updateServicesData1("Truckstop Posting","Van");
                cff.updateServicesData1("LoadLink Posting","Van");
                cf.clickOnButtonWithValue("Save");
                log("Resetting Load Post");
                cm.navigateStoredURL("Load_2L");
                ls.selectTheRemoveActionNextToTheIntegrationListing("DAT");
                ls.selectTheRemoveActionNextToTheIntegrationListing("LoadBoard Network");
                ls.selectTheRemoveActionNextToTheIntegrationListing("TransCore");
                ls.selectTheRemoveActionNextToTheIntegrationListing("Trucker Tools Load Board");
                ls.selectTheRemoveActionNextToTheIntegrationListing("Truckstop 2");
                cm.navigateStoredURL("Load_3L");
                ls.selectTheRemoveActionNextToTheIntegrationListing("LoadBoard Network");
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