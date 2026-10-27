package pageHelper.AfterTest.TMS.API_Operation;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import pageHelper.Test.TMS.Admin.Admin_Global_Services;
import pageHelper.Utility.CommonFunction;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.xmlreader;

import java.io.File;

public class After_Comdata_Fuel_Card {

    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    Common_Steps cm;
    CommonFunction cmf;
    Admin_Global_Services ags;

    public After_Comdata_Fuel_Card(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        cm = new Common_Steps(DriverInstance);
        cmf = new CommonFunction(DriverInstance);
        ags = new Admin_Global_Services(DriverInstance);
    }

    @After(value = "@2736", order = 2)
    public void resetComdataFuelCardState() throws Exception {
        cm.openFromAppLauncher("Fuel Cards");
        cm.searchAndSelectFromSearchList("Bruce Fleet Carrier Two 35 - 224W64R4L6");

        String activeStatus = xml.getlocator("Verify_Label_Text_Value")
                .replace("{paramlink1}", "Status")
                .replace("{paramlink2}", "Active");
        if (webDriver.getwebelementscount(activeStatus) > 0) {
            cm.scrollIntoSection("Fuel Card Control Panel");
            cm.waitForSeconds("2");
            cm.clickOnLinkPartialTextOnPage("Show menu");
            cm.waitForSeconds("1");
            cm.clickOnLinkPartialTextOnPage("Deactivate");
        }
        cm.verifyIsSetTo("Status", "Inactive");

        cm.openFromAppLauncher("TMS Admin");
        cm.goToTab("Credentials");
        cm.goToTab("Global Services");
        ags.searchAndSelectServices("Comdata");
        cmf.updateServicesData1("Fuel Cards", "False");
        ags.ClickonNativeSalesforceButton("Save");

        cm.openFromAppLauncher("Drivers");
        cm.RecentlyViewToAll();
        cm.searchAndSelectFromSearchList("Bruce Fleet Carrier Two 35");
        cm.clickOnEditIconOnLabel("Fuel Card Driver Number");
        String driverNumberInput = xml.getlocator("InputField")
                .replace("{paramlink}", "Fuel Card Driver Number");
        webDriver.waitUntilElementIsVisible(driverNumberInput);
        WebElement driverNumberField = webDriver.getwebelement(driverNumberInput);
        webDriver.Clear(driverNumberField);
        driverNumberField.sendKeys(Keys.TAB);
        cm.waitForSeconds("1");
        cm.clickOnButton("SaveEdit");
        cm.waitForSeconds("2");
        cm.scrollIntoSection("General Information");

        String assignedDriverNumber = xml.getlocator("Verify_Label_Text_Value")
                .replace("{paramlink1}", "Fuel Card Driver Number")
                .replace("{paramlink2}", "BFCT35");
        webDriver.verifyElementNotToBePresent(assignedDriverNumber);
    }
}
