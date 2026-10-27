package pageHelper.AfterTest.TMS.Vendor;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Admin.Admin_Global_Services;
import pageHelper.Test.TMS.Object_Manager.Field_Set;
import pageHelper.Test.TMS.Vendor.Vendor_Invoice;
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
public class After_Vendor_invoice {

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

    public After_Vendor_invoice(bddDriver contextSteps) throws Exception {
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

    @After(value = "@3083",order=2)
    public void VendorInvoice3083(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Vendor Invoice");
                cm.waitForSeconds("2");
                Field_Set fs = new Field_Set(this.DriverInstance);
                fs.openFromSetupIcon("Edit Page");
                cm.waitForSeconds("2");
                 Vendor_Invoice vi = new Vendor_Invoice(this.DriverInstance);
                 vi.editLRPMakeFieldAsFieldUnder("Remit To","required");
                 vi.editLRPSaveChanges("Save");
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


}
