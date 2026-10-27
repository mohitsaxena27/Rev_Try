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
public class After_Accessorial_Exclusion {

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
    public After_Accessorial_Exclusion(bddDriver contextSteps) throws Exception {
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

    @After(value = "@1166",order=2)
    public void Accessorial_Exclusion_1166(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Accessorial_Exclusion");
                cm.clickOnButton("Delete");
                cm.clickOnButtonWithTextOnModal("Delete");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

}
