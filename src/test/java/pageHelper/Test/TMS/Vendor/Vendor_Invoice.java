package pageHelper.Test.TMS.Vendor;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;
import org.testng.Assert;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.util.List;
import java.util.Map;

@Log4j
public class Vendor_Invoice {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    public Vendor_Invoice(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("TMS" + File.separator + "Vendor" + File.separator + "Vendor_Invoice.xml");
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
    }

    @Then("Edit LRP - Make {string} Field as {string} Field under UI Behavior")
    public void editLRPMakeFieldAsFieldUnder(String arg0, String arg1) throws Exception {
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("VerifyMessage").replace("{paramlink}","Lightning App Builder")));
        webDriver.verifyCurrentURL("visualEditor");
         //Click on Field Name
        webDriver.SwitchToFrameByElement(webDriver.getwebelement(pageObject.getlocator("IframeTitle").replace("{paramlink}", "Surface")));
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("LRPField").replace("{paramlink}", arg0)));
        webDriver.waitforElementtobeclickable(pageObject.getlocator("LRPField").replace("{paramlink}", arg0));
        webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("LRPField").replace("{paramlink}", arg0)));
        webDriver.SwitchToParentFrame();
         // Click on None
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("WaitForLoadDetails").replace("{paramlink}", arg0)));
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("UIBehaviorFiled").replace("{paramlink1}", "UI Behavior").replace("{paramlink2}", arg1)));
        webDriver.waitforElementtobeclickable(pageObject.getlocator("UIBehaviorFiled").replace("{paramlink1}", "UI Behavior").replace("{paramlink2}", arg1));
        webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("UIBehaviorFiled").replace("{paramlink1}", "UI Behavior").replace("{paramlink2}", arg1)));
    }

    @Then("Edit LRP - {string} Changes")
    public void editLRPSaveChanges(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("ButtonWithText").replace("{paramlink}", arg0)));
        webDriver.waitforElementtobeclickable(pageObject.getlocator("ButtonWithText").replace("{paramlink}", arg0));
        webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("ButtonWithText").replace("{paramlink}", arg0)));
        webDriver.waitForElementLoad(2);
        int count=webDriver.getwebelementscount(pageObject.getlocator("VerifyHeading").replace("{paramlink}","Save without required fields?"));
        if(count>0)
        {
            webDriver.waitforElementtobeclickable(pageObject.getlocator("SaveConfirm"));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("SaveConfirm")));
        }
        webDriver.waitForElementLoad(2);
        webDriver.waitUntilTheElementIsNotVisible(pageObject.getlocator("VerifyInActiveButton"));

        int count1=webDriver.getwebelementscount(pageObject.getlocator("VerifyHeading").replace("{paramlink}","Page Saved"));
        if(count1>0)
        {
            webDriver.waitforElementtobeclickable(pageObject.getlocator("ButtonWithText").replace("{paramlink}", "Activate"));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("ButtonWithText").replace("{paramlink}", "Activate")));
            webDriver.waitForElementLoad(6);
            int count2=webDriver.getwebelementscount(pageObject.getlocator("VerifyHeading").replace("{paramlink}","Activation:"));
            if(count2>0)
            {
                webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("ButtonWithText").replace("{paramlink}", "Assign as Org Default")));
                webDriver.waitforElementtobeclickable(pageObject.getlocator("ButtonWithText").replace("{paramlink}", "Assign as Org Default"));
                webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("ButtonWithText").replace("{paramlink}", "Assign as Org Default")));
                webDriver.waitForElementLoad(5);
                int count3=webDriver.getwebelementscount(pageObject.getlocator("VerifyHeading").replace("{paramlink}","Assign form factor"));
                if(count3>0)
                {
                    webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("ButtonWithText").replace("{paramlink}", "Next")));
                    webDriver.waitforElementtobeclickable(pageObject.getlocator("ButtonWithText").replace("{paramlink}", "Next"));
                    webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("ButtonWithText").replace("{paramlink}", "Next")));
                }
                webDriver.waitForElementLoad(3);
                int count4=webDriver.getwebelementscount(pageObject.getlocator("VerifyHeading").replace("{paramlink}","Review assignment"));
                if(count4>0)
                {
                    webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("AssignSave")));
                    webDriver.waitforElementtobeclickable(pageObject.getlocator("AssignSave"));
                    webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("AssignSave")));
                }
            }
        }
    }

    @Then("Accessorial table should match:")
    public void accessorialTableShouldMatch(DataTable dt) throws DocumentException, InterruptedException {
        List<Map<String, String>> expectedRows = dt.asMaps(String.class, String.class);

        for (Map<String, String> row : expectedRows) {
            String Accessorial = row.get("Accessorial");
            String Qty = row.get("Qty");
            String Unit = row.get("Unit");
            String Unit_price = row.get("Unit price");
            String Charge = row.get("Charge");
            String Stop = row.get("Stop");
            WebElement rowDetails = webDriver.passwebelement(pageObject.getlocator("Accessorials").replace("{paramlink}",Accessorial));
            String Actual_Accessorial = rowDetails.findElement(By.xpath(".//td[1]")).getText().trim();
            String Actual_Stop = rowDetails.findElement(By.xpath(".//td[2]")).getText().trim();
            String Actual_QTY = rowDetails.findElement(By.xpath(".//td[3]//input")).getAttribute("value").trim();
            String Actual_Unit = new Select(rowDetails.findElement(By.xpath(".//td[4]//select"))).getFirstSelectedOption().getText().trim();
            String Actual_Unit_Price= rowDetails.findElement(By.xpath(".//td[5]//input")).getAttribute("value").trim();
            String Actual_Charge= rowDetails.findElement(By.xpath(".//td[6]//span")).getText().trim();
            webDriver.Stringcomparator(Accessorial,Actual_Accessorial);
            webDriver.Stringcomparator(Qty,Actual_QTY);
            webDriver.Stringcomparator(Unit,Actual_Unit);
            webDriver.Stringcomparator(Unit_price,Actual_Unit_Price);
            webDriver.Stringcomparator(Charge,Actual_Charge);
            webDriver.Stringcomparator(Stop,Actual_Stop);

        }
    }

    @Then("Click on {string} button on {string} Modal")
    public void clickOnButtonOnModal(String arg0, String arg1) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("ClickOnModalButton").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
        webDriver.waitforElementtobeclickable(pageObject.getlocator("ClickOnModalButton").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1));
        webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("ClickOnModalButton").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
    }
}
