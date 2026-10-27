package pageHelper.AfterTest.TMS.Carrier;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import org.testng.Assert;
import pageHelper.Test.TMS.SetUp.Sharing_Settings;
import pageHelper.Test.TMS.Transportation_Profile.Carrier_Service;
import pageHelper.Test.TMS.Transportation_Profile.Transportation;
import pageHelper.Utility.Common_Apis;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.DriverController;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

import static pageHelper.bddDriver.log;

/**
 * @author manish.m
 */
public class After_Carrier_Service {

    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    int maxAttempts = 3;  // Safety limit
    int attempt = 0;
    boolean success = false;
    Common_Apis ca;
    public After_Carrier_Service(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
        pageObject=new xmlreader("TMS"+ File.separator+"Transportation_Profile"+File.separator+"Carrier_Service.xml");
        ca = new Common_Apis(DriverInstance);
    }
    @After(value = "@653",order=2)
    public void Matching_Maximum_HU_Height(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.goToModule("Transportation Profiles");
                cm.SelectTPFromRecentlyView("Stored Rate Carrier Two");
                cm.clickOnLinkTextOnPage("Carrier Service", "Stored Rate Carrier Two - LTL");
                cm.scrollIntoSection("Handling Unit Thresholds");
                cm.clickOnEditIconOn("Maximum HU Height");
                cm.enterLabelText("Maximum HU Height", "");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("Maximum HU Height", "");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
    @After(value = "@644",order=2)
    public void Matching_Maximum_HU_Length(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                Common_Steps cm = new Common_Steps(DriverInstance);
                cm.goToModule("Transportation Profiles");
                cm.SelectTPFromRecentlyView("Stored Rate Carrier Two");
                cm.clickOnLinkTextOnPage("Carrier Service", "Stored Rate Carrier Two - LTL");
                cm.scrollIntoSection("Handling Unit Thresholds");
                cm.clickOnEditIconOn("Maximum HU Length");
                cm.enterLabelText("Maximum HU Length", "");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("Maximum HU Length", "");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
            if (!success) {
                Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
            }
    }
    @After(value = "@660",order=2)
    public void Matching_Minimum_Linear_Feet(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.goToModule("Transportation Profiles");
                cm.SelectTPFromRecentlyView("Stored Rate Carrier Two");
                cm.clickOnLinkTextOnPage("Carrier Service", "Stored Rate Carrier Two - LTL");
                cm.scrollIntoSection("Handling Unit Thresholds");
                cm.clickOnEditIconOn("Minimum Linear Feet");
                cm.enterLabelText("Minimum Linear Feet", "");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("Minimum Linear Feet", "");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }
    @After(value = "@661",order=2)
    public void Minimum_Weight(Scenario s) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                cm.goToModule("Transportation Profiles");
                cm.SelectTPFromRecentlyView("Stored Rate Carrier Two");
                cm.clickOnLinkTextOnPage("Carrier Service", "Stored Rate Carrier Two - LTL");
                cm.scrollIntoSection("Handling Unit Thresholds");
                cm.clickOnEditIconOn("Minimum Weight");
                cm.enterLabelText("Minimum Weight", "");
                cm.clickOnButton("Save");
                cm.verifyIsSetTo("Minimum Weight", "");
                success=true;
            } catch (AssertionError | Exception e) {
                System.out.println( "Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@655",order=2)
    public void TC_655(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                Common_Steps cm = new Common_Steps(DriverInstance);
                    try{
                        cm.navigateStoredURL("Transportion_URL");
                    } catch (Exception e) {
                        cm.openFromAppLauncher("Transportation Profiles");
                        cm.SelectTPFromRecentlyView("Stored Rate Carrier Two");
                        cm.clickOnLinkTextOnPage("Carrier Service", "Stored Rate Carrier Two - LTL");
                    }
                cm.scrollIntoSection("Handling Unit Thresholds");
                cm.clickOnEditIconOnLabel("Maximum HU Weight");
                cm.enterLabelText("Maximum HU Weight", "");
                cm.clickOnButton("Save");
                cm.waitForSeconds("2");
                cm.verifyIsSetTo("Maximum HU Weight", "");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@652",order=2)
    public void TC_652(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                Common_Steps cm = new Common_Steps(DriverInstance);
                try{
                    cm.navigateStoredURL("Transportion_URL");
                } catch (Exception e) {
                    cm.openFromAppLauncher("Transportation Profiles");
                    cm.SelectTPFromRecentlyView("Stored Rate Carrier Two");
                    cm.clickOnLinkTextOnPage("Carrier Service", "Stored Rate Carrier Two - LTL");
                }

                cm.scrollIntoSection("Handling Unit Thresholds");
                cm.clickOnEditIconOnLabel("Maximum HU Count");
                cm.enterLabelText("Maximum HU Count", "");
                cm.clickOnButton("Save");
                cm.waitForSeconds("2");
                cm.verifyIsSetTo("Maximum HU Count", "");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }


    @After(value = "@645",order=2)
    public void TC_645(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                Common_Steps cm = new Common_Steps(DriverInstance);
                try{
                    cm.navigateStoredURL("Transportion_URL");
                } catch (Exception e) {
                    cm.openFromAppLauncher("Transportation Profiles");
                    cm.SelectTPFromRecentlyView("Stored Rate Carrier Two");
                    cm.clickOnLinkTextOnPage("Carrier Service", "Stored Rate Carrier Two - LTL");
                }

                cm.scrollIntoSection("Handling Unit Thresholds");
                cm.clickOnEditIconOnLabel("Maximum HU Width");
                cm.enterLabelText("Maximum HU Width", "");
                cm.clickOnButton("Save");
                cm.waitForSeconds("2");
                cm.verifyIsSetTo("Maximum HU Width", "");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@642",order=2)
    public void TC_642(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                Common_Steps cm = new Common_Steps(DriverInstance);
                try{
                    cm.navigateStoredURL("Transportion_URL");
                } catch (Exception e) {
                    cm.openFromAppLauncher("Transportation Profiles");
                    cm.SelectTPFromRecentlyView("Stored Rate Carrier Two");
                    cm.clickOnLinkTextOnPage("Carrier Service", "Stored Rate Carrier Two - LTL");
                }

                cm.scrollIntoSection("Handling Unit Thresholds");
                cm.clickOnEditIconOnLabel("Maximum Linear Feet");
                cm.enterLabelText("Maximum Linear Feet", "");
                cm.clickOnButton("Save");
                cm.waitForSeconds("2");
                cm.verifyIsSetTo("Maximum Linear Feet", "");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }

    @After(value = "@658",order=2)
    public void TC_658(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                Common_Steps cm = new Common_Steps(DriverInstance);
                try{
                    cm.navigateStoredURL("Transportion_URL");
                } catch (Exception e) {
                    cm.openFromAppLauncher("Transportation Profiles");
                    cm.SelectTPFromRecentlyView("Stored Rate Carrier Two");
                    cm.clickOnLinkTextOnPage("Carrier Service", "Stored Rate Carrier Two - LTL");
                }

                cm.scrollIntoSection("Load Weight & Volume Thresholds");
                cm.clickOnEditIconOnLabel("Maximum Volume");
                cm.enterLabelText("Maximum Volume", "");
                cm.clickOnButton("Save");
                cm.waitForSeconds("2");
                cm.verifyIsSetTo("Maximum Volume", "");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }


    @After(value = "@659",order=2)
    public void TC_659(Scenario s) throws Exception {
        while (!success && attempt < maxAttempts) {
            attempt++;
            try {
                Common_Steps cm = new Common_Steps(DriverInstance);
                try{
                    cm.navigateStoredURL("Transportion_URL");
                } catch (Exception e) {
                    cm.openFromAppLauncher("Transportation Profiles");
                    cm.SelectTPFromRecentlyView("Stored Rate Carrier Two");
                    cm.clickOnLinkTextOnPage("Carrier Service", "Stored Rate Carrier Two - LTL");
                }

                cm.scrollIntoSection("Load Weight & Volume Thresholds");
                cm.clickOnEditIconOnLabel("Maximum Weight");
                cm.enterLabelText("Maximum Weight", "50000");
                cm.clickOnButton("Save");
                cm.waitForSeconds("2");
                cm.verifyIsSetTo("Maximum Weight", "50,000");
                success = true;
            } catch (AssertionError | Exception e) {
                System.out.println("Test failed on attempt " + attempt + ": " + e.getMessage());

            }
        }
        if (!success) {
            Assert.fail("Test did not pass after " + maxAttempts + " attempts.");
        }
    }


    @After(value = "@3085",order=2)
    public void CarrierService3085(Scenario s) throws Exception {
        ca.DeleteRecords("rtms__CarrierService__c",DriverInstance.getVariable("Carrier_Service"));
    }
}
