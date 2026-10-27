package pageHelper.Utility;

import com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter;
import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.en.Then;
import org.dom4j.DocumentException;
import org.openqa.selenium.Keys;
import org.testng.Assert;
import org.testng.asserts.SoftAssert;
import pageHelper.bddDriver;
import utils.DriverController;
import utils.PropertyReader;
import utils.xmlreader;

import java.awt.*;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;
import java.awt.event.KeyEvent;
import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

public class WebActions {
    public  webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader locators;
    
    public xmlreader genericLocators = new xmlreader("src\\test\\resources\\locators\\Generic.xml");

    public PropertyReader propertyReader = new PropertyReader();
    public WebActions(bddDriver contextSteps, DriverController drivercontroler) throws Exception {
        this.DriverInstance = contextSteps;
        webDriver=new baseDriverHelper(bddDriver.getWebDriver());
    }
    public WebActions(DriverController drivercontroler)
    {
        webDriver=new baseDriverHelper(drivercontroler.getDriver());
    }
//
//    @Then("^Wait until the text \"([^\"]*)\" is present on the \"([^\"]*)\" page$")
//    public void Wait_Until_Text_Is_present_on_page(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.waitforElementtobeclickable(locators.getlocator("//locators/" + Locators));
//        webDriver.verifyElementToBePresent(locators.getlocator("//locators/" + Locators));
//    }
//
//    @Then("^Wait until the text \"([^\"]*)\" is Absent on the \"([^\"]*)\" page$")
//    public void Wait_Until_Text_Is_Absent_on_page(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.waitforElementNotToBeVisible(locators.getlocator("//locators/" + Locators));
//        webDriver.verifyElementNotToBePresent(locators.getlocator("//locators/" + Locators));
//    }
//
//    @Then("^Wait until the current page title changes to \"([^\"]*)\"$")
//    public void Wait_Until_Title_Is_Change(String Title) throws Throwable
//    {
//        webDriver.waitforTitleContains(Title);
//        System.out.println(webDriver.GetTitle());
//    }
//    @Then("^Wait until the current page is loaded completely$")
//    public void Wait_Until_Page_Loaded_Completely() throws Throwable
//    {
//       webDriver.waitForCompletePageLoad();
//    }
//    @Then("^Wait until the frame \"([^\"]*)\" is loaded and switch to the frame$")
//    public void WaitforFrameToBeAvailableAndSwitchToIt(String FrameName) throws Throwable
//    {
//        webDriver.waitforFrameToBeAvailableAndSwitchToIt(FrameName);
//    }
//    @Then("^Wait until the \"([^\"]*)\" value changes to \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void WaitforFrameToBeAvailableAndSwitchToIt(String Locators,String Text, String PageName) throws Throwable
//    {
//        try{
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.waitFortTextToBePresentInElement(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),Text);
//    }
//    catch(Exception e)
//    {
//        Thread.sleep(2000);
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.waitFortTextToBePresentInElement(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),Text);
//
//    }
//    }
//
//    @Then("^Wait until the \"([^\"]*)\" is visible on the \"([^\"]*)\" page$")
//    public void WaitUntilTheElementIsVisible(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//    }
//
//    @Then("^Wait until the \"([^\"]*)\" is not selected on the \"([^\"]*)\" page$")
//    public void WaitUntilTheElementIsNotSelected(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.waitUntilTheElementIsNotSelected(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//    }
//    @Then("^Wait until the \"([^\"]*)\" is clickable on the \"([^\"]*)\" page$")
//    public void WaitUntilTheElementIsClickable(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.waitforElementtobeclickable(locators.getlocator("//locators/" + Locators));
//    }
//    @Then("^Wait until the attribute \"([^\"]*)\" with value \"([^\"]*)\" of the \"([^\"]*)\" is changed on the \"([^\"]*)\" page$")
//    public void waitUntilTheAttributeValueChangeToAnElement(String AttributeName, String AttributeValue, String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.waitUntilTheAttributeValueChangeToAnElement(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),AttributeName,AttributeValue);
//    }
//    @Then("^Wait until the Alert currently displayed is absent$")
//    public void WaitUntilTheAlertNotDisplaying() throws Throwable
//    {
//        webDriver.waitUntilAlertNotDisplaying();
//    }
//    @Then("^Wait until the \"([^\"]*)\" is Not visible on the \"([^\"]*)\" page$")
//    public void WaitUntilTheElementIsNotVisible(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.waitforElementNotToBeVisible(locators.getlocator(Locators));
//    }
//    @Then("^Wait until an Alert is displayed in the current page$")
//    public void WaitUntilTheAlertIsDisplaying() throws Throwable
//    {
//        webDriver.waitUntilTheAlertIsDisplaying();
//    }
//    @Then("^Wait until all images are loaded in the current page$")
//    public void WaitUntilAllImagesAreLoaded() throws Throwable
//    {
//        webDriver.waitUntilAllImagesAreLoaded();
//    }
//    @Then("Wait until a new window is opened")
//    public void WaitUntilANewWindowOpen() throws Throwable
//    {
//        webDriver.waitUntilANewWindowOpen();
//    }
//
//    @Then("Wait for {int} seconds")
//    public void WaitUntilAllImagesAreLoaded(int time) throws Throwable
//    {
//        webDriver.waitForElementLoad(time);
//    }
//
//    @Then("^Uncheck the checkbox \"([^\"]*)\" on \"([^\"]*)\" Page$")
//    public void UncheckTheCheckbox(String Locators,String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//
//        webDriver.uncheckTheCheckBox(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//    }
//    @Then("^Check the checkbox \"([^\"]*)\" on \"([^\"]*)\" Page$")
//    public void checkTheCheckbox(String Locators,String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//
//        webDriver.CheckTheCheckBox(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//    }
//    @Then("^Verify that the current page title is \"([^\"]*)\"$")
//    public void VerifyTitle(String Title) throws Throwable
//    {
//        System.out.println(webDriver.GetTitle());
//        webDriver.VerifyTitle(Title);
//    }
//    @Then("^Verify that the current page URL is \"([^\"]*)\"$")
//    public void VerifyCurrentURL(String CurrentURL) throws Throwable
//    {
//        System.out.println(webDriver.CurrentURL());
//        webDriver.verifyCurrentURL(CurrentURL);
//    }
//    @Then("^Verify text \"([^\"]*)\" is present on the \"([^\"]*)\" page$")
//    public void Verify_Text_Is_present_on_page(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.waitforElementtobeclickable(locators.getlocator("TextPlaceholder").replace("{paramlink}",Locators));
//        webDriver.verifyElementToBePresent(locators.getlocator("TextPlaceholder").replace("{paramlink}",Locators));
//    }
//    @Then("^Verify Element \"([^\"]*)\" is present on the \"([^\"]*)\" page$")
//    public void Verify_Element_Is_present_on_page(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.waitforElementtobeclickable(locators.getlocator("//locators/" + Locators));
//        webDriver.verifyElementToBePresent(locators.getlocator("//locators/" + Locators));
//    }
//
//    @Then("^Verify Heading \"([^\"]*)\" is present on the \"([^\"]*)\" page$")
//    public void Verify_Heading_Is_present_on_page(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.waitforElementtobeclickable(locators.getlocator("//locators/" + Locators));
//        webDriver.verifyElementToBePresent(locators.getlocator("//locators/" + Locators));
//    }
//
//    @Then("^Verify Element \"([^\"]*)\" with Text \"([^\"]*)\" is present on the \"([^\"]*)\" page$")
//    public void Verify_Element_Is_present_on_page(String Locators,String Text, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName.toLowerCase() + ".xml");
//        webDriver.waitforElementtobeclickable(locators.getlocator(Locators).replace("{paramlink}",Text));
//        webDriver.verifyElementToBePresent(locators.getlocator(Locators).replace("{paramlink}",Text));
//    }
//
//    @Then("^Verify that an Alert is present$")
//    public void VerifyThatAnAlertIsPresent() throws Throwable
//    {
//        webDriver.waitUntilTheAlertIsDisplaying();
//        Assert.assertTrue(webDriver.verifyAlertPresent(),"Alert not present on Page");
//
//    }
//    @Then("^Verify that the list \"([^\"]*)\" has some option selected on the \"([^\"]*)\" page$")
//    public void VerifyThatListHasSomeOptionSelected(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        boolean flag = webDriver.returnListHasSomeOptionSelected(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//        Assert.assertTrue(flag, "Options are not selected on Select Input Box");
//
//    }
//    @Then("^Verify that the list \"([^\"]*)\" has \"([^\"]*)\" number of options on the \"([^\"]*)\" page$")
//    public void VerifyThatListHasNumberOfOptions(String Locators,String NumberofOptions, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        int noOfOption= webDriver.returnListHasNumberOfOptions(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//        Assert.assertEquals(noOfOption,Integer.parseInt(NumberofOptions),"Mismatch Options Count on Page");
//
//    }
//    @Then("^Verify that the list \"([^\"]*)\" has option with value \"([^\"]*)\" selected on the \"([^\"]*)\" page$")
//    public void VerifyThatListHasOptionWithValueSelected(String Locators,String SelectedValue, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//       boolean flag= webDriver.returnListHasOptionWithValueSelected(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),SelectedValue);
//        Assert.assertTrue(flag, "Provided Value are not selected");
//
//    }
//    @Then("^Verify that the list \"([^\"]*)\" allows selection of multiple options on the \"([^\"]*)\" page$")
//    public void VerifyThatListAllowSelectionOfMultipleOption(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        boolean flag=webDriver.returnAllowSelectionOfMultipleOptionFlag(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//        Assert.assertTrue(flag, "Multiple Selection Option is not enabled.");
//
//    }
//
//    @Then("^Verify that the \"([^\"]*)\" has non-empty value on the \"([^\"]*)\" page$")
//    public void VerifyThatElementHasNonEmptyValue(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        boolean flag = webDriver.returnElementEmptyValueFlag(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//        Assert.assertTrue(flag, "Element has Empty value where expected was Non-Empty Value");
//    }
//
//    @Then("^Verify that the \"([^\"]*)\" has non-empty Text on the \"([^\"]*)\" page$")
//    public void VerifyThatElementHasNonEmptyText(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        boolean flag = webDriver.returnElementEmptyTextFlag(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//        Assert.assertTrue(flag, "Element has Empty value where expected was Non-Empty Value");
//    }
//
//    @Then("^Verify that the \"([^\"]*)\" has empty value on the \"([^\"]*)\" page$")
//    public void VerifyThatElementHasEmptyValue(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        boolean flag = webDriver.returnElementEmptyValueFlag(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//        Assert.assertFalse(flag, "Element has non Empty value where expected was Empty Value");
//    }
//    @Then("^Verify that the \"([^\"]*)\" has tag name \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void VerifyThatElementHasTagName(String Locators,String tagname, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = webDriver.returnElementTagName(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//        Assert.assertEquals(data,tagname, "TagName Value not matched!!");
//    }
//    @Then("^Verify that the \"([^\"]*)\" has class name \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void VerifyThatElementHasClassName(String Locators,String classname, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = webDriver.returnElementAttrubuteValue(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),"class");
//        Assert.assertTrue(data.contains(classname), "ClassName Value not matched!!");
//    }
//    @Then("^Verify that the \"([^\"]*)\" has Value \"([^\"]*)\" for \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void VerifyThatElementHasClassName(String Locators,String AttValue,String AttributeName, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = webDriver.returnElementAttrubuteValue(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),AttributeName);
//        Assert.assertTrue(data.contains(AttValue), AttributeName+" Value not matched!!");
//    }
//    @Then("^Verify that the \"([^\"]*)\" display value is \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void VerifyThatElementDisplayValue(String Locators,String AttributeValue, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = webDriver.returnElementAttrubuteValue(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),"value");
////        Assert.assertEquals(data.toLowerCase(),AttributeValue.toLowerCase(), "Value not matched!!");
//        Stringcomparator(data.toLowerCase(),AttributeValue.toLowerCase());
//    }
//    @Then("^Verify that the \"([^\"]*)\" display Field value is \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void VerifyThatElementDisplayFiledValue(String Locators,String AttributeValue, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = webDriver.returnElementAttrubuteValue(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),"value");
////        Assert.assertEquals(data.toLowerCase(),DriverInstance.getVariables().get(AttributeValue).toLowerCase(), "Value not matched!!");
////        ExtentCucumberAdapter.addTestStepLog(Locators+" : "+DriverInstance.getVariables().get(AttributeValue));
//        Stringcomparator(data.toLowerCase(),DriverInstance.getVariables().get(AttributeValue).toLowerCase());
//    }
//    @Then("^Verify that the \"([^\"]*)\" display as Today on the \"([^\"]*)\" page$")
//    public void VerifyThatElementDisplayValueAsToday(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = webDriver.returnElementAttrubuteValue(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),"value");
//        DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
//        Date date = new Date();
//        String date1 = dateFormat.format(date);
//        String month;
//        if(date1.split("/")[0].startsWith("0"))
//        {
//            month= date1.split("/")[0].replace("0","");
//        }
//        else{
//            month= date1.split("/")[0];
//        }
//        String day;
//        if(date1.split("/")[1].startsWith("0"))
//        {
//            day= date1.split("/")[1].replace("0","");
//        }
//        else{
//            day= date1.split("/")[1];
//        }
//        String finaldate = month+"/"+day+"/"+date1.split("/")[2];
//        System.out.println(finaldate);
//        System.out.println("data"+data);
//        Stringcomparator(data.toLowerCase(),finaldate.toLowerCase());
////        Assert.assertEquals(data,finaldate, "Value not matched!!");
//    }
//    @Then("^Verify that the \"([^\"]*)\" display Text \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void VerifyThatElementDisplayText(String Locators,String Text, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = webDriver.getText(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
////        Assert.assertEquals(data.toLowerCase(),Text.toLowerCase(), "Value not matched!!");
//        Stringcomparator(data.toLowerCase(),Text.toLowerCase());
//    }
//
//    @Then("^Verify that the \"([^\"]*)\" display Value \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void VerifyThatElementDisplayText11(String Locators,String Text, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = webDriver.getText(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
////        Assert.assertEquals(data.toLowerCase(),Text.toLowerCase(), "Value not matched!!");
//        Stringcomparator(data.toLowerCase(),Text.toLowerCase());
//    }
//
//    @Then("^Verify that the \"([^\"]*)\" display Field Text \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void VerifyThatElementDisplayText1(String Locators,String Text, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = webDriver.getText(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
////        Assert.assertEquals(data.toLowerCase(),DriverInstance.getVariables().get(Text).toLowerCase(), "Value not matched!!");
////        ExtentCucumberAdapter.addTestStepLog(Locators+" : "+DriverInstance.getVariables().get(Text));
//        Stringcomparator(data.toLowerCase().trim(),DriverInstance.getVariables().get(Text).toLowerCase().trim());
//
//    }
//    @Then("^Verify that the \"([^\"]*)\" display Today Date on the \"([^\"]*)\" page$")
//    public void VerifyThatElementDisplayTextAsTodayDate(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = webDriver.getText(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//        DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
//        Date date = new Date();
//        String date1 = dateFormat.format(date);
//        String month;
//        if(date1.split("/")[0].startsWith("0"))
//        {
//            month= date1.split("/")[0].replace("0","");
//        }
//        else{
//            month= date1.split("/")[0];
//        }
//        String day;
//        if(date1.split("/")[1].startsWith("0"))
//        {
//            day= date1.split("/")[1].replace("0","");
//        }
//        else{
//            day= date1.split("/")[1];
//        }
//        String finaldate = month+"/"+day+"/"+date1.split("/")[2];
//        System.out.println(finaldate);
//        System.out.println("data"+data);
////        Assert.assertEquals(data,finaldate, "Value not matched!!");
//        Stringcomparator(data.toLowerCase(),finaldate.toLowerCase());
//
//    }
//    @Then("^Verify that the \"([^\"]*)\" display \"([^\"]*)\" for css property name \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void VerifyThatElementDisplayCssPropertyName(String Locators,String CssValue,String AttributeName, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = webDriver.returnCssPropertyName(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),AttributeName);
//        Assert.assertEquals(data.toLowerCase(),CssValue.toLowerCase(), "Value not matched!!");
//    }
//
//    @Then("^Verify that the element \"([^\"]*)\" is checked on the \"([^\"]*)\" Page$")
//    public void verifyElementIsChecked(String Locators,String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//       boolean flag= webDriver.ReturnElementCheckStatus(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//      Assert.assertTrue(flag,"Element not checked");
//    }
//    @Then("^Verify that the URL of current page is \"([^\"]*)\"$")
//    public void VerifyCurrentPageURL(String CurrentURL) throws Throwable
//    {
//        System.out.println(webDriver.CurrentURL());
//        webDriver.verifyCurrentURL(CurrentURL);
//    }
//    @Then("^Verify that an Alert is not present$")
//    public void VerifyThatAnAlertIsNotPresent() throws Throwable
//    {
//        Assert.assertFalse(webDriver.verifyAlertPresent(),"Alert present on Page");
//    }
//    @Then("^Verify that the Alert displays the message as \"([^\"]*)\"$")
//    public void VerifyAlertMessage(String AlertMessage) throws Throwable
//    {
//        Assert.assertEquals(webDriver.returnAlertMessage(),AlertMessage.trim(), "Value not matched!!");
//    }
//    @Then("^Set the title of current page in a variable \"([^\"]*)\"$")
//    public void storeTitleOfPage(String Title) throws Throwable
//    {
//        HashMap<String, String> Variables = new HashMap<>();
//        Variables.put(Title,webDriver.GetTitle());
//        Variables.putAll(DriverInstance.getVariables());
//        DriverInstance.setVariables(Variables);
//    }
//    @Then("^Get the title of current page from a variable \"([^\"]*)\"$")
//    public void getTitleOfPage(String Title) throws Throwable
//    {
//        DriverInstance.getVariables().get(Title);
//    }
//    @Then("^Set the Application URL into \"([^\"]*)\"$")
//    public void StoreURLOfApplication(String URL) throws Throwable
//    {
//        HashMap<String, String> Variables = new HashMap<>();
//        Variables.put(URL,webDriver.CurrentURL());
//        DriverInstance.setVariables(Variables);
//    }
//    @Then("^Get the URL of Application from a variable \"([^\"]*)\"$")
//    public void getURLOfApplication(String URL) throws Throwable
//    {
//        DriverInstance.getVariables().get(URL);
//    }
//
//    @Then("^Set the value of attribute \"([^\"]*)\" from \"([^\"]*)\" on the \"([^\"]*)\" page in a variable \"([^\"]*)\"$")
//    public void storeAttributeOfElement(String AttributeName,String Locators,String PageName,String VariableName) throws Throwable
//    {
//        HashMap<String, String> Variables = new HashMap<>();
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = webDriver.returnElementAttrubuteValue(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),AttributeName);
//        Variables.put(VariableName,data);
//        Variables.putAll(DriverInstance.getVariables());
//        DriverInstance.setVariables(Variables);
//    }
//    @Then("^Get the value of attribute \"([^\"]*)\" from a variable \"([^\"]*)\"$")
//    public void getValueOfAttribute(String AttributeName,String VariableName) throws Throwable
//    {
//        System.out.println(AttributeName);
//        DriverInstance.getVariables().get(VariableName);
//    }
//    @Then("^Set the value displayed in \"([^\"]*)\" on the \"([^\"]*)\" page in a variable \"([^\"]*)\"$")
//    public void storeValueOfElement(String Locators,String PageName,String VariableName) throws Throwable
//    {
//        HashMap<String, String> Variables = new HashMap<>();
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = webDriver.returnElementAttrubuteValue(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),"value");
//        Variables.put(VariableName,data);
//        Variables.putAll(DriverInstance.getVariables());
//        DriverInstance.setVariables(Variables);
//    }
//    @Then("^Get the value of Element from a variable \"([^\"]*)\"$")
//    public void getValueOfElement(String VariableName) throws Throwable
//    {
//        DriverInstance.getVariables().get(VariableName);
//    }
//    @Then("^Set URL of the current page in a variable \"([^\"]*)\"$")
//    public void storeURLOfPage(String variable) throws Throwable
//    {
//        HashMap<String, String> Variables = new HashMap<>();
//        Variables.put(variable,webDriver.CurrentURL());
//        Variables.putAll(DriverInstance.getVariables());
//        DriverInstance.setVariables(Variables);
//    }
//    @Then("^Get the URL of current page from a variable \"([^\"]*)\"$")
//    public void getCurrentURLOfPage(String variable) throws Throwable
//    {
//        DriverInstance.getVariables().get(variable);
//    }
//    @Then("^Set text of the selected option from list \"([^\"]*)\" on the \"([^\"]*)\" page in a variable \"([^\"]*)\"$")
//    public void storeSelectedOptionFromList(String Locators,String PageName,String VariableName) throws Throwable
//    {
//        HashMap<String, String> Variables = new HashMap<>();
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = webDriver.returnValueSelectedInList(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//        Variables.put(VariableName,data);
//        Variables.putAll(DriverInstance.getVariables());
//        DriverInstance.setVariables(Variables);
//    }
//    @Then("^Get text of the selected option from list from a variable \"([^\"]*)\"$")
//    public void getSelectedOptionFromList(String variable) throws Throwable
//    {
//        DriverInstance.getVariables().get(variable);
//
//    }
//    @Then("^Set count of options in the List \"([^\"]*)\" on the \"([^\"]*)\" page in a variable \"([^\"]*)\"$")
//    public void storeOptionCountFromList(String Locators,String PageName,String VariableName) throws Throwable
//    {
//        HashMap<String, String> Variables = new HashMap<>();
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = String.valueOf(webDriver.returnOptionsCountsInList(webDriver.getwebelement(locators.getlocator("//locators/" + Locators))));
//        Variables.put(VariableName,data);
//        Variables.putAll(DriverInstance.getVariables());
//        DriverInstance.setVariables(Variables);
//    }
//    @Then("^Get count of options in the List from a variable \"([^\"]*)\"$")
//    public void getOptionCountFromList(String variable) throws Throwable
//    {
//        DriverInstance.getVariables().get(variable);
//    }
//    @Then("^Set the count of elements identified by locator \"([^\"]*)\" on the \"([^\"]*)\" page in a variable \"([^\"]*)\"$")
//    public void storeElementCountByLocators(String Locators,String PageName,String VariableName) throws Throwable
//    {
//        HashMap<String, String> Variables = new HashMap<>();
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = String.valueOf(webDriver.getwebelementscount(locators.getlocator("//locators/" + Locators)));
//        Variables.put(VariableName,data);
//        Variables.putAll(DriverInstance.getVariables());
//        DriverInstance.setVariables(Variables);
//    }
//    @Then("^Get the count of elements identified by locator from a variable \"([^\"]*)\"$")
//    public void storeElementCountByLocators(String variable) throws Throwable
//    {
//        DriverInstance.getVariables().get(variable);
//    }
//    @Then("^Set text from \"([^\"]*)\" on the \"([^\"]*)\" page in a variable \"([^\"]*)\"$")
//    public void storeElementText(String Locators,String PageName,String VariableName) throws Throwable
//    {
//        HashMap<String, String> Variables = new HashMap<>();
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = webDriver.getText(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//        Variables.put(VariableName,data);
//        Variables.putAll(DriverInstance.getVariables());
//        DriverInstance.setVariables(Variables);
//        System.out.println("VariableName :"+DriverInstance.getVariables().get(VariableName));
//    }
//    @Then("^Get Element Text from a variable \"([^\"]*)\"$")
//    public void GetElementText(String variable) throws Throwable
//    {
//        DriverInstance.getVariables().get(variable);
//    }
//    @Then("^Set Tag Name of \"([^\"]*)\" on the \"([^\"]*)\" page in a variable \"([^\"]*)\"$")
//    public void storeElementTagName(String Locators,String PageName,String VariableName) throws Throwable
//    {
//        HashMap<String, String> Variables = new HashMap<>();
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = webDriver.returnElementTagName(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//        Variables.put(VariableName,data);
//        Variables.putAll(DriverInstance.getVariables());
//        DriverInstance.setVariables(Variables);
//    }
//    @Then("^Get Tag Name from a variable \"([^\"]*)\"$")
//    public void getElementTagName(String variable) throws Throwable
//    {
//        DriverInstance.getVariables().get(variable);
//    }
//
//    @Then("^Verify that the \"([^\"]*)\" on the \"([^\"]*)\" page has value \"([^\"]*)\"$")
//    public void VerifyThatElementHasValue(String Locators, String PageName,String AttributeValue) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = webDriver.returnElementAttrubuteValue(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),"value");
//        Assert.assertEquals(data.toLowerCase(),AttributeValue.toLowerCase(), "Value not matched!!");
//    }
//    @Then("^Verify that the \"([^\"]*)\" on the \"([^\"]*)\" page displays text \"([^\"]*)\"$")
//    public void VerifyThatElementDisplaysText(String Locators, String PageName,String Text) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = webDriver.getText(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//        Assert.assertEquals(data.toLowerCase(),Text.toLowerCase(), "Text not matched!!");
//    }
//
//    @Then("^Select element by label \"([^\"]*)\" in the radio button group$")
//    public void SelectRadioElementByLabelName(String LabelName) throws Throwable
//    {
//      webDriver.Clickon(webDriver.getwebelement("//Label[text()='"+LabelName+"'"));
//    }
//    @Then("^Select option by value \"([^\"]*)\" in the list \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void SelectOptionByValue(String selectByValue,String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.selectOptionByValue(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),selectByValue);
//
//    }
//    @Then("^Select option by text \"([^\"]*)\" in the list \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void SelectOptionByText(String selectByText,String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.selectOptionByText(webDriver.getwebelement(locators.getlocator(Locators)),selectByText);
//
//    }
//    @Then("^Select option by index \"([^\"]*)\" in the list \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void SelectOptionByIndex(String selectByIndex,String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.selectOptionByIndex(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),selectByIndex);
//
//    }
//    @Then("^Right click on the element \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void RightClickonElementElement(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.ActionWithElement(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),"RightClick");
//
//    }
//    @Then("^Mouseover on the element \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void MouseoverWithElement(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.ActionWithElement(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),"Mouseover");
//
//    }
//    @Then("^Double click on the element \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void DoubleClickWithElement(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.ActionWithElement(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),"DoubleClick");
//
//    }
//    @Then("^Drag the element \"([^\"]*)\" and drop on the element \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void DragAndDropElement(String Locators,String Locators2, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.DragAndDropElement(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),webDriver.getwebelement(locators.getlocator("//locators/" + Locators2)));
//
//    }
//
//    @Then("^Switch to the window By title \"([^\"]*)\"")
//    public void SwitchToWindowWithTitle(String WindowTitle) throws Throwable
//    {
//        webDriver.SwitchWindowTitled(WindowTitle);
//
//    }
//    @Then("^Switch to the Next Tab")
//    public void SwitchToNextTab() throws Throwable
//    {
//        webDriver.SwitchToNextTab();
//
//    }
//    @Then("^Switch to the window By Index \"([^\"]*)\"")
//    public void SwitchWindowByIndex(String index) throws Throwable
//    {
//        webDriver.SwitchWindowByIndex(index);
//
//    }
//    @Then("^Switch to the parent Window")
//    public void SwitchToParentWindod() throws Throwable
//    {
//        webDriver.SwitchToParentWindod();
//
//    }
//    @Then("^Close the current window")
//    public void CloseCurrentWindows() throws Throwable
//    {
//        webDriver.CloseWindowByIndex("1");
////
//
//    }
//    @Then("^Close all windows")
//    public void CloseAllWindows() throws Throwable
//    {
//        webDriver.CloseAllWindows();
//
//    }
//    @Then("^Close the window with title \"([^\"]*)\"")
//    public void CloseWindowByTitle(String WindowTitle) throws Throwable
//    {
//        webDriver.CloseWindowByTitle(WindowTitle);
//
//    }
//    @Then("^Close the window with index \"([^\"]*)\"")
//    public void CloseWindowByIndex(String index) throws Throwable
//    {
//        webDriver.CloseWindowByIndex(index);
//
//    }
//    @Then("^Go to \"([^\"]*)\"$")
//    public void GotoURL(String URL) throws Throwable
//    {
//        webDriver.GOto(URL);
//
//    }
//    @Then("^Switch to the parent page")
//    public void SwitchToParentPage() throws Throwable
//    {
//        webDriver.SwitchToParentPage();
//
//    }
//    @Then("^Switch to the parent frame of the active element")
//    public void SwitchToParentFrame() throws Throwable
//    {
//        webDriver.SwitchToParentFrame();
//
//    }
//    @Then("^Switch to the frame named \"([^\"]*)\"")
//    public void SwitchToFrame(String frameName) throws Throwable
//    {
//        webDriver.SwitchToFrame(frameName);
//
//    }
//    @Then("^Switch to the frame by index \"([^\"]*)\"")
//    public void SwitchToFrameByIndex(String URL) throws Throwable
//    {
//        webDriver.SwitchToFrameByIndex(URL);
//
//    }
//    @Then("^Switch to the frame By element \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void SwitchToFrameByElement(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.SwitchToFrameByElement(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//
//    }
//    @Then("^Delete cookie with name \"([^\"]*)\"")
//    public void DeleteCookies(String Cookies) throws Throwable
//    {
//        webDriver.DeleteCookiesWithName(Cookies);
//
//    }
//    @Then("^Delete all cookies from the current session")
//    public void DeleteAllCookies() throws Throwable
//    {
//        webDriver.DeleteAllCookies();
//
//    }
//    @Then("^Click on the Refresh button in the browser")
//    public void Refresh() throws Throwable
//    {
//        webDriver.Refresh();
//
//    }
//    @Then("^Click on the Forward button in the browser")
//    public void Forward() throws Throwable
//    {
//        webDriver.Forward();
//
//    }
//    @Then("^Click on the Back button in the browser")
//    public void Back() throws Throwable
//    {
//        webDriver.Back();
//
//    }
//    @Then("^Click OK button in the alert")
//    public void AcceptAlert() throws Throwable
//    {
//        webDriver.AcceptAlert();
//
//    }
//    @Then("^Click on Cancel button in the alert")
//    public void CancelAlert() throws Throwable
//    {
//        webDriver.CancelAlert();
//
//    }
////    @Then("Open new Tabs with index {Param} on opened Browser")
////    public void OpenTabs(String tab ) throws Throwable
////    {
////        webDriver.OpenNewTab(Integer.parseInt(tab));
////
////    }
//    @Then("^Click on element \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void ClickOn(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//            try {
//                webDriver.Clickon(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//            } catch (Exception e) {
//                webDriver.waitforElementtobeclickable(locators.getlocator("//locators/" + Locators));
//                webDriver.Clickon(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//
//            }
//
//    }
//    @Then("^Click on element \"([^\"]*)\" with text \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void ClickOn1(String Locators,String ActualText, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName.toLowerCase() + ".xml");
//        try {
//            webDriver.Clickon(webDriver.getwebelement(locators.getlocator(Locators).replace("{paramlink}",ActualText)));
//        } catch (Exception e) {
//            webDriver.waitforElementtobeclickable(locators.getlocator(Locators).replace("{paramlink}",ActualText));
//            webDriver.Clickon(webDriver.getwebelement(locators.getlocator(Locators).replace("{paramlink}",ActualText)));
//
//        }
//
//    }
//    @Then("^Click If element \"([^\"]*)\" is visible on the \"([^\"]*)\" page$")
//    public void ClickOnIfElementVisible(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//
//        int count= webDriver.getwebelementscount(locators.getlocator("//locators/" + Locators));
//        if(count>0) {
//            webDriver.Clickon(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//        }
//    }
//
//    @Then("^Clear the value displayed in the \"([^\"]*)\" field on the \"([^\"]*)\" page$")
//    public void ClearTheValueDisplayed(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.ClearAttributeValue(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//
//    }
//    @Then("^Clear the text displayed in the \"([^\"]*)\" field on the \"([^\"]*)\" page$")
//    public void ClearThetextDisplayed(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.ClearText(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//
//    }
//
//    @Then("^Verify that the link \"([^\"]*)\" opens in a new window or tab on the \"([^\"]*)\" page$")
//    public void OpenLinkIntoNewTabOrWindow(String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.verifyLinksOpenNewTanOrWindows(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//
//    }
//    @Then("^Update parameter \"([^\"]*)\" with value of \"([^\"]*)\" attribute from the element \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void setAttribute(String AttValue, String Attributename,String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.setAttributeUsingJS(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),Attributename,AttValue);
//
//    }
//
//    @Then("^Verify that the element \"([^\"]*)\" on the \"([^\"]*)\" page displays a value less than \"([^\"]*)\"$")
//    public void VerifyValueLessThan(String Locators, String PageName,  String ExpValue) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.VerifyElementValueLessThan(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),Integer.parseInt(ExpValue));
//    }
//    @Then("^Verify that the element \"([^\"]*)\" on the \"([^\"]*)\" page displays a value greater than \"([^\"]*)\"$")
//    public void VerifyValueGreaterThan(String Locators, String PageName,  String ExpValue) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.VerifyElementValueGreaterThan(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),Integer.parseInt(ExpValue));
//    }
//
//    @Then("^Verify that the element \"([^\"]*)\" on the \"([^\"]*)\" page displays a value less than or equal to \"([^\"]*)\"$")
//    public void VerifyValueLessThanOrEqualTo(String Locators, String PageName,  String ExpValue) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.VerifyElementValueLessThanOrEqualTo(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),Integer.parseInt(ExpValue));
//    }
//    @Then("^Verify that the element \"([^\"]*)\" on the \"([^\"]*)\" page displays a value greater than or equal to \"([^\"]*)\"$")
//    public void VerifyValueGreaterThanOrEqualTo(String Locators, String PageName,  String ExpValue) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.VerifyElementValueGreaterThanOrEqualTo(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),Integer.parseInt(ExpValue));
//    }
//    @Then("^Upload file \"([^\"]*)\" with element \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void UploadFile(String FilePath, String Locators, String PageName) throws Throwable
//    {
//        String str = System.getProperty("user.dir")+"/src/test/resources/dataSource/"+FilePath;
//
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.SendKeys(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),str);
//    }
//    @Then("^Upload file \"([^\"]*)\"$")
//    public void UploadFile1(String FilePath) throws Throwable
//    {
//        String str = System.getProperty("user.dir")+"/src/test/resources/dataSource/"+FilePath;
//        File file = new File(str);
//        String filepath= file.getAbsolutePath();
//        StringSelection stringSelection = new StringSelection(filepath);
//        Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
//        clipboard.setContents(stringSelection, null);
//        Thread.sleep(2000);
//        keyEvent();
//   }
//    private static Clipboard getSystemClipboard()
//    {
//        Toolkit defaultToolkit = Toolkit.getDefaultToolkit();
//        return defaultToolkit.getSystemClipboard();
//    }
//  public void keyEvent() throws AWTException {
//      Robot robot = new Robot();
//
//      robot.keyPress(KeyEvent.VK_CONTROL);
//      robot.keyPress(KeyEvent.VK_V);
//      robot.keyPress(KeyEvent.VK_ENTER);
//      robot.keyRelease(KeyEvent.VK_CONTROL);
//      robot.keyRelease(KeyEvent.VK_V);
//      robot.keyRelease(KeyEvent.VK_ENTER);
//  }
//    @Then("^Enter text \"([^\"]*)\" in the element \"([^\"]*)\" field on the \"([^\"]*)\" page$")
//    public void EnterText(String Text, String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName.toLowerCase() + ".xml");
//       try {
//           webDriver.SendKeys(webDriver.getwebelement(locators.getlocator( Locators)), Text);
//       }
//       catch(Exception e)
//       {
//           webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(locators.getlocator(Locators)));
//           webDriver.SendKeys(webDriver.getwebelement(locators.getlocator(Locators)), Text);
//
//       }
//        webDriver.SendkeaboardKeys(webDriver.getwebelement(locators.getlocator(Locators)), Keys.ENTER);
//
//    }
//
//    @Then("^Enter text \"([^\"]*)\"$")
//    public void EnterTextUsingActions(String Text) throws Throwable
//    {
//            webDriver.EnterTextUsingActions(Text);
//    }
//
//    @Then("^Verify that the \"([^\"]*)\" display Text  contains \"([^\"]*)\" on the \"([^\"]*)\" page$")
//    public void VerifyThatElementContainsText(String Locators,String Text, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        String data = webDriver.getText(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//        Assert.assertTrue(data.contains(Text.trim()), "Value not matched!!");
//
//    }
//    @Then("^Enter text \"([^\"]*)\" in the element \"([^\"]*)\" field on the \"([^\"]*)\" page using javascript executor$")
//    public void EnterTextUsingJS(String Text, String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.SendKeysUsingJS(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)),Text);
//    }
//    @Then("^Click on element \"([^\"]*)\" on the \"([^\"]*)\" page to open in a new window and switch to the new window$")
//    public void ClickOnElementToOpenInNewWindowAndSwitchToIt(String Text, String Locators, String PageName) throws Throwable
//    {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.ClickOnElementToOpenInNewWindowAndSwitchToIt(webDriver.getwebelement(locators.getlocator("//locators/" + Locators)));
//    }
//    @Then("^Press Enter/Return Key$")
//    public void PressEnter() throws Throwable
//    {
//        webDriver.SendKeyBoardKeysUsingActions(Keys.ENTER);
//    }
//    @Then("^Press Tab Key$")
//    public void PressTab() throws Throwable
//    {
//        webDriver.SendKeyBoardKeysUsingActions(Keys.TAB);
//    }
//    @Then("^Press Esc Key$")
//    public void PressEsc() throws Throwable
//    {
//        webDriver.SendKeyBoardKeysUsingActions(Keys.ESCAPE);
//    }
//
//    @Then("^Press Shift+Delete Keys$")
//    public void PressShiftAndDelete() throws Throwable
//    {
//        webDriver.PressShiftDelete();
//    }
//    @Then("^Press \"([^\"]*)\" Key$")
//    public void PressKeys(String text) throws Throwable
//    {
//        webDriver.SendKeyBoardKeysUsingActions(Keys.valueOf(text));
//    }
//
//    @Then("^Log: \"([^\"]*)\"$")
//    public static void log(String message)
//    {
//        System.out.println(message);
//        ExtentCucumberAdapter.addTestStepLog("<table style='color:DarkGreen;'><tr><td><b>"+message+"</b></td></tr><tr></table>");
//
//    }
//
//    @Then("^Log: \"([^\"]*)\" is : \"([^\"]*)\"$")
//    public void log1(String message, String VariableName)
//    {
//        System.out.println(message);
//        String VariableValue = DriverInstance.getVariables().get(VariableName);
//        ExtentCucumberAdapter.addTestStepLog("<table><tr><td><b>"+message+" is : "+VariableValue+"</b></td></tr><tr></table>");
//    }
//
//    @Then("^Scroll Into \"([^\"]*)\" on \"([^\"]*)\" Page$")
//    public  void Scroll(String Locators, String PageName) throws DocumentException, InterruptedException {
//        locators = new xmlreader("src\\test\\resources\\locators\\" + PageName + ".xml");
//        webDriver.ScrollIntoView(webDriver.getwebelement(locators.getlocator("//locators/"+ Locators)));
//
//    }
//    public void Stringcomparator(String actual, String expected) {
//        System.out.println("Actual String : " + actual);
//        System.out.println("Expected String : " + expected);
//
//        if (expected == null || expected.equals("N/A")) {
//            expected = "";
//        }
//        if (actual == null) {
//            actual = "";
//        }
//
//        try {
//            Assert.assertEquals(expected, actual);
//        } catch (AssertionError e) {
//            ExtentCucumberAdapter.addTestStepLog("Assertion Failed Due to" + e.getMessage());
//            System.out.println("Assertion Failure cought - "+actual+" VS "+expected);
//            ExtentCucumberAdapter.addTestStepLog("<table style='color:red;'><tr><td><b>Actual</b></td><td><b>Expected</b></td></tr><tr>");
//            ExtentCucumberAdapter.addTestStepLog("<td>" + actual +   "</td><td> " + expected + " </td></tr></table>");
//            SoftAssert softAssert = new SoftAssert();
//            softAssert.assertFalse(true);
//            softAssert.fail();
//
//        }
//    }
}
