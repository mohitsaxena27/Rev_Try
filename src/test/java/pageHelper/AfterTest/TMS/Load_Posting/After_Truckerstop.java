package pageHelper.AfterTest.TMS.Load_Posting;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Load.Load_Summary;
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
public class After_Truckerstop {

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
    Load_Summary ls;

    public After_Truckerstop(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
         cm = new Common_Steps(DriverInstance);
         cf=new Common_Steps_Frame(DriverInstance);
         ca = new Common_Apis(DriverInstance);
         cff=new CommonFunction_Frame(DriverInstance);
         cmf= new CommonFunction(DriverInstance);
         ls= new Load_Summary(DriverInstance);
    }

    @After(value = "@2810",order=2)
    public void Truckerstop_2810(Scenario s) throws Exception {

        while (!success && attempt < maxAttempts) {
            attempt++;
            Load_Summary ls = new Load_Summary(DriverInstance);
            try {
                //Step 1
                log("Resetting Load Post Status");
                cm.navigateStoredURL("Load Posting");
                cm.scrollIntoSection("General Information");
                cm.clickOnEditIconOnLabel("Posting Status");
                cff.updateServicesData1("Posting Status","Unposted");
                cm.clickOn("Save");
                cm.verifyIsSetTo("Posting Status","Unposted");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2813",order=2)
    public void Truckerstop_2813(Scenario s) throws Exception {

        while (!success && attempt < maxAttempts) {
            attempt++;
            Load_Summary ls = new Load_Summary(DriverInstance);
            try {
                //Step 1
                log("Resetting Load Post Status");
                cm.navigateStoredURL("Load_Details");
                cm.scrollIntoSection("Load Postings (1)");
                ls.selectTheRemoveActionNextToTheIntegrationListing("Truckstop 2");
                cm.verifyMessageAreDisplayingAs("");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
}