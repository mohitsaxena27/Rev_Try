package pageHelper.AfterTest.TMS.Object_Manager;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.log4j.Log4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Object_Manager.Field_Set;
import pageHelper.Utility.CommonFunction_Frame;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

@Log4j
public class After_Stop_Field_Set {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();

    int maxAttempts = 3;  // Safety limit
    int attempt = 0;
    boolean success = false;

    public After_Stop_Field_Set(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"CommonFrame.xml");
        pageObject=new xmlreader("TMS"+ File.separator+"Object_Manager"+File.separator+"Field_Set.xml");
    }

    @After(value = "@1509",order=2)
    public void DeleteFields_1509(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        Field_Set fs = new Field_Set(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Field_Set_Page");
                cm.waitForSeconds("1");
                fs.OpenFieldSet("TMS1");
                fs.MakeItRequired("Instructions",false);
                fs.BrowserZoom("60");
                fs.DeleteWithFieldName2("Instructions");
                fs.DeleteWithFieldName("Shipping/Receiving Contact");
                fs.DeleteWithFieldName("Pickup/Delivery Number");
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

    @After(value = "@1511",order=2)
    public void DeleteFields_1511(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        Field_Set fs = new Field_Set(DriverInstance);
        CommonFunction_Frame cff=new CommonFunction_Frame(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Field_Set_Page");
                cm.waitForSeconds("1");
                fs.DeleteFieldSet("TMS1_LTL");
                webDriver.waitForElementLoad(2);

                cm.openFromAppLauncher("Transportation Profiles");
                cm.searchAndSelectFromSearchList("Boston Beans");
                cm.scrollIntoSection("Stop Defaults");
                cm.clickOnEditIconOnLabel("Planned Duration Pickup Preloaded");
                cff.updateServicesData1("Planned Duration Pickup Preloaded","");
                cff.updateServicesData1("Default Cargo Status Pickup","--None--");
                cm.clickOnButton("Save");
                cm.scrollIntoSection("Stop Defaults");
                cm.verifyIsSetTo("Default Cargo Status Pickup", "--None--");

                cm.openFromAppLauncher("Transportation Profiles");
                cm.searchAndSelectFromSearchList("Denver Deli Meats");
                cm.scrollIntoSection("Stop Defaults");
                cm.clickOnEditIconOnLabel("Planned Duration Delivery Live Unload");
                cff.updateServicesData1("Planned Duration Delivery Live Unload","");
                cff.updateServicesData1("Default Cargo Status Delivery","--None--");
                cm.clickOnButton("Save");
                cm.scrollIntoSection("Stop Defaults");
                cm.verifyIsSetTo("Default Cargo Status Delivery", "--None--");
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

    @After(value = "@2710",order=2)
    public void DeleteFields_2710(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        Field_Set fs = new Field_Set(DriverInstance);
        fs.openFromSetupIcon("Setup");
        cm.switchWindowByIndex("1");
        fs.openObjectManager("Stop");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                fs.OpenFieldSet("TMS12");
                fs.DeleteWithFieldName("Country");
                fs.DeleteWithFieldName("City");
                fs.DeleteWithFieldName("State/Province");
                fs.DeleteWithFieldName("Postal Code");
                fs.DeleteWithFieldName("Geolocation (Latitude)");
                fs.DeleteWithFieldName("Geolocation (Longitude)");
                fs.addTheIndividualFieldsSetAfter("Shipping/Receiving Contact","Shipping/Receiving Hours");
                fs.SaveFieldSet();
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println(e.getMessage());
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
            cm.closeCurrentTab();
            cm.switchToParentWindow();
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

}