package pageHelper.Test.TMS.Admin;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import lombok.Value;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pageHelper.Test.TMS.Load.Load_Financial;
import pageHelper.Test.TMS.Object_Manager.Field_Set;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.ColorUtils;
import utils.PropReader;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.concurrent.TimeUnit;

@Log4j
public class Home_Page {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader PageObject;
    public xmlreader xml;
    public PropertyReader propertyReader = new PropertyReader();
    public List<String> searchResults = new ArrayList<>();
    Common_Steps cm;
    public Home_Page(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        PageObject = new xmlreader("TMS Admin" + File.separator + "Home_Page.xml");
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        cm = new Common_Steps(DriverInstance);
    }

    @Then("Run {string} Job")
    public void runJob(String arg0) throws Exception {
        try {
            webDriver.waitForElementLoad(2);
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}",arg0)));
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}",arg0)));
        }
        catch(Exception e)
        {
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}",arg0)));
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}",arg0)));

        }
        String status;
        status= webDriver.getText(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}",arg0)));
        if(status.equalsIgnoreCase("Scheduled") ) {
            //&& !arg0.equalsIgnoreCase("QueuedTransactionJob")
            DeleteJob(arg0);
            webDriver.waitForElementLoad(2);
            cm.clickOnButtonWithTitle("Refresh");
            webDriver.waitForElementLoad(5);
            status= webDriver.getText(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}",arg0)));
        }

        if(status.equalsIgnoreCase("Not Running or Scheduled!")) {
            webDriver.waitForElementLoad(1);
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Execute_button").replace("{paramlink}",arg0)));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Execute_button").replace("{paramlink}",arg0)));
            webDriver.waitForElementLoad(1);
            int count=webDriver.getwebelementscount(PageObject.getlocator("RunJobButton").replace("{paramlink}", arg0));
            if(count==0)
            {
                webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Execute_button").replace("{paramlink}",arg0)));
            }
            System.out.println(count);
            webDriver.safeJavaScriptClick(webDriver.getwebelement(PageObject.getlocator("RunJobButton").replace("{paramlink}", arg0)));
            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("VerifyMessage").replace("{paramlink}", "Success - Batch Processes")));
            webDriver.verifyElementToBePresent(xml.getlocator("VerifyMessage").replace("{paramlink}", "Success - Batch Processes"));
            Load_Financial ldf = new Load_Financial(DriverInstance);
            ldf.storeCurrentTimeInFormatOfOnTo("M/d/yyyy, hh:mm a","Previous_Run_Time");
            do{
                webDriver.waitForElementLoad(3);
                webDriver.PageRefresh();
                cm.clickOnButtonWithTitle("Refresh");
                webDriver.waitForElementLoad(1);
                webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}",arg0)));
                webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}",arg0)));
                status= webDriver.getText(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}",arg0)));
            }
            while(status.equalsIgnoreCase("Queued")||status.equalsIgnoreCase("Holding")||status.equalsIgnoreCase("Processing")||status.equalsIgnoreCase("Preparing"));

            if(arg0.equalsIgnoreCase("EDIWatcherJob"))
            {
                String status1;
                do{
                    webDriver.waitForElementLoad(5);
                    webDriver.PageRefresh();
                    cm.clickOnButtonWithTitle("Refresh");
                    webDriver.waitForElementLoad(5);
                    webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}","EDIJob")));
                    webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}","EDIJob")));
                    status1= webDriver.getText(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}","EDIJob")));
                }
                while(status1.equalsIgnoreCase("Queued")||status1.equalsIgnoreCase("Holding")||status1.equalsIgnoreCase("Processing"));

            }
            if(arg0.equalsIgnoreCase("FuelIndexUpdateJob"))
            {
                String status1;
                do{
                    webDriver.waitForElementLoad(5);
                    webDriver.PageRefresh();
                    cm.clickOnButtonWithTitle("Refresh");
                    webDriver.waitForElementLoad(5);
                    webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}","FuelSurchargeUpdateJob")));
                    webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}","FuelSurchargeUpdateJob")));
                    status1= webDriver.getText(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}","FuelSurchargeUpdateJob")));
                }
                while(status1.equalsIgnoreCase("Queued")||status1.equalsIgnoreCase("Holding")||status1.equalsIgnoreCase("Processing"));
            }

        }
        else{
            System.out.println("Status is already set to " +status);
        }
    }

    @Then("Run {string} Job until Previous Run Time is not blank")
    public void runAndDeleteJob(String arg0) throws Exception {
        String PreviousRunTime;
        LocalDateTime compareTime;
        DateTimeFormatter formatter =
                DateTimeFormatter.ofPattern("M/d/yyyy, hh:mm a", Locale.ENGLISH);
        String time1 = LocalDateTime.now().format(formatter);
        LocalDateTime currentTime =
                LocalDateTime.parse(time1, formatter);
        try {
            webDriver.waitForElementLoad(2);
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}",arg0)));
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}",arg0)));
        }
        catch(Exception e)
        {
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}",arg0)));
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}",arg0)));

        }
        String status;
        status= webDriver.getText(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}",arg0)));
        if(status.equalsIgnoreCase("Scheduled") ) {
            //&& !arg0.equalsIgnoreCase("QueuedTransactionJob")
            DeleteJob(arg0);
            webDriver.waitForElementLoad(2);
            cm.clickOnButtonWithTitle("Refresh");
            webDriver.waitForElementLoad(5);
            status= webDriver.getText(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}",arg0)));
        }

        if(status.equalsIgnoreCase("Not Running or Scheduled!")) {
            webDriver.waitForElementLoad(1);
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Execute_button").replace("{paramlink}",arg0)));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Execute_button").replace("{paramlink}",arg0)));
            webDriver.waitForElementLoad(1);
            int count=webDriver.getwebelementscount(PageObject.getlocator("RunJobButton").replace("{paramlink}", arg0));
            if(count==0)
            {
                webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Execute_button").replace("{paramlink}",arg0)));
            }
            System.out.println(count);
            webDriver.safeJavaScriptClick(webDriver.getwebelement(PageObject.getlocator("RunJobButton").replace("{paramlink}", arg0)));
            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("VerifyMessage").replace("{paramlink}", "Success - Batch Processes")));
            webDriver.verifyElementToBePresent(xml.getlocator("VerifyMessage").replace("{paramlink}", "Success - Batch Processes"));
            do{
                webDriver.waitForElementLoad(3);
                webDriver.PageRefresh();
                cm.clickOnButtonWithTitle("Refresh");
                webDriver.waitForElementLoad(1);
                WebElement el = webDriver.passwebelement(PageObject.getlocator("GetJobDetails").replace("{paramlink1}", "Previous Run Time").replace("{paramlink2}", arg0));
                webDriver.ScrollIntoView(el);
                PreviousRunTime = webDriver.GetText(webDriver.passwebelement(PageObject.getlocator("GetJobDetails").replace("{paramlink1}", "Previous Run Time").replace("{paramlink2}", arg0)));
                if (PreviousRunTime != null && !PreviousRunTime.trim().isEmpty()) {
                    compareTime = LocalDateTime.parse(
                            PreviousRunTime.trim(),
                            formatter
                    );
                }
                else{
                    compareTime = currentTime;
                }
            }
            while(!currentTime.isBefore(compareTime));
        }
        else{
            System.out.println("Status is already set to " +status);
        }
    }

    @Then("Verify and Delete {string} from Scheduled Jobs")
    public void verifyAndDeleteFromScheduledJobs(String arg0) throws Exception {
        String status;
        try {
            webDriver.waitForElementLoad(2);
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}",arg0)));
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}",arg0)));
        }
        catch(Exception e)
        {
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}",arg0)));
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}",arg0)));

        }
        status= webDriver.getText(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}",arg0)));
        if(!status.equalsIgnoreCase("Not Running or Scheduled!")) {
            do {
                webDriver.waitForElementLoad(5);
                webDriver.PageRefresh();
                cm.clickOnButtonWithTitle("Refresh");
                webDriver.waitForElementLoad(5);
                webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}", arg0)));
                webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}", arg0)));
                status = webDriver.getText(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}", arg0)));
            }
            while (status.equalsIgnoreCase("Queued") || status.equalsIgnoreCase("Holding") || status.equalsIgnoreCase("Processing"));

            status = webDriver.getText(webDriver.getwebelement(xml.getlocator("JobStatus").replace("{paramlink}", arg0)));
            if (status.equalsIgnoreCase("Scheduled")) {
                DeleteJob(arg0);
                webDriver.waitForElementLoad(2);
                cm.clickOnButtonWithTitle("Refresh");
            }
        }
    }
    @Then("Delete {string} job")
    public void DeleteJob(String args) throws Exception {
        Field_Set fs = new Field_Set(DriverInstance);
        fs.openFromSetupIcon("Setup");
        cm.switchWindow();
        cm.waitForSeconds("2");
        cm.searchAndSelectFromQuickSearch("Scheduled Job");
        cm.switchToFrameByTitle("All Scheduled Jobs ~ Salesforce - Enterprise Edition");
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("SpanTextObject").replace("{paramlink}",String.valueOf(args.charAt(0)).toUpperCase())));
        Thread.sleep(1000);
        webDriver.SwitchToFrameByIndex("0");
        if(webDriver.getwebelementscount(xml.getlocator("DeleteJob2").replace("{paramlink}",args))>0) {
            webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("DeleteJob2").replace("{paramlink}", args)));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("DeleteJob2").replace("{paramlink}", args)));
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("DeleteJob2").replace("{paramlink}", args)));
            Thread.sleep(800);
            webDriver.acceptAlert();
            System.out.println(args);
            webDriver.SwitchToParentFrame();
            cm.switchToFrameByTitle("All Scheduled Jobs ~ Salesforce - Enterprise Edition");
            if(args.equalsIgnoreCase("EDIWatcherJob"))
            {
                webDriver.waitForElementLoad(2);
                if(webDriver.getwebelementscount(xml.getlocator("DeleteJob").replace("{paramlink}","EDIJob"))>0) {
                    webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("DeleteJob").replace("{paramlink}", "EDIJob")));
                    webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("DeleteJob").replace("{paramlink}", "EDIJob")));
                    webDriver.Clickon(webDriver.getwebelement(xml.getlocator("DeleteJob").replace("{paramlink}", "EDIJob")));
                    Thread.sleep(800);
                    webDriver.acceptAlert();
                }
            }
        }
        webDriver.SwitchToParentFrame();
        webDriver.closeAndSwitchToPrevious();
        webDriver.waitForElementLoad(1);
    }

    @Then("Click on dropdown chevron & Verify dropdown Action Option for {string}")
    public void clickOnDropdownChevronVerifyDropdownActionOptionFor(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Execute_button").replace("{paramlink}",arg0)));
        webDriver.waitUntilElementIsVisible(xml.getlocator("Execute_button").replace("{paramlink}",arg0));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Execute_button").replace("{paramlink}",arg0)));
        webDriver.waitForElementLoad(1);
        webDriver.verifyElementToBePresent(xml.getlocator("JobButton").replace("{paramlink}",arg0).replace("{paramlink1}","Run Now"));
        webDriver.verifyElementToBePresent(xml.getlocator("JobButton").replace("{paramlink}",arg0).replace("{paramlink1}","Schedule"));
        if(arg0.equalsIgnoreCase("FleetManagementJob3"))
        {
            webDriver.verifyElementToBePresent(xml.getlocator("JobButton").replace("{paramlink}",arg0).replace("{paramlink1}","Emergency Run"));
        }
    }

    @Then("Click on Run Now for {string}")
    public void clickOnRunNowFor(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Execute_button").replace("{paramlink}",arg0)));
        webDriver.waitUntilElementIsVisible(xml.getlocator("Execute_button").replace("{paramlink}",arg0));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Execute_button").replace("{paramlink}",arg0)));
        webDriver.waitForElementLoad(1);
        int count=webDriver.getwebelementscount(PageObject.getlocator("RunJobButton").replace("{paramlink}", arg0));
        if(count==0)
        {
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Execute_button").replace("{paramlink}",arg0)));
        }
        System.out.println(count);
        webDriver.safeJavaScriptClick(webDriver.getwebelement(PageObject.getlocator("RunJobButton").replace("{paramlink}", arg0)));

    }

    @Then("Click on dropdown chevron & Verify dropdown Action Option for {string} - {string} is greyed out and unactionable")
    public void clickOnDropdownChevronVerifyDropdownActionOptionUnactionable(String arg0, String Arg1) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Execute_button").replace("{paramlink}",arg0)));
        webDriver.waitUntilElementIsVisible(xml.getlocator("Execute_button").replace("{paramlink}",arg0));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Execute_button").replace("{paramlink}",arg0)));
        webDriver.waitForElementLoad(1);
        webDriver.verifyElementToBePresent(PageObject.getlocator("JobButtonDisabled").replace("{paramlink}",arg0).replace("{paramlink1}",Arg1));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Execute_button").replace("{paramlink}",arg0)));
        webDriver.waitForElementLoad(1);
    }


    @Then("Verify Name, Status, Next Run Time, Previous Run Time, Total Batches, Batches Processed and Batch Errors for {string}")
    public void verifyNameStatusNextRunTimePreviousRunTimeTotalBatchesBatchesProcessedAndBatchErrorsFor(String arg0) throws DocumentException, InterruptedException {

        WebElement el = webDriver.passwebelement(xml.getlocator("JobRundetails").replace("{paramlink}",arg0));

        WebElement StatusIcon = webDriver.NavigateChildWelElement(el,"//td[2]//lightning-icon");
        WebElement Status = webDriver.NavigateChildWelElement(el,"//td[2]//lightning-base-formatted-text");
        String IconName = StatusIcon.getDomAttribute("icon-name");
        if(Status.getText().equalsIgnoreCase("Not Running or Scheduled!"))
        {
            Assert.assertEquals(IconName,"standard:first_non_empty","Icon not matched");
            verifyIconIsDisplayingWithBackgroundColor(StatusIcon,"Dark Red");
        }
        else if(Status.getText().equalsIgnoreCase("Not Applicable"))
        {
            Assert.assertEquals(IconName,"utility:dash","Icon not matched");
            verifyIconIsDisplayingWithBackgroundColor(StatusIcon,"Black");
        }
         else
        {
            Assert.assertEquals(IconName,"standard:task2","Icon not matched");
            verifyIconIsDisplayingWithBackgroundColor(StatusIcon,"Green");
        }
        webDriver.VerifyChildElementDisplayed(el,"//td[3]/*[@data-label='Next Run Time']");
        webDriver.VerifyChildElementDisplayed(el,"//td[4]/*[@data-label='Previous Run Time']");
        webDriver.VerifyChildElementDisplayed(el,"//td[5]/*[@data-label='Total Batches']");
        webDriver.VerifyChildElementDisplayed(el,"//td[6]/*[@data-label='Batches Processed']");
        webDriver.VerifyChildElementDisplayed(el,"//td[7]/*[@data-label='Batch Errors']");
    }

    public void verifyIconIsDisplayingWithBackgroundColor(WebElement wl, String arg1) throws DocumentException, InterruptedException {
        String color=wl.getCssValue("color");
        String BGhex = org.openqa.selenium.support.Color.fromString(color).asHex();
        java.awt.Color bgcolor = java.awt.Color.decode(BGhex);
        System.out.println(" Color is: "+bgcolor);
        String colorName = ColorUtils.getClosestColorName(
                bgcolor.getRed(), bgcolor.getGreen(), bgcolor.getBlue());
        System.out.println("Color Name: " + colorName);
//        webDriver.Stringcomparator(colorName,arg1);
        String imgbackgroundcolor=wl.getCssValue("background-color");
        String BGhex1 = org.openqa.selenium.support.Color.fromString(imgbackgroundcolor).asHex();
        java.awt.Color bgcolor1 = java.awt.Color.decode(BGhex1);
        System.out.println("Background Color is: "+bgcolor1);
        System.out.println("RGB: " + bgcolor1.getRed() + "," + bgcolor1.getGreen() + "," + bgcolor1.getBlue());
        String colorName1 = ColorUtils.getClosestColorName(
                bgcolor1.getRed(), bgcolor1.getGreen(), bgcolor1.getBlue());
        System.out.println("Color Name: " + colorName1);
        webDriver.Stringcomparator(colorName1,arg1);
    }

    @Then("Get {string} of {string} onto {string}")
    public void getOfOnto(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException {
       webDriver.ScrollIntoView(webDriver.passwebelement(PageObject.getlocator("GetJobDetails").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1)));
       webDriver.waitUntilElementIsVisible(PageObject.getlocator("GetJobDetails").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1));
       String value = webDriver.GetText(webDriver.passwebelement(PageObject.getlocator("GetJobDetails").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1)));

       if(arg0.equalsIgnoreCase("Previous Run Time"))
       {
           DateTimeFormatter formatter =
                   DateTimeFormatter.ofPattern("M/d/yyyy, hh:mm a");
           LocalDateTime dateTime = LocalDateTime.parse(value, formatter);
           // Get system timezone
           ZoneId systemZone = ZoneId.systemDefault();

           ZonedDateTime zonedDateTime = dateTime.atZone(systemZone);

           // If system timezone is IST → convert to Chicago
           if (systemZone.getId().contains("Asia")) {
               ZoneId chicagoZone = ZoneId.of("America/Chicago");
               zonedDateTime = zonedDateTime.withZoneSameInstant(chicagoZone);
           }

           // Format only time HH:mm
           value = zonedDateTime.format(DateTimeFormatter.ofPattern("HH:mm"));
       }
       DriverInstance.setVariable(arg2,value);
    }

    @Then("Get Date and Time for {string} of {string} onto {string}")
    public void getDateOfOnto(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(PageObject.getlocator("GetJobDetails").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1)));
        webDriver.waitUntilElementIsVisible(PageObject.getlocator("GetJobDetails").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1));
        String value = webDriver.GetText(webDriver.passwebelement(PageObject.getlocator("GetJobDetails").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1)));

        if(arg0.equalsIgnoreCase("Previous Run Time"))
        {
            DateTimeFormatter formatter =
                    DateTimeFormatter.ofPattern("M/d/yyyy, hh:mm a").withLocale(Locale.ENGLISH);
            LocalDateTime dateTime = LocalDateTime.parse(value, formatter);
            // Get system timezone
            ZoneId systemZone = ZoneId.systemDefault();

            ZonedDateTime zonedDateTime = dateTime.atZone(systemZone);

            // If system timezone is IST → convert to Chicago
            if (systemZone.getId().contains("Asia")) {
                ZoneId chicagoZone = ZoneId.of("America/Chicago");
                zonedDateTime = zonedDateTime.withZoneSameInstant(chicagoZone);
            }

            // Format only time HH:mm
            value = zonedDateTime.format(DateTimeFormatter.ofPattern("M/d/yyyy, hh:mm a"));
        }
        DriverInstance.setVariable(arg2,value);
    }

    @Then("Set {string} minus {string} hours time onto {string}")
    public void setMinusHoursTimeOnto(String arg0, String arg1, String arg2) {

        if(arg0.contains("SysData"))
        {
            arg0= DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        LocalTime time = LocalTime.parse(arg0,
                DateTimeFormatter.ofPattern("HH:mm"));
        // Subtract 2 hours
        LocalTime updatedTime = time.minusHours(Integer.parseInt(arg1));
        String formattedTime = updatedTime.format(
                DateTimeFormatter.ofPattern("HH:mm"));
        System.out.println(formattedTime);
        DriverInstance.setVariable(arg2, formattedTime);

    }


    @Then("Wait for url Change from {string}")
    public void waitForUrlChangeFrom(String arg0) {
        webDriver.WaitForCurrentURLChange(DriverInstance.getVariable(arg0));
    }

    @Then("Wrap {string} in one line")
    public void wrapInOneLine(String arg0) {
        DriverInstance.setVariable(arg0, DriverInstance.getVariable(arg0).replaceAll("\\R+", " ").trim());
    }



    @Then("Verify {string} Details")
    public void verifyDetails(String arg0, DataTable dt) throws InterruptedException, DocumentException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("{paramlink}",arg0)));
        webDriver.waitForElementLoad(1);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            for (Map.Entry<String, String> entry : details.entrySet()) {
                WebElement el = webDriver.passwebelement(PageObject.getlocator("GetValuebyDataLabel").replace("{paramlink1}",arg0).replace("{paramlink2}", entry.getKey()));
                System.out.println("Locators : "+PageObject.getlocator("GetValuebyDataLabel").replace("{paramlink1}",arg0).replace("{paramlink2}", entry.getKey()));
                String Value = el.getAttribute("data-cell-value");
                if(entry.getValue().trim().equalsIgnoreCase("Integer"))
                {
                    Assert.assertTrue(isInteger(Value));
                }
                else if(entry.getKey().trim().contains("Run Time")) {
                    webDriver.waitUntilElementIsVisible(PageObject.getlocator("GetJobDetails").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", arg0));
                    String value = webDriver.GetText(webDriver.passwebelement(PageObject.getlocator("GetJobDetails").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", arg0)));
                    if (entry.getKey().equalsIgnoreCase("Previous Run Time")) {
                        DriverInstance.setVariable("Actual_Previous_Run_Time", value);
                        webDriver.ToleranceTime(value, DriverInstance.getVariable("Previous_Run_Time"), "M/d/yyyy, hh:mm a");
//                        webDriver.ToleranceTime(value, DriverInstance.getVariable("Previous_Run_Time"), "dd/MM/yyyy, hh:mm a");
                    }
                    else {
                        if (isInteger(entry.getValue())) {
                            webDriver.ToleranceTime(value, AddMinutes(DriverInstance.getVariable("Actual_Previous_Run_Time"), entry.getValue().trim()), "M/d/yyyy, hh:mm a");
                        }
                        else if (entry.getValue().contains("08:00"))
                            {
                                ZoneId CHICAGO_ZONE = ZoneId.of("America/Chicago");
                                ZoneId IST_ZONE = ZoneId.of("Asia/Calcutta");
                                DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("M/d/yyyy, hh:mm a");
                                // Current time in Chicago (DST handled automatically)
                                ZonedDateTime now = ZonedDateTime.now(CHICAGO_ZONE);

                                // Define today's slots in Chicago time
                                ZonedDateTime today8am = ZonedDateTime.of(
                                        now.toLocalDate(),
                                        LocalTime.of(8, 0),
                                        CHICAGO_ZONE
                                );

                                ZonedDateTime today12pm = ZonedDateTime.of(
                                        now.toLocalDate(),
                                        LocalTime.of(12, 0),
                                        CHICAGO_ZONE
                                );

                                ZonedDateTime today4pm = ZonedDateTime.of(
                                        now.toLocalDate(),
                                        LocalTime.of(16, 0),
                                        CHICAGO_ZONE
                                );

                                ZonedDateTime today8pm = ZonedDateTime.of(
                                        now.toLocalDate(),
                                        LocalTime.of(20, 0),
                                        CHICAGO_ZONE
                                );

                                ZonedDateTime result;

                                // Decide next available slot
                                if (now.isBefore(today8am)) {
                                    result = today8am;

                                } else if (now.isAfter(today8am)&&now.isBefore(today12pm)) {
                                    result = today12pm;

                                }
                                else if (now.isAfter(today12pm)&&now.isBefore(today4pm)) {
                                    result = today4pm;

                                }
                                else if (now.isAfter(today4pm)&&now.isBefore(today8pm)) {
                                    result = today8pm;

                                }

                                else {
                                    // after 8 PM → next day 8 AM
                                    result = ZonedDateTime.of(
                                            now.plusDays(1).toLocalDate(),
                                            LocalTime.of(8, 0),
                                            CHICAGO_ZONE
                                    );
                                }
                                // Convert to IST (or any system timezone if needed)
                                ZoneId userZone = ZoneId.systemDefault();
                                if (userZone.equals(IST_ZONE)) {
                                    result = result.withZoneSameInstant(IST_ZONE);
                                }
                                String ExpectedTime = result.format(FORMATTER);
                                System.out.println(ExpectedTime);
                                webDriver.ToleranceTime(value, ExpectedTime, "M/d/yyyy, hh:mm a");
                            }
                        else if (entry.getValue().contains("1>12:00 AM")) {
                            ZoneId CHICAGO_ZONE = ZoneId.of("America/Chicago");
                            ZoneId IST_ZONE = ZoneId.of("Asia/Calcutta");
                            DateTimeFormatter FORMATTER =
                                    DateTimeFormatter.ofPattern("M/d/yyyy, hh:mm a");
                            ZonedDateTime now = ZonedDateTime.now(CHICAGO_ZONE);
                            ZonedDateTime result;
                                // Tomorrow 12:00 AM Chicago
                                result = ZonedDateTime.of(
                                        now.plusDays(1).toLocalDate(),
                                        LocalTime.MIDNIGHT,
                                        CHICAGO_ZONE
                                );

                            // Convert to IST (or any system timezone if needed)
                            ZoneId userZone = ZoneId.systemDefault();
                            if (userZone.equals(IST_ZONE)) {
                                result = result.withZoneSameInstant(IST_ZONE);
                            }
                            String expectedTime = result.format(FORMATTER);
                            System.out.println(expectedTime);
                            webDriver.ToleranceTime(value, expectedTime, "M/d/yyyy, hh:mm a");
                        }
                        else{
                            Assert.fail("This Next Day Time is not correct - Please check");
                        }
                    }
                }
                else{
                        webDriver.Stringcomparator(Value, entry.getValue().trim());
                    }


            }
        }
    }
    public static String AddMinutes(String input,String Minutes) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("M/d/yyyy, hh:mm a");
        LocalDateTime dateTime = LocalDateTime.parse(input, formatter);
        LocalDateTime result = dateTime.plusMinutes(Integer.parseInt(Minutes));
        String output = result.format(formatter);
        System.out.println(output); // 6/10/2026, 04:11 PM
        return output;
    }
    public static boolean isInteger(String str) {
        return str != null && str.matches("-?\\d+");
    }

    @Then("Delete All Scheduled Job")
    public void deleteAllScheduledJob() throws Exception {
        Field_Set fs = new Field_Set(DriverInstance);
        DriverInstance.setVariable("ScheduledJOB", "NA");
        webDriver.waitForElementLoad(10);
        int count = webDriver.getwebelementscount(PageObject.getlocator("AllScheduledJob").replace("[{index}]", ""));
        if (count > 0) {
            fs.openFromSetupIcon("Setup");
            cm.switchWindow();
            cm.searchAndSelectFromQuickSearch("Scheduled Job");
            int ActiveJob;
            do {
                webDriver.scrollUpWithJS(4);
                cm.switchToFrameByTitle("All Scheduled Jobs ~ Salesforce - Enterprise Edition");
                ActiveJob = webDriver.getwebelementscount(PageObject.getlocator("DeleteJob2"));
                webDriver.ScrollIntoView(webDriver.passwebelement(PageObject.getlocator("DeleteJob2")));
                webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(PageObject.getlocator("DeleteJob2")));
                webDriver.Clickon(webDriver.getwebelement(PageObject.getlocator("DeleteJob2")));
                Thread.sleep(800);
                webDriver.acceptAlert();
                Thread.sleep(2000);
                webDriver.SwitchToParentFrame();
                webDriver.Refresh();
            }
            while (ActiveJob != 1);
            webDriver.closeAndSwitchToPrevious();
            webDriver.waitForElementLoad(1);
        }

    }
    @Then("Verify {string} is null or Empty")
    public void verifyIsNullOrEmpty(String arg0) {
        String val = DriverInstance.getVariable(arg0);
        if(!val.isBlank())
        {
            Assert.fail(arg0 + " should be null but getting value here");
        }
    }
    @Then("Verify {string} is Not null or Empty")
    public void verifyIsNotNullOrEmpty(String arg0) {
        String val = DriverInstance.getVariable(arg0);
        if(val.isBlank())
        {
            Assert.fail(arg0 + " should be Not null but getting null value");
        }
    }

    @Then("Verify {string} has numeric value")
    public void verifyHasNumericValue(String arg0) {
       String Value = DriverInstance.getVariable(arg0);
        try {
            Integer.parseInt(Value);
            System.out.println("Numeric value");
        } catch (NumberFormatException e) {
            System.out.println("Not numeric");
            Assert.fail(arg0+ "is not numeric value - "+Value);
        }
    }

    @Then("Scroll On Modal")
    public void scrollOnModal() {
        webDriver.ScrollOnModal();
    }

    @Then("Navigate to set up Page {string}")
    public void navigateToSetUpPage(String arg0) throws Exception {
        String url = PropReader.get("application_url");
        DriverInstance.setVariable("SetupPage", url.replace(".com", arg0));
        cm.navigateStoredURL("SetupPage");
    }

    @Then("Convert {string} into Single Line String")
    public void convertIntoSingleLineString(String arg0) {
        String singleLine = DriverInstance.getVariable(arg0)
                .replace("\n", "")
                .replace("\r", "")
                .replace("\"", "\\\"");
        System.out.println(singleLine);
        DriverInstance.setVariable(arg0,singleLine);
    }

    @Then("Set Page url for {string} into {string}")
    public void setPageUrlForInto(String arg0, String arg1) {
        String url = PropReader.get("application_url");
        DriverInstance.setVariable(arg1, url.replace(".com", arg0));

    }
}