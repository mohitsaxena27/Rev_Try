package pageHelper.AfterTest.FMS.Fleet_Equipment;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
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
public class After_Fleet_Equipment_Management {

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

    public After_Fleet_Equipment_Management(bddDriver contextSteps) throws Exception {
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

    @After(value = "@2653",order=2)
    public void SamasaraAPI(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                Transportation tp = new Transportation(DriverInstance);
                cm.openFromAppLauncher("Transportation Profiles");
                cm.SelectTPFromRecentlyView("Illinois Terminal");
                tp.clickOnNextTo("Customer Operations");
                cm.goToTab("Equipment Pool");
                cm.clickOnEditIconOnLabel("Is Drop Location");
                cff.updateServicesData1("Is Drop Location","True");
                cm.clickOnButtonWithTitle("Save");
                cm.waitForSeconds("1");
                tp.ViewAll("Equipment Pools");
                tp.selectRecordsForDelete("Test Pool One","Equipment Pools");
                cf.clickOnDivText("Delete");
                cf.clickOnLinkTextOnPage("Confirm","Delete");
                cm.verifyMessageAreDisplaying("was deleted");
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
