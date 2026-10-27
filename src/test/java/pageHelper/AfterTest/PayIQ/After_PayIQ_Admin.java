package pageHelper.AfterTest.PayIQ;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import okhttp3.internal.connection.Exchange;
import org.testng.Assert;
import pageHelper.Test.PayIQ.PayIQ_Admin;
import pageHelper.Test.TMS.Admin.Home_Page;
import pageHelper.Utility.*;
import pageHelper.Utility.CommonFunction;
import pageHelper.Utility.CommonFunction_Frame;
import pageHelper.Utility.Common_Apis;
import pageHelper.Utility.Common_Steps;
import pageHelper.Utility.*;
import pageHelper.Test.TMS.Load.Load_Financial;
import pageHelper.Utility.*;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;
import pageHelper.Test.TMS.Object_Manager.Field_Set;
import pageHelper.Utility.Common_Steps_Frame;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.text.SimpleDateFormat;
import java.net.URLEncoder;
import io.restassured.http.Method;
import utils.PropReader;

import static pageHelper.bddDriver.log;

/**
 * @author Sufiya
 */
public class After_PayIQ_Admin {

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
    PayIQ_Admin pa;
    Common_Steps_Frame csf;


    public After_PayIQ_Admin(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        pageObject = new xmlreader("PayIQ" + File.separator + "PayIQ_Admin.xml");
        ca = new Common_Apis(DriverInstance);
        cff = new CommonFunction_Frame(DriverInstance);
        pa = new PayIQ_Admin(DriverInstance);
        csf= new Common_Steps_Frame(DriverInstance);
    }

