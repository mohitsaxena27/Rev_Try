package pageHelper.Test.Email;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.testng.Assert;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import javax.mail.MessagingException;
import java.io.File;
import java.io.IOException;

import static utils.MailUtility.maiUtility.*;

@Log4j
public class Carrier_Removal {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    public Carrier_Removal(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject=new xmlreader("TMS"+ File.separator+"Load"+File.separator+"Load_Details.xml");
    }

    @Then("Verify Carrier Removal Notification Mail having CC as {string}")
    public void verifyCarrierRemovalNotificationMailHavingCCAs(String arg0) throws IOException, MessagingException {

        if(arg0.equalsIgnoreCase("Company Email"))
        {
            arg0=propertyReader.readproperty("Company_Email");
        }
        boolean flag=  verifyCC("Sandbox: Carrier Removal Notification",arg0);
        Assert.assertTrue(flag);

    }

    @Then("Verify Carrier Removal Notification Mail having {string} attached pdf")
    public void verifyCarrierRemovalNotificationMailHavingAttachedPdf(String arg0) {
        String FileName=DriverInstance.getVariable("1L")+" - "+DriverInstance.getVariable("Carrier_Service")+" - Carrier Removal Confirmation.pdf";
        try {
            String flag = verifyAttachmentByName("Sandbox: Carrier Removal Notification", FileName);
            Assert.assertEquals(flag, arg0, "Unable to find E-mail for Carrier Removal Notification without Attachment!!");
        }
        catch (AssertionError e)
        {
            webDriver.waitForElementLoad(300);
            String flag = verifyAttachmentByName("Sandbox: Carrier Removal Notification", FileName);
            Assert.assertEquals(flag, arg0, "Unable to find E-mail for Carrier Removal Notification without Attachment after waiting 8 Minutes!!");

        }
    }

    @Then("Verify Carrier Removal Notification Email Template")
    public void verifyCarrierRemovalNotificationEmailTemplate() {
        String regexTemplate =
                "Carrier Removal Notification\\s*" +
                        "([A-Za-z0-9\\-\\s']+) has been removed from load\\s*([A-Za-z0-9\\-\\s']+)\\.?\\s*" +
                        "We apologize for any inconvenience\\. Please contact dispatch if you have questions\\.\\s*" +
                        "Thank you,\\s*" +
                        "([A-Za-z\\s]+)\\s*" +                // Sender.Name
                        "([\\w._%+-]+@[\\w.-]+)\\s*" +        // Sender.Email
                        "([A-Za-z0-9\\-\\s_/]+)";

        boolean flag= matchTemplateWithThreshold("Sandbox: Carrier Removal Notification",regexTemplate);
        Assert.assertTrue(flag);
    }
}
