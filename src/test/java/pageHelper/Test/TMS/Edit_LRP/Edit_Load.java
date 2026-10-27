package pageHelper.Test.TMS.Edit_LRP;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pageHelper.Utility.CommonFunction_Frame;
import pageHelper.Utility.Common_Steps;
import pageHelper.Utility.Common_Steps_Frame;
import pageHelper.bddDriver;
import utils.ColorUtils;
import utils.PropertyReader;
import utils.TableVerifier;
import utils.xmlreader;

import java.io.File;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Log4j
public class Edit_Load {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    public Edit_Load(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("TMS" + File.separator + "Load" + File.separator + "Load_Financial.xml");
        xml = new xmlreader("Generics" + File.separator + "CommonFrame.xml");
    }

    @Then("Edit LRP - Add {string} Field near {string} on {string} Tab")
    public void editLRPMakeFieldAsFieldUnder(String arg0, String arg1, String arg2) throws Exception {
        Common_Steps cm = new Common_Steps(DriverInstance);
        CommonFunction_Frame cmf = new CommonFunction_Frame(DriverInstance);
        Common_Steps_Frame cff = new Common_Steps_Frame(DriverInstance);
        cff.goToTab("Fields");
        cm.waitForSeconds("5");
        webDriver.getSalesforceSearchInput(arg0);
        cm.waitForSeconds("2");
        cff.switchToFrameByTitle("Surface");
        cff.goToTab(arg2);
        cm.waitForSeconds("10");
        cm.switchToParentFrame();
        String sourceloc =xml.getlocator("SpanTextObject").replace("{paramlink}", arg0);
        String destloc = "//*[text()='Team Assignments & Status']/ancestor::div[@class='actualNode'][1]//div[@id='field-section-content']";
        webDriver.dragFromParentToIframe(sourceloc,destloc);
    }
}