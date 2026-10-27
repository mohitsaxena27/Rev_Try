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
import pageHelper.Test.TMS.Object_Manager.Field_Set;
import pageHelper.Utility.*;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import io.cucumber.java.After;


import java.io.File;

import static pageHelper.bddDriver.log;

/**
 * @author manish.m
 */
@Slf4j
public class After_Project44_LTL_API {

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
    Admin_Global_Services ags;
    public After_Project44_LTL_API(bddDriver contextSteps) throws Exception {
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
        ags = new Admin_Global_Services(this.DriverInstance);
    }

    @After(value = "@541",order=2)
    public void Project44_541(Scenario s) throws Exception {
        ca.deleteFieldWithTitle("Project44QuoteOperation2");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Go to the Project 44 Customer TP > Rates tab > Carrier API Login Group field > adjust to null > save");
                cm.openFromAppLauncher("Transportation Profiles");
                cm.SelectTPFromRecentlyView("Project44 Customer");
                cm.goToTab("Rates");
                cm.clickOnEditIconOnLabel("Carrier API Login Group");
                cm.enterLabelText("Carrier API Login Group", "");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("Carrier API Login Group", "");

                log("Go to the Global Defaults TP > Rates tab > Carrier API Login Group field > adjust to null > save");
                cm.openFromAppLauncher("Transportation Profiles");
                cm.SelectTPFromRecentlyView("Global Default");
                cm.goToTab("Rates");
                cm.clickOnEditIconOnLabel("Carrier API Login Group");
                cm.enterLabelText("Carrier API Login Group", "");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("Carrier API Login Group", "");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
                System.out.println(e.getMessage());
            }

        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
          }

    @After(value = "@1616",order=2)
    public void Project44_1616(Scenario s) throws Exception {
        ca.deleteFieldWithTitle("Project44QuoteOperation2");
        ca.deleteFieldWithTitle("Project44TenderOperation2");
    }

    @After(value = "@1584",order=2)
    public void Project44_1584(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Load Tracking Administration Off");
                cm.navigateStoredURL("Load_1");
                cm.clickOnNativeIcon("Load Tracking");
                cf.verifyMessageAreDisplayingAs("Load Tracking Administration");
                cf.ClickonNativeSalesforceButton("Off");
                cm.verifyMessageAreDisplaying("Success - Carrier Banner");
                cm.closeToastMessage();

                log("Email Carrier Two's TP > Carrier Operations tab > clear the DOT Number and SCAC values > save");
                cm.goToModule("Transportation Profiles");
                cm.SelectTPFromRecentlyView("Email Carrier Two");
                cm.scrollIntoSection("Fleet Summary");
                cm.clickOnEditIconOnLabel("SCAC");
                cm.enterLabelText("SCAC", "");
                cm.scrollIntoSection("US Registration");
                cm.enterLabelText("US DOT Number", "");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("US DOT Number", "");
                log("Delete Queued Transection job");
                hm.DeleteJob("QueuedTransactionJob");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
                System.out.println(e.getMessage());
            }
        }
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));

        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@544", order = 2)
    public void after_Project44_544(Scenario s) throws Exception {

        Field_Set fs = new Field_Set(DriverInstance);
        Common_Steps cm = new Common_Steps(DriverInstance);

        try {
            log("Post Condition: Disable Remote Site P44BOL");
            fs.openFromSetupIcon("Setup");
            cm.switchWindowByIndex("1");
            cm.searchAndSelectFromQuickSearch("Remote Site Settings");
            cm.switchToFrameByTitle("All Remote Sites ~ Salesforce - Enterprise Edition");
            cm.waitForSeconds("2");
            cf.clickOn("P");
            cm.waitForSeconds("2");
            cm.switchToFrameByTitle("All Remote Sites ~ Salesforce - Enterprise Edition");
            cf.clickOnButtonWithTitle("Delete - Record 1 - P44BOL");
            cm.waitForSeconds("1");
            cf.acceptAlertIfAny();
            cm.switchToParentFrame();
            cm.closeCurrentTab();
            cm.switchToParentWindow();
            log("P44BOL disabled successfully");

        } catch (Exception e) {
            log("After @544 failed: " + e.getMessage());
        }
    }

    @After(value = "@545", order = 2)
    public void Project44_545(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Load Tracking Administration Off");
                cm.navigateStoredURL("Load_1");
                cm.clickOnNativeIcon("Load Tracking");
                cf.verifyMessageAreDisplayingAs("Load Tracking Administration");
                cf.ClickonNativeSalesforceButton("Off");
                cm.verifyMessageAreDisplaying("Success - Carrier Banner");
                cm.closeToastMessage();

                log("Email Carrier Two's TP > Carrier Operations tab > clear the DOT Number and SCAC values > save");
                cm.goToModule("Transportation Profiles");
                cm.SelectTPFromRecentlyView("Email Carrier Two");
                cm.scrollIntoSection("Fleet Summary");
                cm.clickOnEditIconOnLabel("SCAC");
                cm.enterLabelText("SCAC", "");
                cm.scrollIntoSection("US Registration");
                cm.enterLabelText("US DOT Number", "");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("US DOT Number", "");

                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
                System.out.println(e.getMessage());
            }
        }
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));

        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
}
