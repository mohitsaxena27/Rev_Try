package pageHelper.AfterTest.TMS.TransportationProfile;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Utility.*;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

/**
 * @author manish.m
 */
@Slf4j
public class After_Batch_Processing {

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
    Common_Helper CH;
    public After_Batch_Processing(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
         cm = new Common_Steps(DriverInstance);
         cf=new Common_Steps_Frame(DriverInstance);
         ca = new Common_Apis(DriverInstance);
         cff=new CommonFunction_Frame(DriverInstance);
         cmf= new CommonFunction(DriverInstance);
         CH = new Common_Helper(DriverInstance);
    }

    @After(value = "@749",order=2)
    public void Batch_Processing_749(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("TP_Page");
                cm.goToTab("Billing");
                cm.scrollIntoSection("Batch Invoicing POD Treatment");
                cm.clickOnEditIconOnLabel("Batch Invoicing POD Treatment");
                cff.updateServicesData1("Batch Invoicing POD Treatment","Include in Invoice Attachment");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("Batch Invoicing POD Treatment", "Include in Invoice Attachment");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
    @After(value = "@3450", order = 2)
    public void Batch_Processing_3450(Scenario s) {

        boolean success = false;
        int attempt = 0;
        int maxAttempts = 3;

        // Only required TPs
        String[] tpList = {"TP_Page1", "TP_Page2", "TP_Page3"};

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                for (String tp : tpList) {
                    System.out.println("===== Processing TP: " + tp + " =====");
                    // Navigate to TP
                    cm.navigateStoredURL(tp);
                    cm.waitForSeconds("1");
                    cm.goToTab("Billing");
                    cm.waitForSeconds("1");
                    cm.scrollIntoSection("Billing Method");
                    cm.clickOnEditIconOnLabel("Billing Method");
                    cff.updateServicesData1("Billing Method", "Email");
                    cm.clickOnButton("Save");
                    cm.waitForSeconds("2");
                    // Verify
                    cm.verifyIsSetTo("Billing Method", "Email");
                    System.out.println("✅ Updated Billing Method to Email for: " + tp);
                }

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("❌ Attempt " + attempt + " failed: " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3444", order = 2)
    public void Batch_Processing_3444(Scenario s) throws Exception {

        boolean success = false;
        int attempt = 0;
        int maxAttempts = 3;

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("TP_Page");
                cm.goToTab("Billing");

                // Update Email Process
                cm.scrollIntoSection("Batch Invoicing Email Process");
                cm.clickOnEditIconOnLabel("Batch Invoicing Email Process");
                cff.updateServicesData1(
                        "Batch Invoicing Email Process",
                        "One Email, Combined Invoice Attachments"
                );

                // Update POD Treatment
                cff.updateServicesData1(
                        "Batch Invoicing POD Treatment",
                        "Include in Invoice Attachment"
                );

                cm.clickOnButton("Save");

                // Verify values
                cm.verifyIsSetTo(
                        "Batch Invoicing Email Process",
                        "One Email, Combined Invoice Attachment"
                );

                cm.verifyIsSetTo(
                        "Batch Invoicing POD Treatment",
                        "Include in Invoice Attachment"
                );

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Attempt " + attempt + " failed: " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
    @After(value = "@880", order = 2)
    public void Batch_Processing_880(Scenario s) throws Exception {

        boolean success = false;
        int attempt = 0;
        int maxAttempts = 3;

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {

                cm.navigateStoredURL("TP_Page");
                cm.waitForSeconds("1");

                cm.goToTab("Billing");
                cm.waitForSeconds("1");

                cm.scrollIntoSection("Batch Invoicing Email Process");
                cm.clickOnEditIconOnLabel("Batch Invoicing Email Process");

                cff.updateServicesData1(
                        "Batch Invoicing Email Process",
                        "One Email, Combined Invoice Attachment"
                );

                cm.clickOnButton("Save");
                cm.waitForSeconds("2");

                cm.verifyIsSetTo(
                        "Batch Invoicing Email Process",
                        "One Email, Combined Invoice Attachment"
                );

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Attempt " + attempt + " failed: " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
    @After(value = "@879", order = 2)
    public void Batch_Processing_879(Scenario s) throws Exception {

        boolean success = false;
        int attempt = 0;
        int maxAttempts = 3;

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {

                cm.navigateStoredURL("TP_Page");
                cm.waitForSeconds("2");

                cm.goToTab("Billing");
                cm.waitForSeconds("1");

                cm.scrollIntoSection("Batch Invoicing Email Process");
                cm.clickOnEditIconOnLabel("Batch Invoicing Email Process");

                cff.updateServicesData1(
                        "Batch Invoicing Email Process",
                        "One Email, Combined Invoice Attachment"
                );

                cm.clickOnButton("Save");
                cm.waitForSeconds("2");
                cm.verifyIsSetTo(
                        "Batch Invoicing Email Process",
                        "One Email, Combined Invoice Attachment"
                );

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Attempt " + attempt + " failed: " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
}
