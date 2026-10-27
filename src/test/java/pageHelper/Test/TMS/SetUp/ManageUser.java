package pageHelper.Test.TMS.SetUp;

import com.ibm.icu.impl.duration.impl.DataRecord;
import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import pageHelper.Utility.CommonFunction_Frame;
import pageHelper.Utility.Common_Steps;
import pageHelper.Utility.Common_Steps_Frame;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;

@Log4j
public class ManageUser {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    Common_Steps cm;
    Common_Steps_Frame cf;
    CommonFunction_Frame cff;
    public ManageUser(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"CommonFrame.xml");
        pageObject=new xmlreader("TMS"+ File.separator+"SetUp"+File.separator+"ManageUser.xml");

        cm = new Common_Steps(DriverInstance);
         cf = new Common_Steps_Frame(DriverInstance);
         cff = new CommonFunction_Frame(DriverInstance);
    }

    public void NavigateToUser(String UserName) throws Exception {
        webDriver.waitForElementLoad(1);
        cm.switchToFrameByTitle("All ~ Salesforce - Enterprise Edition");
        cf.clickOnContains(UserName);
        cm.switchToParentFrame();

    }

    public void NavigateToPermissionSet() throws Exception {
        cm.switchToFrameByTitle("User:");
        cf.clickOnContains("Permission Set Assignments");
        cf.clickOnButtonOnPage("Edit Assignments","Permission Set Assignments");
        cm.switchToFrameByTitle("Permission Set Assignments:");
    }
    @Then("Click on Login with {string}")
    public void clickOnLoginWith(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("LoginUser").replace("{paramlink}",arg0)));
        webDriver.waitforElementtobeclickable(pageObject.getlocator("LoginUser").replace("{paramlink}",arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("LoginUser").replace("{paramlink}",arg0)));

    }

    @Then("Login With User")
    public void loginWithUser() throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("LoginBtn2")));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("LoginBtn2"));
        webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("LoginBtn2")));

    }


    @Then("Verify {string} Apex Job is processed with Apex Class as {string} and Apex Method as {string}")
    public void verifyApexJobIsProcessedWithApexClassAsAndApexMethodAs(
            String CountRecords, String arg0, String arg1) throws Exception {

        Common_Steps cm = new Common_Steps(DriverInstance);
        int count = 0;
        int retry = 0;
        int maxRetry = 10;
        do {
            cm.waitForSeconds("5");
            cm.refreshCurrentPage();
            cm.waitForSeconds("1");
            cm.switchToFrameByTitle("Apex Jobs ~ Salesforce - Enterprise Edition");
            cm.waitForSeconds("1");

            count = webDriver.getwebelementscount2(
                    pageObject.getlocator("ApexJobELDDownloadCheck")
                            .replace("{paramlink1}", arg0)
                            .replace("{paramlink2}", arg1));
            retry++;
            cm.switchToParentFrame();

        } while (count <= Integer.parseInt(CountRecords) && retry < maxRetry);

        if (count <= Integer.parseInt(CountRecords)) {
            throw new Exception("Apex Job was not processed after " + maxRetry
                    + " retries. Expected count > " + CountRecords
                    + ", but found " + count);
        }
    }
}
