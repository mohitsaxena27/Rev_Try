package pageHelper.AfterTest.FMS.Fleet_Trip_Planner;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import lombok.extern.slf4j.Slf4j;
import org.testng.Assert;
import pageHelper.Test.TMS.Admin.Admin_Global_Services;
import pageHelper.Utility.*;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

/**
 * @author manish.m
 */
@Slf4j
public class After_Trip_Plan {

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

    public After_Trip_Plan(bddDriver contextSteps) throws Exception {
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

    @After(value = "@2627",order=2)
    public void Fleet_2627(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.GetIDUsingName("Trip_Plan_ID_1", "rtms__TripPlan__c", "SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c", "Trip_Plan_ID_1");
        ca.GetIDUsingName("Trip_Plan_ID_4", "rtms__TripPlan__c", "SysData=>Trip_Plan_ID_3");
        ca.DeleteRecords1("rtms__TripPlan__c", "Trip_Plan_ID_4");
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__RateEntry__c", DriverInstance.getVariable("Rate_Entry_1"));
    }

    @After(value = "@2628",order=2)
    public void Fleet_2628(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.GetIDUsingName("Trip_Plan_ID_1", "rtms__TripPlan__c", "SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c", "Trip_Plan_ID_1");
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__RateEntry__c", DriverInstance.getVariable("Rate_Entry_1"));
    }

    @After(value = "@2629",order=2)
    public void Fleet_2629(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.GetIDUsingName("Trip_Plan_ID_1","rtms__TripPlan__c","SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c","Trip_Plan_ID_1");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__RateEntry__c",DriverInstance.getVariable("Rate_Entry_1"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Driver_QA");
                cm.scrollIntoSection("ELD Configuration");
                cm.clickOnEditIconOnLabel("ELD Exempt");
                cff.updateServicesData1("ELD Exempt","False");
                cm.clickOnButton("Save");
                cm.waitForSeconds("1");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2630",order=2)
    public void Fleet_2630(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.GetIDUsingName("Trip_Plan_ID_1", "rtms__TripPlan__c", "SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c", "Trip_Plan_ID_1");
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__RateEntry__c", DriverInstance.getVariable("Rate_Entry_1"));
    }

    @After(value = "@2652",order=2)
    public void Fleet_2652(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.GetIDUsingName("Trip_Plan_ID_1","rtms__TripPlan__c","SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c","Trip_Plan_ID_1");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__RateEntry__c",DriverInstance.getVariable("Rate_Entry_1"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.openFromAppLauncher("Drivers");
                cm.SelectTPFromRecentlyView("Dave Fleet Carrier One 11");
                cm.scrollIntoSection("ELD Configuration");
                cm.clickOnEditIconOnLabel("ELD Exempt");
                cff.updateServicesData1("ELD Exempt","False");
                cm.clickOnButton("Save");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }


}
