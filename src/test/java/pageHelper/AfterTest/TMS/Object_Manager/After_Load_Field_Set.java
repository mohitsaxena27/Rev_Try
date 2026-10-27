package pageHelper.AfterTest.TMS.Object_Manager;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.log4j.Log4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Object_Manager.Field_Set;
import pageHelper.Test.TMS.SetUp.Sharing_Settings;
import pageHelper.Utility.CommonFunction_Frame;
import pageHelper.Utility.Common_Apis;
import pageHelper.Utility.Common_Steps;
import pageHelper.Utility.Common_Steps_Frame;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

import static pageHelper.bddDriver.log;

@Log4j
public class After_Load_Field_Set {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    CommonFunction_Frame cff;
    Common_Steps_Frame cf;
    int maxAttempts = 3;  // Safety limit
    int attempt = 0;
    boolean success = false;

    public After_Load_Field_Set(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"CommonFrame.xml");
        pageObject=new xmlreader("TMS"+ File.separator+"Object_Manager"+File.separator+"Field_Set.xml");
        cf=new Common_Steps_Frame(DriverInstance);
        cff=new CommonFunction_Frame(DriverInstance);
    }

    @After(value = "@2004",order=2)
    public void DeleteFields(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        Field_Set fs = new Field_Set(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Field_Set_Page");
                cm.waitForSeconds("1");
                fs.OpenFieldSet("TMS15");
                fs.BrowserZoom("60");
                fs.DeleteWithFieldName("Warehouse Contact");
                fs.DeleteWithFieldName("Terminal Cutoff Date");
                fs.DeleteWithFieldName("Team");
                fs.DeleteWithFieldName("PO Number");
                fs.DeleteWithFieldName("Other Instructions");
                fs.DeleteWithFieldName("Offer Rate Type");
                fs.DeleteWithFieldName("Offer Rate");
                fs.DeleteWithFieldName("Driver Phone");
                fs.DeleteWithFieldName("Driver Comments");
                fs.BrowserZoom("100");
                fs.SaveFieldSet();
                cm.waitForSeconds("1");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println(e.getMessage());
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2275",order=2)
    public void DeleteFields_2275(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        Field_Set fs = new Field_Set(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Field_Set_Page");
                cm.waitForSeconds("1");
                fs.DeleteFieldSet("TMS15_LTL");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println(e.getMessage());
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@1107",order=2)
    public void DeleteFields_1107(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        Field_Set fs = new Field_Set(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Field_Set_Page");
                cm.waitForSeconds("1");
                fs.OpenFieldSet("TMS16");
                fs.BrowserZoom("60");
                fs.DeleteWithFieldName("Order Date");
                fs.DeleteWithFieldName("Import/Export");
                fs.DeleteWithFieldName("Carrier Portal");
                fs.DeleteWithFieldName("Cargo Summary");
                fs.DeleteWithFieldName("Booking Number");
                fs.BrowserZoom("100");
                fs.SaveFieldSet();
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println(e.getMessage());
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@1108",order=2)
    public void DeleteFields_1108(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        Field_Set fs = new Field_Set(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Field_Set_Page");
                cm.waitForSeconds("1");
                fs.DeleteFieldSet("TMS16_LTL");
                fs.DeleteFieldsAndRelationships("Custom_Field_1108");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println(e.getMessage());
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@1975",order=2)
    public void DeleteFields_1975(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        Field_Set fs = new Field_Set(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Field_Set_Page");
                cm.waitForSeconds("1");
                fs.OpenFieldSet("TMS1");
                fs.BrowserZoom("60");
                fs.DeleteWithFieldName("Terminal Cutoff Date");
                fs.DeleteWithFieldName("Team");
                fs.DeleteWithFieldName("Max Pay Amount");
                fs.DeleteWithFieldName("Customer Sales Rep");
                fs.DeleteWithFieldName("Commodity Condition");
                fs.MakeItRequired("Booking Number",false);
                fs.DeleteWithFieldName("Booking Number");
                fs.BrowserZoom("100");
                fs.SaveFieldSet();
                cm.waitForSeconds("3");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println(e.getMessage());
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@1992",order=2)
    public void DeleteFields_1992(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        Field_Set fs = new Field_Set(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Field_Set_Page");
                cm.waitForSeconds("1");
                fs.DeleteFieldSet("TMS1_LTL");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println(e.getMessage());
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }

    }

    @After(value = "@668",order=2)
    public void DeleteFields_668(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        Common_Apis ca = new Common_Apis(DriverInstance);
        Field_Set fs = new Field_Set(DriverInstance);
        Sharing_Settings ss = new Sharing_Settings(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Deleting Field Set");
                cm.navigateStoredURL("Field_Set_Page");
                cm.waitForSeconds("1");
                fs.DeleteFieldSet("TMS18_Truckload_Reefer");
                cm.waitForSeconds("2");
            } catch (AssertionError | Exception e) {
                System.out.println(e.getMessage());
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
            log("Deleting Global Value Set with Modes");
            cm.navigateStoredURL("Picklist_Value_Sets");
            cm.waitForSeconds("1");
            cm.switchToFrameByTitle("Picklist Value Sets");
            cf.clickOn("M");
            cm.switchToParentFrame();
            cm.waitForSeconds("2");
            cm.switchToFrameByTitle("Picklist Value Sets");
            cf.clickOn("Modes");
            cm.switchToParentFrame();
            cm.switchToFrameByTitle("Global Value Set ~ Salesforce - Enterprise Edition");
            ss.DeletePicklistValueSet("Truckload-Reefer");
            cf.acceptAlertIfAny();
            cm.switchToParentFrame();
            cm.switchToFrameByTitle("Find and Replace Value: Modes ~ Salesforce - Enterprise Edition");
            cff.updateServicesData1("Replace value on records with blank value","true");
            cf.clickOnButtonWithTitle("Save");
            cm.waitForSeconds("2");
            ca.GetIDUsingName("ModeName","rtms__Mode__c","Truckload-Reefer");
            ca.DeleteRecords1("rtms__Mode__c","ModeName");
            success=true;
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }

    }
}