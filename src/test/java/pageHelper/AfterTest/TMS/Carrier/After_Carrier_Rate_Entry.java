package pageHelper.AfterTest.TMS.Carrier;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import org.testng.Assert;
import pageHelper.Utility.Common_Apis;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

/**
 * @author manish.m
 */
public class After_Carrier_Rate_Entry {

    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    int maxAttempts = 3;  // Safety limit
    int attempt = 0;
    boolean success = false;
    Common_Apis ca;
    public After_Carrier_Rate_Entry(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
        pageObject=new xmlreader("TMS Admin"+File.separator+"Rate_Entry.xml");
        ca = new Common_Apis(DriverInstance);
    }

    @After(value = "@426",order=2)
    public void CarrierService3085(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__RateEntry__c",DriverInstance.getVariable("Rate_Entry_SFID"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
    }

    @After(value = "@1365",order=2)
    public void CarrierService1365(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__RateEntry__c",DriverInstance.getVariable("Rate_Entry_SFID"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
    }
    @After(value = "@1740",order=2)
    public void CarrierRateEntry1740(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__RateEntry__c",DriverInstance.getVariable("Freight_Rate_Entry_SFID"));
        ca.DeleteRecords("rtms__RateEntry__c",DriverInstance.getVariable("Accessorial_Rate_Entry_SFID"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
    }
    @After(value = "@1743",order=2)
    public void CarrierRateEntry1743(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__RateEntry__c",DriverInstance.getVariable("Freight_Rate_Entry_SFID"));
        ca.DeleteRecords("rtms__RateEntry__c",DriverInstance.getVariable("Accessorial_Rate_Entry_SFID"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
    }
}