package pageHelper.Test.TMS.Transportation_Profile;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.Keys;
import org.testng.Assert;
import pageHelper.bddDriver;
import utils.DriverController;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.util.List;
import java.util.Map;

@Log4j
public class Carrier_Service {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    public Carrier_Service(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
        pageObject=new xmlreader("TMS"+ File.separator+"Transportation_Profile"+File.separator+"Carrier_Service.xml");
    }

    @Then("Click on {string} link from {string} page")
    public void clickOnLinkFromCarrierQuotePage(String labelName, String Page) throws Exception {
        webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("SpanTitle").replace("{paramlink}", labelName)));
    }
}
