package pageHelper.AfterTest.TMS.API_Operation;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Admin.Home_Page;
import pageHelper.Utility.*;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

/**
 * @author Sufiya
 */
@Slf4j
public class After_Rand_McNally_API {

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
    public After_Rand_McNally_API(bddDriver contextSteps) throws Exception {
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

    @After(value = "@3262", order = 2)
    public void FourKites_API_Post_Test_Cleanup(Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {

                cm.navigateStoredURL("TP_1");
                cm.scrollIntoSection("Customer Mileage & Routing");
                cm.clickOnEditIconOnLabel("Mileage API");
                cff.updateServicesData1("Mileage API", "Null");
                cm.clickOnButton("Save");
                cm.waitForSeconds("4");

                cm.searchAndSelectFromTheGlobalSearch("Boston Beans");
                cm.goToTab("Details");
                cm.scrollIntoSection("Address Information");
                cm.clickOnEditIconOnLabel("Shipping Address");
                cmf.updateServicesData1("Shipping Zip/Postal Code", "02215");
                cm.clickOnButton("Save");
                cm.waitForSeconds("4");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Retry " + attempt + " failed: " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("Post  cleanup failed after " + maxAttempts + " attempts.");
        }
    }
}