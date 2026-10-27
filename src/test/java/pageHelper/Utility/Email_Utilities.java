package pageHelper.Utility;

import com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter;
import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.Assert;
import pageHelper.bddDriver;
import utils.*;

import javax.mail.MessagingException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static utils.MailUtility.maiUtility.*;

@Log4j
public class Email_Utilities {
    public webHelper webDriver;
    private final bddDriver DriverInstance;
    public xmlreader xml;
    WebDriver Chromedriver;
    public PropertyReader propertyReader = new PropertyReader();
    public Email_Utilities(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        webDriver = new baseDriverHelper(bddDriver.getGuestDriver());
        xml=new xmlreader("src\\test\\resources\\locators\\salesforce.xml");
    }


    @Then("Accept Tender and Verify Carrier guest LWC")
    public void AcceptTenderAndVerifyCarrierGuestLWC() throws Exception {
        Thread.sleep(1000);
        Chromedriver = new ChromeDriver();
        Chromedriver.manage().window().maximize();
        webDriver = new baseDriverHelper(Chromedriver);
        Chromedriver.get(DriverInstance.getVariable("Accept_Link")); // Replace with actual test URL
        Thread.sleep(3000);
        webDriver.move_to_element(webDriver.getwebelement(xml.getlocator("SearchFields").replace("{paramlink}","Search...")));
//        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("DivText").replace("{paramlink}",DriverInstance.getLoadNum())));
        Thread.sleep(2000);
        String BillOfLandingNumber= webDriver.getText(webDriver.getwebelement(xml.getlocator("GetVerifyText").replace("{paramlink}","Bill of Lading Number")));
        String Load_Status=  webDriver.getText(webDriver.getwebelement(xml.getlocator("GetVerifyText").replace("{paramlink}","Load Status")));
        String Total_Wieght= webDriver.getText(webDriver.getwebelement(xml.getlocator("GetVerifyText").replace("{paramlink}","Total Weight")));
        String OwnerID= webDriver.getText(webDriver.getwebelement(xml.getlocator("GetVerifyText1").replace("{paramlink}","Owner ID")));
        String Origin=  webDriver.getText(webDriver.getwebelement(xml.getlocator("GetVerifyText").replace("{paramlink}","Origin")));
        String OrderDate = webDriver.getText(webDriver.getwebelement(xml.getlocator("GetVerifyText").replace("{paramlink}","Order Date")));
        log("Bill Of Landing Number : "+BillOfLandingNumber);
        log("Load Status : "+Load_Status);
        log("Total_Weight : "+Total_Wieght);
        log("OwnerID : "+OwnerID);
        log("Origin : "+Origin);
        log("OrderDate : "+OrderDate);
        Thread.sleep(2000);
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Button_Text").replace("{paramlink}","Accept")));
        Thread.sleep(1000);
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("SpanText").replace("{paramlink}","Carrier Load Confirm Accept Message")));
        log("Carrier Load Confirm Accept Message is displaying");
        Chromedriver.quit();
    }
    @Then("Select the load and Arrived action on the first stop")
    public void Select_the_load_and_Arrived() throws Exception {
        Thread.sleep(5000);
        Chromedriver = new ChromeDriver();
        Chromedriver.manage().window().maximize();
        webDriver = new baseDriverHelper(Chromedriver);
        Chromedriver.get(DriverInstance.getVariable("Status_Link"));
        webDriver.move_to_element(webDriver.getwebelement(xml.getlocator("SearchFields").replace("{paramlink}","Search...")));
        try {
            int Size;
            do {
                webDriver.PageRefresh();
                webDriver.move_to_element(webDriver.getwebelement(xml.getlocator("SearchFields").replace("{paramlink}","Search...")));
                Thread.sleep(4000); // Wait for 2 seconds before checking again
                Size = webDriver.getwebelementscount(xml.getlocator("EntityOperation").replace("{paramlink}", DriverInstance.getLoadNum()));
            } while (Size==0);
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("EntityOperation").replace("{paramlink}", DriverInstance.getLoadNum())));
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("EntityOperation").replace("{paramlink}", DriverInstance.getLoadNum())));
//            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("DivText").replace("{paramlink}", DriverInstance.getLoadNum())));
        }
        catch (Exception e)
        {
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("EntityOperation").replace("{paramlink}", DriverInstance.getLoadNum())));
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("EntityOperation").replace("{paramlink}", DriverInstance.getLoadNum())));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("DivText").replace("{paramlink}", DriverInstance.getLoadNum())));
        }
        Thread.sleep(2000);
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("SpanTextMultiple").replace("{paramlink}","Arrived").replace("index","1")));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("SpanTextMultiple").replace("{paramlink}","Arrived").replace("index","1")));


    }

    @Then("Send Update with Arrived Time, Carrier Status and Comments")
    public void sendUpdateWithArrivedTimeCarrierStatusAndComments() throws Exception {

        WebElement element = webDriver.getwebelement(xml.getlocator("InputTextLabel").replace("{paramlink}", "Arrival Date"));
        try {
            webDriver.ClearAndEnterDate(element,ExpectedDate("0"));
        }
        catch(Exception e)
        {
            webDriver.ClearAndEnterDate(element,ExpectedDate("0"));

        }
        WebElement element1 = webDriver.getwebelement(xml.getlocator("InputTextLabel").replace("{paramlink}", "In Time"));
        webDriver.SendKeys(element1,"12");
        WebElement element2 = webDriver.getwebelement(xml.getlocator("InputTextLabel").replace("{paramlink}", "Comments"));
        webDriver.SendKeys(element2,"Dock 5 thanks!");
        webDriver.VerifyText(webDriver.getwebelement(xml.getlocator("DivTextContains").replace("{paramlink}", "Please enter 24-hour time, such as ")),"Please enter 24-hour time, such as ");
        log("Validation rule is presented stating 'Please enter 24-hour time, such as 0130 or 2230'");
        webDriver.SendKeys(element1,"1235");
        Thread.sleep(2000);
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("ButtonAriaLabel").replace("{paramlink}","Carrier Status")));
        Thread.sleep(1000);
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("SpanText").replace("{paramlink}","Checked In")));
        Thread.sleep(1000);
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("Button_Text").replace("{paramlink}","Send Update")));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Button_Text").replace("{paramlink}","Send Update")));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("DivText").replace("{paramlink}","Success - Pickup/Delivery Status")));
        log("Validate success message stating 'Success- Pickup/Delivery Status. Save was Successful'");
        Chromedriver.quit();
    }

    @Then("Get {string} link from Email for Subject {string}")
    public void getLinkFromEmailForDriverTripConfirmation(String arg0, String arg1) throws Exception {
        if(arg1.contains("SysData"))
        {
            arg1=DriverInstance.getVariable(arg1.split("=>")[1]);
        }
        try {
            String Link = getLink(arg1, arg0);
            DriverInstance.setVariable("Link", Link);
        }
        catch(Exception e)
        {
            Common_Apis ca = new Common_Apis(DriverInstance);
            ca.verifyEmailMessageAfterTestStart(arg1.replace("Sandbox:","").trim(),"GetMessage");
            String Link = getLinkUrlFromEmail(DriverInstance.getVariable("GetMessage"), arg0);
            DriverInstance.setVariable("Link", Link);
        }
    }

    public String ExpectedDate(String P_Expected_Date)  {
        String formattedDate;
        LocalDate tomorrow;
        if(P_Expected_Date.equalsIgnoreCase("Tomorrow")) {
            tomorrow = LocalDate.now().plusDays(1);
        }
        else{
            tomorrow = LocalDate.now().plusDays(Integer.parseInt(P_Expected_Date));

        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy");
        formattedDate = tomorrow.format(formatter);
        System.out.println(formattedDate);
        return formattedDate;
    }
    public static void log(String message)
    {
        System.out.println(message);
        ExtentCucumberAdapter.addTestStepLog("<table style='color:DarkGreen;'><tr><td><b>"+message+"</b></td></tr><tr></table>");

    }

    @Then("Verify the email attachment has {string} {string} with subject {string}")
    public void verifyTheEmailAttachmentHasFileAsAttachment(String condition,String Filename,  String Subject) {
        if(Filename.contains("SysData")) {
            String Value = Filename.split("=>")[1];
            Filename = DriverInstance.getVariable(Value);
        }
            String flag = verifyAttachmentByName(Subject, Filename);
            Assert.assertEquals(flag, condition, "Attachment condition matched");
    }

    @Then("Verify the email attachment has {string} as an attachment with subject {string}")
    public void verifyTheEmailAttachmentHasAsAttachment(String Filename, String Subject) {

        if(Filename.contains("SysData")) {
            String Value = Filename.split("=>")[1];
            Filename = DriverInstance.getVariable(Value);
        }
        if(Subject.contains("SysData")) {
            String Value = Subject.split("=>")[1];
            Subject = DriverInstance.getVariable(Value);
        }
            try {
                String flag = verifyAttachmentByName(Subject, Filename);
                Assert.assertEquals(flag, "Valid", "No attachment found or don't match the filename");
            }
            catch (AssertionError e) {
                try {
                    Common_Apis ca = new Common_Apis(DriverInstance);
                    ca.GetEmailAttributesAfterTestStart("HasAttachment",Subject.replace("Sandbox:","").trim(),"GetAttachment");
                     if(DriverInstance.getVariable("GetAttachment").equalsIgnoreCase("true"))
                     {
                         System.out.println("Attachment is there with Email - Passing this test");
                         ca.getCountFromObject("ContentDocument","Title",Filename,"FileCount");
                         Assert.assertTrue(Integer.parseInt(DriverInstance.getVariable("FileCount_count"))>0,"Not able to Verify Attachment either through Email or Email Message Records");
                     }
                     else{
                         Assert.fail("Not able to Verify Attachment either through Email or Email Message Records");
                     }
                }
                catch (Exception e1)
                {
                    Assert.fail("Mail not found for Subject "+ Subject);
                }

            }

        }

    @Then("Verify the email attachment has {string} or {string} as an attachment with subject {string}")
    public void verifyTheEmailAttachmentcontainsAsAttachment(String Filename,String Filename2, String Subject) {

        if(Filename.contains("SysData")) {
            String Value = Filename.split("=>")[1];
            Filename = DriverInstance.getVariable(Value);
        }
        if(Filename2.contains("SysData")) {
            String Value = Filename2.split("=>")[1];
            Filename2 = DriverInstance.getVariable(Value);
        }
        if(Subject.contains("SysData")) {
            String Value = Subject.split("=>")[1];
            Subject = DriverInstance.getVariable(Value);
        }
        try {
            String flag = verifyAttachmentByName(Subject, Filename);
            Assert.assertEquals(flag, "Valid", "No attachment found or don't match the filename");
        }
        catch (AssertionError e) {
            webDriver.waitForElementLoad(300);
            String flag = verifyAttachmentByName(Subject, Filename);
            Assert.assertEquals(flag, "Valid", "No attachment found or don't match the filename");
        }

    }

    @Then("Verify recipient {string} is present in the email as {string} with Subject {string}")
    public void verifyRecipentIsPresentInTheEmailAsWithSubject(String emailId, String RecepientType, String subject) throws Exception {

        if(emailId.contains("SysData"))
        {
            emailId=DriverInstance.getVariable(emailId.split("=>")[1]);
        }
        if(RecepientType.equalsIgnoreCase("CC")){
            try {
                boolean flag = verifyCC(subject, emailId);
                Assert.assertTrue(flag);
            }
            catch (AssertionError e)
            {
                Common_Apis ca = new Common_Apis(DriverInstance);
                ca.GetEmailAttributesAfterTestStart("CcAddress",subject,"CCList");
                if(DriverInstance.getVariable("CCList").contains(emailId))
                {
                    System.out.println("CC Verified");
                }
                else{
                    Assert.fail("Unable to verify CC with Subject "+subject);
                }
            }
        }
        else {
            try {
                boolean flag = verifyTo(subject, emailId);
                Assert.assertTrue(flag);
            }
            catch (AssertionError e)
            {
                Common_Apis ca = new Common_Apis(DriverInstance);
                ca.GetEmailAttributesAfterTestStart("ToAddress",subject,"TOList");
                if(DriverInstance.getVariable("TOList").contains(emailId))
                {
                    System.out.println("TO Verified");
                }
                else{
                    Assert.fail("Unable to verify To list with Subject "+subject);
                }
            }
        }
    }
}