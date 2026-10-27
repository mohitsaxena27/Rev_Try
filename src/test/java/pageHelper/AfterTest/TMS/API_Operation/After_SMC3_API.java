package pageHelper.AfterTest.TMS.API_Operation;

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

import static pageHelper.bddDriver.log;

/**
 * @author manish.m
 */
@Slf4j
public class After_SMC3_API {

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
    Transportation tp;

    public After_SMC3_API(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
         cm = new Common_Steps(DriverInstance);
         cf=new Common_Steps_Frame(DriverInstance);
         ca = new Common_Apis(DriverInstance);
         cff=new CommonFunction_Frame(DriverInstance);
         cmf= new CommonFunction(DriverInstance);
         tp = new Transportation(DriverInstance);
    }

    @After(value = "@2480",order=2)
    public void SMC3_2480(Scenario s) throws Exception {
        ca.deleteFieldWithTitle("SMC3GetAvailableTariffsOperation");
        ca.deleteFieldWithTitle("SMC3GetTerminalsOperation");
        ca.deleteFieldWithTitle("SMC3GetTransitTimeOperation");
        ca.deleteFieldWithTitle("SMC3QuoteOperation");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                log("Go to SMC3 Customer TP > Rates tab > Carrier Rate Entries related list > select the rate entry whose Carrier Service record equals 'AAA Cooper Transportation - SMC3'");
                cm.openFromAppLauncher("Transportation Profiles");
                cm.SelectTPFromRecentlyView("SMC3 Customer");
                cm.goToTab("Rates");
                cm.waitForSeconds("2");
                cm.scrollIntoSection("Carrier Rate Entries");
                tp.openCarrierRateEntryFor("AAA Cooper Transportation - SMC3");
                cm.waitForSeconds("3");
                cm.enterLabelText("Contract Id", "");
                cm.clickOn("Save");
                cm.verifyIsSetTo("Contract Id", "");
                cm.verifyMessageAreDisplaying("Save was successful.");
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

    @After(value = "@2482",order=2)
    public void SMC3_2482(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.deleteFieldWithTitle("SMC3GetAvailableTariffsOperation");
        ca.deleteFieldWithTitle("SMC3GetTerminalsOperation");
        ca.deleteFieldWithTitle("SMC3GetTransitTimeOperation");
        ca.deleteFieldWithTitle("SMC3QuoteOperation");
    }
    @After(value = "@2481",order=2)
    public void SMC3_2481(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.deleteFieldWithTitle("SMC3GetAvailableTariffsOperation");
        ca.deleteFieldWithTitle("SMC3GetTerminalsOperation");
        ca.deleteFieldWithTitle("SMC3GetTransitTimeOperation");
        ca.deleteFieldWithTitle("SMC3QuoteOperation");
    }

}
