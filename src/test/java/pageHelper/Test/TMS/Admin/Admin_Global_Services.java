package pageHelper.Test.TMS.Admin;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Log4j
public class Admin_Global_Services {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader PageObject;
    public xmlreader Generic;
    public PropertyReader propertyReader = new PropertyReader();
    public List<String> searchResults = new ArrayList<>();

    public Admin_Global_Services(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        PageObject = new xmlreader("TMS Admin" + File.separator + "Global_Services_Credentials.xml");
        Generic = new xmlreader("Generics" + File.separator + "Common.xml");
    }
    @Then("Ensure the {string} is displayed with count {string}")
    public void ensureTheDisplayedWithCount(String arg0, String arg1) throws DocumentException, InterruptedException {
        String Actual = webDriver.getText(Generic.getlocator("SpanText1").replace("{paramlink}", arg0 + " (" + arg1 + ")"));
        String Expected = arg0 + " (" + arg1 + ")";
        webDriver.Stringcomparator(Actual, Expected);
        System.out.println("Expected");
    }

    @Then("Search text {string} in the {string} search box")
    public void searchTextInTheSearchBox(String arg0, String arg1) throws Exception {
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(Generic.getlocator("SearchBox").replace("{paramlink}", arg1)));
        webDriver.SendKeys(webDriver.getwebelement(Generic.getlocator("SearchBox").replace("{paramlink}", arg1)), arg0);
        webDriver.waitForElementLoad(1);
        // webDriver.getwebelement(Generic.getlocator("SearchBox").isBlank());
       //  Boolean flag= webDriver.getText(Generic.getlocator("SearchBox").replace("{paramlink}", arg1)).isEmpty();
    }

    @Then("verify the search result is correct for searched text {string}")
    public void verifyTheSearchResultIsCorrectForSearchedText(String searchTerm) throws DocumentException, InterruptedException {
        webDriver.getWebElements(Generic.getlocator("SearchList")).stream().forEach(X -> searchResults.add(((WebElement) X).getText()));
        System.out.println(searchResults.size() + " Search results are found");
        System.out.println("Search results details are: " + searchResults);

    }

    @Then("Select the {string} record from the lookup field results")
    public void selectTheRecordFromTheLookupFieldResults(String arg0) throws Exception {
        if(webDriver.getwebelementscount(Generic.getlocator("Search_Result").replace("{paramlink}", arg0))>0) {
            webDriver.waitUntilElementIsVisible(Generic.getlocator("Search_Result").replace("{paramlink}", arg0));
            webDriver.Clickon(webDriver.getwebelement(Generic.getlocator("Search_Result").replace("{paramlink}", arg0)));
        }
        else{
            webDriver.waitUntilElementIsVisible(Generic.getlocator("SearchBox").replace("{paramlink}", "Search Credentials..."));
            webDriver.SendKeys(webDriver.getwebelement(Generic.getlocator("SearchBox").replace("{paramlink}", "Search Credentials...")), arg0);
            webDriver.waitForElementLoad(2);
            webDriver.waitUntilElementIsVisible(Generic.getlocator("Search_Result").replace("{paramlink}", arg0));
            webDriver.Clickon(webDriver.getwebelement(Generic.getlocator("Search_Result").replace("{paramlink}", arg0)));
        }
        webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("GlobalServicesHeader").replace("{paramlink}", arg0)));
        String ActualText = webDriver.getText(webDriver.getwebelement(Generic.getlocator("GlobalServicesHeader").replace("{paramlink}", arg0)));
        webDriver.Stringcomparator(ActualText, arg0);
    }

    @Then("Search and Select {string} Service")
    public void searchAndSelectServices(String ServiceName) throws Exception {
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("SearchBox").replace("{paramlink}", "Search Credentials...")));
        webDriver.SendKeys(webDriver.passwebelement(Generic.getlocator("SearchBox").replace("{paramlink}", "Search Credentials...")), ServiceName);
        webDriver.waitForElementLoad(1);
        webDriver.Clickon(webDriver.passwebelement(Generic.getlocator("Search_Result").replace("{paramlink}", ServiceName)));
        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("GlobalServicesHeader").replace("{paramlink}", ServiceName)));
        String ActualText = webDriver.getText(webDriver.passwebelement(Generic.getlocator("GlobalServicesHeader").replace("{paramlink}", ServiceName)));
        webDriver.Stringcomparator(ActualText, ServiceName);
    }


    @Then("Select from List and Verify details for all Enabled fields for {string} service")
    public void verifyDetailsForEnabledService(String arg0, DataTable dt) throws Exception {
//        searchAndSelectServices(arg0);
        try {
//            webDriver.scrollAndSelectRecord(arg0);
            webDriver.scrollRecordFromList2(arg0);
            Thread.sleep(1200);
            validateServicesData(dt, Boolean.TRUE);
        }
        catch (Exception e)
        {
            webDriver.scrollAndSelectRecord(arg0);
            Thread.sleep(1000);
            validateServicesData(dt, Boolean.TRUE);
        }
    }

    @Then("Update details under {string} section")
    public void updatedDetailsforsection(String arg0, DataTable dt) throws Exception {
        expandSection(arg0);
        //     validateServicesData(dt,Boolean.TRUE);

        updateServicesData(dt);
    }

    private void expandSection(String arg0) throws Exception {
//        if(webDriver.isElementPresent("//*[@title='Show Section - "+arg0+"']")){
//            webDriver.Clickon();
//        }
        WebElement el = webDriver.getwebelement("//*[@title='Hide Section - " + arg0 + "']");
        webDriver.ScrollIntoView(el);

    }


    @Then("Verify details for all Disabled or Readonly fields for {string} service")
    public void verifyDetailsForDisabledService(String arg0, DataTable dt) throws Exception {

        validateServicesData(dt,Boolean.FALSE);
    }

    @Then("Update details for {string} service")
    public void updateDetailsForenabledService(String arg0, DataTable dt) throws Exception {

        updateServicesData(dt);
    }

    @Then("Click on Native {string} button")
    public void ClickonNativeSalesforceButton(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("ButtonText").replace("{paramlink}", arg0)));
        webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonText").replace("{paramlink}", arg0));
        webDriver.ClickOnElement(webDriver.passwebelement(Generic.getlocator("ButtonText").replace("{paramlink}", arg0)));
    }

    public void validateServicesData(DataTable dt, Boolean isenabled) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
