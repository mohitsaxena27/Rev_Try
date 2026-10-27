package pageHelper.AfterTest.TMS.Carrier;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import org.testng.Assert;
import pageHelper.Utility.CommonFunction_Frame;
import pageHelper.Utility.Common_Apis;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

/**
 * @author manish.m
 */
public class After_Carrier_FindCarrier {

    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    Common_Steps cm;
    public PropertyReader propertyReader = new PropertyReader();
    int maxAttempts = 3;  // Safety limit
    int attempt = 0;
    boolean success = false;
    Common_Apis ca;
    CommonFunction_Frame cff;
    public After_Carrier_FindCarrier(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
        pageObject=new xmlreader("TMS Admin"+File.separator+"Rate_Entry.xml");
        ca = new Common_Apis(DriverInstance);
        cm = new Common_Steps(DriverInstance);
        cff=new CommonFunction_Frame(DriverInstance);
    }

    @After(value = "@2453",order=2)
    public void Carrier2453(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__TruckPosting__c",DriverInstance.getVariable("Posting1_SFID"));
        ca.DeleteRecords("rtms__TruckPosting__c",DriverInstance.getVariable("Posting2_SFID"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("2LRI"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("3LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
               cm.navigateStoredURL("Stored_Rate_TP");
               cm.goToTab("Compliance");
                cm.clickOnEditIconOnLabel("Carrier Review Status");
                cff.updateServicesData1("Carrier Review Status","Approved");
                cm.clickOnButton("SaveEdit");
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
