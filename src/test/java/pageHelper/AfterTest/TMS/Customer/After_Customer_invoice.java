package pageHelper.AfterTest.TMS.Customer;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Admin.Admin_Global_Services;
import pageHelper.Test.TMS.Admin.Configuration;
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
public class After_Customer_invoice {

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

    public After_Customer_invoice(bddDriver contextSteps) throws Exception {
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

    @After(value = "@736",order=2)
    public void CustomerInvoice5(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("TMS Admin > Document Options > Global > document -specific Settings > drop down the list to customer invoice > adjust the Customer Default Invoice Terms to 15 > save");
                Admin_Global_Services as = new Admin_Global_Services(DriverInstance);
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Document Options");
                cm.switchToFrameByTitle("accessibility title");
                cf.clickOnLinkTextOnPage("Link","Global Defaults");
                cm.switchToParentFrame();
                cm.switchToFrameByTitle("accessibility title");
                cm.scrollIntoLastOfWebpage();
                cf.scrollIntoSection("Document-Specific Settings");
                as.updateTheCustomSelectOptionAs("Document","Customer Invoice");
                cff.updateServicesData1("Customer Default Invoice Terms","9");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();

                log("Go to Los Angeles Lighting's TP > billing tab > adjust the Invoice Terms to 15 > save");
                cm.openFromAppLauncher("Transportation Profiles");
                cm.SelectTPFromRecentlyView("Los Angeles Lighting");
                cm.goToTab("Billing");
                cm.clickOnEditIconOnLabel("Invoice Terms");
                cm.enterLabelText("Invoice Terms", "15");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("Invoice Terms", "15");

                log("Go to Chicago Pizza's TP > billing tab > default bill to value > adjust this to be Chicago Pizza > save");
                cm.openFromAppLauncher("Transportation Profiles");
                cm.SelectTPFromRecentlyView("Chicago Pizza");
                cm.goToTab("Billing");
                cm.waitForSeconds("1");
                cm.clickOnEditIconOnLabel("Billing Method");
                cm.waitForSeconds("1");
                cmf.updateServicesDataWithKeyValue("Default Customer Bill To_2","Chicago Pizza");
                cm.clickOnButton("Save");
                cm.waitForSeconds("3");
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

    @After(value = "@1385",order=2)
    public void CustomerInvoice1385(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L1CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L2CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L3CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L4CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L5CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L6CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L7CRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1L8CRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("TMS Admin> Configuration > Invoice Processing > Set the Customer Invoice Creation Trigger picklist value to Delivered");
                Admin_Global_Services as = new Admin_Global_Services(DriverInstance);
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.waitForSeconds("2");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Invoice Processing");
                as.updateTheCustomSelectOptionAs("Customer Invoice Creation Trigger","Delivered");
                cf.clickOnButtonWithValue("Save");
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

    @After(value = "@738",order=2)
    public void CustomerInvoice738(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("TMS Admin > Config > change Calculate and Display Taxes to true > save");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.waitForSeconds("2");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Global Settings");
                cff.updateServicesData1("Calculate and Display Taxes","True");
                cf.clickOnButtonWithValue("Save");
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

    @After(value = "@1575",order=2)
    public void CustomerInvoice1575(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("TMS Admin > Config > change Calculate and Display Taxes to true > save");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Configuration");
                cm.waitForSeconds("2");
                cm.switchToFrameByTitle("accessibility title");
                cf.scrollIntoSection("Global Settings");
                cff.updateServicesData1("Calculate Negative Taxes","True");
                cf.clickOnButtonWithValue("Save");
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
    @After(value = "@739",order=2)
    public void CustomerInvoice739(Scenario s) throws Exception {
        System.out.println(1);
        ca.DeleteRecords("rtms__SalesTaxExclusion__c",DriverInstance.getVariable("Sales_Tax_Exclusions_Record_Id"));
        System.out.println(10);
    }
    @After(value = "@740",order=2)
    public void CustomerInvoice740(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__SalesTaxExclusion__c",DriverInstance.getVariable("Sales_Tax_Exclusions_Record_Id"));
    }

    @After(value = "@741",order=2)
    public void CustomerInvoice741(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__CustomerInvoice__c",DriverInstance.getVariable("Customer_Invoice_SFID_Email"));
        ca.DeleteRecords("rtms__CustomerInvoice__c",DriverInstance.getVariable("Customer_Invoice_SFID_Print"));
        ca.DeleteRecords("rtms__CustomerInvoice__c",DriverInstance.getVariable("Customer_Invoice_SFID_EDI"));
    }

    @After(value = "@502",order=2)
    public void CustomerInvoice_502(Scenario s) throws Exception {

        ca.deleteFieldWithTitle("SysData=>FinalFilename_PDF_1");
        ca.deleteFieldWithTitle("SysData=>FinalFilename_PDF_2");
        ca.deleteFieldWithTitle("SysData=>FinalFilename_CSV_1");
        ca.deleteFieldWithTitle("SysData=>FinalFilename_CSV_2");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Go to Revenova HQ's TP > billing tab > adjust the data");
                cm.openFromAppLauncher("Transportation Profiles");
                cm.SelectTPFromRecentlyView("Revenova HQ");
                cm.goToTab("Billing");
                cm.waitForSeconds("2");
                cm.clickOnEditIconOnLabel("Customer Invoice Export File");
                cmf.updateServicesDataWithKeyValue("Customer Invoice Export File","Valid FED - UC Group Sample");
                cmf.updateServicesDataWithKeyValue("Billing Email Attachment Format","PDF with CSV");
                cmf.updateServicesDataWithKeyValue("Batch Invoicing Email Process","One Email, Combined Invoice Attachment");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("Customer Invoice Export File", "Valid FED - UC Group Sample");
                cm.verifyIsSetTo("Billing Email Attachment Format", "PDF with CSV");
                cm.verifyIsSetTo("Batch Invoicing Email Process", "One Email, Combined Invoice Attachment");

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

    @After(value = "@450",order=2)
    public void CustomerInvoice_450(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__CustomerInvoice__c",DriverInstance.getVariable("Customer_Invoice_SFID_Email"));
        ca.DeleteRecords("rtms__CustomerInvoice__c",DriverInstance.getVariable("Customer_Invoice_SFID_Print"));
        ca.DeleteRecords("rtms__CustomerInvoice__c",DriverInstance.getVariable("Customer_Invoice_SFID_Email2"));
        ca.DeleteRecords("rtms__CustomerInvoice__c",DriverInstance.getVariable("Customer_Invoice_SFID_Print2"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Go to Boston Beans's TP > billing tab > adjust the data");
                cm.openFromAppLauncher("Transportation Profiles");
                cm.SelectTPFromRecentlyView("Boston Beans");
                cm.goToTab("Billing");
                cm.clickOnEditIconOnLabel("Customer Invoice Export File");
                cmf.updateServicesDataWithKeyValue("Customer Invoice Export File","Valid FED - UC Group Sample");
                cmf.updateServicesDataWithKeyValue("Billing Email Attachment Format","PDF with CSV");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("Customer Invoice Export File", "Valid FED - UC Group Sample");
                cm.verifyIsSetTo("Billing Email Attachment Format", "PDF with CSV");

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

    @After(value = "@742",order=2)
    public void CustomerInoice742(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                Admin_Global_Services as = new Admin_Global_Services(DriverInstance);
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Customer Invoice Documents");
                Configuration con=new Configuration(DriverInstance);
                con.selectAs("Delivery Receipt","Invoice Action","Never Include");

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

    @After(value = "@872",order=2)
    public void CustomerInvoice872(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
    }
    @After(value = "@746", order = 2)
    public void CustomerInvoice746(Scenario s) throws Exception {
        Admin_Global_Services AGS = new Admin_Global_Services(DriverInstance);
        ca.DeleteRecords("rtms__CustomerInvoice__c", DriverInstance.getVariable("Customer_Invoice_SFID"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("TMS Admin > Customer Invoice Documents > Search for 'Denver Deli Meats' > set Delivery Receipt = Never Include > Save");
                cm.openFromAppLauncher("TMS Admin");
                cm.goToTab("Customer Invoice Documents");
                cm.waitForSeconds("2");
                cm.switchToFrameByTitle("accessibility title");
                AGS.searchTextInTheSearchBox("Denver Deli Meats", "Customer");
                cm.waitForSeconds("2");
                cff.updateServicesData1("Delivery Receipt", "Never Include");
                cf.clickOnButtonWithValue("Save");
                cm.switchToParentFrame();
                cm.waitForSeconds("2");
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
}
