package pageHelper.Test.TMS.Load;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pageHelper.Utility.CommonFunction;
import pageHelper.Utility.Common_Steps;
import pageHelper.Utility.Common_Steps_Frame;
import pageHelper.bddDriver;
import utils.ColorUtils;
import utils.PropertyReader;
import utils.TableVerifier;
import utils.xmlreader;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import java.time.ZonedDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

@Log4j
public class Load_Financial {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader xml1;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    public Load_Financial(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("TMS" + File.separator + "Load" + File.separator + "Load_Financial.xml");
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        xml1 = new xmlreader("Generics" + File.separator + "CommonFrame.xml");
    }
    @Then("Verify Table {string} With Details")
    public void verifyTableWithDetails(String arg0,DataTable dt) throws DocumentException, InterruptedException {
        String tableXpath = xml.getlocator("TableNameWithDataComponantID").replace("{paramlink}",arg0);
        List<Map<String, String>> expectedData = dt.asMaps(String.class, String.class);
        TableVerifier verifier = new TableVerifier(bddDriver.getWebDriver());
        // Specify which columns to verify — customize as needed
        List<String> columnsToVerify = new ArrayList<>(dt.row(0));
        verifier.verifyFinancialTableDetails(tableXpath, expectedData, columnsToVerify);
    }
    @Then("Click on button with Title Text {string}")
    public void clickOnButtonWithTitle(String arg0) throws DocumentException, InterruptedException {
        try {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("WithTitleButton").replace("{paramlink}", arg0)));
            webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("WithTitleButton").replace("{paramlink}", arg0)));
        }
        catch (Exception e1)
        {
            webDriver.waitForElementLoad(2);
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("WithTitleButton").replace("{paramlink}", arg0)));
            webDriver.WaitforElementtobeclickable(xml.getlocator("WithTitleButton").replace("{paramlink}", arg0));
            webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("WithTitleButton").replace("{paramlink}", arg0)));

        }
    }

    @Then("Verify Title {string} Field value is set to {string} on {string}")
    public void verifyTitleFieldValueIsSetToOn(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException {
        String fieldName = webDriver.passwebelement(xml.getlocator("VerifyCombobox").replace("{paramlink1}",arg0).replace("{paramlink2}", arg2)).getAttribute("for");
        System.out.println(fieldName);
        WebElement element = webDriver.passwebelement(xml.getlocator("FormFields").replace("{paramlink}", fieldName));
        webDriver.ScrollIntoView(element);
        String ActualText = webDriver.Getattribute(element, "data-value");
        webDriver.Partialstringcomparator(ActualText, arg1);
    }
    @Then("Select Title {string} Field value as {string} on {string}")
    public void SelectFieldValueIsSetToOn(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException {

        String fieldName = webDriver.passwebelement(xml.getlocator("VerifyCombobox").replace("{paramlink1}",arg0).replace("{paramlink2}", arg2)).getAttribute("for");
        System.out.println(fieldName);
        WebElement element = webDriver.passwebelement(xml.getlocator("FormFields").replace("{paramlink}", fieldName));
        webDriver.ScrollIntoView(element);
        webDriver.waitForElementLoad(1);
        webDriver.ClickOnElement(element);
        webDriver.waitForElementLoad(2);
        webDriver.ClickOnElement(webDriver.passwebelement(xml.getlocator("SpanText").replace("{paramlink}",arg1)));
    }
    @Then("Verify Title button {string} is displaying with Object {string}")
    public void verifyTitleButton(String arg0, String arg2) throws DocumentException, InterruptedException {
        webDriver.verifyElementToBePresent(xml.getlocator("VerifyButtonTitlewithCustom").replace("{paramlink1}",arg0).replace("{paramlink2}", arg2));
    }
    @Then("Click on Title button {string} is displaying with Object {string}")
    public void ClickTitleButton(String arg0, String arg2) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("VerifyButtonTitlewithCustom").replace("{paramlink1}",arg0).replace("{paramlink2}", arg2)));
        webDriver.waitUntilElementIsVisible(xml.getlocator("VerifyButtonTitlewithCustom").replace("{paramlink1}",arg0).replace("{paramlink2}", arg2));
        webDriver.ClickOnElement(webDriver.passwebelement(xml.getlocator("VerifyButtonTitlewithCustom").replace("{paramlink1}",arg0).replace("{paramlink2}", arg2)));
    }
    @Then("Verify and get Updated On {string} is displaying with Object {string}")
    public void verifyTextWithCustom(String arg0,String arg2) throws DocumentException, InterruptedException {
        String Text;
         if(arg0.contains("Date=>"))
         {
             String now = LocalDateTime.now()
                     .format(DateTimeFormatter.ofPattern("M/d/yyyy"));
             Text = webDriver.getText(webDriver.passwebelement(xml.getlocator("VerifyUpdatewithCustom").replace("{paramlink2}", arg2)));
             webDriver.Partialstringcomparator(Text,"Updated "+now);
         }
         else if(arg0.contains("SysData=>")) {
             String DateText = DriverInstance.getVariable(arg0.split("=>")[1]).replace("Updated","").trim();
             Text = webDriver.getText(webDriver.passwebelement(xml.getlocator("VerifyUpdatewithCustom").replace("{paramlink2}", arg2))).replaceAll("\\s+", " ");;
//             webDriver.Partialstringcomparator(Text, DateText);
             Assert.assertTrue(
                     isTimeWithinTolerance(Text, DateText, 10),
                     "❌ Time mismatch beyond tolerance.\nExpected: "
                             + DateText + "\nActual: " + Text
             );
         }
         else {
             Text = webDriver.getText(webDriver.passwebelement(xml.getlocator("VerifyUpdatewithCustom").replace("{paramlink2}", arg2)));
             webDriver.Partialstringcomparator(Text, arg0);
         }
         DriverInstance.setVariable("UpdatedOn",Text);

    }
    public boolean isTimeWithinTolerance(String uiText,
                                         String expectedText,
                                         long toleranceSeconds) {

        DateTimeFormatter formatter =
                DateTimeFormatter.ofPattern("M/d/yyyy, h:mm:ss a");

        // Clean text
        uiText = uiText.replace("Updated", "").trim();
        expectedText = expectedText.replace("Updated", "").trim();

        LocalDateTime uiTime =
                LocalDateTime.parse(uiText, formatter);

        LocalDateTime expectedTime =
                LocalDateTime.parse(expectedText, formatter);

        long diff = Math.abs(
                ChronoUnit.SECONDS.between(expectedTime, uiTime)
        );

        return diff <= toleranceSeconds;
    }

    @Then("Store current Time in format of {string} on to {string}")
    public void storeCurrentTimeInFormatOfOnTo(String arg0, String arg1) {

        String Time = LocalDateTime.now().format(
                DateTimeFormatter.ofPattern(arg0,Locale.ENGLISH)).toUpperCase(Locale.ENGLISH);;
        System.out.println(Time);
        DriverInstance.setVariable(arg1,Time);
    }
    @Then("Store current Chicago Time in format of {string} on to {string}")
    public void storeCurrentChicagoTimeInFormatOfOnTo(String format, String variableName) {

        String time = LocalDateTime.now(
                        ZoneId.of("America/Chicago"))
                .format(DateTimeFormatter.ofPattern(format, Locale.ENGLISH));

        System.out.println(time);

        DriverInstance.setVariable(variableName, time);
    }

    @Then("Store current Time plus {string} hrs in format of {string} on to {string}")
    public void storeCurrentTimeInFormatPlusHours(String hrs, String arg0, String UpdatedTime) {

        ZonedDateTime chicagoTime = ZonedDateTime
                .now(ZoneId.of("America/Chicago"))
                .plusHours(Integer.parseInt(hrs));

        String Time = chicagoTime.format(DateTimeFormatter.ofPattern(arg0));

        System.out.println("Updated Time is: "+Time);
        DriverInstance.setVariable(UpdatedTime, Time);
    }


    @Then("Verify {string} is Greater than Zero")
    public void verifyIsGreaterThanZero(String arg0) {
        if(arg0.contains("SysData=>")) {
            arg0 = DriverInstance.getVariable(arg0.split("=>")[1]);
        }

        BigDecimal amount = new BigDecimal(
                arg0.replaceAll("[^0-9.-]", "")
        );

        Assert.assertTrue(
                amount.compareTo(BigDecimal.ZERO) > 0,
                "❌ Amount is not greater than zero: " + arg0
        );
    }

    @Then("Verify {string} is Zero")
    public void verifyIsZero(String arg0) {
        if(arg0.contains("SysData=>")) {
            arg0 = DriverInstance.getVariable(arg0.split("=>")[1]);
        }

        BigDecimal amount = new BigDecimal(
                arg0.replaceAll("[^0-9.-]", "")
        );

        Assert.assertTrue(
                amount.compareTo(BigDecimal.ZERO) == 0,
                "❌ Amount is not greater than zero: " + arg0
        );
    }

    @Then("Verify Highlight Color of {string} is {string}")
    public void verifyHighlightColorOrIs(String arg0, String arg1) throws DocumentException, InterruptedException {
        WebElement wl2 = webDriver.getwebelement(pageObject.getlocator("Margincolor").replace("{paramlink}", arg0));
        String imgbackgroundcolor=wl2.getCssValue("background-color");
        String BGhex1 = org.openqa.selenium.support.Color.fromString(imgbackgroundcolor).asHex();
        java.awt.Color bgcolor1 = java.awt.Color.decode(BGhex1);
        System.out.println("Background Color is: "+bgcolor1);
        System.out.println("RGB: " + bgcolor1.getRed() + "," + bgcolor1.getGreen() + "," + bgcolor1.getBlue());
        String colorName1 = ColorUtils.getClosestColorName(
                bgcolor1.getRed(), bgcolor1.getGreen(), bgcolor1.getBlue());
        System.out.println("Color Name: " + colorName1);
        webDriver.Stringcomparator(colorName1,arg1);
    }

    @Then("Store {string} Tax Amount on to {string}")
    public void storeTaxAmountOnTo(String arg0, String arg1) throws DocumentException, InterruptedException {
         if(arg0.equalsIgnoreCase("1"))
         {
             arg0 = "2";
         }
         else{
             arg0 = "4";
         }
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("VerifyTaxAmount").replace("{index}",arg0)));
        String Tax= webDriver.GetText(webDriver.passwebelement(pageObject.getlocator("VerifyTaxAmount").replace("{index}",arg0)));
        DriverInstance.setVariable(arg1,Tax);


    }

    @Then("Add New Exchange Rate with Start Date as {string} and CAD as {string}")
    public void addNewExchangeRateWithStartDateAsAndCADAs(String arg0, String arg1) throws Exception {
        if (arg0.contains("SysData")) {
            arg0 = DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        if (arg1.contains("SysData")) {
            arg1 = DriverInstance.getVariable(arg1.split("=>")[1]);
        }
        webDriver.SendKeys(webDriver.passwebelement(xml1.getlocator("FormFields").replace("{paramlink}","StartDate")),arg0 );
        webDriver.SendKeys(webDriver.passwebelement(xml1.getlocator("FormFields").replace("{paramlink}","ConversionRateCAD")),arg1);
        Common_Steps_Frame cmf = new Common_Steps_Frame(DriverInstance);
        cmf.clickOnButtonWithTitle("Save");
        webDriver.waitForElementLoad(2);
        if(webDriver.getwebelementscount(xml1.getlocator("FormFields").replace("{paramlink}","errorDiv_ep"))>0)
        {
            cmf.clickOnButtonWithTitle("Cancel");
        }
    }

    public void DeleteCurrencyDate(String Date) throws Exception {
          if(Date.contains("SysData"))
          {
              Date= DriverInstance.getVariable(Date.split("=>")[1]);
          }
        webDriver.ScrollIntoView(webDriver.passwebelement(xml1.getlocator("DeleteCurrency").replace("{paramlink}",Date)));
        webDriver.waitforElementtobeclickable(xml1.getlocator("DeleteCurrency").replace("{paramlink}",Date));
        webDriver.safeJavaScriptClick(webDriver.passwebelement(xml1.getlocator("DeleteCurrency").replace("{paramlink}",Date)));
    }
}