package pageHelper.AfterTest.TMS.Carrier;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Admin.Admin_Global_Services;
import pageHelper.Test.TMS.Admin.Configuration;
import pageHelper.Test.TMS.Admin.Home_Page;
import pageHelper.Test.TMS.Object_Manager.Field_Set;
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
public class After_Carrier_Guest {

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
    public After_Carrier_Guest(bddDriver contextSteps) throws Exception {
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


    @After(value = "@617",order=2)
    public void CustomerGuest617(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                hm.DeleteJob("QueuedTransactionJob");
                cm.waitForSeconds("2");
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
                System.out.println(e.getMessage());
            }
            Field_Set fs = new Field_Set(DriverInstance);
            cm.navigateStoredURL("Load_Setting");
                try {
                    fs.OpenFieldSet("TMS30");
                    fs.DeleteWithFieldName("Load Number");
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

    @After(value = "@604",order=2)
    public void CustomerGuest604(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                hm.DeleteJob("QueuedTransactionJob");
                cm.waitForSeconds("2");
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

    @After(value = "@608",order=2)
    public void CustomerGuest608(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                hm.DeleteJob("QueuedTransactionJob");
                cm.waitForSeconds("2");
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

    @After(value = "@609",order=2)
    public void CustomerGuest609(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                hm.DeleteJob("QueuedTransactionJob");
                cm.waitForSeconds("2");
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
                System.out.println(e.getMessage());
            }
            Field_Set fs = new Field_Set(DriverInstance);
            cm.navigateStoredURL("Load_Setting");
            try {
                fs.OpenFieldSet("TMS30");
                fs.DeleteWithFieldName("Load Number");
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
    @After(value = "@2782",order=2)
    public void CustomerGuest2782(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                hm.DeleteJob("QueuedTransactionJob");
                cm.waitForSeconds("2");
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

    @After(value = "@2877", order = 2)
    public void resetRfqLoadBoard(Scenario s) throws Exception {
        success = false;
        attempt = 0;
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("TP_Page");
                cm.goToTab("Settings");
                cm.scrollIntoSection("Load Postings");
                cm.clickOnEditIconOnLabel("Enable RFQ Load Board");
                cm.waitForSeconds("2");
                cmf.updateServicesData1("Enable RFQ Load Board", "false");
                cm.clickOnButton("Save");
                cm.waitForSeconds("1");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("RFQ Load Board cleanup failed on attempt "
                        + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("RFQ Load Board cleanup did not pass after "
                    + maxAttempts + " attempts.");
        }
    }

    @After(value = "@1165",order=2)
    public void CustomerGuest1165(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
    }
    @After(value = "@2827",order=2)
    public void CustomerGuest2827(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                hm.DeleteJob("QueuedTransactionJob");
                cm.waitForSeconds("2");
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

    @After(value = "@2828", order = 2)
    public void CustomerGuest2828(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            Field_Set fs = new Field_Set(DriverInstance);
            cm.navigateStoredURL("Load_Setting");
            try {
                fs.OpenFieldSet("TMS30");
                fs.DeleteWithFieldName("Load Number");
                fs.SaveFieldSet();
                cm.waitForSeconds("3");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println(e.getMessage());
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
    @After(value = "@2856", order = 2)
    public void CarrierSettlement2856(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                // Post Step 1: Setup > Scheduled Jobs > find QueuedTransactionJob > Delete
                hm.DeleteJob("QueuedTransactionJob");
                cm.waitForSeconds("2");

                // Post Step 2: TMS Admin > Customer Invoice Documents > set Carrier Upload to False for Bill of Lading > Save
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Customer Invoice Documents");
                cm.waitForSeconds("2");
                Configuration con = new Configuration(DriverInstance);
                con.selectAs("Bill Of Lading", "Carrier Upload", "False");
                cf.clickOnButtonWithTitle("Save");
                cm.waitForSeconds("2");
                cm.switchToParentFrame();

                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
                System.out.println(e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
    @After(value = "@2816",order=2)
    public void CustomerGuest2816(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                hm.DeleteJob("QueuedTransactionJob");
                cm.waitForSeconds("2");


//                log("TMS Admin > Document Options > Global > document -specific Settings > drop down the list to customer invoice > adjust the Customer Default Invoice Terms to 15 > save");
                Admin_Global_Services as = new Admin_Global_Services(DriverInstance);
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Customer Invoice Documents");
                Configuration con=new Configuration(DriverInstance);
                con.selectAs("Bill Of Lading","Carrier Upload","False");
//                cf.clickOnButtonWithValue("Save");
                cf.clickOnButtonWithTitle("Save");
                cm.switchToParentFrame();

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

    @After(value = "@2877", order = 2)
    public void CustomerGuest2877(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("TP_Page");
                cm.waitForSeconds("2");
                cm.goToTab("Settings");
                cm.scrollIntoSection("Load Postings");
                cm.clickOnEditIconOnLabel("Enable RFQ Load Board");
                cff.updateServicesData1("Enable RFQ Load Board", "false");
                cm.clickOnButton("Save");
                cm.waitForSeconds("2");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Teardown attempt " + attempt + " failed: " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
}
