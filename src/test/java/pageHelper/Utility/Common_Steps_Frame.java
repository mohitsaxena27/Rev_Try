package pageHelper.Utility;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.Color;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Log4j
public class Common_Steps_Frame {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public PropertyReader propertyReader = new PropertyReader();

    public Common_Steps_Frame(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        System.out.println("this.DriverInstance");
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml=new xmlreader("Generics"+ File.separator+"CommonFrame.xml");
    }

    @Then("Update details -")
    public void updateDetailsForenabledServiceWith( DataTable dt) throws Exception {
        CommonFunction_Frame cf = new CommonFunction_Frame(DriverInstance);
        cf.updateServicesDataWithCount(dt);
    }
    @Then("Enter {string} with Id {string} -")
    public void EnterWithId(String arg0, String arg1) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("FormFields").replace("{paramlink}",arg1)));
        webDriver.waitforElementtobeclickable(xml.getlocator("FormFields").replace("{paramlink}",arg1));
        webDriver.EnterTextUsingJS(webDriver.getwebelement(xml.getlocator("FormFields").replace("{paramlink}",arg1)),arg0);
    }
    @Then("Click on button with Title Contains {string} -")
    public void clickOnButtonWithTitleContains(String arg0) throws DocumentException, InterruptedException {
        try {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("WithTitleContains").replace("{paramlink}", arg0)));
            webDriver.WaitforElementtobeclickable(xml.getlocator("WithTitleContains").replace("{paramlink}", arg0));
            webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("WithTitleContains").replace("{paramlink}", arg0)));
        } catch (Exception e1) {
            webDriver.waitForElementLoad(2);
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("WithTitleContains").replace("{paramlink}", arg0)));
            webDriver.WaitforElementtobeclickable(xml.getlocator("WithTitleContains").replace("{paramlink}", arg0));
            webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("WithTitleContains").replace("{paramlink}", arg0)));

        }
    }
    @Then("Store iframe field {string} value into {string} -")
    public void storeIframeFieldValue(String fieldLabel, String variableName)
            throws DocumentException, InterruptedException {

        WebElement labelElement = webDriver.getwebelement(
                xml.getlocator("LabelText")
                        .replace("{paramlink}", fieldLabel));

        if (labelElement == null) {
            throw new IllegalStateException(
                    "Unable to locate iframe field label: " + fieldLabel);
        }

        String fieldId = labelElement.getAttribute("for");
        WebElement fieldElement = webDriver.getwebelement(
                xml.getlocator("FormFields")
                        .replace("{paramlink}", fieldId));

        if (fieldElement == null) {
            fieldElement = webDriver.getwebelement(
                    xml.getlocator("InputField")
                            .replace("{paramlink}", fieldLabel));
        }

        if (fieldElement == null) {
            throw new IllegalStateException(
                    "Unable to locate iframe input field: " + fieldLabel);
        }

        webDriver.ScrollIntoView(fieldElement);

        String fieldValue = webDriver.Getattribute(fieldElement, "value");
        DriverInstance.setVariable(variableName, fieldValue);

        System.out.println(variableName + " : " + fieldValue);
    }

    @Then("Click on button with Title Contains {string} and {string} -")
    public void clickOnButtonWithTitleContains2(String arg0, String arg1) throws DocumentException, InterruptedException {
        try {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("WithTitleContains2").replace("{paramlink}", arg0).replace("{paramlink2}", arg1)));
            webDriver.WaitforElementtobeclickable(xml.getlocator("WithTitleContains2").replace("{paramlink}", arg0).replace("{paramlink2}", arg1));
            webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("WithTitleContains2").replace("{paramlink}", arg0).replace("{paramlink2}", arg1)));
        } catch (Exception e1) {
            webDriver.waitForElementLoad(2);
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("WithTitleContains2").replace("{paramlink}", arg0).replace("{paramlink2}", arg1)));
            webDriver.WaitforElementtobeclickable(xml.getlocator("WithTitleContains2").replace("{paramlink}", arg0).replace("{paramlink2}", arg1));
            webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("WithTitleContains2").replace("{paramlink}", arg0).replace("{paramlink2}", arg1)));

        }
    }
    //Click button with name attribute
    @Then("Click on {string} button -")
    public void clickOnButton(String arg0) throws Exception {
        try {

            webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Button_Name_Cotains").replace("{paramlink}", arg0)));
            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("Button_Name_Cotains").replace("{paramlink}", arg0)));
            webDriver.safeJavaScriptClick(webDriver.passwebelement(xml.getlocator("Button_Name_Cotains").replace("{paramlink}", arg0)));
        }
        catch(Exception e)
        {
            webDriver.Clickon(webDriver.passwebelement(xml.getlocator("Button_Name_Cotains").replace("{paramlink}", arg0)));

        }
    }
    @Then("Update details with Table -")
    public void updateDetailswithTable( DataTable dt) throws Exception {
        CommonFunction_Frame cf = new CommonFunction_Frame(DriverInstance);
        cf.updateServiceWithTable(dt);
    }

    @And("Click on Button with Value {string} -")
    public void clickOnButtonWithValue(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("ValueInput").replace("{paramlink}",arg0)));
        webDriver.WaitforElementtobeclickable(xml.getlocator("ValueInput").replace("{paramlink}",arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("ValueInput").replace("{paramlink}",arg0)));
    }
    @Then("Click on button {string} -")
    public void clickOnButton1(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Global_Text").replace("//*","//button").replace("{paramlink}",arg0)));
        webDriver.waitforElementtobeclickable(xml.getlocator("Global_Text").replace("//*","//button").replace("{paramlink}",arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("Global_Text").replace("//*","//button").replace("{paramlink}",arg0)));
    }

    @Then("Verify Modal Heading Text displaying as {string} -")
    public void verifyHeadingAreDisplayingAs(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(xml.getlocator("Global_Text_Contains").replace("//*", "//h2//*").replace("{paramlink}", arg0));
        webDriver.verifyElementToBePresent(xml.getlocator("Global_Text_Contains").replace("//*", "//h2//*").replace("{paramlink}", arg0));
    }
    @Then("Select {string} from List -")
    public void selectFromList(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitforElementtobeclickable(xml.getlocator("ButtonIconTitle").replace("{paramlink}",arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("ButtonIconTitle").replace("{paramlink}",arg0)));

    }
    @Then("Click on {string} button on {string} Page -")
    public void clickOnButtonOnPage(String arg0, String arg1) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("BtnClickOnPage").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1)));
        webDriver.waitforElementtobeclickable(xml.getlocator("BtnClickOnPage").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("BtnClickOnPage").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1)));

    }
    @Then("Verify details for all Enabled fields -")
    public void verifyDetailsForEnabledService( DataTable dt) throws Exception {
        CommonFunction_Frame cf = new CommonFunction_Frame(DriverInstance);
        cf.validateServicesData(dt,Boolean.TRUE,Boolean.FALSE);
    }
    @Then("Verify {string} having value of {string} -")
    public void verifyIsSetTo(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1)));
        webDriver.verifyElementToBePresent(xml.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1));

    }
    //Verify Field are not displaying on page
    @Then("Verify Label {string} not displaying on Page -")
    public void verifyNotDisplayingOnPage(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementNotToBePresent(xml.getlocator("Global_Text").replace("{paramlink}",arg0));
    }

    @Then("Within the Legend select {string} as {string} -")
    public void withinTheModalSelectAs(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Verify_Label_Text_Value").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1)));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("Verify_Label_Text_Value").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1)));
        webDriver.waitForElementLoad(1);
    }
    @Then("Verify {string} Clear Icon button is displaying -")
    public void verifyClearSectionButtonIsDisplaying(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementToBePresent(xml.getlocator("LabelClearIcon").replace("{paramlink}",arg0));

    }

    @Then("Verify details for all Required Enabled fields -")
    public void verifyDetailsForEnabledRequiredService( DataTable dt) throws Exception {
        CommonFunction_Frame cf = new CommonFunction_Frame(DriverInstance);
        cf.validateServicesData(dt,Boolean.TRUE,Boolean.FALSE);
    }

    @Then("Verify details for all Disabled or Readonly fields -")
    public void verifyDetailsForDisabledService(DataTable dt) throws Exception {
        CommonFunction_Frame cf = new CommonFunction_Frame(DriverInstance);
        cf.validateServicesData(dt,Boolean.FALSE,Boolean.FALSE);
    }

    //Click on Button Icon
    @Then("Click on PickList {string} -")
    public void clickOnPickList(String arg0) throws Exception {
        webDriver.ScrollIntoComplexView(xml.getlocator("Label_Button").replace("{paramlink}", arg0));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Label_Button").replace("{paramlink}", arg0)));
        webDriver.waitForElementLoad(1);
    }

    @Then("Verify Text displaying as {string} -")
    public void verifyMessageAreDisplayingAs(String arg0) throws DocumentException, InterruptedException {
        if (arg0.contains("SysData")) {
            String Value = arg0.split("=>")[1];
            webDriver.waitUntilElementIsVisible(xml.getlocator("Global_Text_Contains").replace("{paramlink}", DriverInstance.getVariable(Value)));
            webDriver.verifyElementToBePresent(xml.getlocator("Global_Text_Contains").replace("{paramlink}", DriverInstance.getVariable(Value)));
        }
        else{
            webDriver.waitUntilElementIsVisible(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg0));
            webDriver.verifyElementToBePresent(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg0));
        }
    }

    @Then("Click on {string} with Text -")
    public void clickOn(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Global_Text").replace("{paramlink}",arg0)));
        webDriver.waitforElementtobeclickable(xml.getlocator("Global_Text").replace("{paramlink}",arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("Global_Text").replace("{paramlink}",arg0)));
    }

    @Then("Click on {string} with Contains Text -")
    public void clickOnContains(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Global_Text_Contains").replace("{paramlink}",arg0)));
        webDriver.waitforElementtobeclickable(xml.getlocator("Global_Text_Contains").replace("{paramlink}",arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("Global_Text_Contains").replace("{paramlink}",arg0)));
    }

    @Then("{string} field highlights red as required -")
    public void fieldHighlightsRedAsRequired(String arg0) throws DocumentException, InterruptedException {

        webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("CheckRequiredLabel").replace("{paramlink}",arg0)));
        webDriver.verifyElementToBePresent(xml.getlocator("CheckRequiredLabel").replace("{paramlink}",arg0));

    }

    @Then("Remove {string} from {string} Field -")
    public void removeFromField(String arg0, String arg1) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LabelClearIcon").replace("{paramlink}",arg1)));
        webDriver.WaitforElementtobeclickable(xml.getlocator("LabelClearIcon").replace("{paramlink}",arg1));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("LabelClearIcon").replace("{paramlink}",arg1)));
    }

    @Then("Click on {string} Field info -")
    public void clickOnFieldInfo(String arg0) throws DocumentException, InterruptedException {
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("InputInfoButton").replace("{paramlink}",arg0)));

    }

    @Then("Verify {string} Attribute {string} displaying as {string} -")
    public void verifyAttributeDisplayingAs(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException {
        String Act_Result;
        if(arg2.equalsIgnoreCase(""))
        {
            Act_Result = webDriver.returnElementAttrubuteValue(webDriver.passwebelement(xml.getlocator("InputField").replace("{paramlink}", arg0)), arg1);

        }
        else {
            Act_Result = webDriver.returAttrubuteValue(webDriver.passwebelement(xml.getlocator("InputField").replace("{paramlink}", arg0)), arg1);
        }
        if(arg0.contains("Date")||arg0.contains("date"))
        {
            webDriver.Partialstringcomparator(Act_Result, webDriver.ExpectedDate(arg2));
        }
        {
            webDriver.Partialstringcomparator(Act_Result, arg2);
        }
    }

    @Then("Scroll into Section {string} -")
    public void scrollIntoSection(String arg0) throws Exception{
        webDriver.ScrollIntoComplexView(xml.getlocator("Global_Text").replace("{paramlink}", arg0));
    }

    @Then("Enter Label {string} Text as {string} -")
    public void enterLabelText(String arg0, String arg1) throws Exception {
        if(arg1.equalsIgnoreCase("Company Email"))
        {
            arg1=propertyReader.readproperty("Company_Email");
        }

        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("InputField").replace("{paramlink}", arg0)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("InputField").replace("{paramlink}", arg0)));
        webDriver.EnterTextUsingJS(webDriver.getwebelement(xml.getlocator("InputField").replace("{paramlink}", arg0)),arg1);
        webDriver.waitForElementLoad(1);
    }

    @Then("Select on {string} as value {string} -")
    public void selectOnAsValue(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Label_Button").replace("{paramlink}",arg0)));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("Label_Button").replace("{paramlink}",arg0)));
        webDriver.SelectComboBoxOption(webDriver.getwebelement(xml.getlocator("Div_aria_Label").replace("{paramlink}",arg0)),webDriver.getwebelement(xml.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1)));
    }
    //Verify Field are displaying on page and Required
    @Then("Verify Label {string} is Required and displaying on Page -")
    public void verifyLabelIsDisplayingOnPageRequired(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("InputFiledRequired").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(xml.getlocator("InputFiledRequired").replace("{paramlink}", arg0));
    }

    @Then("Verify Picklist {string} is Required and displaying on Page -")
    public void verifyPickListIsDisplayingOnPageRequired(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("PickListRequired").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(xml.getlocator("PickListRequired").replace("{paramlink}", arg0));
    }
    @Then("Verify Text not displaying as {string} -")
    public void verifyMessageAreNotDisplayingAs(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementNotToBePresent(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg0));
    }

    @Then("Verify Button with Title not displaying as {string} -")
    public void verifyButtonNotDisplayingAs(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementNotToBePresent(xml.getlocator("WithTitle").replace("{paramlink}", arg0));
    }
    @Then("Verify Button with Title displaying as {string} -")
    public void verifyButtonDisplayingAs(String arg0) throws DocumentException, InterruptedException {
        if (arg0.contains("SysData")) {
            String Value = arg0.split("=>")[1];
            arg0 = DriverInstance.getVariable(Value);
        }
            webDriver.verifyElementToBePresent(xml.getlocator("WithTitle").replace("{paramlink}", arg0));
    }

    @Then("Select Text {string} on Field Title {string} -")
    public void selectTextOnFieldTitle(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("SelectTitle").replace("{paramlink}",arg1)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("SelectTitle").replace("{paramlink}",arg1)));
        webDriver.selectOptionByText(webDriver.getwebelement(xml.getlocator("SelectTitle").replace("{paramlink}",arg1)),arg0);
    }

    @Then("Accept Alert If any")
    public void acceptAlertIfAny() {
        webDriver.acceptAlert();
    }
    @Then("Click on {string} Link Text {string} on Page -")
    public void clickOnLinkTextOnPage(String arg0, String arg1)throws Exception {
        DriverInstance.setVariable(arg0,arg1);
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg1)));
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg1)));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg1)));
        webDriver.waitForElementLoad(2);
    }
    @Then("Verify {string} Link Text {string} on Page -")
    public void VerifyLinkTextOnPage(String arg0, String arg1)throws Exception {
        DriverInstance.setVariable(arg0,arg1);
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg1)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg1)));
        webDriver.verifyElementToBePresent(xml.getlocator("Global_Text").replace("*", "span").replace("{paramlink}", arg1));
        webDriver.waitForElementLoad(2);
    }
    @Then("Click on Partial Link Text {string} on Page -")
    public void clickOnLinkPartialTextOnPage(String arg1)throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Global_Text_Contains").replace("*", "span").replace("{paramlink}", arg1)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("Global_Text_Contains").replace("*", "span").replace("{paramlink}", arg1)));
        webDriver.waitForElementLoad(1);
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Global_Text_Contains").replace("*", "span").replace("{paramlink}", arg1)));

    }
    @Then("Click on {string} {string} Action -")
    public void clickOnAction(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("SiblingText").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("SiblingText").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1)));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("SiblingText").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1)));
        webDriver.waitForElementLoad(1);
    }

    @Then("Enter {string} on Input value Field {string} -")
    public void enterOnInputValueField(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("InputValue").replace("{paramlink}", arg1)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("InputValue").replace("{paramlink}", arg1)));
        webDriver.EnterTextUsingJS(webDriver.getwebelement(xml.getlocator("InputValue").replace("{paramlink}", arg1)),arg0);
        webDriver.waitForElementLoad(1);

    }

    @Then("Click on Exact Text with {string} -")
    public void clickOnExactTextWith(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("ExactText").replace("{paramlink}",arg0)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("ExactText").replace("{paramlink}",arg0)));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("ExactText").replace("{paramlink}",arg0)));
    }

    @Then("Click on {string} Checkbox -")
    public void clickOnCheckbox(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("GlobalCheckbox").replace("{paramlink}",arg0)));
        webDriver.waitforElementtobeclickable(xml.getlocator("GlobalCheckbox").replace("{paramlink}",arg0));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("GlobalCheckbox").replace("{paramlink}",arg0)));

        }

    @Then("Click on div text {string} -")
    public void clickOnDivText(String arg0) throws Exception {
        webDriver.ScrollIntoComplexView(xml.getlocator("DivText").replace("{paramlink}", arg0));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("DivText").replace("{paramlink}", arg0)));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("DivText").replace("{paramlink}", arg0)));
        webDriver.waitForElementLoad(1);
    }
    @Then("Click on {string} Button on {string} -")
    public void clickOnButtonOn(String arg0, String arg1) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("ModalButton").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1)));
        webDriver.waitforElementtobeclickable(xml.getlocator("ModalButton").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("ModalButton").replace("{paramlink1}",arg0).replace("{paramlink2}",arg1)));

    }
    @And("Click on Native {string} icon -")
    public void clickOnNativeIcon(String arg0) throws Exception {

        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("ButtonTitle").replace("{paramlink}", arg0)));
        webDriver.waitforElementtobeclickable(xml.getlocator("ButtonTitle").replace("{paramlink}", arg0));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("ButtonTitle").replace("{paramlink}", arg0)));
    }

    @Then("Select {string} as {string} from Dueling List -")
    public void selectAsFromDuelingList(String arg0, String arg1) throws Exception {
        CommonFunction_Frame cf = new CommonFunction_Frame(DriverInstance);
        cf.moveOptionToChosen(arg0,arg1);
    }
    @Then("Click on Native {string} button -")
    public void ClickonNativeSalesforceButton(String arg0) throws Exception {
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("ButtonText").replace("{paramlink}", arg0)));
        webDriver.Clickon(webDriver.getwebelement(xml.getlocator("ButtonText").replace("{paramlink}", arg0)));
    }
    @Then("Click on button with Title {string} -")
    public void clickOnButtonWithTitle(String arg0) throws DocumentException, InterruptedException {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("WithTitle").replace("{paramlink}", arg0)));
            webDriver.WaitforElementtobeclickable(xml.getlocator("WithTitle").replace("{paramlink}", arg0));
            webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("WithTitle").replace("{paramlink}", arg0)));
    }

    @Then("Search {string} as {string} -")
    public void searchAs(String arg0, String arg1) throws DocumentException, InterruptedException, IOException {
        webDriver.waitForElementLoad(2);
        clickOn("Search...");
        String fieldName = webDriver.passwebelement(xml.getlocator("LabelText").replace("{paramlink}", "Search by object type")).getAttribute("for");
        WebElement element = webDriver.passwebelement(xml.getlocator("FormFields").replace("{paramlink}", fieldName));
        webDriver.waitUntilTheElementIsVisible(element);
        webDriver.ClickOnElement(element);
        webDriver.waitForElementLoad(1);
        webDriver.waitforElementtobeclickable(xml.getlocator("ButtonIconSearchTitle").replace("{paramlink}", arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("ButtonIconSearchTitle").replace("{paramlink}", arg0)));
        webDriver.waitForElementLoad(1);
        webDriver.SendKeys(webDriver.passwebelement(xml.getlocator("VerifyPlaceholder").replace("{paramlink}", "Search...")),arg1);
        webDriver.waitForElementLoad(1);
        webDriver.ClickOnElement(webDriver.passwebelement(xml.getlocator("WithTitle").replace("{paramlink}", arg1)));

    }
    @Then("Verify Help Text displaying as {string}")
    public void verifyHelpTextDisplayingAs(String arg0) throws DocumentException, InterruptedException {

     //   webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg0)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg0)));
        webDriver.verifyElementToBePresent(xml.getlocator("Global_Text_Contains").replace("{paramlink}", arg0));
    }
    @Then("To open the preview attachments -")
    public void toOpenThePreviewAttachments() throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Preview_file")));
        webDriver.waitforElementtobeclickable(xml.getlocator("Preview_file"));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("Preview_file")));

    }
    @Then("Go to {string} Tab -")
    public void goToTab(String arg0) throws Exception {
        Thread.sleep(1000);
        if (webDriver.getwebelementscount(xml.getlocator("LinkText").replace("{paramlink}", arg0)) > 0) {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LinkText").replace("{paramlink}", arg0)));
            webDriver.waitforElementtobeclickable(xml.getlocator("LinkText").replace("{paramlink}", arg0));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("LinkText").replace("{paramlink}", arg0)));
        } else {
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LinkText").replace("{paramlink}", arg0)));
            webDriver.waitforElementtobeclickable(xml.getlocator("LinkText").replace("{paramlink}", arg0));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("LinkText").replace("{paramlink}", arg0)));

        }
    }
    @Then("Switch to Frame by Title {string} -")
    public void switchToFrameByTitle(String arg0) throws DocumentException, InterruptedException {
        webDriver.SwitchToParentFrame();
        webDriver.SwitchToFrameByElement(webDriver.getwebelement(xml.getlocator("IframeTitle").replace("{paramlink}", arg0)));
    }

    @Then("Select {string} with Value {string}")
    public void selectWithValue(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("LabelSelect").replace("{paramlink}", arg0)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("LabelSelect").replace("{paramlink}", arg0)));
        webDriver.selectOptionByText(webDriver.getwebelement(xml.getlocator("LabelSelect").replace("{paramlink}", arg0)),arg1);
    }

    @Then("Enter File Label {string} Text as {string} -")
    public void enterLabelText2(String arg0, String arg1) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("InputField2").replace("{paramlink}", arg0)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(xml.getlocator("InputField2").replace("{paramlink}", arg0)));
        webDriver.EnterTextUsingJS(webDriver.getwebelement(xml.getlocator("InputField2").replace("{paramlink}", arg0)),arg1);
        webDriver.waitForElementLoad(1);
    }

    @Then("Set count of Text {string} on to {string}")
    public void setCountOfTextOnTo(String arg0, String arg1) throws DocumentException, InterruptedException {
      int count=  webDriver.getwebelementscount(xml.getlocator("Global_Text").replace("{paramlink}", arg0));
       DriverInstance.setVariable(arg1,String.valueOf(count));
    }

    @And("Click on link {string} -")
    public void clickOnLink(String arg0) throws Exception {
        //  webDriver.scrollDownWithJS(10);
        if (arg0.contains("SysData")) {
            String Value = arg0.split("=>")[1];
            String Act = DriverInstance.getVariable(Value);
            webDriver.ScrollUsingJSUntilElementIsNotFound(xml.getlocator("Global_Text").replace("//*", "//h2//*").replace("{paramlink}", Act));
            webDriver.ScrollIntoView(webDriver.passwebelement(xml.getlocator("Global_Text").replace("//*", "//h2//*").replace("{paramlink}", Act)));
            webDriver.waitforElementtobeclickable(xml.getlocator("LinkText1").replace("{paramlink}", Act));
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("LinkText1").replace("{paramlink}", Act)));
        } else {
            webDriver.ScrollUsingJSUntilElementIsNotFound(xml.getlocator("Global_Text").replace("//*", "//h2//*").replace("{paramlink}", arg0));
            webDriver.waitForElementLoad(1);
            webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("Global_Text").replace("{paramlink}", arg0)));
            webDriver.waitforElementtobeclickable(xml.getlocator("LinkText1").replace("{paramlink}", arg0));
            webDriver.Clickon(webDriver.getwebelement(xml.getlocator("LinkText1").replace("{paramlink}", arg0)));
        }
    }

    @Then("Click on Modal Button {string}")
    public void ClickOnModalButton(String Arg0) throws Exception {
        webDriver.waitforElementtobeclickable(xml.getlocator("ButtonOnModal"));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(xml.getlocator("ButtonOnModal").replace("{paramlink}",Arg0)));

    }

    @Then("Click on Link Text {string} on new Window with {string} Frame")
    public void clickOnLinkTextOnNewWindowWithFrame(String arg0, String arg1) throws InterruptedException {
       webDriver.HandleWindowsAndClickOnLinkText(arg1,arg0);
    }

    @Then("Click on Search lookup with Title {string} -")
    public void clickOnSearchLookupWithTitle(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(xml.getlocator("imgTitle").replace("{paramlink}", arg0)));
        webDriver.WaitforElementtobeclickable(xml.getlocator("imgTitle").replace("{paramlink}", arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(xml.getlocator("imgTitle").replace("{paramlink}", arg0)));

    }

    @Then("Select {string} with Id {string} -")
    public void SelectWithId(String arg0, String arg1) throws Exception {
        String locator = xml.getlocator("FormFields").replace("{paramlink}", arg1);
        WebElement element = webDriver.getwebelement(locator);
        webDriver.ScrollIntoView(element);
        webDriver.waitforElementtobeclickable(locator);
        webDriver.selectOptionByText(element, arg0);
    }
}