package pageHelper.AfterTest.TMS.TransportationProfile;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Admin.Home_Page;
import pageHelper.Test.TMS.Object_Manager.Field_Set;
import pageHelper.Test.TMS.SetUp.ManageUser;
import pageHelper.Test.TMS.SetUp.Permission_Set;
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
public class After_Credit_Limit {

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

    public After_Credit_Limit(bddDriver contextSteps) throws Exception {
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

    @After(value = "@1579",order=2)
    public void ARCalculationJob(Scenario s) throws Exception {
        Sharing_Settings ss = new Sharing_Settings(DriverInstance);
        log("Deleting Load");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("3LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("4LRI"));
        log("Load Deleted successfully");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                if(webDriver.NumberOfWindow()>1)
                {
                    webDriver.CloseCurrentWindows();
                    webDriver.SwitchToParentWindod();
                }
                Field_Set fs = new Field_Set(DriverInstance);
                ManageUser mu = new ManageUser(DriverInstance);
                Permission_Set ps = new Permission_Set(DriverInstance);
                log("Setting Enforce Customer Credit Limits to false");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Enforce Customer Credit Limits","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                log("Setting Sharing Settings to Public Read/Write");
                fs.openFromSetupIcon("Setup");
                cm.switchWindowByIndex("1");
                cm.searchAndSelectFromQuickSearch("Sharing Settings");
                cm.switchToFrameByTitle("Sharing Settings");
                ss.updateSharingSettingsFor("Accounts");
                cm.switchToParentFrame();
                cm.switchToFrameByTitle("Sharing Settings");
                ss.updateSharingSettingsAs("Public Read/Write","Account and Contract : Default Access");
                cm.switchToFrameByTitle("Sharing Settings");
                ss.updateSharingSettingsAs("Public Read/Write","Load : Default Access");
                log("Remove Permission Set : A/R Calc Testing TMS Developer 1579");
                cm.searchAndSelectHrefFromQuickSearch("User","ManageUsers");
                mu.NavigateToUser("User, Second");
                mu.NavigateToPermissionSet();
                ps.moveToAvailable("A/R Calc Testing TMS Developer 1579");
                cf.clickOnButtonWithValue("Save");
                cm.waitForSeconds("3");
                cm.switchToParentFrame();
                cm.closeCurrentTab();
                cm.switchToParentWindow();
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@597",order=2)
    public void ARCalculationJob2(Scenario s) throws Exception {
        Sharing_Settings ss = new Sharing_Settings(DriverInstance);

        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L1CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L2CRI"));        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L1CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2L1CRI"));        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L1CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2L2CRI"));
        ca.DeleteRecords("rtms__CreditLimit__c",DriverInstance.getVariable("Credit_Limit"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Setting Enforce Customer Credit Limits to false");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Enforce Customer Credit Limits","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                log("Update TP The Jedi Order Credit Limit Credit to initial State");

                cm.goToModule("Transportation Profiles");
                cm.searchAndSelectFromSearchList("The Jedi Order Credit Limit");
                cm.goToTab("Credit");
                cm.clickOnEditIconOnLabel("Credit Limit");
                cm.removeFromField("","Credit Limit");
                cm.enterLabelText("Credit Limit Amount", "");
                cm.enterLabelText("A/R Current", "");
                cm.enterLabelText("A/R Unbilled", "");
                cm.enterLabelText("A/R Past Due", "");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("Credit Limit", "");
                log("Update TP The Sith Credit Limit Credit to initial State");

                cm.goToModule("Transportation Profiles");
                cm.searchAndSelectFromSearchList("The Sith Credit Limit");
                cm.goToTab("Credit");
                cm.clickOnEditIconOnLabel("Credit Limit");
                cm.removeFromField("","Credit Limit");
                cm.enterLabelText("Credit Limit Amount", "");
                cm.enterLabelText("A/R Current", "");
                cm.enterLabelText("A/R Unbilled", "");
                cm.enterLabelText("A/R Past Due", "");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("Credit Limit", "");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
            ca.DeleteRecords("rtms__CreditLimit__c",DriverInstance.getVariable("Credit_Limit"));

        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@1715",order=2)
    public void ARCalculationJob3(Scenario s) throws Exception {
        Sharing_Settings ss = new Sharing_Settings(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L1CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("3LRI"));
        ca.DeleteRecords("rtms__CreditLimit__c",DriverInstance.getVariable("Credit_Limit"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Setting Enforce Customer Credit Limits to false");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Enforce Customer Credit Limits","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                log("Update TP The Millennium Falcon Credit to initial State");

                cm.goToModule("Transportation Profiles");
                cm.searchAndSelectFromSearchList("Millennium Falcon Credit Limit");
                cm.goToTab("Credit");
                cm.clickOnEditIconOnLabel("Credit Limit");
                cm.removeFromField("","Credit Limit");
                cm.enterLabelText("Credit Limit Amount", "");
                cm.enterLabelText("A/R Current", "");
                cm.enterLabelText("A/R Unbilled", "");
                cm.enterLabelText("A/R Past Due", "");
                cm.clickOnButton("Save");
                cm.waitForSeconds("4");
                cm.verifyIsSetTo("Credit Limit", "");
                log("Update TP Chewbacca Credit Limit Credit to initial State");

                cm.goToModule("Transportation Profiles");
                cm.searchAndSelectFromSearchList("Chewbacca Credit Limit");
                cm.goToTab("Credit");
                cm.clickOnEditIconOnLabel("Credit Limit");
                cm.removeFromField("","Credit Limit");
                cm.enterLabelText("Credit Limit Amount", "");
                cm.enterLabelText("A/R Current", "");
                cm.enterLabelText("A/R Unbilled", "");
                cm.enterLabelText("A/R Past Due", "");
                cm.clickOnButton("Save");
                cm.waitForSeconds("4");
                cm.verifyIsSetTo("Credit Limit", "");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
            ca.DeleteRecords("rtms__CreditLimit__c",DriverInstance.getVariable("Credit_Limit"));

        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@1702",order=2)
    public void ARCalculationJob4(Scenario s) throws Exception {
        Sharing_Settings ss = new Sharing_Settings(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L1CRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Setting Enforce Customer Credit Limits to false");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Enforce Customer Credit Limits","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                log("Update TP The Sith Credit Limit Credit to initial State");

                cm.goToModule("Transportation Profiles");
                cm.searchAndSelectFromSearchList("The Sith Credit Limit");
                cm.goToTab("Credit");
                cm.clickOnEditIconOnLabel("Credit Limit Amount");
                cm.enterLabelText("Credit Limit Amount", "10000");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("Credit Limit Amount", "USD 10,000.00");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@468",order=2)
    public void ARCalculationJob5(Scenario s) throws Exception {
        Sharing_Settings ss = new Sharing_Settings(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2L1CRI"));
        ca.DeleteRecords("rtms__CreditLimit__c",DriverInstance.getVariable("Credit_Limit"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Setting Enforce Customer Credit Limits to false");

                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Enforce Customer Credit Limits","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                log("Update TP The Sith Credit Limit Credit to initial State");

                cm.goToModule("Transportation Profiles");
                cm.searchAndSelectFromSearchList("The Sith Credit Limit");
                cm.goToTab("Credit");
                cm.clickOnEditIconOnLabel("Credit Limit");
                cm.removeFromField("","Credit Limit");
                cm.enterLabelText("Credit Limit Amount", "");
                cm.enterLabelText("A/R Current", "");
                cm.enterLabelText("A/R Unbilled", "");
                cm.enterLabelText("A/R Past Due", "");
                cm.clickOnButton("Save");
                cm.waitForSeconds("4");
                cm.verifyIsSetTo("Credit Limit", "");

                log("Update TP Death Star Credit Limit Credit to initial State");

                cm.goToModule("Transportation Profiles");
                cm.searchAndSelectFromSearchList("Death Star Credit Limit");
                cm.goToTab("Credit");
                cm.clickOnEditIconOnLabel("Credit Limit");
                cm.removeFromField("","Credit Limit");
                cm.enterLabelText("Credit Limit Amount", "");
                cm.enterLabelText("A/R Current", "");
                cm.enterLabelText("A/R Unbilled", "");
                cm.enterLabelText("A/R Past Due", "");
                cm.clickOnButton("Save");
                cm.waitForSeconds("4");
                cm.verifyIsSetTo("Credit Limit", "");
                cm.goToModule("Home");
                hm.runJob("ARCalculationJob");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
            ca.DeleteRecords("rtms__CreditLimit__c",DriverInstance.getVariable("Credit_Limit"));

        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@598",order=2)
    public void ARCalculationJob6(Scenario s) throws Exception {
        Sharing_Settings ss = new Sharing_Settings(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L1CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("3LRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Setting Enforce Customer Credit Limits to false");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Enforce Customer Credit Limits","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                log("Update TP Death Star Credit Limit Credit Refresh");
                cm.goToModule("Transportation Profiles");
                cm.searchAndSelectFromSearchList("Death Star Credit Limit");
                cm.clickOn("Refresh Credit");
                cm.waitForSeconds("5");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3167",order=2)
    public void ARCalculationJob3167(Scenario s) throws Exception {
        Sharing_Settings ss = new Sharing_Settings(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L11CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L21CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L31CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L41CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L51CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L61CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L71CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L81CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L91CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L101CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L111CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L121CRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Setting Enforce Customer Credit Limits to false");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Enforce Customer Credit Limits","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@419",order=2)
    public void Customer_1686(Scenario s) throws Exception {
        Sharing_Settings ss = new Sharing_Settings(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L1CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2L1CRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {


                log("Update TP Chewbacca Credit Limit to initial State");
                cm.navigateStoredURL("TP_Chewbacca");
                cm.goToTab("Credit");
                cm.clickOnEditIconOnLabel("Credit Limit Amount");
                cm.enterLabelText("Credit Limit Amount", "100000");
                cm.clickOnButton("Save");
                cm.waitForSeconds("4");

                cm.navigateStoredURL("TP_Jedi_Credit");
                cm.goToTab("Billing");
                cm.waitForSeconds("1");
                cm.clickOnEditIconOnLabel("Billing Method");
                cm.waitForSeconds("1");
                cmf.updateServicesDataWithKeyValue("Default Customer Bill To_2","The Jedi Order Credit Limit");
                cm.clickOnButton("Save");
                cm.waitForSeconds("4");
                cm.Homepage();
                hm.runJob("ARCalculationJob");
                cm.waitForSeconds("2");
                log("Setting Enforce Customer Credit Limits to false");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Enforce Customer Credit Limits","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
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
