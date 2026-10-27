package pageHelper.Test.TMS.SetUp;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.NoSuchFrameException;
import org.openqa.selenium.WebElement;
import pageHelper.Utility.CommonFunction_Frame;
import pageHelper.Utility.Common_Steps;
import pageHelper.Utility.Common_Steps_Frame;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Log4j
public class Sharing_Settings {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    Common_Steps cm;
    Common_Steps_Frame cf;
    CommonFunction_Frame cff;
    public Sharing_Settings(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"CommonFrame.xml");
         cm = new Common_Steps(DriverInstance);
         cf = new Common_Steps_Frame(DriverInstance);
         cff = new CommonFunction_Frame(DriverInstance);
    }


    public void updateSharingSettingsFor(String arg0) throws Exception {
        cf.verifyMessageAreDisplayingAs("Manage sharing settings for:");
        cff.updateServicesData1("Manage sharing settings for:",arg0);
    }

    public void updateSharingSettingsAs(String arg0, String arg1) throws Exception {
        webDriver.waitForElementLoad(1);
        editOrganizationWideDefaults();
//        cf.clickOnButtonOnPage("Edit","Organization-Wide Defaults");
        cm.switchToParentFrame();
        cm.switchToFrameByTitle("Organization-Wide Sharing");
        try {
            cf.selectTextOnFieldTitle(arg0,arg1);
        }
        catch (Exception e)
        {
            webDriver.PageRefresh();
            webDriver.waitForElementLoad(2);
            cm.switchToParentFrame();
            cm.switchToFrameByTitle("Organization-Wide Sharing");
            cf.selectTextOnFieldTitle(arg0,arg1);
        }
        cf.clickOnButtonWithValue(" Save ");
        cf.acceptAlertIfAny();
        cm.switchToParentFrame();

    }

    @Then("Edit Organization-Wide Defaults")
    public void editOrganizationWideDefaults() throws Exception {    // Write code here that turns the phrase above into concrete actions    throw new io.cucumber.java.PendingException();}
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("BtnClickOnPage").replace("{paramlink1}","Edit").replace("{paramlink2}","Organization-Wide Defaults")));
        webDriver.waitforElementtobeclickable(xml.getlocator("BtnClickOnPage").replace("{paramlink1}","Edit").replace("{paramlink2}","Organization-Wide Defaults"));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("BtnClickOnPage").replace("{paramlink1}","Edit").replace("{paramlink2}","Organization-Wide Defaults")));
        webDriver.waitForElementLoad(4);
        int count =webDriver.getwebelementscount(xml.getlocator("BtnClickOnPage").replace("{paramlink1}","Edit").replace("{paramlink2}","Organization-Wide Defaults"));
         if(count>0)
         {
             webDriver.Clickon(webDriver.getwebelement(xml.getlocator("BtnClickOnPage").replace("{paramlink1}","Edit").replace("{paramlink2}","Organization-Wide Defaults")));
         }

    }

    @Then("Add Picklist Values with Mode {string}")
    public void addPicklistValuesWithMode(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("TextAreaTitle").replace("{paramlink}","Modes")));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("TextAreaTitle").replace("{paramlink}","Modes")));
        webDriver.SendKeys(webDriver.getwebelement(xml.getlocator("TextAreaTitle").replace("{paramlink}","Modes")), arg0);
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("InputCheckbox")));
        webDriver.waitforElementtobeclickable(xml.getlocator("InputCheckbox"));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("InputCheckbox")));
    }

    @Then("Delete Picklist Value Sets {string}")
    public void DeletePicklistValueSet(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("DeleteModePicklist").replace("{paramlink}",arg0)));
        webDriver.waitforElementtobeclickable(xml.getlocator("DeleteModePicklist").replace("{paramlink}",arg0));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("DeleteModePicklist").replace("{paramlink}",arg0)));
    }


    @Then("Create New remote Site with Following details")
    public void createNewRemoteSiteWithFollowingDetails(DataTable dataTable) throws Exception {
        List<Map<String, String>> data = dataTable.asMaps(String.class, String.class);
        String Remote_Site_Name = data.get(0).get("Remote Site Name");
        String Remote_Site_URL = data.get(0).get("Remote Site URL");
        String Active = data.get(0).get("Active");
        if(Integer.parseInt(DriverInstance.getVariable("AvailableCount"))==0)
        {
            Common_Steps cmf = new Common_Steps(DriverInstance);

            webDriver.waitUntilElementIsVisible(xml.getlocator("FormFields").replace("{paramlink}","new-remote-site"));
            webDriver.Clickon(webDriver.passwebelement(xml.getlocator("FormFields").replace("{paramlink}","new-remote-site")));
            cmf.switchToParentFrame();
            cmf.switchToFrameByTitle("Remote Site Edit ~ Salesforce - Enterprise Edition");
            webDriver.waitUntilElementIsVisible(xml.getlocator("FormFields").replace("{paramlink}","SiteName"));
            webDriver.SendKeys(webDriver.passwebelement(xml.getlocator("FormFields").replace("{paramlink}","SiteName")),Remote_Site_Name);
            webDriver.SendKeys(webDriver.passwebelement(xml.getlocator("FormFields").replace("{paramlink}","EndpointUrl")),Remote_Site_URL);
            String value=webDriver.passwebelement(xml.getlocator("FormFields").replace("{paramlink}","IsActive")).getDomAttribute("checked");
            System.out.println(value);
            if(Active.equalsIgnoreCase("True")) {
                if (!value.equalsIgnoreCase("true")) {
                    webDriver.Clickon(webDriver.passwebelement(xml.getlocator("FormFields").replace("{paramlink}", "IsActive")));
                }
            }
           webDriver.waitUntilElementIsVisible(xml.getlocator("WithTitle").replace("{paramlink}", "Save"));
           webDriver.Clickon(webDriver.getwebelement(xml.getlocator("WithTitle").replace("{paramlink}", "Save")));
           webDriver.waitForElementLoad(2);
        }
    }
}