package pageHelper.AfterTest.TMS.Object_Manager;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.log4j.Log4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Object_Manager.Field_Set;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

@Log4j
public class After_Line_Item_Field_Set {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();

    int maxAttempts = 3;  // Safety limit
    int attempt = 0;
    boolean success = false;

    public After_Line_Item_Field_Set(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"CommonFrame.xml");
        pageObject=new xmlreader("TMS"+ File.separator+"Object_Manager"+File.separator+"Field_Set.xml");
    }

    @After(value = "@1970",order=2)
    public void DeleteFields_1107(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        Field_Set fs = new Field_Set(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Field_Set_Page");
                cm.waitForSeconds("1");
                fs.OpenFieldSet("TMS1");
                fs.MakeItRequired("NMFC Number",false);
                fs.DeleteWithFieldName2("NMFC Number");
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

    @After(value = "@1971",order=2)
    public void DeleteFields_1971(Scenario s) throws Exception {
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

    @After(value = "@1985",order=2)
    public void DeleteFields_1985(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        Field_Set fs = new Field_Set(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Field_Set_Page");
                cm.waitForSeconds("1");
                fs.OpenFieldSet("TMS7");
                fs.BrowserZoom("60");
                fs.DeleteWithFieldName("HazMat Contact");
                fs.DeleteWithFieldName("HazMat Class/Division");
                fs.DeleteWithFieldName("HazMat");
                fs.DeleteWithFieldName("NMFC Number");
                fs.DeleteWithFieldName("Length");
                fs.DeleteWithFieldName("NMFC Class");
                fs.DeleteWithFieldName("Extended Price");
                fs.DeleteWithFieldName("Cargo Summary");
                fs.BrowserZoom("100");
                fs.SaveFieldSet();
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println(e.getMessage());
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
//            cm.closeCurrentTab();
//            cm.switchToParentWindow();
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@1986",order=2)
    public void DeleteFields_1986(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        Field_Set fs = new Field_Set(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Field_Set_Page");
                cm.waitForSeconds("1");
                fs.DeleteFieldSet("TMS7_LTL");
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