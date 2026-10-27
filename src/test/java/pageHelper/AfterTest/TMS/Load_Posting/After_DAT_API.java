package pageHelper.AfterTest.TMS.Load_Posting;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Admin.Admin_Authorized_Users;
import pageHelper.Test.TMS.Admin.Admin_Global_Services;
import pageHelper.Test.TMS.Load.Load_Config;
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
public class After_DAT_API {

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

    public After_DAT_API(bddDriver contextSteps) throws Exception {
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

    @After(value = "@2703",order=2)
    public void Banyan_2447(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
                //Step2.a
                log("Resetting Global credentials for Project44");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Authorized Users");
                cm.clickOn("User User");
                Admin_Authorized_Users AAU = new Admin_Authorized_Users(DriverInstance);
                AAU.updateCheckboxAsForCredentialCard("Enabled","false","DAT 2");
                AAU.updateCheckboxAsForCredentialCard("Enabled","true","DAT");
                AGS.ClickonNativeSalesforceButton("Save");
                //Step2.b
                cm.goToTab("Global Services");
                AGS.searchTextInTheSearchBox("DAT 2", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("DAT 2");
                cff.updateServicesData1("Enabled", "false");
                AGS.ClickonNativeSalesforceButton("Save");
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


    @After(value = "@2930",order=2)
    public void load_2930(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
                //Step2.a
                log("Resetting Global credentials for Project44");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Authorized Users");
                cm.clickOn("User User");
                Admin_Authorized_Users AAU = new Admin_Authorized_Users(DriverInstance);
                AAU.updateCheckboxAsForCredentialCard("Enabled","false","DAT 2");
                AAU.updateCheckboxAsForCredentialCard("Enabled","true","DAT");
                AGS.ClickonNativeSalesforceButton("Save");
                //Step2.b
                cm.goToTab("Global Services");
                AGS.searchTextInTheSearchBox("DAT 2", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("DAT 2");
                cff.updateServicesData1("Enabled", "false");
                AGS.ClickonNativeSalesforceButton("Save");
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
    @After(value = "@2704",order=2)
    public void load_2704(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
                //Step2.a
                log("Resetting Global credentials for Project44");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Credentials");
                cm.goToTab("Authorized Users");
                cm.clickOn("User User");
                Admin_Authorized_Users AAU = new Admin_Authorized_Users(DriverInstance);
                AAU.updateCheckboxAsForCredentialCard("Enabled","false","DAT 2");
                AAU.updateCheckboxAsForCredentialCard("Enabled","true","DAT");
                AGS.ClickonNativeSalesforceButton("Save");
                //Step2.b
                cm.goToTab("Global Services");
                AGS.searchTextInTheSearchBox("DAT 2", "Search Credentials...");
                AGS.selectTheRecordFromTheLookupFieldResults("DAT 2");
                cff.updateServicesData1("Enabled", "false");
                AGS.ClickonNativeSalesforceButton("Save");
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