///Read from External source

        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {

                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                String Current_locator = Generic.getlocator("LabelText");
                String fieldName = "";
                if (entry.getKey().contains("-")) {
                    String index = entry.getKey().split("-")[1];
                    String fieldsname = entry.getKey().split("-")[0];
                    String final_locator = "(" + Current_locator + ")[" + index + "]";
                    fieldName = webDriver.getwebelement(final_locator.replace("{paramlink}", fieldsname)).getAttribute("for");
                } else {
                    fieldName = webDriver.getwebelement(Current_locator.replace("{paramlink}", entry.getKey())).getAttribute("for");
                    System.out.println("Man"+Current_locator.replace("{paramlink}", entry.getKey()));
                    System.out.println(fieldName);
                }
//                String fieldName = webDriver.getwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())).getAttribute("for");
                WebElement element = webDriver.passwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
                webDriver.ScrollIntoView(element);
                String Tag = element.getTagName();
                String type = element.getAttribute("type");
                System.out.println(type);
                if (Tag.equalsIgnoreCase("input") && type.equalsIgnoreCase("text")) {
                    String ActualText = webDriver.Getattribute(element, "value");
                    System.out.println("Actual Test:" + ActualText);
                    Boolean enabled = element.isEnabled();
                    Boolean readonly = Boolean.valueOf(webDriver.Getattribute(element, "readonly"));
                    System.out.println("Read only Value" + readonly);
                    System.out.println("Enable Value" + enabled);
                    if (entry.getKey().equalsIgnoreCase("Record Id") || entry.getKey().equalsIgnoreCase("Code")) {
                        System.out.println("Skipping Validation");
                    }
                    else if (entry.getKey().equalsIgnoreCase("Record Id-2") || entry.getKey().equalsIgnoreCase("Code-2")|| entry.getKey().equalsIgnoreCase("Parent Record Id")) {
                        System.out.println("Skipping Validation");
                    }
                    else {
                        Boolean actualSate = (enabled && !readonly);
                        Assert.assertEquals(actualSate, isenabled);
                        webDriver.Partialstringcomparator(ActualText, entry.getValue());
                    }


                }
                else if (Tag.equalsIgnoreCase("input") && type.equalsIgnoreCase("password")) {
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
                    System.out.println("Current Fields:" + entry.getKey() + " is Encrypted as this is Password type Element");

                }
                else if (Tag.equalsIgnoreCase("input") && type.equalsIgnoreCase("checkbox")) {
//                     System.out.println(element.getAttribute("checked"));
//                    boolean isChecked  = "true".equalsIgnoreCase(element.getAttribute("checked"));
                    boolean isChecked  = webDriver.checkSelectedUsingJS(element);
                        System.out.println( isChecked+"Man" +new Date());
                        if (isChecked) {
                            System.out.println("Checkbox is checked");

                        } else {
                            System.out.println("Checkbox is unchecked");
                        }
//                        Assert.assertEquals(isChecked,Boolean.valueOf(entry.getValue()));

//                    boolean isChecked = element.isSelected();
//                    if (isChecked) {
//                        System.out.println("Checkbox is checked");
//                    } else {
//                        System.out.println("Checkbox is unchecked");
//                    }

//                    String ActualState = webDriver.Getattribute(element, "checked");
//                    webDriver.Stringcomparator(ActualState.toLowerCase(), entry.getValue().toLowerCase());
//                    Assert.assertEquals(element.isEnabled(),isenabled);
                }
            }
        }
    }

    public void updateServicesData(DataTable dt) throws Exception {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
///Read from External source

        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {

                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());

                String fieldName = webDriver.getwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())).getAttribute("for");
                WebElement element = webDriver.passwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
                webDriver.ScrollIntoView(element);
                String Tag = element.getTagName();
                String type = element.getAttribute("type");

                if (Tag.equalsIgnoreCase("input") && type.equalsIgnoreCase("text")) {
                    //   webDriver.SendKeys(element, DriverInstance.getThreadLocalMapValue(entry.getKey()));
                    if(entry.getValue().contains("SysData"))
                    {
                        webDriver.SendKeys(element, DriverInstance.getVariable(entry.getValue().split("=>")[1]));
                    }
                    else {
                        webDriver.SendKeys(element, entry.getValue());
                    }
                } else if (Tag.equalsIgnoreCase("input") && type.equalsIgnoreCase("password")) {
                    //   webDriver.SendKeys(element, DriverInstance.getThreadLocalMapValue(entry.getKey()));
//                    String ActualText = webDriver.getAttributeValueUsingJavascript(element);
                    webDriver.SendKeys(element, entry.getValue());
                } else if (Tag.equalsIgnoreCase("input") && type.equalsIgnoreCase("checkbox")) {
                    //    webDriver.SendKeys(element, DriverInstance.getThreadLocalMapValue(entry.getKey()));
//                    webDriver.Clickon(element);

                    webDriver.ScrollIntoView(element);
                    if (entry.getValue().equalsIgnoreCase("False")) {
                        boolean isChecked = "true".equalsIgnoreCase(element.getAttribute("checked"));
                        if (isChecked) {
                            try {
                                webDriver.ClickOnElement(element);
                            } catch (Exception e) {
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
                            }
                        }

                    }
                    else {
                        System.out.println("Man" + element.getAttribute("checked"));
                        boolean isChecked = "true".equalsIgnoreCase(element.getAttribute("checked"));
                        if (!isChecked) {
                            try {
                                webDriver.ClickOnElement(element);
                            } catch (Exception e) {
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
                            }
                        }
                    }
                }
            }
        }
    }

    @And("Update the Custom Select option {string} as {string}")
    public void updateTheCustomSelectOptionAs(String arg0, String arg1) throws DocumentException, InterruptedException, IOException {

        if (arg1.contains("SysData")) {
            arg1 = DriverInstance.getVariable(arg1.split("=>")[1]);
        }
        WebElement fieldName = webDriver.getwebelement(Generic.getlocator("CustomSelect").replace("{paramlink}", arg0));
        if (!arg1.isEmpty()) {
            webDriver.Select(fieldName, arg1);
        } else {
            webDriver.selectOptionByIndex(fieldName, "0");
        }
    }

    @Then("Set Field Value {string} into {string} Value")
    public void setGlobalServiceIntoValue(String arg0, String arg1) throws DocumentException, InterruptedException {
        DriverInstance.setVariable(arg1,GetValue(arg0));
        System.out.println(arg1+" : "+GetValue(arg0));
    }

    public String GetValue(String Key) throws DocumentException, InterruptedException {
        String Current_locator = Generic.getlocator("LabelText");
        String fieldName = "";
        if (Key.contains("-")) {
            String index = Key.split("-")[1];
            String fieldsname = Key.split("-")[0];
            String final_locator = "(" + Current_locator + ")[" + index + "]";
            fieldName = webDriver.getwebelement(final_locator.replace("{paramlink}", fieldsname)).getAttribute("for");
        } else {
            fieldName = webDriver.getwebelement(Current_locator.replace("{paramlink}", Key)).getAttribute("for");

        }
        WebElement element = webDriver.getwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
        webDriver.ScrollIntoView(element);
        String ActualText = webDriver.Getattribute(element, "value");

        return ActualText;
    }


    @And("Global Service : Close Credential")
    public void globalServiceCloseCredential() throws DocumentException, InterruptedException {
         webDriver.ScrollIntoView(webDriver.passwebelement(PageObject.getlocator("CloseButton")));
         webDriver.waitforElementtobeclickable(PageObject.getlocator("CloseButton"));
         webDriver.ClickOnElement(webDriver.passwebelement(PageObject.getlocator("CloseButton")));
    }

    @Then("Verify {string} search box is {string}")
    public void verifySearchBoxIsBlank(String arg0, String arg1) throws DocumentException, InterruptedException {

        webDriver.waitUntilElementIsVisible(Generic.getlocator("SearchBox").replace("{paramlink}", arg0));
        String value = webDriver.Getattribute(webDriver.getwebelement(Generic.getlocator("SearchBox").replace("{paramlink}", arg0)), "value");
        webDriver.Stringcomparator(value,arg1);
    }

    @Then("Verify {string} Row {string} Column value as {string}")
    public void verifyRowColumnValueAs(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException {
       WebElement wl = webDriver.passwebelement(PageObject.getlocator("CredentialCoumnValue").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1));
       String value= webDriver.Getattribute(wl,"data-cell-value");
       webDriver.Stringcomparator(value,arg2);
    }
}