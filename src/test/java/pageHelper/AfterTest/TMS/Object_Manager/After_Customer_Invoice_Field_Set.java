package pageHelper.AfterTest.TMS.Object_Manager;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.log4j.Log4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Object_Manager.Field_Set;
import pageHelper.Utility.CommonFunction_Frame;
import pageHelper.Utility.Common_Apis;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

@Log4j
public class After_Customer_Invoice_Field_Set {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();

    int maxAttempts = 3;  // Safety limit
    int attempt = 0;
    boolean success = false;

    public After_Customer_Invoice_Field_Set(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"CommonFrame.xml");
        pageObject=new xmlreader("TMS"+ File.separator+"Object_Manager"+File.separator+"Field_Set.xml");
    }

    @After(value = "@1932",order=2)
    public void DeleteFields_1932(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        Common_Apis ca = new Common_Apis(DriverInstance);
        Field_Set fs = new Field_Set(DriverInstance);
        ca.GetIDUsingName("CustomerInvoice1","rtms__CustomerInvoice__c","1932-1");
        ca.DeleteRecords1("rtms__CustomerInvoice__c","CustomerInvoice1");
        ca.GetIDUsingName("CustomerInvoice2","rtms__CustomerInvoice__c","1932-2");
        ca.DeleteRecords1("rtms__CustomerInvoice__c","CustomerInvoice2");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Field_Set_Page");
                cm.waitForSeconds("1");
                fs.OpenFieldSet("TMS1");
                fs.BrowserZoom("60");
                fs.DeleteWithFieldName("Dispute Reason");
                fs.DeleteWithFieldName("Disputed");
                fs.DeleteWithFieldName("Customer Quote");
                fs.DeleteWithFieldName("Created Date");
                fs.DeleteWithFieldName("Billing Method");
                fs.DeleteWithFieldName("Billing Account");
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

}