    @After(value = "@2199", order = 2)
    public void L2199_Qualification_PayIQ_Program_Not_Open(Scenario s) throws Exception {
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
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2773", order = 2)
    public void TC_2773(Scenario s) throws Exception {

        Home_Page hm = new Home_Page(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                hm.DeleteJob("Delete PayIQ Log");
                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2796", order = 2)
    public void After_2796(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.openFromAppLauncher("PayIQ Admin");
                cm.goToTab("Configuration");
                cff.updateServicesData1("Error Email", "test@revenova.com");
                cm.waitForSeconds("1");
                cm.clickOn("Save");
                cm.verifyMessageAreDisplaying("PayIQ Configuration Saved");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@3365", order = 2)
    public void L3365_GenTierPayJob_Calc_Tiers_Bracket_Rounding_and_Currency(Scenario s) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);
        Common_Steps_Frame csf = new Common_Steps_Frame(DriverInstance);
        Load_Financial lf = new Load_Financial(DriverInstance);
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;

            try {
                // Reset PayIQ Program Status
                cm.navigateStoredURL("PayIQ_Program");
                cm.clickOnEditIconOnLabel("Status");

                cff.updateServicesData1("Status", "Pending");

                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                // Delete PayIQ Logs
                cm.openFromAppLauncher("PayIQ Admin");
                cm.waitForSeconds("5");

                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("3");

                cm.navigateStoredURL("CurrencyExchanged");
                cm.waitForSeconds("2");
                cm.switchToFrameByTitle("Dated Exchange Rates ~ Salesforce - Enterprise Edition");
                csf.clickOn("Canadian Dollar");
                cm.waitForSeconds("4");
                cm.switchWindowByIndex("1");
                cm.waitForSeconds("2");
                lf.DeleteCurrencyDate("SysData=>YesterdayDate");
                cm.waitForSeconds("1");
                webDriver.acceptAlert();
                cm.waitForSeconds("1");
                System.out.println("Deleted");
                webDriver.CloseCurrentWindows();
                cm.switchToParentWindow();
                cm.waitForSeconds("2");

                cm.navigateStoredURL("CurrencyExchanged");
                cm.waitForSeconds("2");
                cm.switchToFrameByTitle("Dated Exchange Rates ~ Salesforce - Enterprise Edition");
                csf.clickOn("Euro");
                cm.waitForSeconds("4");
                cm.switchWindowByIndex("1");
                cm.waitForSeconds("2");
                lf.DeleteCurrencyDate("SysData=>YesterdayDate");
                cm.waitForSeconds("1");
                webDriver.acceptAlert();
                cm.waitForSeconds("1");
                System.out.println("Deleted");
                webDriver.CloseCurrentWindows();
                cm.switchToParentWindow();
                cm.waitForSeconds("2");

                cm.navigateStoredURL("CurrencyExchanged");
                cm.waitForSeconds("2");
                cm.switchToFrameByTitle("Dated Exchange Rates ~ Salesforce - Enterprise Edition");
                csf.clickOn("Mexican Peso");
                cm.waitForSeconds("4");
                cm.switchWindowByIndex("1");
                cm.waitForSeconds("2");
                lf.DeleteCurrencyDate("SysData=>YesterdayDate");
                cm.waitForSeconds("1");
                webDriver.acceptAlert();
                cm.waitForSeconds("1");
                System.out.println("Deleted");
                webDriver.CloseCurrentWindows();
                cm.switchToParentWindow();
                cm.waitForSeconds("2");
                success = true;

            } catch (AssertionError | Exception e) {

                System.out.println("Test failed on attempt "
                        + attempt + ": " + e.getMessage());

            }
        }

        if (!success) {
            Assert.fail("Test did not pass after "
                    + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2896", order = 2)
    public void L2896_ClearOutUnapprovedPay_Job_PayIQ_Locked(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms9__Participant__c", DriverInstance.getVariable("Participant_SFID"));
        // Delete Test Load
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {

                // Reset Program Status
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

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }

        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2797", order = 2)
    public void L2797_ClearOutUnapprovedPay_Job_Pay_Adjustments(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.deleteAllRecordsAssociatedToName("Pay Adjustment-","rtms9__Pay_Adjustment__c");

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

                ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2954", order = 2)
    public void L2954_Pay_Detail_Team_Pay_Multi_Currency_Conversion_Separation(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c",DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms9__Participant__c",DriverInstance.getVariable("Participant_SFID"));
        ca.DeleteRecords("rtms9__Pay_Header__c",DriverInstance.getVariable("Pay_Header1_SFID"));
        ca.DeleteRecords("rtms9__Pay_Header__c",DriverInstance.getVariable("Pay_Header2_SFID"));
        ca.DeleteRecords("rtms9__Pay_Header__c",DriverInstance.getVariable("Pay_Header3_SFID"));
        ca.DeleteRecords("rtms9__Pay_Header__c",DriverInstance.getVariable("Pay_Header4_SFID"));
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
                cm.searchAndSelectRecordsUsingAPI("Contact","Joe Texas Rangers");
                cm.goToTab("Details");
                cm.clickOnEditIconOnLabel("Contact Currency");
                cff.updateServicesData1("Contact Currency", "USD - U.S. Dollar");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Contact Currency", "USD - U.S. Dollar");
                cm.searchAndSelectRecordsUsingAPI("Contact","Joe Detroit Tigers");
                cm.goToTab("Details");
                cm.clickOnEditIconOnLabel("Contact Currency");
                cff.updateServicesData1("Contact Currency", "USD - U.S. Dollar");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Contact Currency", "USD - U.S. Dollar");
                cm.navigateStoredURL("User_setup");
                cm.switchToFrameByTitle("User: Test User1 ~ Salesforce - Enterprise Edition");
                csf.clickOnButton("edit");
                cm.switchToParentFrame();
                cm.switchToFrameByTitle("User Edit");
                cm.scrollDownWithTimes("15");
                csf.SelectWithId("USD - U.S. Dollar","defaultcurrencyisocode");
                csf.clickOnButtonWithTitle("Save");
                cm.switchToParentFrame();
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

    @After(value = "@2866", order = 2)
    public void L2866_Fleet_Trip_Planner_LWC_Pay_Estimate_Format_Functionality(Scenario s) throws Exception {
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
                cm.clickOnEditIconOnLabel("Allow Pay Estimates");
                cff.updateServicesData1("Allow Pay Estimates","False");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");

                cm.navigateStoredURL("Manage User URL");
                cm.switchToFrameByTitle("All");
                csf.clickOn("U");
                cm.switchToParentFrame();
                cm.waitForSeconds("3");
                cm.switchToFrameByTitle("All");
                csf.clickOn("User, User");
                cm.switchToParentFrame();
                cm.switchToFrameByTitle("User: User User ~ Salesforce - Enterprise Edition");
                csf.clickOnButton("edit");
                cm.switchToParentFrame();
                cm.switchToFrameByTitle("User Edit");
                cm.scrollDownWithTimes("15");
                pa.EnterWithLabel(" ","Estimate Adjustment Lower Limit");
                pa.EnterWithLabel(" ","Estimate Adjustment Upper Limit");
                csf.clickOnButtonWithTitle("Save");
                cm.switchToParentFrame();
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

    @After(value = "@2780", order = 2)
    public void TC_2780(Scenario s) throws Exception {
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
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2781", order = 2)
    public void TC_2781(Scenario s) throws Exception {
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
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2771", order = 2)
    public void TC_2771(Scenario s) throws Exception {

        Home_Page hm = new Home_Page(DriverInstance);
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                hm.DeleteJob("Match Loads To PayIQ Participants");

                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.navigateStoredURL("Manage User URL");
                cm.switchToFrameByTitle("All");
                csf.clickOn("U");
                cm.switchToParentFrame();
                cm.waitForSeconds("3");
                cm.switchToFrameByTitle("All");
                csf.clickOn("User, User");
                cm.switchToParentFrame();
                cm.switchToFrameByTitle("User: User User ~ Salesforce - Enterprise Edition");
                csf.clickOnButton("edit");
                cm.switchToParentFrame();
                cm.switchToFrameByTitle("User Edit");
                cm.scrollDownWithTimes("15");
                csf.SelectWithId("(GMT-05:00) Central Daylight Time (America/Chicago)","TimeZoneSidKey");
                csf.clickOnButtonWithTitle("Save");
                cm.switchToParentFrame();
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

    @After(value = "@2994", order = 2)
    public void L2994_Pay_Detail_Team_Pay(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        Common_Steps_Frame csf = new Common_Steps_Frame(DriverInstance);
        Load_Financial lf = new Load_Financial(DriverInstance);

        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        ca.deleteAllRecordsAssociatedToName(DriverInstance.getVariable("ePay_Name"), "rtms__EPayment__c");
        ca.deleteAllRecordsAssociatedToName(DriverInstance.getVariable("Pay_Advance_1"), "rtms9__Pay_Advance__c");
        ca.deleteAllRecordsAssociatedToName(DriverInstance.getVariable("Min_Pay_Rule_1"), "rtms9__Minimum_Pay_Rule__c");
        ca.deleteAllRecordsAssociatedToName("Clone - PayIQProgram", "rtms9__PayIQ_Program__c");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                if (DriverInstance.getVariable("CurrencyExchanged") == null || DriverInstance.getVariable("CurrencyExchanged").isEmpty()) {
                    DriverInstance.setVariable("CurrencyExchanged", PropReader.get("application_url") + "/lightning/setup/Currencies/page?address=%2Fsetup%2Fcur%2FdatedCurrencyList.jsp");
                }

                // Reset PayIQ Program Status
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                // Delete PayIQ Logs
                cm.openFromAppLauncher("PayIQ Admin");
                cm.waitForSeconds("5");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("3");

                // Delete Canadian Dollar
                cm.navigateStoredURL("CurrencyExchanged");
                cm.waitForSeconds("2");
                cm.switchToFrameByTitle("Dated Exchange Rates ~ Salesforce - Enterprise Edition");
                csf.clickOn("Canadian Dollar");
                cm.waitForSeconds("4");
                cm.switchWindowByIndex("1");
                cm.waitForSeconds("2");
                lf.DeleteCurrencyDate("SysData=>Tomorrow_Date");
                cm.waitForSeconds("1");
                webDriver.acceptAlert();
                cm.waitForSeconds("1");
                lf.DeleteCurrencyDate("SysData=>Today_Date");
                cm.waitForSeconds("1");
                webDriver.acceptAlert();
                cm.waitForSeconds("1");
                lf.DeleteCurrencyDate("SysData=>Yesterday_Date");
                cm.waitForSeconds("1");
                webDriver.acceptAlert();
                cm.waitForSeconds("1");
                System.out.println("Deleted");
                webDriver.CloseCurrentWindows();
                cm.switchToParentWindow();
                cm.waitForSeconds("2");

                // Delete Euro
                cm.navigateStoredURL("CurrencyExchanged");
                cm.waitForSeconds("2");
                cm.switchToFrameByTitle("Dated Exchange Rates ~ Salesforce - Enterprise Edition");
                csf.clickOn("Euro");
                cm.waitForSeconds("4");
                cm.switchWindowByIndex("1");
                cm.waitForSeconds("2");
                lf.DeleteCurrencyDate("SysData=>Tomorrow_Date");
                cm.waitForSeconds("1");
                webDriver.acceptAlert();
                cm.waitForSeconds("1");
                lf.DeleteCurrencyDate("SysData=>Today_Date");
                cm.waitForSeconds("1");
                webDriver.acceptAlert();
                cm.waitForSeconds("1");
                lf.DeleteCurrencyDate("SysData=>Yesterday_Date");
                cm.waitForSeconds("1");
                webDriver.acceptAlert();
                cm.waitForSeconds("1");
                System.out.println("Deleted");
                webDriver.CloseCurrentWindows();
                cm.switchToParentWindow();
                cm.waitForSeconds("2");

                // Delete Mexican Peso
                cm.navigateStoredURL("CurrencyExchanged");
                cm.waitForSeconds("2");
                cm.switchToFrameByTitle("Dated Exchange Rates ~ Salesforce - Enterprise Edition");
                csf.clickOn("Mexican Peso");
                cm.waitForSeconds("4");
                cm.switchWindowByIndex("1");
                cm.waitForSeconds("2");
                lf.DeleteCurrencyDate("SysData=>Tomorrow_Date");
                cm.waitForSeconds("1");
                webDriver.acceptAlert();
                cm.waitForSeconds("1");
                lf.DeleteCurrencyDate("SysData=>Today_Date");
                cm.waitForSeconds("1");
                webDriver.acceptAlert();
                cm.waitForSeconds("1");
                lf.DeleteCurrencyDate("SysData=>Yesterday_Date");
                cm.waitForSeconds("1");
                webDriver.acceptAlert();
                cm.waitForSeconds("1");
                System.out.println("Deleted");
                webDriver.CloseCurrentWindows();
                cm.switchToParentWindow();
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

    @After(value = "@2933", order = 2)
    public void L2933_Pay_Detail_Team_Pay_Amount_Distribution(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        ca.DeleteRecords("rtms9__Participant__c", DriverInstance.getVariable("Participant_SFID"));
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

    @After(value = "@2772", order = 2)
    public void TC_2772(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                cm.waitForSeconds("2");

                cm.goToTab("Configuration");
                cff.updateServicesData1("Log Performance", "False");
                cff.updateServicesData1("Log Governor Limits", "False");
                cff.updateServicesData1("Log Qualification (met/did not meet criteria)", "True");
                cff.updateServicesData1("Log Math", "True");
                cff.updateServicesData1("Log Currency Conversions", "True");
                cm.clickOnButton1("Save");
                cm.waitForSeconds("3");

                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

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

    @After(value = "@2793", order = 2)
    public void TC_2793(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords1("rtms9__Load_Role__c", "Role_SFID_1");
        ca.DeleteRecords1("rtms9__Load_Role__c", "Role_SFID_2");
        ca.DeleteRecords1("rtms__DriverLog__c", "DriverLog_SFID");
        ca.DeleteRecords("rtms__Load__c", DriverInstance.getVariable("1LRI"));
        ca.deleteAllRecordsAssociatedToName("Testing Leg 1","rtms__TripPlanLeg__c");
        ca.deleteAllRecordsAssociatedToName("Leg","rtms__TripPlanLeg__c");
        ca.deleteAllRecordsAssociatedToName("Testing Segment 1","rtms__TripPlanSegment__c");
        ca.deleteAllRecordsAssociatedToName("Segment","rtms__TripPlanSegment__c");
        ca.deleteAllRecordsAssociatedToName("Trip Plan" , "rtms__TripPlan__c");

        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
                cm.waitForSeconds("2");
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

    @After(value = "@2743", order = 2)
    public void TC_2743(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.DeleteRecords1("rtms9__Load_Role__c", "Role_SFID_1");
        ca.DeleteRecords1("rtms9__Load_Role__c", "Role_SFID_2");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.openFromAppLauncher("PayIQ Admin");
                cm.clickOn("Execute Delete PayIQ Logs Now");
                pa.waitTillIs("Delete PayIQ Log", "Completed");
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

    @After(value = "@2776", order = 2)
    public void After_2776(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        ca.deleteAllRecordsAssociatedToFieldName("rtms9__Participant_Name__c","Joe Revenova PayIQ (Contact)","rtms9__Pay_Header__c");
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                cm.navigateStoredURL("Contact_Currency");
                cm.clickOnEditIconOnLabel("Contact Currency");
                cff.updateServicesData1("Contact Currency","USD - U.S. Dollar");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Contact Currency","USD - U.S. Dollar");

                cm.navigateStoredURL("PayIQ_DeleteLogs");
                cm.goToTab("Configuration");
                cm.waitForSeconds("2");
                cff.updateServicesData1("Delete Performance Logs", "true");
                cm.waitForSeconds("1");
                cff.updateServicesData1("Delete Governor Limits Logs", "true");
                cff.updateServicesData1("Delete Qualification Logs", "true");
                cff.updateServicesData1("Delete Math Logs", "true");
                cff.updateServicesData1("Delete Currency Conversion Logs", "true");
                cm.waitForSeconds("1");
                cm.clickOn("Save");
                cm.waitForSeconds("1");
                cm.verifyMessageAreDisplaying("PayIQ Configuration Saved");

                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@2783", order = 2)
    public void TC_2783(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                // Post Step 1 & 2 - Set PayIQ Program status back to Pending
                cm.navigateStoredURL("PayIQ_Program_1");
                cm.waitForSeconds("3");
                cm.clickOnEditIconOnLabel("Status");
                cff.updateServicesData1("Status", "Pending");
                cm.clickOnButton("SaveEdit");
                cm.waitForSeconds("3");
                cm.verifyIsSetTo("Status", "Pending");

                // Post Step 3 & 4 - Open PayIQ Admin > Configuration tab
                // Reset Delete PayIQ Logs Job Deletes Logs Older Than X Days = 0
                cm.openFromAppLauncher("PayIQ Admin");
                cm.waitForSeconds("8");  // increased wait for LWC to fully render
                cm.goToTab("Configuration");
                cm.waitForSeconds("3");  // wait for Configuration tab content to load
                //cff.updateServicesData1(
                //        "Delete PayIQ Logs Job Deletes Logs Older Than X Days", "0");
                cm.enterLabelText("Delete PayIQ Logs Job Deletes Logs Older Than X Days", "0");
                cm.waitForSeconds("1");
                cm.clickOn("Save");
                cm.waitForSeconds("3");
                cm.verifyMessageAreDisplayingAs("PayIQ Configuration Saved");

                success = true;

            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt "
                        + attempt + ": " + e.getMessage());
            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

}