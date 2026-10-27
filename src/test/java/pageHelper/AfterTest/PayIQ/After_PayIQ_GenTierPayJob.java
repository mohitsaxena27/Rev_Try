package pageHelper.AfterTest.PayIQ;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import org.testng.Assert;
import pageHelper.Test.PayIQ.PayIQ_Admin;
import pageHelper.Utility.*;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

import static pageHelper.bddDriver.log;

/**
 * @author Sufiya
 */
public class After_PayIQ_GenTierPayJob {

    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    int maxAttempts = 3;  // Safety limit
    int attempt = 0;
    boolean success = false;
    Common_Apis ca;
    CommonFunction cmf;
    CommonFunction_Frame cff;
    Common_Steps_Frame cf;
    PayIQ_Admin pa;

    public After_PayIQ_GenTierPayJob(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        pageObject = new xmlreader("PayIQ" + File.separator + "PayIQ_Admin.xml");
        ca = new Common_Apis(DriverInstance);
        cff = new CommonFunction_Frame(DriverInstance);
        pa = new PayIQ_Admin(DriverInstance);
        cf=new Common_Steps_Frame(DriverInstance);
    }

    @After(value = "@2812",order=2)
    public void L2199_Qualification_PayIQ_Program_Not_Open(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms9__Accessorial_Rule__c", DriverInstance.getVariable("Accessorial_Rules_SFID_1"));
        ca.DeleteRecords("rtms9__Accessorial_Rule__c", DriverInstance.getVariable("Accessorial_Rules_SFID_2"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status","Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status","Pending");

                cm.navigateStoredURL("Participants_1");
                cm.scrollIntoSection("Duration");
                cm.clickOnEditIconOnLabel("Expiration Date");
                cff.updateServicesData1("Expiration Date","NA");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Expiration Date","");


                cm.navigateStoredURL("PayIQ_Program_2");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status","Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status","Pending");

                cm.navigateStoredURL("Participants_2");
                cm.scrollIntoSection("Duration");
                cm.clickOnEditIconOnLabel("Expiration Date");
                cff.updateServicesData1("Expiration Date","NA");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Expiration Date","");

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2853", order = 2)
    public void After_2853(Scenario s) throws Exception {

        ca.GetIDUsingName("Participant_Name", "rtms9__Participant__c", "SysData=>Participant_Name_2");
        ca.DeleteRecords1("rtms9__Participant__c", "Participant_Name");
        ca.GetIDUsingName("Filter_Name", "rtms9__Load_Filter__c", "SysData=>Filter_1");
        ca.DeleteRecords1("rtms9__Load_Filter__c", "Filter_Name");
        ca.GetIDUsingName("Filter_SFID", "rtms9__Load_Filter__c", "SysData=>Filter_1");
        ca.DeleteRecords1("rtms9__Load_Filter__c", "Filter_SFID");
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2847", order = 2)
    public void After_2847(Scenario s) throws Exception {

        ca.GetIDUsingName("Participant_Name", "rtms9__Participant__c", "SysData=>Participant_Name_2");
        ca.DeleteRecords1("rtms9__Participant__c", "Participant_Name");
        ca.GetIDUsingName("Filter_Name", "rtms9__Load_Filter__c", "SysData=>Filter_1");
        ca.DeleteRecords1("rtms9__Load_Filter__c", "Filter_Name");

        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2851", order = 2)
    public void After_2851(Scenario s) throws Exception {

        ca.GetIDUsingName("Participant_Name", "rtms9__Participant__c", "SysData=>Participant_Name_2");
        ca.DeleteRecords1("rtms9__Participant__c", "Participant_Name");
        ca.GetIDUsingName("Filter_Name", "rtms9__Load_Filter__c", "SysData=>Filter_1");
        ca.DeleteRecords1("rtms9__Load_Filter__c", "Filter_Name");

        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.navigateStoredURL("Calculation_Tier");
                cm.scrollIntoSectionWithTitle("Tier Calculation Settings");
                cm.clickOnEditIconOnLabel("Percent");
                cm.enterLabelText("Percent", "10");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Percent", "10");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2854", order = 2)
    public void After_2854(Scenario s) throws Exception {

        ca.GetIDUsingName("Participant_Name", "rtms9__Participant__c", "SysData=>Participant_Name_2");
        ca.DeleteRecords1("rtms9__Participant__c", "Participant_Name");
        ca.GetIDUsingName("Filter_Name", "rtms9__Load_Filter__c", "SysData=>Filter_1");
        ca.DeleteRecords1("rtms9__Load_Filter__c", "Filter_Name");
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2855", order = 2)
    public void After_2855(Scenario s) throws Exception {

        ca.GetIDUsingName("Participant_Name", "rtms9__Participant__c", "SysData=>Participant_Name_2");
        ca.DeleteRecords1("rtms9__Participant__c", "Participant_Name");
        ca.GetIDUsingName("Filter_Name", "rtms9__Load_Filter__c", "SysData=>Filter_1");
        ca.DeleteRecords1("rtms9__Load_Filter__c", "Filter_Name");

        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2860", order = 2)
    public void After_2860(Scenario s) throws Exception {

        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        ca.GetIDUsingName("Calculation_Tier_SFID", "rtms9__Calculation_Tier__c", "SysData=>Calculation_Tier_2");
        ca.DeleteRecords1("rtms9__Calculation_Tier__c", "Calculation_Tier_SFID");
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3371", order = 2)
    public void After_3371(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("2LRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");


                cm.navigateStoredURL("CalculationTier1");
                cm.scrollIntoSection("Tier Calculation Settings");
                cm.clickOnEditIconOnLabel("Revoke Payout If Dipped Under Threshold");
                cff.updateServicesData1("Revoke Payout If Dipped Under Threshold", "false");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");


                cm.navigateStoredURL("CalculationTier2");
                cm.scrollIntoSection("Tier Calculation Settings");
                cm.clickOnEditIconOnLabel("Revoke Payout If Dipped Under Threshold");
                cff.updateServicesData1("Revoke Payout If Dipped Under Threshold", "false");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");


                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2832", order = 2)
    public void L2832_GenTierPayJob_Calc_Tier_Load_Margin_Percent_of_Load_Margin_Invoiced(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2818", order = 2)
    public void L28318_GenTierPayJob_Calc_Tier_Load_Margin_Percent_of_Load_Margin_Invoiced(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("3");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2819", order = 2)
    public void L28319_GenTierPayJob_Calc_Tier_Load_Margin_Percent_of_Load_Margin_Invoiced(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("3");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2833", order = 2)
    public void L2833_GenTierPayJob_Calc_Tier_Load_Margin_Percent_of_Load_Margin_Invoiced(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("3");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2945", order = 2)
    public void L2945_GenTierPayJob_Calc_Tier_Trip_Plan_Leg_Distance_Change(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.GetIDUsingName("Trip_Plan_ID_1", "rtms__TripPlan__c", "SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c", "Trip_Plan_ID_1");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2836", order = 2)
    public void L2836_GenTierPayJob_Calc_Tier_Load_Margin_Quoted_Percent_of_Load_Margin_Invoiced(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");
                cm.navigateStoredURL("CalculationTier");
                cm.scrollIntoSectionWithTitle("Tier Calculation Settings");
                cm.clickOnEditIconOnLabel("Calculation Financials to Use");
                cff.updateServicesData1("Calculation Financials to Use","Quoted");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Calculation Financials to Use","Quoted");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2839", order = 2)
    public void L2839_GenTierPayJob_Calc_Tier_Load_Rev_Full_Qtd_Pct_of_Load_Rev_Frght_Only_Invoiced(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.navigateStoredURL("CalculationTier");
                cm.scrollIntoSectionWithTitle("Tier Calculation Settings");
                cm.clickOnEditIconOnLabel("Calculation Financials to Use");
                cff.updateServicesData1("Calculation Revenue Number", "Full Revenue");
                cff.updateServicesData1("Calculation Financials to Use", "Quoted");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Calculation Financials to Use", "Quoted");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2840", order = 2)
    public void L2840_GenTierPayJob_Calc_Tier_Load_Rev_Full_Qtd_Pct_of_Load_Rev_Fuel_Only_Invoiced(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.navigateStoredURL("CalculationTier");
                cm.scrollIntoSectionWithTitle("Tier Calculation Settings");
                cm.clickOnEditIconOnLabel("Calculation Financials to Use");
                cff.updateServicesData1("To (<=)", "200");
                cff.updateServicesData1("Calculation Revenue Number", "Full Revenue");
                cff.updateServicesData1("Calculation Financials to Use", "Quoted");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Calculation Financials to Use", "Quoted");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2901", order = 2)
    public void L2901_GenTierPayJob_PayIQ_Locked(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3349", order = 2)
    public void L3349_GenTierPayJob_Calc_Method_Amount_per_Load_Contributing_to_Bracket(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3348", order = 2)
    public void L3348_GenTierPayJob_Calc_Method_Load_Contribution_Within_Bracket(Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1L1CRI"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1L2CRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {

                //Set Program back to Pending
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                //Delete PayIQ Logs
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("3");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3357", order = 2)
    public void L3357_GenTierPayJob_Calc_Meth_One_Time_Payout_Revoke_Payout_If_Dipped_Under_Threshold(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("3LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("4LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.navigateStoredURL("Calculation_Tier");
                cm.scrollIntoSectionWithTitle("Tier Calculation Settings");
                cm.clickOnEditIconOnLabel("Revoke Payout If Dipped Under Threshold");
                cff.updateServicesData1("Revoke Payout If Dipped Under Threshold","False");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2857", order = 2)
    public void L2857_GenTierPayJob_Cal_Tier_Load_Margin_Amount_per_Load_w_Currency_Conversion_Qtd(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms9__Pay_Header__c",DriverInstance.getVariable("Pay_Header_SFID"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.searchAndSelectRecordsUsingAPI("Contact","Joe Revenova PayIQ");
                cm.goToTab("Details");
                cm.clickOnEditIconOnLabel("Contact Currency");
                cff.updateServicesData1("Contact Currency", "USD - U.S. Dollar");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Contact Currency", "USD - U.S. Dollar");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2943", order = 2)
    public void After_2943(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms9__Pay_Advance__c",DriverInstance.getVariable("Pay_Advance_SFID_1"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2862", order = 2)
    public void After_2862(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms9__Accessorial_Rule__c", DriverInstance.getVariable("Accessorial_Rules_SFID_1"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");


                cm.navigateStoredURL("Participant_1");
                cm.clickOnEditIconOnLabel("Allow Pay Estimates");
                cff.updateServicesData1("Email Out Pay Estimates", "false");
                cm.waitForSeconds("1");
                cff.updateServicesData1("Allow Pay Estimates", "false");
                cm.waitForSeconds("1");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.navigateStoredURL("Participant_2");
                cm.clickOnEditIconOnLabel("Allow Pay Estimates");
                cff.updateServicesData1("Allow Pay Estimates", "false");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2858", order = 2)
    public void After_2858(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms9__Accessorial_Rule__c", DriverInstance.getVariable("Accessorial_Rules_SFID_1"));
        ca.DeleteRecords("rtms9__Minimum_Pay_Rule__c", DriverInstance.getVariable("Minimum_Pay_Rules_SFID_1"));
        ca.DeleteRecords("rtms9__Minimum_Pay_Rule__c", DriverInstance.getVariable("Minimum_Pay_Rules_SFID_2"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");


                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2861", order = 2)
    public void After_2861(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms9__Pay_Estimate_Detail__c", DriverInstance.getVariable("Pay_Estimate_Rules_SFID_1"));
        ca.DeleteRecords("rtms9__Pay_Estimate_Detail__c", DriverInstance.getVariable("Pay_Estimate_Rules_SFID_2"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.navigateStoredURL("Participant_1");
                cm.clickOnEditIconOnLabel("Allow Pay Estimates");
                cm.waitForSeconds("1");
                cff.updateServicesData1("Allow Pay Estimates", "false");
                cm.waitForSeconds("1");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                cm.navigateStoredURL("CalculationTierURL");
                cm.scrollIntoSection("Tier Calculation Settings");
                cm.clickOnEditIconOnLabel("Amount");
//                cff.updateServicesData1("Amount", "0.50");
                cm.enterLabelText("Amount","0.5");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("4");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2979", order = 2)
    public void After_2979(Scenario s) throws Exception {
    Common_Steps cm = new Common_Steps(DriverInstance);
    ca.DeleteRecords("rtms9__Pay_Advance__c", DriverInstance.getVariable("Pay_Advance_SFID_1"));
    ca.deleteAllRecordsAssociatedToFieldName("rtms9__Participant_Name__c","Dave Fleet Carrier One 7 (Driver)","rtms9__Pay_Header__c");
    while (!success && attempt < maxAttempts) {
        attempt++;
        try {
            cm.navigateStoredURL("PayIQ_Program_1");
            cm.clickOnEditIconOnLabel("Status");
            cff.updateServicesData1("Status", "Pending");
            cm.clickOnButton("SaveEdit");
            cm.waitForSeconds("3");
            cm.verifyIsSetTo("Status", "Pending");
            cm.waitForSeconds("2");
            cm.openFromAppLauncher("PayIQ Admin");
            cm.clickOn("Execute Delete PayIQ Logs Now");
            pa.waitTillIs("Delete PayIQ Log", "Completed");
            success = true;

        } catch (AssertionError | Exception e) {
            System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
        }
    }
    if (!success) {
        Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
    }
}

    @After(value = "@2885", order = 2)
    public void After_2885(Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__DriverLog__c", DriverInstance.getVariable("Driver_SFID_1"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {

                //Set Program back to Pending
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                //Reset Calculation Tier page
                cm.navigateStoredURL("Calculation_Tier_Page");
                cm.waitForSeconds("2");
                cm.clickOnEditIconOnLabel("Criteria Driver Log Duration Field(s)");
                cm.DeselectAsFromDuelingList("Criteria Driver Log Duration Field(s)", "Yard Move Duration");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("4");
//                cm.verifyIsSetTo("Criteria Driver Log Duration Field(s)", "Pending");

                //Delete PayIQ Logs
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2834", order = 2)
    public void After_2834(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");


                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2835", order = 2)
    public void After_2835(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");


                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3350", order = 2)
    public void After_3350(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("2LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2845", order = 2)
    public void After_2845(Scenario s) throws Exception {

        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.GetIDUsingName("Calculation_Tier_ID_Name", "rtms9__Calculation_Tier__c", "SysData=>Calculation_Tier_ID");
        ca.DeleteRecords1("rtms9__Calculation_Tier__c", "Calculation_Tier_ID_Name");

        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");

                cm.navigateStoredURL("Custom_Currency_Page");
                cm.waitForSeconds("10");
                cf.switchToFrameByTitle("Global Value Set ~ Salesforce - Enterprise Edition");
                cf.scrollIntoSection("Values");
                cf.clickOnButtonWithTitleContains2("Del","Cargo Value");
                webDriver.acceptAlert();
                cm.waitForSeconds("2");
                cf.switchToFrameByTitle("Find and Replace Value: Custom Currency Fields ~ Salesforce - Enterprise Edition");
                cff.updateServicesData1("Replace value on records with blank value","True");
                cf.clickOnButtonWithTitle("Save");
                cm.waitForSeconds("6");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2846", order = 2)
    public void After_2846(Scenario s) throws Exception {

        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.GetIDUsingName("Calculation_Tier_ID_Name", "rtms9__Calculation_Tier__c", "SysData=>Calculation_Tier_ID");
        ca.DeleteRecords1("rtms9__Calculation_Tier__c", "Calculation_Tier_ID_Name");
        ca.GetIDUsingName("Calculation_Tier_ID_Name2", "rtms9__Calculation_Tier__c", "SysData=>Calculation_Tier_ID_2");
        ca.DeleteRecords1("rtms9__Calculation_Tier__c", "Calculation_Tier_ID_Name2");

        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");

                cm.navigateStoredURL("Custom_Currency_Page");
                cm.waitForSeconds("10");
                cf.switchToFrameByTitle("Global Value Set ~ Salesforce - Enterprise Edition");
                cf.scrollIntoSection("Values");
                cf.clickOnButtonWithTitleContains2("Del","Cargo Value");
                webDriver.acceptAlert();
                cm.waitForSeconds("2");
                cf.switchToFrameByTitle("Find and Replace Value: Custom Currency Fields ~ Salesforce - Enterprise Edition");
                cff.updateServicesData1("Replace value on records with blank value","True");
                cf.clickOnButtonWithTitle("Save");
                cm.waitForSeconds("6");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2815", order = 2)
    public void L2815_GenTierPayJob_Calc_Tier_Load_Margin_Percent_of_Load_Margin_Quoted(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                success = true;


            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3358", order = 2)
    public void L3358_GenTierPayJob_Calc_Method_One_Time_Payout_at_Target_Bonus (Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1L1CRI"));
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1L2CRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {

                //Set Program back to Pending
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                //Delete PayIQ Logs
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("3");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2790", order = 2)
    public void L2790_ClearOutUnapprovedPay_Job_Pay_Details (Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);

        ca.GetIDUsingName("Participant_Name", "rtms9__Participant__c", "SysData=>Participant_Name_2");
        ca.DeleteRecords1("rtms9__Participant__c", "Participant_Name");
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2869", order = 2)
    public void After_2869(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.GetIDUsingName("Trip_Plan_ID_1","rtms__TripPlan__c","SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c","Trip_Plan_ID_1");
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2884", order = 2)
    public void After_2884(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.deleteAllRecordsAssociatedToName("Pay Estimate-","rtms9__Pay_Estimate__c");
        ca.GetIDUsingName("Trip_Plan_ID_1","rtms__TripPlan__c","SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c","Trip_Plan_ID_1");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2873", order = 2)
    public void After_2873(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
//        ca.DeleteRecords("rtms__DriverLog__c", DriverInstance.getVariable("DriverLog_SFID_1"));
//        ca.DeleteRecords("rtms__DriverLog__c", DriverInstance.getVariable("DriverLog_SFID_2"));


        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

//                cm.openFromAppLauncher("PayIQ Admin");
//                cm.clickOn("Execute Delete PayIQ Logs Now");
//                pa.waitTillIs("Delete PayIQ Log", "Completed");
//                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2844", order = 2)
    public void After_2844(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms9__Calculation_Tier__c", DriverInstance.getVariable("Calculation_Tier_SFID_1"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Custom_Currency_Page1");
                cm.waitForSeconds("5");
                cf.switchToFrameByTitle("Global Value Set ~ Salesforce - Enterprise Edition");
                cf.scrollIntoSection("Values");
                cf.clickOnButtonWithTitleContains2("Del","Cargo Value");
                webDriver.acceptAlert();
                cm.waitForSeconds("2");
                cf.switchToFrameByTitle("Find and Replace Value: Custom Currency Fields ~ Salesforce - Enterprise Edition");
                cff.updateServicesData1("Replace value on records with blank value","True");
                cf.clickOnButtonWithTitle("Save");
                cm.waitForSeconds("6");

                cm.navigateStoredURL("Custom_Currency_Page2");
                cm.waitForSeconds("5");
                cf.switchToFrameByTitle("Global Value Set ~ Salesforce - Enterprise Edition");
                cf.scrollIntoSection("Values");
                cf.clickOnButtonWithTitleContains2("Del","Unit Price");
                webDriver.acceptAlert();
                cm.waitForSeconds("2");
                cf.clickOnButtonWithTitle("Save");
                cm.waitForSeconds("6");

                cm.navigateStoredURL("Custom_Currency_Page3");
                cm.waitForSeconds("5");
                cf.switchToFrameByTitle("Global Value Set ~ Salesforce - Enterprise Edition");
                cf.scrollIntoSection("Values");
                cf.clickOnButtonWithTitleContains2("Del","Total Weight");
                webDriver.acceptAlert();
                cm.waitForSeconds("2");
                cf.clickOnButtonWithTitle("Save");
                cm.waitForSeconds("6");

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2886", order = 2)
    public void After_2886(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.GetIDUsingName("Trip_Plan_ID_1", "rtms__TripPlan__c", "SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c", "Trip_Plan_ID_1");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.navigateStoredURL("Participant_1");
                cm.waitForSeconds("2");
                cm.clickOnEditIconOnLabel("Pay Off Load Instead of Trip Plan Leg");
                cff.updateServicesData1("Pay Off Load Instead of Trip Plan Leg", "false");
                cm.waitForSeconds("1");
                cff.updateServicesData1("Pay Off Load Instead of Trip Plan Leg", "false");
                cm.waitForSeconds("1");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2899", order = 2)
    public void After_2899(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms9__Accessorial_Rule__c", DriverInstance.getVariable("Accessorial_Rules_SFID_1"));
        ca.DeleteRecords("rtms9__Accessorial_Rule__c", DriverInstance.getVariable("Accessorial_Rules_SFID_2"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
    @After(value = "@2872", order = 2)
    public void After_2872(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.GetIDUsingName("Trip_Plan_ID_1", "rtms__TripPlan__c", "SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c", "Trip_Plan_ID_1");
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }




    @After(value = "@2913", order = 2)
    public void After_2913_MatchTripPlanLegsToPayIQParticipants(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);

        // Delete the Trip Plan created during the test
        ca.GetIDUsingName("Trip_Plan_ID_1", "rtms__TripPlan__c", "SysData=>Trip_Plan_ID");
        ca.DeleteRecords1("rtms__TripPlan__c", "Trip_Plan_ID_1");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("Role_edit");
                cm.clickOnEditIconOnLabel("Eligible Date Field");
                cff.updateServicesData1("Eligible Date Field", "Departure Date");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Eligible Date Field", "Departure Date");

                // Step 3 & 4 - Navigate back to PayIQ Program and set Status back to Pending
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                // Delete PayIQ Logs
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");

                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2977", order = 2)
    public void After_2977(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.deleteAllRecordsAssociatedToName("ePay-","rtms__EPayment__c");
        ca.deleteAllRecordsAssociatedToName("Segment","rtms__TripPlanSegment__c");
        ca.deleteAllRecordsAssociatedToName("Trip Plan-","rtms__TripPlan__c");
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2955", order = 2)
    public void After_2955(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.deleteAllRecordsAssociatedToName("ePay-","rtms__EPayment__c");
        ca.deleteAllRecordsAssociatedToName("Segment","rtms__TripPlanSegment__c");
        ca.deleteAllRecordsAssociatedToName("Trip Plan-","rtms__TripPlan__c");
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {

                cm.navigateStoredURL("TransportationProfile_1");
                cm.goToTab("Settlement");
                cm.scrollIntoSection("ePayment Information");
                cm.clickOnEditIconOnLabel("EPayment Authorized");
                cff.updateServicesData1("EPayment Authorized", "EFS Money Code");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("EPayment Authorized", "EFS Money Code");

                cm.navigateStoredURL("Participant_1");
                cm.clickOnEditIconOnLabel("Pay Off Load Instead of Trip Plan Leg");
                cm.waitForSeconds("1");
                cff.updateServicesData1("Pay Off Load Instead of Trip Plan Leg", "false");
                cm.waitForSeconds("1");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2817", order = 2)
    public void L2817_GenTierPayJob_Calc_Tier_Load_Margin_Percent_of_Load_Margin_SlidingScale_Quoted(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);

        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));

        boolean success = false;
        int attempt = 0;
        int maxAttempts = 3;

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2805", order = 2)
    public void L2805_GenTierPayJob_Calc_Tier_Load_Count_Amount_Per_Load(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);

        ca.DeleteRecords("rtms9__Participant__c",DriverInstance.getVariable("Participants_SFID_1"));

        boolean success = false;
        int attempt = 0;
        int maxAttempts = 3;

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println(
                        "Test failed on attempt " + attempt + ": " + e.getMessage()
                );
            }
        }

        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2821", order = 2)
    public void L2821_GenTierPayJob_Calc_Tier_Load_Revenue_Percent_of_Load_Revenue_Full_FreightOnly(Scenario s) throws Exception {

        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));

        Common_Steps cm = new Common_Steps(DriverInstance);
        boolean success = false;
        int attempt = 0;
        int maxAttempts = 3;

        while (!success && attempt < maxAttempts) {
            attempt++;

            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.navigateStoredURL("Calculation_Tier");
                cm.clickOnEditIconOnLabel("Criteria Revenue Number");
                cff.updateServicesData1("Criteria Revenue Number", "Full Revenue");
                cff.updateServicesData1("Calculation Revenue Number", "Full Revenue");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Calculation Revenue Number", "Full Revenue");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.waitForSeconds("4");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {

                System.out.println(
                        "Test failed on attempt " + attempt + ": " + e.getMessage()
                );
            }
        }

        if (!success) {
            Assert.fail(
                    "After Test did not pass after " + maxAttempts + " attempts."
            );
        }
    }

    @After(value = "@2830", order = 2)
    public void L2830_GenTierPayJob_Calc_Tier_Load_Revenue_Percent_of_Load_Revenue_FuelOnly_FreightFuel(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        Common_Steps cm = new Common_Steps(DriverInstance);
        boolean success = false;
        int attempt = 0;
        int maxAttempts = 3;

        while (!success && attempt < maxAttempts) {
            attempt++;

            try {
                log("Reset PayIQ Program");
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.navigateStoredURL("Calculation_Tier");
                cm.scrollIntoSection("Tier Range/Target");
                cm.clickOnEditIconOnLabel("Criteria Revenue Number");
                cff.updateServicesData1("Criteria Revenue Number", "Full Revenue");

                cm.scrollIntoSection("Tier Calculation Settings");
                cff.updateServicesData1("Calculation Revenue Number", "Full Revenue");

                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.waitForSeconds("4");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {

                System.out.println(
                        "Test failed on attempt " + attempt + ": " + e.getMessage()
                );
            }
        }

        if (!success) {
            Assert.fail(
                    "After Test did not pass after " + maxAttempts + " attempts."
            );
        }
    }

    @After(value = "@2137", order = 2)
    public void L2137_PayIQ_Program_Clone_Operation(Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);

        boolean success = false;
        int attempt = 0;
        int maxAttempts = 3;

        ca.DeleteRecords("rtms9__Load_Filter__c","SysData=>Filter_1");
        ca.DeleteRecords("rtms9__Load_Filter__c","SysData=>Filter_2");
        ca.DeleteRecords("rtms9__Load_Filter__c","SysData=>Filter_3");
        ca.deleteAllRecordsAssociatedToName("Clone - PayIQProgram Aggregated Load Count (Quoted Calculations)","rtms9__PayIQ_Program__c");
        ca.DeleteRecords("rtms9__PayIQ_Program__c","SysData=>Cloned_PayIQProgram");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {

                cm.openFromAppLauncher("PayIQ Programs");
                cm.searchAndSelectFromSearchList("PayIQProgram Aggregated Load Count (Quoted Calculations)");
                cm.waitForSeconds("3");
                cm.clickOnEditIconOnLabel("Description");
                cff.updateServicesData1("Description", "");
                cff.updateServicesData1("Freight Plan Load Criteria","--None--");
                cff.updateServicesData1("Payroll Description", "");
                cff.updateServicesData1("Payroll Type", "");
                cff.updateServicesData1("Payroll Code", "");

                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                success = true;

            } catch (AssertionError | Exception e) {

                System.out.println(
                        "TC2137 After Test failed on attempt "
                                + attempt
                                + ": "
                                + e.getMessage()
                );
            }
        }

        if (!success) {
            Assert.fail(
                    "TC2137 After Test did not pass after "
                            + maxAttempts
                            + " attempts."
            );
        }
    }

    @After(value = "@2826", order = 2)
    public void L2826_GenerateAccessorialPayJob_Customer_Quote_Accessorial(Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);

        boolean success = false;
        int attempt = 0;
        int maxAttempts = 3;

        ca.deleteAllRecordsAssociatedToName("Pay Estimate-", "rtms9__Pay_Estimate__c");
        ca.deleteAllRecordsAssociatedToName("Trip Plan", "rtms__TripPlan__c");
        ca.deleteAllRecordsAssociatedToName("L-", "rtms__Load__c");

        while (!success && attempt < maxAttempts) {
            attempt++;

            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.waitForSeconds("2");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                String rule1 = DriverInstance.getVariable("Accessorial_Rule_1");
                String rule2 = DriverInstance.getVariable("Accessorial_Rule_2");

                if (rule1 != null && !rule1.isEmpty()) {
                    ca.DeleteRecords("rtms9__Accessorial_Rule__c", rule1);
                }
                if (rule2 != null && !rule2.isEmpty()) {
                    ca.DeleteRecords("rtms9__Accessorial_Rule__c", rule2);
                }
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println(
                        "Cleanup attempt " + attempt + " failed: " + e.getMessage()
                );
                if (attempt == maxAttempts) {
                    throw e;
                }
            }
        }

        if (!success) {
            Assert.fail(
                    "After Test cleanup did not pass after " + maxAttempts + " attempts."
            );
        }
    }

}