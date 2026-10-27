package pageHelper.Test.TMS.SetUp;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.And;
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
public class Permission_Set {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    Common_Steps cm;
    Common_Steps_Frame cf;
    CommonFunction_Frame cff;
    public Permission_Set(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"CommonFrame.xml");
        pageObject=new xmlreader("TMS"+ File.separator+"SetUp"+File.separator+"Permission_Set.xml");
         cm = new Common_Steps(DriverInstance);
         cf = new Common_Steps_Frame(DriverInstance);
         cff = new CommonFunction_Frame(DriverInstance);
    }

    @Then("Set Permission {string} as {string}")
    public void setPermissionAsTrue(String arg0, String arg1) {
        webDriver.setPermission(arg0,Boolean.parseBoolean(arg1));
    }
    @Then("Move {string} to enable")
    public void moveToEnable(String arg0) throws DocumentException, InterruptedException {
        String First =pageObject.getlocator("AvailablePermissionSets");
        String Second =pageObject.getlocator("EnabledPermissionSets");
        String Add =pageObject.getlocator("Add");
        webDriver.enablePermissionSet(First,Second,Add,arg0);
    }
    @Then("Move {string} to available")
    public void moveToAvailable(String arg0) throws DocumentException, InterruptedException {
        String First =pageObject.getlocator("AvailablePermissionSets");
        String Second =pageObject.getlocator("EnabledPermissionSets");
        String Remove =pageObject.getlocator("Remove");
        webDriver.enablePermissionSet(Second,First,Remove,arg0);
    }

    @And("Check if already Exist")
    public void checkIfAlreadyExist() throws DocumentException, InterruptedException {
      if(webDriver.getwebelementscount(xml.getlocator("VerifyMessage").replace("{paramlink}", "Please fix the following:"))>0)
        {
           cf.clickOnButtonWithValue("Cancel");
           Thread.sleep(2000);
        }


    }
}