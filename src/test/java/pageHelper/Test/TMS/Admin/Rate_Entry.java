package pageHelper.Test.TMS.Admin;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Log4j
public class Rate_Entry {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader PageObject;
    public xmlreader Generic;
    public PropertyReader propertyReader = new PropertyReader();
    public List<String> searchResults = new ArrayList<>();

    public Rate_Entry(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        PageObject = new xmlreader("TMS Admin" + File.separator + "Rate_Entry.xml");
        Generic = new xmlreader("Generics" + File.separator + "Common.xml");
    }

    @Then("Verify and get Rate_Entry Number on kay {string}")
    public void verifyAndGetRate_EntryNumberOnKay(String arg0) throws DocumentException, InterruptedException {
       webDriver.waitUntilElementIsVisible(PageObject.getlocator("Rate_Value"));
       String text= webDriver.GetText(webDriver.passwebelement(PageObject.getlocator("Rate_Value")));
       DriverInstance.setVariable(arg0,text);
    }


    @Then("Enter Rate Entry {string} Text as {string}")
    public void enterRateEntryTextAs(String arg0, String arg1) throws Exception {
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", arg0)));
        String fieldName = webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", arg0)).getAttribute("for");
        System.out.println(fieldName);
        System.out.println(Generic.getlocator("LabelText").replace("{paramlink}", arg0));
        WebElement element = webDriver.passwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
        webDriver.ScrollIntoView(element);
        webDriver.SendKeys(element, arg1);
        webDriver.waitForElementLoad(1);
        webDriver.Clickon(element);
    }
}