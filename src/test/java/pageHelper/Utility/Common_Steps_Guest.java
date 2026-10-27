package pageHelper.Utility;

import Listner.ToastContext;
import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.devtools.HasDevTools;
import org.openqa.selenium.support.ui.Select;
import org.testng.Assert;
import pageHelper.bddDriver;
import utils.ColorUtils;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Log4j
public class Common_Steps_Guest {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader Guest;
    public PropertyReader propertyReader = new PropertyReader();

    public Common_Steps_Guest(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        System.out.println("this.DriverInstance");
        webDriver = new baseDriverHelper(bddDriver.getGuestDriver());
        xml=new xmlreader("Generics"+ File.separator+"CommonFrame.xml");
        Guest=new xmlreader("Generics"+ File.separator+"CommonGuest.xml");
    }
    private void refreshDriver() {
        webDriver = new baseDriverHelper(bddDriver.getGuestDriver());
    }
    @Then("Guest - Click on button with Title {string}")
    public void clickOnButtonWithTitle(String arg0) throws DocumentException, InterruptedException {
        if (arg0.contains("SysData=>")) {
            arg0 = DriverInstance.getVariable(arg0.split("=>")[1]);
        }
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("WithTitle").replace("{paramlink}", arg0)));
            webDriver.WaitforElementtobeclickable(xml.getlocator("WithTitle").replace("{paramlink}", arg0));
            webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("WithTitle").replace("{paramlink}", arg0)));
    }
    @Then("Guest - Click on button with Text {string}")
    public void clickOnButtonWithText(String arg0) throws Exception {

        if (arg0.contains("SysData")) {
            String Value = arg0.split("=>")[1];
            arg0 = DriverInstance.getVariable(Value);
        }
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Global_Text").replace("{paramlink}", arg0)));
        webDriver.WaitforElementtobeclickable(xml.getlocator("Global_Text").replace("{paramlink}", arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("Global_Text").replace("{paramlink}", arg0)));
    }
    @Then("Guest - Click on Upload Modal button with Text {string}")
    public void clickOnUploadModalButtonWithText(String arg0) throws Exception {
        String locator = Guest.getlocator("UploadModalButton").replace("{paramlink}", arg0);
        webDriver.waitUntilElementIsVisible(locator);
        WebElement uploadModalButton = webDriver.getwebelement(locator);
        webDriver.ScrollIntoView(uploadModalButton);
        webDriver.Clickon(uploadModalButton);
    }
    @Then("Guest - Click on Stop 2 button with Text {string}")
    public void clickOnStop2ButtonWithText(String arg0) throws Exception {
        String locator = Guest.getlocator("Stop2Button").replace("{paramlink}", arg0);
        webDriver.waitUntilElementIsVisible(locator);
        WebElement stop2Button = webDriver.getwebelement(locator);
        webDriver.ScrollIntoView(stop2Button);
        webDriver.Clickon(stop2Button);
    }

    @Then("Guest - Click RFQ Search Button")
    public void clickRfqSearchButton() throws Exception {
        String locator = Guest.getlocator("RFQSearchButton");
        WebElement button = webDriver.getwebelement(locator);
        if (button == null) {
            throw new AssertionError("RFQ Load Board Search button was not found.");
        }
        webDriver.ScrollIntoView(button);
        webDriver.WaitforElementtobeclickable(locator);
        webDriver.ClickOnElement(button);
        webDriver.waitForElementLoad(5);
    }

    @Then("Guest - Verify Text displaying as {string}")
    public void verifyMessageAreDisplayingAs(String arg0) throws DocumentException, InterruptedException {
        if(arg0.contains("SysData")){
            arg0 = DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        webDriver.waitUntilElementIsVisible(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg0));
        webDriver.verifyElementToBePresent(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg0));
    }
    @Then("Guest - Verify Error Message displaying as {string}")
    public void verifyErrorMessageAreDisplaying(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilTheElementIsVisible(webDriver.Errorwebelement(Guest.getlocator("VerifyMessage").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(Guest.getlocator("VerifyMessage").replace("{paramlink}", arg0));
        if (webDriver.getwebelementscount(Guest.getlocator("ErrorMessage")) > 0) {
            String errorText = webDriver.getText(webDriver.Errorwebelement(Guest.getlocator("ErrorMessage")));
            ToastContext.addExpected(errorText);
        }
        closeErrorToastMessage(arg0);
    }
    @Then("Guest - Verify Error Text displaying as {string}")
    public void verifyErrorTextAreDisplaying(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilTheElementIsVisible(webDriver.Errorwebelement(Guest.getlocator("VerifyMessage").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(Guest.getlocator("VerifyMessage").replace("{paramlink}", arg0));
        if (webDriver.getwebelementscount(Guest.getlocator("ErrorMessage")) > 0) {
            String errorText = webDriver.getText(webDriver.Errorwebelement(Guest.getlocator("ErrorMessage")));
            ToastContext.addExpected(errorText);
        }
    }
    @Then("Guest - Close Error {string} message")
    public void closeErrorToastMessage(String arg0) throws DocumentException, InterruptedException {
        int count = webDriver.getwebelementscount(Guest.getlocator("ErrorCloseToastMsg").replace("{paramlink}", arg0));
        if (count > 0) {
            try {
                webDriver.WaitforElementtobeclickable(Guest.getlocator("ErrorCloseToastMsg").replace("{paramlink}", arg0));
                webDriver.ClickOnElement(webDriver.Errorwebelement(Guest.getlocator("ErrorCloseToastMsg").replace("{paramlink}", arg0)));
            } catch (Exception e) {
                System.out.println("Toast message looks like already closed");
            }
        }
    }
    @Then("Guest - Verify Message displaying as {string}")
    public void verifyMessageAreDisplaying(String arg0) throws DocumentException, InterruptedException {
        if(arg0.contains("SysData")){
            arg0 = DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        webDriver.waitUntilElementIsVisible(xml.getlocator("VerifyMessage").replace("{paramlink}", arg0));
        webDriver.verifyElementToBePresent(xml.getlocator("VerifyMessage").replace("{paramlink}", arg0));
    }
    @Then("Guest - Verify Button displaying as {string}")
    public void verifyButtonAreDisplayingAs(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("ButtonText").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(xml.getlocator("ButtonText").replace("{paramlink}", arg0));
    }

    @Then("Guest - Verify {string} Checkbox is displaying")
    public void guestVerifyCheckboxIsDisplaying(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementToBePresent(Guest.getlocator("VerifyCheckboxLabel").replace("{paramlink}", arg0));
    }

    @Then("Guest - {string} Fleet Driver Confirmation")
    public void guestFleetDriverConfirmation(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(Guest.getlocator("FooterBtn").replace("{paramlink}", arg0)));
        webDriver.WaitforElementtobeclickable(Guest.getlocator("FooterBtn").replace("{paramlink}", arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(Guest.getlocator("FooterBtn").replace("{paramlink}", arg0)));
    }

    @Then("Guest - Verify text {string} not displaying on Page -")
    public void verifyNotDisplayingOnPage(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementNotToBePresent(xml.getlocator("Global_Text").replace("{paramlink}",arg0));
    }
    @Then("Guest - Move to Element {string}")
    public void moveToElement(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitForElementLoad(2);
        webDriver.waitUntilElementIsVisible(Guest.getlocator("InputPlaceHolder").replace("{paramlink}",arg0));
        webDriver.move_to_element(webDriver.Errorwebelement(Guest.getlocator("InputPlaceHolder").replace("{paramlink}",arg0)));
    }

    @Then("Guest - Move Element {string}")
    public void moveElement(String arg0) throws DocumentException, InterruptedException {
        refreshDriver();
        webDriver.waitForElementLoad(2);
        webDriver.waitUntilElementIsVisible(Guest.getlocator("InputPlaceHolder").replace("{paramlink}",arg0));
        webDriver.move_to_element(webDriver.getwebelement(Guest.getlocator("InputPlaceHolder").replace("{paramlink}",arg0)));
    }

    @Then("Guest - Verify Icon {string} is displaying with background color {string}")
    public void verifyIconIsDisplayingWithBackgroundColor(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(Guest.getlocator("IconName").replace("{paramlink}", arg0));
        webDriver.verifyElementToBePresent(Guest.getlocator("IconName").replace("{paramlink}", arg0));
        WebElement wl = webDriver.getwebelement(Guest.getlocator("IconName").replace("{paramlink}", arg0));
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

    @Then("Guest - Verify {string} Color with {string} Text of {string} Button is {string}")
    public void verifyColorWithTextOfButtonIs(String arg0, String arg1, String arg2, String arg3) throws DocumentException, InterruptedException {
        String Locators;
        if( arg2.charAt(arg2.length() - 2) == '_')
        {
            if (arg3.equalsIgnoreCase("disabled")) {
                Locators = "("+Guest.getlocator("VerifyButton").replace("{paramlink1}", arg2.split("_")[0]).replace("{paramlink2}", "true")+")["+arg2.charAt(arg2.length() - 1)+"]";
            } else {
                Locators = "("+Guest.getlocator("VerifyButton").replace("{paramlink1}", arg2.split("_")[0]).replace("{paramlink2}", "false")+")["+arg2.charAt(arg2.length() - 1)+"]";
            }
        }
        else {
            if (arg3.equalsIgnoreCase("disabled")) {
                Locators = Guest.getlocator("VerifyButton").replace("{paramlink1}", arg2).replace("{paramlink2}", "true");
            } else {
                Locators = Guest.getlocator("VerifyButton").replace("{paramlink1}", arg2).replace("{paramlink2}", "false");
            }
        }
        webDriver.waitUntilElementIsVisible(Locators);
        webDriver.verifyElementToBePresent(Locators);
        System.out.println(Locators);
        WebElement wl = webDriver.getwebelement(Locators);
        String color = wl.getCssValue("color");
        String BGhex = org.openqa.selenium.support.Color.fromString(color).asHex();
        java.awt.Color bgcolor = java.awt.Color.decode(BGhex);
        System.out.println(" Color is: " + bgcolor);
        String colorName = ColorUtils.getClosestColorName(
                bgcolor.getRed(), bgcolor.getGreen(), bgcolor.getBlue());
        System.out.println("Color Name: " + colorName);
        webDriver.Stringcomparator(colorName, arg1);
        String imgbackgroundcolor= webDriver.getBackgroundColorUsingJs(wl);
//        String imgbackgroundcolor = wl.getCssValue("background-color");
        String BGhex1 = org.openqa.selenium.support.Color.fromString(imgbackgroundcolor).asHex();
        java.awt.Color bgcolor1 = java.awt.Color.decode(BGhex1);
        System.out.println("Color is: " + bgcolor1);
        System.out.println("RGB: " + bgcolor1.getRed() + "," + bgcolor1.getGreen() + "," + bgcolor1.getBlue());
        String colorName1 = ColorUtils.getClosestColorName(
                bgcolor1.getRed(), bgcolor1.getGreen(), bgcolor1.getBlue());
        System.out.println("Color Name: " + colorName1);
        webDriver.Stringcomparator(colorName1, arg0);
    }

    @Then("Guest - Update details")
    public void GuestUpdateDetails( DataTable dt) throws Exception {
        updateServicesDataWithCount(dt);
    }
    public void updateServicesDataWithCount(DataTable dt) throws Exception {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                String fieldName;
                String Key = "";
                if(entry.getKey().endsWith("_2"))
                {
                    Key= entry.getKey().replace("_2","");
                    System.out.println(Key);
                    webDriver.ScrollIntoView(webDriver.passwebelement(Guest.getlocator("LabelTextWithIndex").replace("{paramlink}", Key)));
                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Guest.getlocator("LabelTextWithIndex").replace("{paramlink}", Key)));
                    fieldName = webDriver.passwebelement(Guest.getlocator("LabelTextWithIndex").replace("{paramlink}", Key)).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(Guest.getlocator("LabelTextWithIndex").replace("{paramlink}", entry.getKey()).replace("_2",""));
                }
                else{
                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Guest.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
                    fieldName = webDriver.passwebelement(Guest.getlocator("LabelText").replace("{paramlink}", entry.getKey())).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(Guest.getlocator("LabelText").replace("{paramlink}", entry.getKey()));

                }
                WebElement element = webDriver.passwebelement(Guest.getlocator("FormFields").replace("{paramlink}", fieldName));
                webDriver.ScrollIntoView(element);
                String Tag = element.getTagName();
                System.out.println(Tag);
                String type = element.getAttribute("type");
                System.out.println(type);
                String role = element.getAttribute("role");

                if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {
                    webDriver.ScrollIntoView(element);
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        if (entry.getValue().equalsIgnoreCase("Company Email")) {
                            webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                        } else if (entry.getKey().contains("Date")) {
                            if(entry.getValue().contains("/"))
                            {
                                webDriver.EnterTimeUsingJS(element, entry.getValue());
                                webDriver.Clickon(element);
                                webDriver.waitForElementLoad(1);
                            }
                            else if (entry.getValue().contains("NA"))
                            {
                                webDriver.EnterTimeUsingJS(element, "");
                                webDriver.Clickon(element);
                                webDriver.waitForElementLoad(1);
                            }
                            else {
                                webDriver.SendKeys(element, webDriver.ReturnDate(entry.getValue()));
                            }
                        }
                        else if (entry.getKey().equalsIgnoreCase("NA")) {
                            webDriver.SendKeys(element, "");
                        }
                        else if (entry.getValue().contains("SysData")) {
                            String Value = entry.getValue().split("=>")[1];
                            if(Value.contains("&"))
                            {
                                webDriver.SendKeys(element, DriverInstance.getVariable(Value.split("&")[0])+Value.split("&")[1]);

                            }
                            else {
                                webDriver.SendKeys(element, DriverInstance.getVariable(Value));
                            }
                        } else {
                            webDriver.Clear(element);
                            webDriver.EnterTextUsingJS(element, entry.getValue());
                        }
                    }
                    else{
                        webDriver.SendKeys(element, "");
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "search".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {
                    webDriver.ScrollIntoView(element);
                    if (entry.getValue().equalsIgnoreCase("Company Email")) {
                        webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                    }
                    else if (entry.getKey().contains("Date")) {
                        webDriver.SendKeys(element,webDriver.ReturnDate(entry.getValue()));
                    }
                    else if (entry.getValue().contains("SysData")) {
                        String Value = entry.getValue().split("=>")[1];
                        webDriver.SendKeys(element,DriverInstance.getVariable(Value));
                    }
                    else {
                        webDriver.SendKeys(element, entry.getValue());
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "file".equalsIgnoreCase(type)) {
                    webDriver.ScrollIntoView(element);
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty())
                    {
                        String scenarioName= DriverInstance.getScenarioName();
                        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");

                        String Root = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator;
                        String FilePath = Root + "UploadFiles" + File.separator+TID+ File.separator + entry.getValue();
                        System.out.println(FilePath);
                        webDriver.SendKeys(element,FilePath);
                    }
                }
                else if (Tag.equalsIgnoreCase("textarea")) {
                    webDriver.ScrollIntoView(element);
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty())
                    {
                        if (entry.getValue().equalsIgnoreCase("Company Email")) {
                            webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                        }
                        else if (entry.getValue().contains("SysData")) {
                            String Value = entry.getValue().split("=>")[1];
                            webDriver.SendKeys(element,DriverInstance.getVariable(Value));
                        }
                        else if(entry.getValue().isBlank()) {
                            webDriver.SendKeys(element, "");
                        }
                        else {
                            webDriver.SendKeys(element, entry.getValue());
                        }
                    }

                    else{
                        webDriver.SendKeys(element, "");
                    }

                }
                else if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && "combobox".equalsIgnoreCase(role)) {
                    webDriver.ScrollIntoView(element);
                    webDriver.waitForElementLoad(1);
                    String ActualText = webDriver.Getattribute(element, "data-value");
                    if (ActualText.equalsIgnoreCase(""))
                    {
                        if (entry.getValue().contains("SysData"))
                        {
                            String Value = DriverInstance.getVariable(entry.getValue().split("=>")[1]);
                            webDriver.SendKeys(element, Value);
                            webDriver.Clickon(element);

                            int count= webDriver.getwebelementscount(Guest.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                            if(count>0) {
                                if(Value.startsWith("L-")||entry.getKey().equalsIgnoreCase("Load")) {
                                    webDriver.waitForElementLoad(2);
                                    webDriver.waitforElementtobeclickable(Guest.getlocator("ButtonIconTitle").replace("*","lightning-base-combobox-formatted-text").replace("{paramlink}", Value));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Guest.getlocator("ButtonIconTitle").replace("*","lightning-base-combobox-formatted-text").replace("{paramlink}", Value)));
                                }
                                else {
                                    webDriver.waitForElementLoad(2);
                                    webDriver.waitforElementtobeclickable(Guest.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Guest.getlocator("ButtonIconTitle").replace("{paramlink}", Value)));
                                }
                            }
                            else{
                                webDriver.waitforElementtobeclickable(Guest.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                webDriver.ClickOnElement(webDriver.getwebelement(Guest.getlocator("SpanText").replace("{paramlink}","Show more results for")));
                                webDriver.waitforElementtobeclickable(Guest.getlocator("SelectTextRadio").replace("{paramlink}", Value));
                                webDriver.ClickOnElement(webDriver.getwebelement(Guest.getlocator("SelectTextRadio").replace("{paramlink}", Value)));
                                webDriver.waitforElementtobeclickable(Guest.getlocator("GlobalText2").replace("{paramlink}", "Select"));
                                webDriver.ClickOnElement(webDriver.getwebelement(Guest.getlocator("GlobalText2").replace("{paramlink}", "Select")));
                            }
                        }
                        else{
                            webDriver.SendKeys(element, entry.getValue());
                            if(!entry.getKey().contains("Time"))
                            {
                                webDriver.Clickon(element);
                                int count= webDriver.getwebelementscount(Guest.getlocator("ButtonIconTitleWithLabel").replace("{paramlink}", entry.getKey().replace("_2","")).replace("{paramlink2}", entry.getValue()));
                                if(count>0) {
                                    webDriver.waitforElementtobeclickable(Guest.getlocator("ButtonIconTitleWithLabel").replace("{paramlink}", entry.getKey().replace("_2","")).replace("{paramlink2}", entry.getValue()));
                                    webDriver.Clickon(webDriver.getwebelement(Guest.getlocator("ButtonIconTitleWithLabel").replace("{paramlink}", entry.getKey().replace("_2","")).replace("{paramlink2}", entry.getValue())));
                                }
                                else{
                                    int Numcount=webDriver.getwebelementscount(Guest.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                    if(Numcount==1) {
                                        webDriver.waitforElementtobeclickable(Guest.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Guest.getlocator("SpanText").replace("{paramlink}", "Show more results for")));
                                    }
                                    else{
                                        webDriver.waitforElementtobeclickable(Guest.getlocator("SpanText").replace("{paramlink}", entry.getValue()));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Guest.getlocator("SpanText").replace("{paramlink}", entry.getValue())));
                                    }
                                    webDriver.waitforElementtobeclickable(Guest.getlocator("SelectTextRadio").replace("{paramlink}", entry.getValue()));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Guest.getlocator("SelectTextRadio").replace("{paramlink}", entry.getValue())));
                                    webDriver.waitforElementtobeclickable(Guest.getlocator("GlobalText2").replace("{paramlink}", "Select"));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Guest.getlocator("GlobalText2").replace("{paramlink}", "Select")));
                                }
                            }
                        }
                    }
                    else if (ActualText.equalsIgnoreCase(entry.getValue())) {
                        System.out.println("Already selected");
                    }
                    else {
                        int flag;
                        if(entry.getKey().endsWith("_2"))
                        {
                            System.out.println(1234);
                            flag=  webDriver.getwebelementscount(Guest.getlocator("LabelClearIcon_2").replace("{paramlink}", entry.getKey().replace("_2","")));
                        }
                        else {
                            flag=  webDriver.getwebelementscount(Guest.getlocator("LabelClearIcon").replace("{paramlink}", entry.getKey()));
                        }
                        System.out.println("Flag is "+flag);
                        if(flag>0) {
                            if (entry.getKey().endsWith("_2")) {
                                System.out.println(111111);
                                webDriver.Clickon(webDriver.getwebelement(Guest.getlocator("LabelClearIcon_2").replace("{paramlink}", Key).replace("_2","")));
                            } else {
                                webDriver.ClickOnElement(webDriver.getwebelement(Guest.getlocator("LabelClearIcon").replace("{paramlink}", entry.getKey())));
                            }
                            if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                                if (entry.getValue().contains("SysData"))
                                {
                                    String Value = DriverInstance.getVariable(entry.getValue().split("=>")[1]);
                                    webDriver.SendKeys(element, Value);
                                    webDriver.Clickon(element);

                                    int count= webDriver.getwebelementscount(Guest.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                                    if(count>0) {
                                        if(Value.startsWith("L-")||entry.getKey().equalsIgnoreCase("Load")) {
                                            webDriver.waitForElementLoad(2);
                                            webDriver.waitforElementtobeclickable(Guest.getlocator("ButtonIconTitle").replace("*","lightning-base-combobox-formatted-text").replace("{paramlink}", Value));
                                            webDriver.ClickOnElement(webDriver.getwebelement(Guest.getlocator("ButtonIconTitle").replace("*","lightning-base-combobox-formatted-text").replace("{paramlink}", Value)));
                                        }
                                        else {
                                            webDriver.waitForElementLoad(2);
                                            webDriver.waitforElementtobeclickable(Guest.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                                            webDriver.ClickOnElement(webDriver.getwebelement(Guest.getlocator("ButtonIconTitle").replace("{paramlink}", Value)));
                                        }
                                    }
                                    else{
                                        webDriver.waitforElementtobeclickable(Guest.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Guest.getlocator("SpanText").replace("{paramlink}","Show more results for")));
                                        webDriver.waitforElementtobeclickable(Guest.getlocator("SelectTextRadio").replace("{paramlink}", Value));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Guest.getlocator("SelectTextRadio").replace("{paramlink}", Value)));
                                        webDriver.waitforElementtobeclickable(Guest.getlocator("GlobalText2").replace("{paramlink}", "Select"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Guest.getlocator("GlobalText2").replace("{paramlink}", "Select")));
                                    }
                                }
                                else{
                                    System.out.println(111112);
                                    webDriver.SendKeys(element, entry.getValue());
                                    webDriver.Clickon(element);
                                    int count = webDriver.getwebelementscount(Guest.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                                    if (count > 0) {
                                        webDriver.waitforElementtobeclickable(Guest.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Guest.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue())));
                                    } else {
                                        webDriver.waitforElementtobeclickable(Guest.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Guest.getlocator("SpanText").replace("{paramlink}", "Show more results for")));
                                        webDriver.waitforElementtobeclickable(Guest.getlocator("SelectTextRadio").replace("{paramlink}", entry.getValue()));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Guest.getlocator("SelectTextRadio").replace("{paramlink}", entry.getValue())));
                                        webDriver.waitforElementtobeclickable(Guest.getlocator("GlobalText2").replace("{paramlink}", "Select"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Guest.getlocator("GlobalText2").replace("{paramlink}", "Select")));
                                    }}
                            }
                        }
                        else{
                            System.out.println(111113);
                            webDriver.Clickon(element);
                            webDriver.SelectComboBoxOption(webDriver.getwebelement(Guest.getlocator("Div_aria_Label").replace("{paramlink}", entry.getKey())), webDriver.getwebelement(Guest.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                        }

                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "password".equalsIgnoreCase(type)) {
                    webDriver.SendKeys(element, entry.getValue());
                }
                else if (Tag.equalsIgnoreCase("input") && "checkbox".equalsIgnoreCase(type)) {

                    webDriver.ScrollIntoView(element);
                    if (entry.getValue().equalsIgnoreCase("False")) {
                        boolean isChecked = element.isSelected();
                        if (isChecked) {
                            try {
                                webDriver.ClickOnElement(element);
                            } catch (Exception e) {
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(Guest.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
                            }
                        }

                    }
                    else {
                        System.out.println("Man" + element.isSelected());
                        boolean isChecked = element.isSelected();
                        if (!isChecked) {
                            try {
                                webDriver.waitForElementLoad(1);
                                webDriver.safeJavaScriptClick(element);
                            } catch (Exception e) {
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(Guest.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
                            }
                        }
                    }
                }
                else if (Tag.equalsIgnoreCase("select") ) {
                    System.out.println("inn");
                    webDriver.ScrollIntoView(element);
                    webDriver.waitUntilTheElementIsVisible(element);
                    webDriver.selectOptionByText(element,entry.getValue());
                }
                else if (Tag.equalsIgnoreCase("input") && "radio".equalsIgnoreCase(type)) {
                    System.out.println("inn");
                    webDriver.ScrollIntoView(element);
                    webDriver.waitUntilTheElementIsVisible(element);
                    webDriver.ClickOnElement(element);
                }
                else if (Tag.equalsIgnoreCase("button") && "button".equalsIgnoreCase(type)) {

                    webDriver.safeJavaScriptClick(element);
                    webDriver.SelectComboBoxOption(webDriver.getwebelement(Guest.getlocator("Div_aria_Label").replace("{paramlink}", entry.getKey())), webDriver.getwebelement(Guest.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                }
            }
        }
    }

    @Then("Guest - Verify details for all Disabled or Readonly fields")
    public void verifyDetailsForDisabledService(DataTable dt) throws Exception {
       validateServicesData(dt,Boolean.FALSE,Boolean.FALSE);
    }
    public void validateServicesData(DataTable dt, Boolean isenabled, Boolean Required) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {

                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                String fieldName = webDriver.passwebelement(Guest.getlocator("LabelText").replace("{paramlink}", entry.getKey())).getAttribute("for");
                System.out.println(fieldName);
                WebElement element = webDriver.passwebelement(Guest.getlocator("FormFields").replace("{paramlink}", fieldName));
                webDriver.ScrollIntoView(element);
                String Tag = element.getTagName();

                String type = element.getAttribute("type");

                String role = element.getAttribute("role");

                if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {
                    String ActualText = webDriver.Getattribute(element, "value");
                    System.out.println("Actual Test:" + ActualText);
                    Boolean enabled = element.isEnabled();
                    Boolean readonly = Boolean.valueOf(webDriver.Getattribute(element, "readonly"));
                    System.out.println("Read only Value" + readonly);
                    System.out.println("Enable Value" + enabled);
                    System.out.println("Enable Value" + enabled);
                    Boolean actualSate = (enabled && !readonly);
                    Boolean RequiredElement = Boolean.valueOf(webDriver.Getattribute(element, "required"));
                    if (Required) {
                        Assert.assertEquals(RequiredElement, true);
                    }
                    Assert.assertEquals(actualSate, isenabled);
                    webDriver.Stringcomparator(ActualText, entry.getValue());
                }
                else if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && "combobox".equalsIgnoreCase(role)) {
                    String ActualText = webDriver.Getattribute(element, "data-value");
                    Boolean RequiredElement = Boolean.valueOf(webDriver.Getattribute(element, "required"));
                    if (Required) {
                        Assert.assertEquals(RequiredElement, true);
                    }
                    webDriver.Stringcomparator(ActualText, entry.getValue());
                }
                else if (Tag.equalsIgnoreCase("input") && "password".equalsIgnoreCase(type)) {
                    //   webDriver.SendKeys(element, DriverInstance.getThreadLocalMapValue(entry.getKey()));
//                    String ActualText = webDriver.getAttributeValueUsingJavascript(element);
                    String ActualText = webDriver.Getattribute(element, "value");
                    Assert.assertEquals(element.isEnabled(), isenabled);
                    String actualSize = "0";
                    String expectedSize = "0";
                    try {
                        actualSize = String.valueOf(ActualText.length());
                    } catch (NullPointerException e) {
                        actualSize = "0";
                    }

                    try {
                        expectedSize = String.valueOf(entry.getValue().length());
                    } catch (NullPointerException e) {
                        expectedSize = "0";
                    }
                    webDriver.Stringcomparator(actualSize, expectedSize);
//                    webDriver.Stringcomparator(ActualText, entry.getValue());
//                    Assert.assertNotNull(ActualText, "Password Fields has some value");

                    System.out.println("Current Fields:" + entry.getKey() + " is Encrypted as this is Password type Element");

                }
                else if (Tag.equalsIgnoreCase("input") && "checkbox".equalsIgnoreCase(type)) {
                    //    webDriver.SendKeys(element, DriverInstance.getThreadLocalMapValue(entry.getKey()));

                    boolean isChecked  = "true".equalsIgnoreCase(element.getAttribute("aria-checked"));
                    System.out.println( isChecked+"" +new Date());
                    if (isChecked) {
                        System.out.println("Checkbox is checked");
                    } else {
                        System.out.println("Checkbox is unchecked");
                    }
//                    Assert.assertEquals(isChecked, Boolean.valueOf(entry.getValue()));
                    Boolean RequiredElement = Boolean.valueOf(webDriver.Getattribute(element, "required"));
                    if (Required) {
                        Assert.assertEquals(RequiredElement, true);
                    }
                }
                else if (Tag.equalsIgnoreCase("button") && "button".equalsIgnoreCase(type)) {
                    String ActualText = webDriver.Getattribute(element, "data-value");
                    Boolean RequiredElement = Boolean.valueOf(webDriver.Getattribute(element, "required"));
                    if (Required) {
                        Assert.assertEquals(RequiredElement, true);
                    }
                    webDriver.Stringcomparator(ActualText, entry.getValue());
                }
                else if (Tag.equalsIgnoreCase("select") ) {
                    // Create a Select object
                    Select select = new Select(element);
                    String selectedText = select.getFirstSelectedOption().getText();
                    System.out.println("Selected Text: " + selectedText);
                    webDriver.Stringcomparator(selectedText, entry.getValue());
                }
            }
        }
    }

    @Then("Guest - RFQ Select Currency as {string}")
    public void guestRFQSelectCurrencyAs(String arg0) throws Exception {
        WebElement element = webDriver.passwebelement(Guest.getlocator("ComboxCurrency"));
        String ActualText = webDriver.Getattribute(element, "data-value");
        if(!ActualText.equalsIgnoreCase(arg0)) {
            webDriver.safeJavaScriptClick(element);
            webDriver.waitForElementLoad(1);
            webDriver.ClickOnElement(webDriver.passwebelement(Guest.getlocator("SpanText").replace("{paramlink}",arg0)));
        }
    }
    @Then("Guest - Enter Label {string} Text as {string}")
    public void enterLabelText(String arg0, String arg1) throws Exception {
        webDriver.safeJavaScriptClick(webDriver.getwebelement(Guest.getlocator("InputField").replace("{paramlink}", arg0)));
        webDriver.EnterTextUsingJS(webDriver.getwebelement(Guest.getlocator("InputField").replace("{paramlink}", arg0)),arg1);
        webDriver.waitForElementLoad(1);
    }

    @Then("Guest - Update RFQ details")
    public void updateRfqDetails(DataTable dt) throws Exception {
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (dataRows.isEmpty()) {
            return;
        }

        for (Map.Entry<String, String> entry : dataRows.get(0).entrySet()) {
            String configuredName = entry.getKey();
            String value = entry.getValue() == null ? "" : entry.getValue().trim();
            String fieldName = resolveRfqFieldName(configuredName);

            WebElement input = webDriver.passwebelement(
                    Guest.getlocator("RFQInputByField").replace("{paramlink}", fieldName));
            if (input != null) {
                webDriver.safeJavaScriptClick(input);
                webDriver.Clear(input);
                if (!value.equalsIgnoreCase("NA") && !value.equalsIgnoreCase("NULL")
                        && !value.isEmpty()) {
                    String inputValue = fieldName.toLowerCase().contains("date")
                            ? webDriver.ReturnDate(value)
                            : value;
                    webDriver.EnterTextUsingJS(input, inputValue);
                }
                continue;
            }

            WebElement combobox = webDriver.passwebelement(
                    Guest.getlocator("RFQComboboxByField").replace("{paramlink}", fieldName));
            if (combobox != null) {
                String currentValue = combobox.getAttribute("data-value");
                if (!currentValue.equalsIgnoreCase(value)) {
                    webDriver.ClickOnElement(combobox);
                    WebElement option = webDriver.getwebelement(
                            Guest.getlocator("RFQComboboxOption").replace("{paramlink}", value));
                    if (option == null) {
                        throw new AssertionError("RFQ combobox option was not found: " + value);
                    }
                    webDriver.ClickOnElement(option);
                }
                continue;
            }

            WebElement mode = webDriver.passwebelement(
                    Guest.getlocator("RFQModeCheckbox").replace("{paramlink}", configuredName));
            if (mode != null) {
                boolean expected = Boolean.parseBoolean(value);
                boolean actual = mode.isSelected()
                        || "true".equalsIgnoreCase(mode.getAttribute("aria-checked"));
                if (actual != expected) {
                    webDriver.ClickOnElement(mode);
                }
                continue;
            }

            throw new AssertionError("RFQ field was not found: " + configuredName);
        }
        webDriver.waitForElementLoad(1);
    }

    @Then("Guest - Click on Label {string}")
    public void ClickOnLabelText(String arg0) throws Exception {
        webDriver.Clickon(webDriver.getwebelement(Guest.getlocator("InputField").replace("{paramlink}", arg0)));
        webDriver.waitForElementLoad(1);
    }

    @Then("Guest - Verify Pay Estimate details")
    public void verifyPayEstimateDetails(DataTable dataTable) throws Exception {
        List<Map<String, String>> expectedRows = dataTable.asMaps(String.class, String.class);
        for (Map<String, String> expectedValues : expectedRows) {
            String estimatedPayAmount = expectedValues.get("Estimated Pay Amount");
            if (estimatedPayAmount != null && estimatedPayAmount.contains("SysData=>")) {
                String sysDataKey = estimatedPayAmount.split("=>", 2)[1].trim();
                estimatedPayAmount = DriverInstance.getVariable(sysDataKey);
            }
            String qty = expectedValues.get("Qty");
            if (qty != null && qty.contains("SysData=>")) {
                String sysDataKey = qty.split("=>", 2)[1].trim();
                qty = DriverInstance.getVariable(sysDataKey);
            }
            String type = expectedValues.get("Type");
            if (type == null || type.trim().isEmpty()) {
                throw new AssertionError("Type is required to identify the Pay Estimate row.");
            }
            type = type.trim();
            String rowXpath = xml.getlocator("PayEstimateRowByType").replace("{paramlink1}", type);
            System.out.println("====================================");
            System.out.println("Verifying Pay Estimate Row");
            System.out.println("Type = [" + type + "]");
            System.out.println("Row XPath = [" + rowXpath + "]");
            List<WebElement> matchingRows = webDriver.getwebelements(rowXpath);
            System.out.println("Matching rows for Type [" + type + "] = " + matchingRows.size());

            if (matchingRows.isEmpty()) {
                throw new AssertionError("Pay Estimate row with Type '" + type + "' was not found.");
            }
            WebElement row = matchingRows.get(0);

            List<WebElement> cells = row.findElements(By.tagName("td"));
            String[] columnNames = expectedValues.keySet().toArray(new String[0]);
            for (int i = 0; i < cells.size() && i < columnNames.length; i++) {
                String columnName = columnNames[i];
                String expectedValue = expectedValues.get(columnName);
                if ("Qty".equals(columnName)) {
                    expectedValue = qty;
                }

                if ("Estimated Pay Amount".equals(columnName)) {
                    expectedValue = estimatedPayAmount;
                }

                if ("NA".equalsIgnoreCase(expectedValue)) {
                    continue;
                }

                WebElement cell = cells.get(i);

                String actualValue = webDriver.Getattribute(cell, "value");

                if (actualValue == null || actualValue.trim().isEmpty()) {
                    actualValue = webDriver.getText(cell);
                }

                actualValue = actualValue == null
                        ? ""
                        : actualValue.trim();

                expectedValue = expectedValue == null
                        ? ""
                        : expectedValue.trim();

                if (expectedValue.isEmpty()) {

                    if (!actualValue.isEmpty()) {
                        throw new AssertionError(
                                "Pay Estimate verification failed"
                                        + "\nType: " + type
                                        + "\nColumn: " + columnName
                                        + "\nExpected: BLANK"
                                        + "\nActual: " + actualValue);
                    }
                    continue;
                }
                if (!actualValue.equals(expectedValue)) {
                    throw new AssertionError(
                            "Pay Estimate verification failed"
                                    + "\nType: " + type
                                    + "\nColumn: " + columnName
                                    + "\nExpected: " + expectedValue
                                    + "\nActual: " + actualValue
                    );
                }
                System.out.println("Verified: " + columnName + " = " + actualValue);
            }
        }
    }

    @Then("Guest - Click on {string} {string} text")
    public void clickOnStopStatusStage(String arg0,String arg1) throws Exception {

        String locator = Guest.getlocator("secondelement")
                .replace("{paramlink}", arg1).replace("{index}",arg0);

        webDriver.WaitforElementtobeclickable(locator);

        WebElement element = webDriver.getwebelement(locator);

        if (element == null) {
            throw new Exception("Stop Status Stage not found: " + arg0);
        }

        webDriver.ScrollIntoView(element);

        webDriver.safeJavaScriptClick(element);
    }

    @Then("Guest - Verify RFQ filter values")
    public void verifyGuestRfqFilterValues(DataTable dt) throws Exception {
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (dataRows.isEmpty()) {
            return;
        }

        for (Map.Entry<String, String> entry : dataRows.get(0).entrySet()) {
            String fieldName = resolveRfqFieldName(entry.getKey());
            WebElement field = webDriver.passwebelement(
                    Guest.getlocator("RFQInputByField").replace("{paramlink}", fieldName));
            boolean combo = false;
            if (field == null) {
                field = webDriver.passwebelement(
                        Guest.getlocator("RFQComboboxByField").replace("{paramlink}", fieldName));
                combo = true;
            }
            if (field == null) {
                throw new AssertionError("RFQ field was not found: " + fieldName);
            }

            String actual = combo ? field.getAttribute("data-value") : field.getAttribute("value");
            String expected = entry.getValue();
            if (expected == null || "NA".equalsIgnoreCase(expected)
                    || "NULL".equalsIgnoreCase(expected)) {
                expected = "";
            } else if (fieldName.toLowerCase().contains("date") && expected.matches("-?\\d+")) {
                expected = webDriver.ReturnDateInSpecifiedFormat(expected, "MMM dd, yyyy");
            }

            actual = actual == null ? "" : actual.trim();
            expected = expected.trim();
            if (!actual.equalsIgnoreCase(expected)) {
                throw new AssertionError("RFQ field value mismatch for '" + fieldName
                        + "'. Expected: '" + expected + "', Actual: '" + actual + "'");
            }
        }
    }

    private String resolveRfqFieldName(String fieldName) {
        String normalized = fieldName.trim().toLowerCase();
        switch (normalized) {
            case "pickup country":
                return "fromCountry";
            case "pickup city":
                return "fromCity";
            case "pickup state/province":
                return "fromStateProvince";
            case "pickup postal code":
                return "fromPostalCode";
            case "pickup search type":
                return "fromSearchType";
            case "pickup distance":
                return "fromSearchDistance";
            case "pickup units":
                return "fromSearchUnits";
            case "dropoff country":
                return "toCountry";
            case "dropoff city":
                return "toCity";
            case "dropoff state/province":
                return "toStateProvince";
            case "dropoff postal code":
                return "toPostalCode";
            case "dropoff search type":
                return "toSearchType";
            case "ship date":
                return "shipDate";
            case "delivery date":
                return "deliveryDate";
            case "max weight":
                return "weight";
            case "weight units":
                return "weightUnits";
            default:
                return fieldName;
        }
    }

    @Then("Guest - Verify RFQ empty fields have no placeholder")
    public void verifyGuestRfqEmptyFieldsHaveNoPlaceholder(DataTable dt) throws Exception {
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (dataRows.isEmpty()) {
            return;
        }

        for (String configuredName : dataRows.get(0).keySet()) {
            String fieldName = resolveRfqFieldName(configuredName);
            WebElement field = webDriver.passwebelement(
                    Guest.getlocator("RFQInputByField").replace("{paramlink}", fieldName));
            if (field == null) {
                field = webDriver.passwebelement(
                        Guest.getlocator("RFQComboboxByField").replace("{paramlink}", fieldName));
            }
            if (field == null) {
                throw new AssertionError("RFQ field was not found: " + configuredName);
            }

            String placeholder = field.getAttribute("placeholder");
            String text = field.getText();
            if ((placeholder != null && !placeholder.trim().isEmpty())
                    || (text != null && !text.trim().isEmpty())) {
                throw new AssertionError("Placeholder or visible text is rendered for empty RFQ field: "
                        + configuredName);
            }
        }
    }

    @Then("Guest - Verify RFQ mode states")
    public void verifyGuestRfqModeStates(DataTable dt) throws Exception {
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (dataRows.isEmpty()) {
            return;
        }

        for (Map.Entry<String, String> entry : dataRows.get(0).entrySet()) {
            WebElement checkbox = webDriver.passwebelement(
                    Guest.getlocator("RFQModeCheckbox").replace("{paramlink}", entry.getKey()));
            if (checkbox == null) {
                throw new AssertionError("RFQ mode checkbox was not found: " + entry.getKey());
            }

            boolean actual = checkbox.isSelected()
                    || "true".equalsIgnoreCase(checkbox.getAttribute("aria-checked"));
            boolean expected = Boolean.parseBoolean(entry.getValue());
            Assert.assertEquals(actual, expected,
                    "RFQ mode state mismatch for: " + entry.getKey());
        }
    }

    @Then("Guest - Verify Matching Loads row count is {string}")
    public void verifyMatchingLoadsRowCount(String expectedRowCount) throws Exception {
        String locator = Guest.getlocator("RFQMatchingLoadsRowCount")
                .replace("{paramlink}", expectedRowCount + " rows");
        WebElement rowCount = webDriver.passwebelement(locator);
        if (rowCount == null || !rowCount.isDisplayed()) {
            throw new AssertionError("Matching Loads row count was not found: "
                    + expectedRowCount + " rows");
        }
    }

    @Then("Guest - Scroll to Matching Loads")
    public void scrollToGuestMatchingLoads() throws Exception {
        WebElement heading = webDriver.passwebelement(
                Guest.getlocator("RFQMatchingLoadsHeading"));
        if (heading == null) {
            throw new AssertionError("Matching Loads heading was not found.");
        }
        webDriver.ScrollIntoView(heading);
    }

    @Then("Guest - Verify matching load row")
    public void verifyGuestMatchingLoadRow(DataTable dt) throws Exception {
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (dataRows.isEmpty()) {
            return;
        }

        Map<String, String> expectedValues = dataRows.get(0);
        String expectedLoadNumber = expectedValues.get("Load Number");
        if (expectedLoadNumber == null) {
            throw new AssertionError("Matching load row requires a Load Number.");
        }
        if (expectedLoadNumber.startsWith("SysData=>")) {
            expectedLoadNumber = DriverInstance.getVariable(expectedLoadNumber.split("=>", 2)[1]);
        }

        String rowLocator = Guest.getlocator("RFQMatchingLoadRow")
                .replace("{paramlink}", expectedLoadNumber);
        WebElement row = null;
        for (int attempt = 0; attempt < 15 && row == null; attempt++) {
            row = webDriver.passwebelement(rowLocator);
            if (row == null) {
                webDriver.waitForElementLoad(1);
            }
        }
        if (row == null) {
            throw new AssertionError("Matching load row was not found: " + expectedLoadNumber);
        }

        for (Map.Entry<String, String> entry : expectedValues.entrySet()) {
            String field = entry.getKey();
            String expected = entry.getValue();
            if ("Load Number".equalsIgnoreCase(field)
                    || "Radio Selected".equalsIgnoreCase(field)) {
                continue;
            }

            WebElement cell = row.findElement(By.xpath(".//*[@data-label='" + field + "']"));
            String actual = cell.getAttribute("data-cell-value");
            expected = expected == null ? "" : expected.trim();
            if (expected.matches("-?\\d+") && field.toLowerCase().contains("date")) {
                expected = webDriver.ReturnDateInSpecifiedFormat(expected, "yyyy-MM-dd");
            } else if (expected.startsWith("SysData=>")) {
                expected = DriverInstance.getVariable(expected.split("=>", 2)[1]);
            }

            actual = actual == null ? "" : actual.trim();
            if ("NA".equalsIgnoreCase(expected) || "NULL".equalsIgnoreCase(expected)) {
                expected = "";
            }
            if (field.equalsIgnoreCase("Equipment")) {
                actual = actual.replace("'", "");
                expected = expected.replace("'", "");
            }
            actual = actual.replace(",", "");
            expected = expected.replace(",", "");
            if (!actual.equalsIgnoreCase(expected)) {
                throw new AssertionError("Matching load '" + expectedLoadNumber + "' field '"
                        + field + "' mismatch. Expected: '" + expected + "', Actual: '" + actual + "'");
            }
        }

        String expectedRadioState = expectedValues.get("Radio Selected");
        if (expectedRadioState != null) {
            boolean actualRadioState = Boolean.parseBoolean(row.getAttribute("aria-selected"));
            Assert.assertEquals(actualRadioState, Boolean.parseBoolean(expectedRadioState),
                    "Radio selection state mismatch for load: " + expectedLoadNumber);
        }
    }

    @Then("Guest - Verify text {string} color is {string}")
    public void verifyGuestTextColor(String expectedText, String expectedColor) throws Exception {
        String locator = xml.getlocator("Global_Text_Contains").replace("{paramlink}", expectedText);
        WebElement element = webDriver.getwebelement(locator);
        if (element == null) {
            throw new AssertionError("Guest text was not found: " + expectedText);
        }

        String cssColor = element.getCssValue("color");
        java.awt.Color color = java.awt.Color.decode(
                org.openqa.selenium.support.Color.fromString(cssColor).asHex());
        String actualColor = ColorUtils.getClosestColorName(
                color.getRed(), color.getGreen(), color.getBlue());
        webDriver.Stringcomparator(actualColor, expectedColor);
    }

    @Then("Guest - Verify no load result radio buttons are displayed")
    public void verifyNoGuestLoadResultRadioButtons() {
        List<WebElement> radios = webDriver.getwebelements("//input[@type='radio']");
        for (WebElement radio : radios) {
            if (radio.isDisplayed()) {
                throw new AssertionError("A load result radio button is visible.");
            }
        }
    }

    @Then("Guest - Verify load result radio buttons are not selected")
    public void verifyGuestLoadResultRadioButtonsAreNotSelected() {
        List<WebElement> radios = webDriver.getwebelements("//input[@type='radio']");
        if (radios.isEmpty()) {
            throw new AssertionError("No load result radio buttons were found.");
        }
        for (WebElement radio : radios) {
            if (radio.isDisplayed() && (radio.isSelected()
                    || "true".equalsIgnoreCase(radio.getAttribute("aria-checked")))) {
                throw new AssertionError("A load result radio button is selected.");
            }
        }
    }
}
