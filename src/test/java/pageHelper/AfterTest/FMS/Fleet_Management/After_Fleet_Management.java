package pageHelper.AfterTest.FMS.Fleet_Management;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.FMS.Fleet_Common;
import pageHelper.Test.FMS.Fleet_Equipment;
import pageHelper.Test.FMS.Fleet_Management;
import pageHelper.Test.TMS.Load.Load_Config;
import pageHelper.Test.TMS.Transportation_Profile.Transportation;
import pageHelper.Utility.*;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

/**
 * @author manish.m
 */
@Slf4j
public class After_Fleet_Management {

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
    Fleet_Management fm;
    Fleet_Equipment fe;
    Load_Config lc;
    Fleet_Common fc;

    public After_Fleet_Management(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
         cm = new Common_Steps(DriverInstance);
         cf=new Common_Steps_Frame(DriverInstance);
         ca = new Common_Apis(DriverInstance);
         cff=new CommonFunction_Frame(DriverInstance);
         cmf= new CommonFunction(DriverInstance);
         fm = new Fleet_Management(DriverInstance);
         fe= new Fleet_Equipment(DriverInstance);
         lc = new Load_Config(DriverInstance);
         fc= new Fleet_Common(DriverInstance);
    }

    @After(value = "@3188",order=2)
    public void FM_3188(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.waitForSeconds("2");
                cm.openFromAppLauncher("Fleet Management Console");
                cm.waitForSeconds("6");
                cff.updateServicesData1("Page","Fleet Management");
                cm.waitForSeconds("3");
                fm.clickOnViewManagerIcon();
                cm.waitForSeconds("1");
                fm.DeleteViewManager("Division One Tractors - Cloned");
                cm.verifyMessageAreDisplayingWith("Delete was successful.");
                cm.waitForSeconds("1");
                fe.selectViewManagerAs("Revenova Loads");
                fe.selectViewManagerAs("Division One Tractors");
                fe.selectViewManagerAs("Division Two Tractors");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3156",order=2)
    public void FM_3156(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.waitForSeconds("2");
                cm.openFromAppLauncher("Fleet Management Console");
                cm.waitForSeconds("6");
                cff.updateServicesData1("Page","Fleet Management");
                cm.waitForSeconds("3");
                fm.clickOnViewManagerIcon();
                cm.waitForSeconds("1");
                fe.selectViewManagerAs("Revenova Loads");
                fe.selectViewManagerAs("Division Two Tractors");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2386",order=2)
    public void FM_2386(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.waitForSeconds("2");
                cm.openFromAppLauncher("Fleet Management Console");
                cm.waitForSeconds("6");
                cff.updateServicesData1("Page","Fleet Management");
                cm.waitForSeconds("3");
                fm.clickOnViewManagerIcon();
                cm.waitForSeconds("1");
                fm.viewManagerClickOnFor("Edit","Division 1 Drivers");
                cm.waitForSeconds("1");
                cff.updateServicesData1("View Name","Division One Drivers");
                cff.updateServicesData1("Shared With","None");
                fm.SelectFromMultiSelectField("Fleet Management","Default For");
                cm.waitForSeconds("1");
                lc.ClickButtonWithTextOnModal("Save");
                cm.verifyMessageAreDisplaying("Save was successful.");
                cm.waitForSeconds("1");
                fm.DeleteViewManager("Division 1 Drivers - Cloned");
                cm.verifyMessageAreDisplayingWith("Delete was successful.");
                cm.waitForSeconds("1");
                fe.selectViewManagerAs("Division One Drivers");
                cm.waitForSeconds("2");
                cm.scrollIntoSection("View - Fleet Driver");
                 fc.clickOnUnderSection("Grid Column Selection","View - Fleet Driver");
                 cm.waitForSeconds("2");
                 fm.RemoveColumnSelection("Driver Name");
                 cm.clickOnButtonWithTitle("Close");
                cm.scrollIntoSection("View Manager");
                fe.selectViewManagerAs("Division Two Drivers");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }


}
