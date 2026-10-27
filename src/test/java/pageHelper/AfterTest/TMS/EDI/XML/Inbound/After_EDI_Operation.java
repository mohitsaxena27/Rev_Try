package pageHelper.AfterTest.TMS.EDI.XML.Inbound;

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
    @After(value = "@2266",order=2)
    public void EDI_2266(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        log("Deleting Load & Files.");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.deleteFieldWithTitle("KleinschmidtGetLoadTendersOperation");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Setting Accessorials   - disable the Limited Access checkbox");
                cm.navigateStoredURL("Accessorials");
                cm.clickOnEditIconOnLabel("Limited Access");
                cff.updateServicesData1("Limited Access","False");
                cm.clickOnButton("SaveEdit");

            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
            try {
                log("Setting Configuration  - Enable Packet Replay & EDI Enabled");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay","False");
                cf.scrollIntoSection("EDI Setup");
                cff.updateServicesData1("EDI Enabled","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
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
                cm.clickOn("QA Arizona Diamondbacks 2266");
                cm.clickOnEditIconOnLabel("Name");
                cm.waitForSeconds("1");
                cff.updateServicesData1("Last Name","Arizona Diamondbacks");
                cm.clickOnButtonOnDetailsPage("Save");
                cm.verifyIsSetTo("Name", "QA Arizona Diamondbacks");
                cm.BrowserBack();
                cm.clickOn("QA Hazmat Not Found");
                cm.setKeyPageRecordIdWith("QAHazmatNotFound","Contact");
                ca.DeleteRecords("Contact",DriverInstance.getVariable("QAHazmatNotFound"));
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

    @After(value = "@2492",order=2)
    public void EDI_2492(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        //Step 1 & 5
        log("Deleting Load & Files.");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.deleteFieldWithTitle("KleinschmidtGetLoadTendersOperation");

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
            //Step4
            try {
                log("Setting Configuration  - Enable Packet Replay & EDI Enabled");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay","False");
                cf.scrollIntoSection("EDI Setup");
                cff.updateServicesData1("EDI Enabled","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
            //Step 3 & 6
            try {
                log("Updating Oldgistics - ATL8");
                cm.searchAndSelectFromTheGlobalSearch("Oldgistics - ATL8");
                cm.goToTab("Contacts");
                cm.clickOn("Harrison Ford Updated");
                cm.setKeyPageRecordIdWith("HarrisonFordUpdated","Contact");
                ca.DeleteRecords("Contact",DriverInstance.getVariable("HarrisonFordUpdated"));
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

    @After(value = "@490",order=2)
    public void EDI_490(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        log("Deleting Load & Files.");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("3LRI"));
        ca.deleteFieldWithTitle("KleinschmidtGetLoadTenderRespOperation");
        while (!success && attempt < maxAttempts) {
            attempt++;

            try {
                log("Setting Configuration  - Enable Packet Replay & EDI Enabled");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Freeze Load Number","True");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay","False");
                cf.scrollIntoSection("EDI Setup");
                cff.updateServicesData1("EDI Enabled","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                cm.waitForSeconds("2");
                cm.navigateStoredURL("TP_Page_EDI_Carrier_One");
                cm.scrollIntoSection("Lane Coverage and Preferences");
                cm.clickOnEditIconOnLabel("SCAC");
                cm.enterLabelText("SCAC", "");
                cm.clickOnButton("Save");
                cm.waitForSeconds("2");

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

    @After(value = "@494",order=2)
    public void EDI_494(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        log("Deleting Load & Files.");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("3LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("4LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("5LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("6LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("7LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("8LRI"));
        ca.deleteFieldWithTitle("KleinschmidtGetLoadStatusesOperation");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Setting Configuration  - Enable Packet Replay & EDI Enabled");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay","False");
                cf.scrollIntoSection("EDI Setup");
                cff.updateServicesData1("EDI Enabled","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
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

    @After(value = "@814",order=2)
    public void EDI_814(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        log("Deleting Load & Files.");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.deleteFieldWithTitle("KleinschmidtGetLoadInvoicesOperation");
        while (!success && attempt < maxAttempts) {
            attempt++;

            try {
                log("Setting Configuration  - Enable Packet Replay & EDI Enabled");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Freeze Load Number","True");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay","False");
                cf.scrollIntoSection("EDI Setup");
                cff.updateServicesData1("EDI Enabled","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
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

    @After(value = "@3036",order=2)
    public void EDI_3036(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        log("Deleting Load & Files.");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.deleteFieldWithTitle("KleinschmidtGetLoadInvoicesOperation");
        while (!success && attempt < maxAttempts) {
            attempt++;

            try {
                log("Setting Configuration  - Enable Packet Replay & EDI Enabled");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Freeze Load Number","True");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay","False");
                cf.scrollIntoSection("EDI Setup");
                cff.updateServicesData1("EDI Enabled","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
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
    @After(value = "@2231",order=2)
    public void EDI_2231(Scenario s) throws Exception {
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
    @After(value = "@1495",order=2)
    public void EDI_1495(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        log("Deleting Load & Files.");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("3LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("4LRI"));

        ca.deleteFieldWithTitle("KleinschmidtGetLoadTenderRespOperation");
        while (!success && attempt < maxAttempts) {
            attempt++;

            try {
                log("Setting Configuration  - Enable Packet Replay & EDI Enabled");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.switchToFrameByTitle("accessibility title");
                cff.updateServicesData1("Freeze Load Number","True");
                cf.scrollIntoSection("Debugging");
                cff.updateServicesData1("Enable Packet Replay","False");
                cf.scrollIntoSection("EDI Setup");
                cff.updateServicesData1("EDI Enabled","False");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
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
}