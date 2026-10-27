package pageHelper.Test.TMS.Account;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

@Log4j
public class Account_Trigger {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    Common_Steps cs;
    public Account_Trigger(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("TMS" + File.separator + "Account" + File.separator + "Account.xml");
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        cs = new Common_Steps(DriverInstance);
    }
    @Then("Verify Message displaying as Account {string} was created.")
    public void verifyMessageDisplayingAsAccountWasCreated(String arg0) throws DocumentException, InterruptedException {
        System.out.println(xml.getlocator("VerifyMessage").replace("{paramlink}", arg0));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("VerifyMessage").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(xml.getlocator("VerifyMessage").replace("{paramlink}", arg0));
        cs.closeToastMessage();
    }

    @Then("Verify Heading Text {string} with text {string}")
    public void verifyHeadingTextWithText(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("HeadingText").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1));
        webDriver.verifyElementToBePresent(pageObject.getlocator("HeadingText").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1));

    }

    @Then("Get ContentDocument Id for {string} {string} and store into {string}")
    public void getContentDocumentIdFor(String arg0, String arg1, String key) throws DocumentException, InterruptedException {

        webDriver.waitUntilElementIsVisible(pageObject.getlocator("GetDocumentID").replace("{paramlink1}",arg1).replace("{Index}",arg0));
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("GetDocumentID").replace("{paramlink1}",arg1).replace("{Index}",arg0)));
        String href=  webDriver.Getattribute(webDriver.getwebelement(pageObject.getlocator("GetDocumentID").replace("{paramlink1}",arg1).replace("{Index}",arg0)), "href");
        String id = href.split("/")[href.split("/").length - 2];
        DriverInstance.setVariable(key,id);
    }
}
