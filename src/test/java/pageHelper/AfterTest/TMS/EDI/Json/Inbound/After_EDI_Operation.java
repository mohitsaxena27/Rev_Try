package pageHelper.AfterTest.TMS.EDI.Json.Inbound;

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
    @After(value = "@3380",order=2)
    public void EDI_3380(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        log("Deleting Load & Files.");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));



        while (!success && attempt < maxAttempts) {
            attempt++;

            //Post Step 4
            try {
                log("Setting Accessorials   - disable the Limited Access checkbox");
                cm.navigateStoredURL("Accessorials");
                cm.clickOnEditIconOnLabel("Limited Access");
                cff.updateServicesData1("Limited Access","False");
                cm.clickOnButton("SaveEdit");

            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
             //post Step 5
            try {
                log("Reset Details for Carrier Tracking Administration");
                cm.openFromAppLauncher("Transportation Profiles");
                cm.searchAndSelectFromSearchList("Revenova HQ");
                cm.scrollIntoSection("Carrier Tracking Administration");
                cm.clickOnEditIconOnLabel("Automatic Carrier Tracking");
                cff.updateServicesData1("Tracking Provider","--None--");
                cff.updateServicesData1("Automatic Tracking Start Trigger","--None--");
                cmf.moveOptionToAvailable("Automatic Carrier Tracking Enabled Modes","Truckload");
                cm.clickOnButton("Save");
                cm.waitForSeconds("3");
                cm.clickOnEditIconOnLabel("Automatic Carrier Tracking");
                cff.updateServicesData1("Automatic Carrier Tracking","Global");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("Automatic Carrier Tracking","Global");
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
            try {
                log("Updating QA Arizona Cardinals");
                cm.searchAndSelectFromTheGlobalSearch("Arizona Cardinals");
                cm.goToTab("Contacts");
                cm.clickOn("QA Arizona Cardinals");
                cm.clickOnEditIconOnLabel("Transportation Role");
                cmf.moveOptionToAvailable("Transportation Role","HazMat");
                String EmailID= propertyReader.readproperty("EmailID");
                cff.updateServicesData1("Email",EmailID);
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("Transportation Role", "");

                log("Updating Arizona Diamondbacks Contacts");
                cm.searchAndSelectFromTheGlobalSearch("Arizona Diamondbacks");
                cm.goToTab("Contacts");
                cm.clickOn("QA Arizona Diamondbacks 3380");
                cm.clickOnEditIconOnLabel("Name");
                cm.waitForSeconds("1");
                cff.updateServicesData1("Last Name","Arizona Diamondbacks");
                cm.clickOnButtonOnDetailsPage("Save");
                cm.verifyIsSetTo("Name", "QA Arizona Diamondbacks");
                cm.BrowserBack();
                cm.clickOn("QA Hazmat Not Found");
                cm.setKeyPageRecordIdWith("QAHazmatNotFound","Contact");
                ca.DeleteRecords("Contact",DriverInstance.getVariable("QAHazmatNotFound"));

                cm.BrowserBack();
                cm.clickOn("George Smiley");
                cm.setKeyPageRecordIdWith("GeorgeSmiley","Contact");
                ca.DeleteRecords("Contact",DriverInstance.getVariable("GeorgeSmiley"));

                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }

        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3375",order=2)
    public void EDI_3375(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        log("Deleting Load & Files.");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            //Step2
            try {
                log("Resetting Equipment type Container45' ");
                cm.navigateStoredURL("EquipmentTypes");
                cm.clickOnEditIconOnLabel("Modes");
                cmf.moveOptionToAvailable("Modes","Truckload");
                cm.clickOnButton("SaveEdit");
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
            try {
                log("Updating Oldgistics - ATL8");
                cm.searchAndSelectFromTheGlobalSearch("Oldgistics - ATL8");
                cm.goToTab("Contacts");
                cm.clickOn("Harrison Ford Updated");
                cm.setKeyPageRecordIdWith("HarrisonFordUpdated","Contact");
                ca.DeleteRecords("Contact",DriverInstance.getVariable("HarrisonFordUpdated"));
                cm.BrowserBack();
                cm.clickOn("George Smiley");
                cm.setKeyPageRecordIdWith("GeorgeSmiley","Contact");
                ca.DeleteRecords("Contact",DriverInstance.getVariable("GeorgeSmiley"));
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3382",order=2)
    public void EDI_3382(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        log("Deleting Load.");
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("2LRI"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("3LRI"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("4LRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;

            try {
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Freeze Load Number", "True");
                cf.clickOnButtonWithValue("Save");
                cm.waitForSeconds("2");
                cm.switchToParentFrame();
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }

    }
    @After(value = "@1498",order=2)
    public void EDI_1498(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        log("Deleting Load.");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("3LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("4LRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;

            try {
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Freeze Load Number","True");
                cf.clickOnButtonWithValue("Save");
                cm.waitForSeconds("2");
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
    @After(value = "@3396",order=2)
    public void EDI_3396(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        log("Deleting Load.");
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;

            try {
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Freeze Load Number", "True");
                cf.clickOnButtonWithValue("Save");
                cm.waitForSeconds("2");
                cm.switchToParentFrame();
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
    @After(value = "@3383",order=2)
    public void EDI_3383(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        log("Deleting Load.");
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;

            try {
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Freeze Load Number", "True");
                cf.clickOnButtonWithValue("Save");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
    @After(value = "@3011",order=2)
    public void EDI_3011(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        log("Deleting Load.");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;

            try {
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Freeze Load Number","True");
                cf.clickOnButtonWithValue("Save");
                cm.waitForSeconds("2");
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


    @After(value = "@3398",order=2)
    public void EDI_3398(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        log("Deleting Loads");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("3LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("4LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("5LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("6LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("7LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("8LRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Setting Configuration  - Enable Packet Replay & EDI Enabled");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Global Settings");
                cff.updateServicesData1("Freeze Load Number","True");
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
    @After(value = "@3400",order=2)
    public void EDI_3400(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        log("Deleting Loads");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("3LRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Resetting Configuration");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Global Settings");
                cff.updateServicesData1("Freeze Load Number","True");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                cm.waitForSeconds("2");
                cm.navigateStoredURL("TP_Page");
                cm.scrollIntoSection("Lane Coverage and Preferences");
                cm.clickOnEditIconOnLabel("SCAC");
                cm.enterLabelText("SCAC", "");
                cm.clickOnButton("Save");
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

    @After(value = "@3449",order=2)
    public void EDI_3449(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        log("Deleting Load & Rate Entry");
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__RateEntry__c", DriverInstance.getVariable("Rate_Entry_1"));

    }

    @After(value = "@EDI",order=3)
    public void EDI_aLL(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        log("Deleting Transaction Log");
        ca.deleteAllRecordsAssociatedToName("EDI-","rtms__EDITransaction__c");
    }


}