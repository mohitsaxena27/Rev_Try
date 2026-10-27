package pageHelper.AfterTest.TMS.Carrier;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import org.testng.Assert;
import pageHelper.Utility.CommonFunction;
import pageHelper.Utility.CommonFunction_Frame;
import pageHelper.Utility.Common_Apis;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

/**
 * @author Sufiya
 */
public class After_Carrier_Banner {

    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    int maxAttempts = 3;  // Safety limit
    int attempt = 0;
    boolean success = false;
    Common_Apis ca;
    CommonFunction cmf;
    CommonFunction_Frame cff;
    public After_Carrier_Banner(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
        pageObject=new xmlreader("TMS"+ File.separator+"Transportation_Profile"+File.separator+"Carrier_Service.xml");
        ca = new Common_Apis(DriverInstance);
        cff=new CommonFunction_Frame(DriverInstance);
    }
    @After(value = "@1115",order=2)
    public void Load_Tracking_Administration_1115(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Boston_Beans_TP");
                cm.scrollIntoSection("Shipping/Receiving Information");
                cm.clickOnEditIconOnLabel("Shipping Hours");
                cm.enterLabelText("Shipping Hours","09:00-22:00");
                cm.clickOnButton("Save");
                cm.waitForSeconds("3");
           //     cm.verifyIsSetTo("Shipping Hours", "09:00-22:00");

                cm.navigateStoredURL("Boston_Beans_Account");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOn("Timezone");
                cff.updateServicesData1("Timezone","America/New_York");
           //     cmf.updateServicesDataWithKeyValue("Timezone","America/New_York");
                cm.clickOnButton("Save");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Timezone", "America/New_York");

                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@1112", order = 2)
    public void CarrierBanner1112(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                if (DriverInstance.getVariable("CS_Email_Carrier_One_Truckload") != null) {
                    cm.navigateStoredURL("CS_Email_Carrier_One_Truckload");
                } else {
                    cm.openFromAppLauncher("Transportation Profiles");
                    cm.searchAndSelectTP("Email Carrier One");
                    cm.waitForSeconds("3");
                    cm.clickOnLinkTextOnPage("Carrier Service", "Email Carrier One - Truckload");
                }
                cm.waitForSeconds("3");
                cm.scrollIntoSection("Carrier Status Contact (Default)");
                cm.clickOnEditIconOn("Status Method");
                cm.waitForSeconds("2");
                cff.updateServicesData1("Status Method", "Email");
                cm.clickOnButton("Save");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status Method", "Email");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@1113",order=2)
    public void CarrierBanner_1113(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
    }
}