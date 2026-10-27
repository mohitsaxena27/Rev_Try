package pageHelper.Utility;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import org.dom4j.DocumentException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;
import org.testng.Assert;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import static org.yaml.snakeyaml.tokens.Token.ID.Key;

public class CommonFunction_Frame {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader Generic;
    public PropertyReader propertyReader = new PropertyReader();

    public CommonFunction_Frame(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        Generic = new xmlreader("Generics" + File.separator + "CommonFrame.xml");

    }
    public void validateServicesData(DataTable dt, Boolean isenabled, Boolean Required) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {

                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                String fieldName = webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())).getAttribute("for");
                System.out.println(fieldName);
                WebElement element = webDriver.passwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
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
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        if (entry.getValue().contains("SysData")) {
                            webDriver.Stringcomparator(ActualText, DriverInstance.getVariable(entry.getValue().split("=>")[1]));
                        } else {
                            webDriver.Stringcomparator(ActualText, entry.getValue());
                        }
                    }
                    else{
                        webDriver.Stringcomparator(ActualText, "");
                    }
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

    public void updateServicesData(DataTable dt) throws Exception {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());

                String fieldName = webDriver.passwebelement(Generic.getlocator("LabelTextInsideFrame").replace("{paramlink}", entry.getKey())).getAttribute("for");
                WebElement element = webDriver.passwebelement(Generic.getlocator("FormFieldsInsideFrame").replace("{paramlink}", fieldName));
                webDriver.ScrollIntoView(element);
                String Tag = element.getTagName();
                String type = element.getAttribute("type");
                String role = element.getAttribute("role");

                if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {
                    webDriver.ScrollIntoView(element);
                    if (entry.getValue().equalsIgnoreCase("Company Email")) {
                        webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                    }
                    else if (entry.getKey().contains("Date")) {
                        webDriver.SendKeys(element,webDriver.ReturnDate(entry.getValue()));
                    }
                    else {
                        webDriver.SendKeys(element, entry.getValue());
                    }
                }

                else if (Tag.equalsIgnoreCase("textarea")) {
                    webDriver.ScrollIntoView(element);

                    if (entry.getValue().equalsIgnoreCase("Company Email")) {
                        webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                    }
                    else {
                        webDriver.SendKeys(element, entry.getValue());
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && "combobox".equalsIgnoreCase(role)) {
                    webDriver.ScrollIntoView(element);

                    String ActualText = webDriver.Getattribute(element, "data-value");
                    if (ActualText.equalsIgnoreCase("")) {
                        webDriver.SendKeys(element, entry.getValue());
                        if(!entry.getKey().contains("Time"))
                        {
                            webDriver.Clickon(element);
                            webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitleFrame").replace("{paramlink}", entry.getValue()));
                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitleFrame").replace("{paramlink}", entry.getValue())));
                        }
                    } else if (ActualText.equalsIgnoreCase(entry.getValue())) {
                        System.out.println("Already selected");
                    } else {

                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("LabelClearIconFrame").replace("{paramlink}", entry.getKey())));
                        webDriver.SendKeys(element, entry.getValue());
                        webDriver.Clickon(element);
                        webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitleFrame").replace("{paramlink}", entry.getValue()));
                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitleFrame").replace("{paramlink}", entry.getValue())));

                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "password".equalsIgnoreCase(type)) {
                    webDriver.SendKeys(element, entry.getValue());
                }
                else if (Tag.equalsIgnoreCase("input") && "checkbox".equalsIgnoreCase(type)) {

                    webDriver.ScrollIntoView(element);
                    boolean isChecked  = "true".equalsIgnoreCase(element.getAttribute("checked"));
                    if(!isChecked) {
                        try {
                            webDriver.ClickOnElement(element);
                        }
                        catch(Exception e) {
                            webDriver.safeJavaScriptClick(webDriver.passwebelement(Generic.getlocator("LabelTextInsideFrame").replace("{paramlink}", entry.getKey())));
                        }
                    }
                } else if (Tag.equalsIgnoreCase("button") && "button".equalsIgnoreCase(type)) {
                    webDriver.Clickon(element);
                    webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("Div_aria_LabelFrame").replace("{paramlink}", entry.getKey())), webDriver.getwebelement(Generic.getlocator("Div_aria_Label_Span_TextFrame").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                }
            }
        }
    }

    public void VerifyLabelDataFieldValue(DataTable dt) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                if(entry.getKey().contains("Date"))
                {
                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", webDriver.ReturnDate(entry.getValue()))));
                    webDriver.verifyElementToBePresent(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", webDriver.ReturnDate(entry.getValue())));

                }
                else{

                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                    webDriver.verifyElementToBePresent(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue()));
                }
            }
        }

    }

    public void HandingTabularData(String TableName, DataTable dt) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {

                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());

                if(entry.getKey().contains("Date"))
                {   webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("HandleTabRowValue").replace("{paramlink}", TableName).replace("{paramlink2}", entry.getKey()).replace("{paramlink3}", webDriver.ReturnDate(entry.getValue()).replaceFirst("\\d", ""))));
                    WebElement wl= webDriver.getwebelement(Generic.getlocator("HandleTabRowValue").replace("{paramlink}", TableName).replace("{paramlink2}", entry.getKey()).replace("{paramlink3}", webDriver.ReturnDate(entry.getValue()).replaceFirst("\\d", "")));
                    String GetText= webDriver.getText(wl);
                    Assert.assertTrue(GetText.contains(webDriver.ReturnDate(entry.getValue()).replaceFirst("\\d", "")));

                }
                else if(entry.getKey().contains("Load"))
                {
                    webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("HandleTabRowValue").replace("{paramlink}", TableName).replace("{paramlink2}", entry.getKey()).replace("{paramlink3}", DriverInstance.getVariable(entry.getValue()))));
                    WebElement wl= webDriver.getwebelement(Generic.getlocator("HandleTabRowValue").replace("{paramlink}", TableName).replace("{paramlink2}", entry.getKey()).replace("{paramlink3}", DriverInstance.getVariable(entry.getValue())));
                    String GetText= webDriver.getText(wl);
                    Assert.assertTrue(GetText.contains(DriverInstance.getVariable(entry.getValue())));
                }
                else{
                    webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("HandleTabRowValue").replace("{paramlink}", TableName).replace("{paramlink2}", entry.getKey()).replace("{paramlink3}", entry.getValue())));
                    WebElement wl= webDriver.getwebelement(Generic.getlocator("HandleTabRowValue").replace("{paramlink}", TableName).replace("{paramlink2}", entry.getKey()).replace("{paramlink3}", entry.getValue()));
                    String GetText= webDriver.getText(wl);
                    Assert.assertTrue(GetText.contains(entry.getValue()));

                }

            }
        }}


    public void updateServicesDataWithLegend(DataTable dt) throws Exception {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {

                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                String legend =entry.getKey().split(", ")[0];
                String LabelName =entry.getKey().split(", ")[1];
                String fieldName = webDriver.getwebelement(Generic.getlocator("LabelTextLegend").replace("{paramlink1}", legend).replace("{paramlink2}", LabelName)).getAttribute("for");
                WebElement element = webDriver.getwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
                webDriver.ScrollIntoView(element);
                String Tag = element.getTagName();
                String type = element.getAttribute("type");
                String role = element.getAttribute("role");

                if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {
                    webDriver.ScrollIntoView(element);

                    if (entry.getValue().equalsIgnoreCase("Company Email")) {
                        webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                    }
                    else if (entry.getKey().contains("Date")) {
                        webDriver.SendKeys(element,webDriver.ReturnDate(entry.getValue()));
                    }
                    else {
                        webDriver.SendKeys(element, entry.getValue());
                    }
                }

                else if (Tag.equalsIgnoreCase("textarea")) {
                    if (entry.getValue().equalsIgnoreCase("Company Email")) {
                        webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                    }
                    else {
                        webDriver.SendKeys(element, entry.getValue());
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && "combobox".equalsIgnoreCase(role)) {
                    webDriver.ScrollIntoView(element);

                    String ActualText = webDriver.Getattribute(element, "data-value");
                    if (ActualText.equalsIgnoreCase("")) {
                        webDriver.SendKeys(element, entry.getValue());
                        if(!LabelName.contains("Time")) {
                            webDriver.Clickon(element);
                            webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue())));
                        }
                    }
                    else if (ActualText.equalsIgnoreCase(entry.getValue())) {
                        System.out.println("Already selected");
                    }
                    else {
                        if(!LabelName.contains("Time")) {
                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("LabelClearIcon").replace("{paramlink}", entry.getKey())));
                            webDriver.SendKeys(element, entry.getValue());
                            webDriver.Clickon(element);
                            webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue())));
                        }
                        else{
                            webDriver.Clear(element);
                            webDriver.SendKeys(element, entry.getValue());
                        }
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "password".equalsIgnoreCase(type)) {
                    webDriver.SendKeys(element, entry.getValue());
                }
                else if (Tag.equalsIgnoreCase("input") && "checkbox".equalsIgnoreCase(type)) {
                    //    webDriver.SendKeys(element, DriverInstance.getThreadLocalMapValue(entry.getKey()));
//                    webDriver.Clickon(element);
                    webDriver.safeJavaScriptClick(webDriver.getwebelement(Generic.getlocator("LabelTextLegend").replace("{paramlink1}", legend).replace("{paramlink2}", LabelName)));
                } else if (Tag.equalsIgnoreCase("button") && "button".equalsIgnoreCase(type)) {
                    webDriver.Clickon(element);
                    webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("Div_aria_Label").replace("{paramlink}", entry.getKey())), webDriver.getwebelement(Generic.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                }
            }
        }
    }

    public void ValidateDetails(DataTable dt) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                try{
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", entry.getKey())));
                    WebElement element = webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", entry.getKey()));
                    String Text = element.getText();
                    if(entry.getValue().equalsIgnoreCase("NA"))
                    {
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, "");
                    }
                    else {
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, entry.getValue());
                    }}
                catch(Exception e)
                {
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", entry.getKey())));
                    WebElement element = webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", entry.getKey()));
                    String Text = element.getText();
                    if(entry.getValue().equalsIgnoreCase("NA"))
                    {
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, "");
                    }
                    else {
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, entry.getValue());
                    }
                }
            }
        }
    }

    public static boolean isDouble(String str) {
        return str.matches("^-?\\d*\\.\\d+$");
    }
    public static boolean isInteger(String str) {
        return str.matches("^-?\\d+$");
    }

    public void ValidateBanner(DataTable dt) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                try{
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("BannerFieldValue").replace("{paramlink}", entry.getKey())));
                    WebElement element = webDriver.passwebelement(Generic.getlocator("BannerFieldValue").replace("{paramlink}", entry.getKey()));
                    String Text = element.getText();
                    if(entry.getValue().equalsIgnoreCase("NA"))
                    {
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, "");
                    }
                    else if(entry.getValue().contains("Number"))
                    {
                        System.out.println("Values are: " + Text);
                        if(Text.contains(".")) {
                            Assert.assertTrue(isDouble(Text.replace(",","")));
                        }
                        else{
                            Assert.assertTrue(isInteger(Text.replace(",","")));

                        }
                    }

                    else if (entry.getKey().contains("Date"))
                    {
                        webDriver.Partialstringcomparator(Text,webDriver.ReturnDate( entry.getValue()).substring(1));
                    }
                    else {
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, entry.getValue());
                    }}
                catch(Exception e)
                {
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", entry.getKey())));
                    WebElement element = webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", entry.getKey()));
                    String Text = element.getText();
                    if(entry.getValue().equalsIgnoreCase("NA"))
                    {
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, "");
                    }
                    else {
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, entry.getValue());
                    }
                }
            }
        }
    }



    public void validateBannerCheckbox(DataTable dt) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                String fieldName = webDriver.passwebelement(Generic.getlocator("SpanLabel").replace("{paramlink}", entry.getKey())).getAttribute("for");
                System.out.println(fieldName);
                WebElement element = webDriver.passwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
                webDriver.ScrollIntoView(element);
                System.out.println("Attribute is "+ element.getAttribute("checked"));
                boolean isChecked  = "true".equalsIgnoreCase(element.getAttribute("checked"));
                System.out.println( isChecked+"" +new Date());
                if (isChecked) {
                    System.out.println("Checkbox is checked");
                } else {
                    System.out.println("Checkbox is unchecked");
                }
                if(entry.getValue().equalsIgnoreCase("True"))
                {
                    Assert.assertTrue(isChecked);
                }
                else{
                    Assert.assertFalse(isChecked);
                }
            }

        }
    }

    public void updateServicesDataWithCount(DataTable dt) throws Exception {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                String fieldName;
                if(entry.getKey().endsWith("_2"))
                {
                    String Key= entry.getKey().replace("_2","");
                    System.out.println(Key);
                    fieldName = webDriver.passwebelement(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", Key)).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", entry.getKey()).replace("_2",""));
                }
                else{
                    fieldName = webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())).getAttribute("for");
                    System.out.println(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey()).replace("_2",""));

                }
                WebElement element = webDriver.passwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
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
                            } else if (entry.getKey().contains("Date") ) {
                                webDriver.SendKeys(element, webDriver.ReturnDate(entry.getValue()));
                            }
                            else if (entry.getKey().contains("Fleet Management Job Last Run")) {
                               if(entry.getValue().contains("/")){
                                   webDriver.SendKeys(element, entry.getValue());
                               }
                               else if (entry.getValue().contains("SysData")) {
                                   String Value = entry.getValue().split("=>")[1];
                                   webDriver.SendKeys(element, DriverInstance.getVariable(Value));
                               }
                               else{
                                   webDriver.SendKeys(element, webDriver.ReturnDateTime(entry.getValue()));
                               }
                            }
                            else if (entry.getValue().contains("SysData")) {
                                String Value = entry.getValue().split("=>")[1];
                                webDriver.SendKeys(element, DriverInstance.getVariable(Value));
                            } else {
                                webDriver.SendKeys(element, entry.getValue());
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
                    else {
                        webDriver.SendKeys(element, entry.getValue());
                    }
                }

                else if (Tag.equalsIgnoreCase("textarea")) {
                    webDriver.ScrollIntoView(element);
                    if (Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        if (entry.getValue().equalsIgnoreCase("Company Email")) {
                            webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                        } else if (entry.getValue().contains("SysData")) {
                            String Value = entry.getValue().split("=>")[1];
                            webDriver.SendKeys(element, DriverInstance.getVariable(Value));
                        } else {
                            webDriver.SendKeys(element, entry.getValue());
                        }
                    }
                    else{
                        webDriver.SendKeys(element, "");
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && "combobox".equalsIgnoreCase(role)) {
                    webDriver.ScrollIntoView(element);

                    String ActualText = webDriver.Getattribute(element, "data-value");
                    if (ActualText.equalsIgnoreCase("")) {
                        webDriver.SendKeys(element, entry.getValue());
                        if(!entry.getKey().contains("Time"))
                        {
                            webDriver.Clickon(element);
                            webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue())));
                        }
                    } else if (ActualText.equalsIgnoreCase(entry.getValue())) {
                        System.out.println("Already selected");
                    } else {

                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("LabelClearIcon").replace("{paramlink}", entry.getKey())));
                        webDriver.SendKeys(element, entry.getValue());
                        webDriver.Clickon(element);
                        webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue())));

                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "password".equalsIgnoreCase(type)) {
                    webDriver.SendKeys(element, entry.getValue());
                }
                else if (Tag.equalsIgnoreCase("input") && "checkbox".equalsIgnoreCase(type)) {

                    webDriver.ScrollIntoView(element);
                    if(entry.getValue().equalsIgnoreCase("true")) {
                        boolean isChecked = "true".equalsIgnoreCase(element.getAttribute("checked"));
                        if (!isChecked) {
                            try {
                                webDriver.ClickOnElement(element);
                            } catch (Exception e) {
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
                            }
                        }
                    }
                    else {
                        boolean isChecked = "true".equalsIgnoreCase(element.getAttribute("checked"));
                        if (isChecked) {
                            try {
                                webDriver.ClickOnElement(element);
                            } catch (Exception e) {
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
                            }
                        }
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "radio".equalsIgnoreCase(type)) {
                    System.out.println("inn");
                    webDriver.ScrollIntoView(element);
                    webDriver.waitUntilTheElementIsVisible(element);
                    webDriver.ClickOnElement(element);
                }
                else if (Tag.equalsIgnoreCase("select")) {
                    System.out.println("inn");
                    webDriver.ScrollIntoView(element);
                    webDriver.waitUntilTheElementIsVisible(element);
                    webDriver.selectOptionByText(element, entry.getValue());

                }
                else if (Tag.equalsIgnoreCase("select") ) {
                    System.out.println("inn");
                    webDriver.ScrollIntoView(element);
                    webDriver.waitUntilTheElementIsVisible(element);
                    webDriver.selectOptionByText(element,entry.getValue());
                }
                else if (Tag.equalsIgnoreCase("button") && "button".equalsIgnoreCase(type)) {
                    webDriver.Clickon(element);
                    webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("Div_aria_Label").replace("{paramlink}", entry.getKey())), webDriver.getwebelement(Generic.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                }
            }
        }
    }

    public void updateServiceWithTable(DataTable dt) throws Exception {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                 String fieldName = webDriver.passwebelement(Generic.getlocator("Global_Text").replace("{paramlink}", entry.getKey())).getAttribute("id");
                // Step 1: Extract the part before "header"
                String extracted = fieldName.split("header")[0];
                // Step 2: Split by ":"
                String[] parts = extracted.split(":");
                // Step 3: Get last number, add 1
                String lastPart = parts[parts.length - 1]; // e.g., "j_id40"
                int lastNumber = Integer.parseInt(lastPart.replace("j_id", ""));
                int dynamicNumber = lastNumber + 1;
                // Step 4: Build the final string
                StringBuilder finalString = new StringBuilder();
                for (int i = 0; i < parts.length - 1; i++) {
                    finalString.append(parts[i]).append(":");
                }
                finalString.append("0:j_id").append(dynamicNumber);
                // Step 5: Print result
                System.out.println(finalString.toString());
                WebElement element = webDriver.passwebelement(Generic.getlocator("FormFields").replace("{paramlink}", finalString.toString()));

                webDriver.ScrollIntoView(element);
                String Tag = element.getTagName();
                System.out.println(Tag);
                String type = element.getAttribute("type");
                System.out.println(type);
                String role = element.getAttribute("role");

                if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {
                    webDriver.ScrollIntoView(element);
                    if (entry.getValue().equalsIgnoreCase("Company Email")) {
                        webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                    }
                    else if (entry.getKey().contains("Date")) {
                        webDriver.SendKeys(element,webDriver.ReturnDate(entry.getValue()));
                    }
                    else if (entry.getValue().contains("SysData")) {
                        String Value = entry.getValue().split("=>")[1];
                        webDriver.SendKeys(element, DriverInstance.getVariable(Value));
                    }
                    else {
                        webDriver.SendKeys(element, entry.getValue());
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
                    else {
                        webDriver.SendKeys(element, entry.getValue());
                    }
                }

                else if (Tag.equalsIgnoreCase("textarea")) {
                    webDriver.ScrollIntoView(element);
                    if (Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        if (entry.getValue().equalsIgnoreCase("Company Email")) {
                            webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                        } else if (entry.getValue().contains("SysData")) {
                            String Value = entry.getValue().split("=>")[1];
                            webDriver.SendKeys(element, DriverInstance.getVariable(Value));
                        } else {
                            webDriver.SendKeys(element, entry.getValue());
                        }
                    }
                    else{
                        webDriver.SendKeys(element, "");
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && "combobox".equalsIgnoreCase(role)) {
                    webDriver.ScrollIntoView(element);

                    String ActualText = webDriver.Getattribute(element, "data-value");
                    if (ActualText.equalsIgnoreCase("")) {
                        webDriver.SendKeys(element, entry.getValue());
                        if(!entry.getKey().contains("Time"))
                        {
                            webDriver.Clickon(element);
                            webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue())));
                        }
                    } else if (ActualText.equalsIgnoreCase(entry.getValue())) {
                        System.out.println("Already selected");
                    } else {

                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("LabelClearIcon").replace("{paramlink}", entry.getKey())));
                        webDriver.SendKeys(element, entry.getValue());
                        webDriver.Clickon(element);
                        webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue())));

                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "password".equalsIgnoreCase(type)) {
                    webDriver.SendKeys(element, entry.getValue());
                }
                else if (Tag.equalsIgnoreCase("input") && "checkbox".equalsIgnoreCase(type)) {

                    webDriver.ScrollIntoView(element);
                    if(entry.getValue().equalsIgnoreCase("true")) {
                        boolean isChecked = "true".equalsIgnoreCase(element.getAttribute("checked"));
                        if (!isChecked) {
                            try {
                                webDriver.ClickOnElement(element);
                            } catch (Exception e) {
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
                            }
                        }
                    }
                    else {
                        boolean isChecked = "true".equalsIgnoreCase(element.getAttribute("checked"));
                        if (isChecked) {
                            try {
                                webDriver.ClickOnElement(element);
                            } catch (Exception e) {
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
                            }
                        }
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "radio".equalsIgnoreCase(type)) {
                    System.out.println("inn");
                    webDriver.ScrollIntoView(element);
                    webDriver.waitUntilTheElementIsVisible(element);
                    webDriver.ClickOnElement(element);
                }
                else if (Tag.equalsIgnoreCase("select")) {
                    System.out.println("inn");
                    webDriver.ScrollIntoView(element);
                    webDriver.waitUntilTheElementIsVisible(element);
                    webDriver.selectOptionByText(element, entry.getValue());

                }
                else if (Tag.equalsIgnoreCase("button") && "button".equalsIgnoreCase(type)) {
                    webDriver.Clickon(element);
                    webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("Div_aria_Label").replace("{paramlink}", entry.getKey())), webDriver.getwebelement(Generic.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                }
            }
        }
    }

    public void updateServicesData1(String key, String Value) throws Exception {


         System.out.println("Setting " + key + " to " + Value);
                String fieldName;
               String Keyd = "";
                if(key.endsWith("_2"))
                {
                    Keyd= key.replace("_2","");
                    System.out.println(Keyd);
                    fieldName = webDriver.passwebelement(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", Keyd)).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", key).replace("_2",""));
                }
                else{
                    fieldName = webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", key)).getAttribute("for");
                    System.out.println(Generic.getlocator("LabelText").replace("{paramlink}", key).replace("_2",""));

                }
                WebElement element = webDriver.passwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
                webDriver.ScrollIntoView(element);
                String Tag = element.getTagName();
                System.out.println(Tag);
                String type = element.getAttribute("type");
                System.out.println(type);
                String role = element.getAttribute("role");

                if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {
                    webDriver.ScrollIntoView(element);
                    if (Value.equalsIgnoreCase("Company Email")) {
                        webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                    }
                    else if (key.contains("Date")) {
                        if(Value.contains("/"))
                        {
                            webDriver.EnterTimeUsingJS(element, Value);
                            webDriver.waitForElementLoad(1);
                        }
                        else if (Value.contains("SysData"))
                        {
                            webDriver.EnterTimeUsingJS(element, DriverInstance.getVariable(Value.split("=>")[1]));
                            webDriver.waitForElementLoad(1);
                        }
                        else if (Value.contains("NA"))
                        {
                            webDriver.EnterTimeUsingJS(element, "");
                            webDriver.Clickon(element);
                            webDriver.waitForElementLoad(1);
                        }
                        else {
                            webDriver.SendKeys(element, webDriver.ReturnDate(Value));
                        }
                    }
                    else if (Value.contains("SysData")) {
                        String Value1 = DriverInstance.getVariable(Value.split("=>")[1]);
                        webDriver.SendKeys(element, Value1);
                    }
                    else {
                        webDriver.SendKeys(element, Value);
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "search".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {
            webDriver.ScrollIntoView(element);
            if (Value.equalsIgnoreCase("Company Email")) {
                webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
            }
            else if (key.contains("Date")) {
                webDriver.SendKeys(element,webDriver.ReturnDate(Value));
            }
            else {
                webDriver.SendKeys(element, Value);
            }
        }
                else if (Tag.equalsIgnoreCase("textarea")) {
                    webDriver.ScrollIntoView(element);

                    if (Value.equalsIgnoreCase("Company Email")) {
                        webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                    }
                    else {
                        webDriver.SendKeys(element, Value);
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && "combobox".equalsIgnoreCase(role)) {
                    webDriver.ScrollIntoView(element);
                    webDriver.waitForElementLoad(1);
                    String ActualText = webDriver.Getattribute(element, "data-value");
                    if (ActualText.equalsIgnoreCase(""))
                    {
                        if (Objects.nonNull(Value) && !Value.isEmpty()) {
                        if (Value.contains("SysData"))
                        {
                             String Value1 = DriverInstance.getVariable(Value.split("=>")[1]);
                            webDriver.SendKeys(element, Value1);
                            webDriver.Clickon(element);

                            int count= webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value1));
                            if(count>0) {
                                if(Value1.startsWith("L-")) {
                                    webDriver.waitForElementLoad(2);
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("*","lightning-base-combobox-formatted-text").replace("{paramlink}", Value1));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("*","lightning-base-combobox-formatted-text").replace("{paramlink}", Value1)));
                                }
                                else {
                                    webDriver.waitForElementLoad(2);
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value1));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value1)));
                                }
                            }
                            else{
                                webDriver.waitforElementtobeclickable(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SpanText").replace("{paramlink}","Show more results for")));
                                webDriver.waitforElementtobeclickable(Generic.getlocator("SelectTextRadio").replace("{paramlink}", Value1));
                                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SelectTextRadio").replace("{paramlink}", Value1)));
                                webDriver.waitforElementtobeclickable(Generic.getlocator("GlobalText2").replace("{paramlink}", "Select"));
                                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("GlobalText2").replace("{paramlink}", "Select")));
                            }
                        }
                        else{
                            webDriver.SendKeys(element, Value);
                            if(!key.contains("Time"))
                            {
                                webDriver.Clickon(element);
                                int count= webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitleWithLabel").replace("{paramlink}", key).replace("{paramlink2}", Value));
                                if(count>0) {
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitleWithLabel").replace("{paramlink}", key).replace("{paramlink2}", Value));
                                    webDriver.Clickon(webDriver.getwebelement(Generic.getlocator("ButtonIconTitleWithLabel").replace("{paramlink}", key).replace("{paramlink2}", Value)));
                                }
                                else{
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SpanText").replace("{paramlink}","Show more results for")));
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("SelectTextRadio").replace("{paramlink}", Value));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SelectTextRadio").replace("{paramlink}", Value)));
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("GlobalText2").replace("{paramlink}", "Select"));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("GlobalText2").replace("{paramlink}", "Select")));
                                }
                            }
                        }
                        }
                    }
                    else if (ActualText.equalsIgnoreCase(Value)) {
                        System.out.println("Already selected");
                    }
                    else {
                        int flag;
                        if(key.endsWith("_2"))
                        {
                            System.out.println(1234);
                            flag=  webDriver.getwebelementscount(Generic.getlocator("LabelClearIcon_2").replace("{paramlink}", key.replace("_2","")));
                        }
                        else {
                            flag=  webDriver.getwebelementscount(Generic.getlocator("LabelClearIcon").replace("{paramlink}", key));
                        }
                        System.out.println("Flag is "+flag);
                        if(flag>0) {
                            if (key.endsWith("_2")) {
                                System.out.println(111111);
                                webDriver.Clickon(webDriver.getwebelement(Generic.getlocator("LabelClearIcon_2").replace("{paramlink}", key).replace("_2","")));
                            } else {
                                webDriver.Clickon(webDriver.getwebelement(Generic.getlocator("LabelClearIcon").replace("{paramlink}", key)));
                            }
                            if (Objects.nonNull(Value) && !Value.isEmpty()) {
                                System.out.println(111112);
                                webDriver.SendKeys(element, Value);
                                webDriver.Clickon(element);

                                int count = webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                                if (count > 0) {
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value)));
                                } else {
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for")));
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("SelectTextRadio").replace("{paramlink}", Value));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SelectTextRadio").replace("{paramlink}", Value)));
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("GlobalText2").replace("{paramlink}", "Select"));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("GlobalText2").replace("{paramlink}", "Select")));
                                }
                            }
                        }
                        else{
                            System.out.println(111113);
                            webDriver.Clickon(element);
                            webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("Div_aria_Label").replace("{paramlink}", key)), webDriver.getwebelement(Generic.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", key).replace("{paramlink2}", Value)));
                        }

                    }
                }

                else if (Tag.equalsIgnoreCase("input") && "password".equalsIgnoreCase(type)) {
                    webDriver.SendKeys(element, Value);
                }
                else if (Tag.equalsIgnoreCase("input") && "checkbox".equalsIgnoreCase(type)) {

                    webDriver.ScrollIntoView(element);
                    if(Value.equalsIgnoreCase("True")) {
                        boolean isChecked = "true".equalsIgnoreCase(element.getAttribute("checked"));
                        if (!isChecked) {
                            try {
                                webDriver.safeJavaScriptClick(element);
                            } catch (Exception e) {
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", key)));
                            }
                        }
                    }
                    else{
                        boolean isChecked = "true".equalsIgnoreCase(element.getAttribute("checked"));
                        if (isChecked) {
                            try {
                                webDriver.ClickOnElement(element);
                            } catch (Exception e) {
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", key)));
                            }
                        }
                    }

                }
                else if (Tag.equalsIgnoreCase("input") && "radio".equalsIgnoreCase(type)) {
                    System.out.println("inn");
                    webDriver.ScrollIntoView(element);
                    webDriver.waitUntilTheElementIsVisible(element);
                    webDriver.ClickOnElement(element);
                }
                else if (Tag.equalsIgnoreCase("select") ) {
                    System.out.println("inn");
                    webDriver.ScrollIntoView(element);
                    webDriver.waitUntilTheElementIsVisible(element);
                    webDriver.selectOptionByText(element,Value);
                }
                else if (Tag.equalsIgnoreCase("button") && "button".equalsIgnoreCase(type)) {
                    webDriver.Clickon(element);
                    webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("Div_aria_Label").replace("{paramlink}", key)), webDriver.getwebelement(Generic.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", key).replace("{paramlink2}", Value)));
                }
            }

    public void moveOptionToChosen(String FieldName,String option) throws DocumentException, InterruptedException {
        // Click Options from Available Options
        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("OptionAvailableList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option)));
        webDriver.waitForElementLoad(1);
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("OptionAvailableList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option)));
        webDriver.ClickOnElement(webDriver.passwebelement(Generic.getlocator("OptionAvailableList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option)));
        // Click "Move to Chosen" (right arrow button)
        webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("WithFieldNameAndTitle").replace("{paramlink1}", FieldName).replace("{paramlink2}","Move selection to Chosen")));
        webDriver.waitForElementLoad(1);
        webDriver.WaitforElementtobeclickable(Generic.getlocator("WithFieldNameAndTitle").replace("{paramlink1}", FieldName).replace("{paramlink2}","Move selection to Chosen"));
        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("WithFieldNameAndTitle").replace("{paramlink1}", FieldName).replace("{paramlink2}","Move selection to Chosen")));
        webDriver.waitForElementLoad(1);
        //Verify selected and displaying on cosen List
        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("OptionChosenList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option)));
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("OptionChosenList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option)));
        webDriver.verifyElementToBePresent(Generic.getlocator("OptionChosenList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option));
    }
    public void VerifyChosen(String FieldName,String option) throws DocumentException, InterruptedException {
        //Verify selected and displaying on cosen List
        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("OptionChosenList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option)));
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("OptionChosenList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option)));
        webDriver.verifyElementToBePresent(Generic.getlocator("OptionChosenList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option));
    }


}
