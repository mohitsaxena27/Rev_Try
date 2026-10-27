package pageHelper.AfterTest.TMS.EDI.Json.Outbound;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Admin.Home_Page;
import pageHelper.Test.TMS.Load.EDI;
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
public class After_EDI_Operation {

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
    EDI ed ;
    public After_EDI_Operation(bddDriver contextSteps) throws Exception {
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
        ed= new EDI(DriverInstance);
    }


    @After(value = "@3387",order=2)
    public void EDI_3387(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        log("Deleting Load & Files.");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Setting Revenova HQ TP - ");
                cm.navigateStoredURL("Revenova_TP");
                cm.scrollIntoSection("Customer Load Tracking");
                cm.clickOnEditIconOnLabel("Location Update Send Frequency");
                cm.waitForSeconds("2");
                cff.updateServicesData1("Location Update Send Frequency","--None--");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("Location Update Send Frequency","--None--");
                cm.goToModule("Home");
                hm.verifyAndDeleteFromScheduledJobs("EDIWatcherJob");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3386",order=2)
    public void EDI_3386(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);

        while (!success && attempt < maxAttempts) {
            attempt++;

            try {
                log("Reset Details for Carrier Tracking Administration");
                cm.openFromAppLauncher("Transportation Profiles");
                cm.searchAndSelectFromSearchList("EDI Carrier One");
                cm.scrollIntoSection("Lane Coverage and Preferences");
                cm.clickOnEditIconOnLabel("SCAC");
                cff.updateServicesData1("SCAC", " ");
                cm.clickOnButton("Save");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }


}