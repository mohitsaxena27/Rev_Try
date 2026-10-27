package pageHelper.Utility;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import org.dom4j.DocumentException;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;
import org.python.antlr.ast.Str;
import org.testng.Assert;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.awt.*;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.StringSelection;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.List;

public class CommonFunction {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader Generic;
    public PropertyReader propertyReader = new PropertyReader();

    public CommonFunction(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        Generic = new xmlreader("Generics" + File.separator + "Common.xml");

    }

    public void validateServicesData(DataTable dt, Boolean isenabled, Boolean Required) throws DocumentException, InterruptedException {

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
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", Key)));
                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", Key)));
                    fieldName = webDriver.passwebelement(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", Key)).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", entry.getKey()).replace("_2",""));
                }
                else{
                    fieldName = webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey()));

                }
                WebElement element = webDriver.passwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
                webDriver.ScrollIntoView(element);
                String Tag = element.getTagName();

                String type = element.getAttribute("type");

                String role = element.getAttribute("role");

                if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {

                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {

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
                        if (entry.getKey().contains("Date")) {
                            if(entry.getValue().contains(",")||entry.getValue().contains("/"))
                            {
                                webDriver.Partialstringcomparator(ActualText, entry.getValue());
                            }
                            else if(entry.getValue().contains("SysData"))
                            {
                                if(DriverInstance.getVariable(entry.getValue().split("=>")[1]).isEmpty() ||DriverInstance.getVariable(entry.getValue().split("=>")[1])==null )
                                {
                                    webDriver.Stringcomparator(ActualText, "");
                                }
                                else{
                                webDriver.Partialstringcomparator(ActualText, DriverInstance.getVariable(entry.getValue().split("=>")[1]));
                                }
                            }
                            else{
                                webDriver.Partialstringcomparator(ActualText, webDriver.ExpectedDate(entry.getValue()));
                            }
                        }
                        else if (entry.getKey().contains("Start Day")) {
                            if(entry.getValue().contains(",")||entry.getValue().contains("/"))
                            {
                                webDriver.Partialstringcomparator(ActualText, entry.getValue());
                            }
                            else if(entry.getValue().contains("SysData"))
                            {
                                webDriver.Partialstringcomparator(ActualText, DriverInstance.getVariable(entry.getValue().split("=>")[0]));
                            }
                            else{
                                webDriver.Partialstringcomparator(ActualText, webDriver.ReturnDateInSpecifiedFormat(entry.getValue(),"MMM d, yyyy"));
                            }
                        }
                        else {
                            if(entry.getValue().contains("SysData"))
                            {
                                if(DriverInstance.getVariable(entry.getValue().split("=>")[1]).isEmpty() ||DriverInstance.getVariable(entry.getValue().split("=>")[1])==null )
                                {
                                    webDriver.Stringcomparator(ActualText, "");
                                }
                                else {
                                    String Value = DriverInstance.getVariable(entry.getValue().split("=>")[1]);
                                    webDriver.Partialstringcomparator(ActualText, Value);
                                }
                            }
                            else {
                                webDriver.Partialstringcomparator(ActualText, entry.getValue());
                            }
                        }
                    }
                    else{
                        String ActualText = webDriver.Getattribute(element, "value");
                        if (Required) {
                            Boolean RequiredElement = Boolean.valueOf(webDriver.Getattribute(element, "required"));
                            Assert.assertEquals(RequiredElement, true);
                        }
                        webDriver.Stringcomparator(ActualText, "");

                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && "combobox".equalsIgnoreCase(role)) {
                    String ActualText = webDriver.Getattribute(element, "data-value");
                    System.out.println("Value is"+ActualText);
                    Boolean RequiredElement = Boolean.valueOf(webDriver.Getattribute(element, "required"));
                    if (Required) {
                        Assert.assertEquals(RequiredElement, true);
                    }
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        if (entry.getValue().contains("SysData")) {
                            String Value = DriverInstance.getVariable(entry.getValue().split("=>")[1]);
                            webDriver.Stringcomparator(ActualText, Value);
                        } else if (entry.getValue().equalsIgnoreCase("NA")) {
                            webDriver.Stringcomparator(ActualText, "");
                        } else {
                            webDriver.Stringcomparator(ActualText, entry.getValue());
                        }
                    }
                    else{
                        webDriver.Stringcomparator(ActualText, "");
                    }
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
                    webDriver.Partialstringcomparator(ActualText, entry.getValue());
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

    public void getDetailsForDisabledOrReadonlyFields(
            String fieldName,
            String variableName) throws Exception {

        // Validate field name
        if (fieldName == null || fieldName.trim().isEmpty()) {
            throw new IllegalArgumentException("Field name cannot be null or empty");
        }

        // Validate variable name
        if (variableName == null || variableName.trim().isEmpty()) {
            throw new IllegalArgumentException("Variable name cannot be null or empty");
        }

        fieldName = fieldName.trim();
        variableName = variableName.trim();

        System.out.println("Getting value for: " + fieldName);
        System.out.println("Storing value in: " + variableName);

        // Get label locator
        String labelLocator = Generic.getlocator("LabelText").replace("{paramlink}", fieldName);

        // Find label
        WebElement label = webDriver.passwebelement(labelLocator);

        if (label == null) {
            throw new Exception("Label not found for field: " + fieldName);
        }

        // Get the 'for' attribute from label
        String fieldNameAttribute = label.getAttribute("for");

        if (fieldNameAttribute == null || fieldNameAttribute.trim().isEmpty()) {

            throw new Exception("The 'for' attribute is missing for field: " + fieldName);
        }

        fieldNameAttribute = fieldNameAttribute.trim();

        // Get form field locator
        String formFieldLocator = Generic.getlocator("FormFields").replace("{paramlink}", fieldNameAttribute);

        // Find form field
        WebElement element = webDriver.passwebelement(formFieldLocator);

        if (element == null) {
            throw new Exception("Form field not found for: " + fieldName + " using attribute: " + fieldNameAttribute);
        }

        // Scroll to element
        webDriver.ScrollIntoView(element);

        // Get actual value
        String actualValue = webDriver.Getattribute(element, "value");

        // Print details
        System.out.println("Field: " + fieldName);
        System.out.println("Value: " + actualValue);
        System.out.println("Variable: " + variableName);

        // Store value in framework variable
        DriverInstance.setVariable(variableName, actualValue);

        System.out.println("Value of Attribute Stored: " + variableName + " is :" + actualValue);
    }


    public void validateServicesDataWithDataFieldNae(DataTable dt, Boolean isenabled, Boolean Required) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                String fieldName;
                String Key = "";
                    fieldName = webDriver.passwebelement(Generic.getlocator("LabelTextUsingdatafieldname").replace("{paramlink}", entry.getKey())).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(Generic.getlocator("LabelTextUsingdatafieldname").replace("{paramlink}", entry.getKey()));

                WebElement element = webDriver.passwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
                webDriver.ScrollIntoView(element);
                String Tag = element.getTagName();

                String type = element.getAttribute("type");

                String role = element.getAttribute("role");

                if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {

                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {

                        String ActualText = webDriver.Getattribute(element, "value");
                        System.out.println("Actual Test:" + ActualText);
                        if (entry.getKey().contains("Date")) {
                            if(entry.getValue().contains(",")||entry.getValue().contains("/"))
                            {
                                webDriver.Partialstringcomparator(ActualText, entry.getValue());
                            }
                            else{
                                webDriver.Partialstringcomparator(ActualText, webDriver.ExpectedDate(entry.getValue()));
                            }
                        }
                        else if (entry.getKey().contains("Start Day")) {
                            if(entry.getValue().contains(",")||entry.getValue().contains("/"))
                            {
                                webDriver.Partialstringcomparator(ActualText, entry.getValue());
                            }
                            else{
                                webDriver.Partialstringcomparator(ActualText, webDriver.ReturnDateInSpecifiedFormat(entry.getValue(),"MMM d, yyyy"));
                            }
                        }
                        else {
                            if(entry.getValue().contains("SysData"))
                            {
                                String Value = DriverInstance.getVariable(entry.getValue().split("=>")[1]);
                                webDriver.Partialstringcomparator(ActualText, Value);
                            }
                            else {
                                webDriver.Partialstringcomparator(ActualText, entry.getValue());
                            }
                        }
                    }
                    else{
                        String ActualText = webDriver.Getattribute(element, "value");
                        webDriver.Stringcomparator(ActualText, "");

                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && "combobox".equalsIgnoreCase(role)) {
                    String ActualText = webDriver.Getattribute(element, "data-value");
                    System.out.println("Value is"+ActualText);
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        if (entry.getValue().contains("SysData")) {
                            String Value = DriverInstance.getVariable(entry.getValue().split("=>")[1]);
                            webDriver.Stringcomparator(ActualText, Value);
                        } else if (entry.getValue().equalsIgnoreCase("NA")) {
                            webDriver.Stringcomparator(ActualText, "");
                        } else {
                            webDriver.Stringcomparator(ActualText, entry.getValue());
                        }
                    }
                    else{
                        webDriver.Stringcomparator(ActualText, "");
                    }
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
                    webDriver.Partialstringcomparator(ActualText, entry.getValue());
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




    public void validateServicesDataUnderSection(String SectionName, DataTable dt) throws DocumentException, InterruptedException {

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
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("LabelTextUnderSectionWithIndex").replace("{SectionName}",SectionName).replace("{paramlink}", Key)));
                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("LabelTextUnderSectionWithIndex").replace("{SectionName}",SectionName).replace("{paramlink}", Key)));
                    fieldName = webDriver.passwebelement(Generic.getlocator("LabelTextUnderSectionWithIndex").replace("{SectionName}",SectionName).replace("{paramlink}", Key)).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(Generic.getlocator("LabelTextUnderSectionWithIndex").replace("{SectionName}",SectionName).replace("{paramlink}", entry.getKey()).replace("_2",""));
                }
                else{
                    fieldName = webDriver.passwebelement(Generic.getlocator("LabelTextUnderSection").replace("{SectionName}",SectionName).replace("{paramlink}", entry.getKey())).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(Generic.getlocator("LabelTextUnderSection").replace("{SectionName}",SectionName).replace("{paramlink}", entry.getKey()));

                }
                WebElement element = webDriver.passwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
                webDriver.ScrollIntoView(element);
                String Tag = element.getTagName();

                String type = element.getAttribute("type");

                String role = element.getAttribute("role");

                if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {

                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {

                        String ActualText = webDriver.Getattribute(element, "value");
                        System.out.println("Actual Test:" + ActualText);
                        Boolean enabled = element.isEnabled();
                        Boolean readonly = Boolean.valueOf(webDriver.Getattribute(element, "readonly"));
                        System.out.println("Read only Value" + readonly);
                        System.out.println("Enable Value" + enabled);
                        System.out.println("Enable Value" + enabled);
                        Boolean actualSate = (enabled && !readonly);
                        Boolean RequiredElement = Boolean.valueOf(webDriver.Getattribute(element, "required"));
                        if (entry.getKey().contains("Date")) {
                            if(entry.getValue().contains(",")||entry.getValue().contains("/"))
                            {
                                webDriver.Partialstringcomparator(ActualText, entry.getValue());
                            }
                            else{
                                webDriver.Partialstringcomparator(ActualText, webDriver.ExpectedDate(entry.getValue()));
                            }
                        }
                        else if (entry.getKey().contains("Start Day")) {
                            if(entry.getValue().contains(",")||entry.getValue().contains("/"))
                            {
                                webDriver.Partialstringcomparator(ActualText, entry.getValue());
                            }
                            else{
                                webDriver.Partialstringcomparator(ActualText, webDriver.ReturnDateInSpecifiedFormat(entry.getValue(),"MMM d, yyyy"));
                            }
                        }
                        else {
                            if(entry.getValue().contains("SysData"))
                            {
                                String Value = DriverInstance.getVariable(entry.getValue().split("=>")[1]);
                                webDriver.Partialstringcomparator(ActualText, Value);
                            }
                            else {
                                webDriver.Partialstringcomparator(ActualText, entry.getValue());
                            }
                        }
                    }
                    else{
                        String ActualText = webDriver.Getattribute(element, "value");
                        webDriver.Stringcomparator(ActualText, "");

                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && "combobox".equalsIgnoreCase(role)) {
                    String ActualText = webDriver.Getattribute(element, "data-value");
                    System.out.println("Value is"+ActualText);
                    Boolean RequiredElement = Boolean.valueOf(webDriver.Getattribute(element, "required"));
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        if (entry.getValue().contains("SysData")) {
                            String Value = DriverInstance.getVariable(entry.getValue().split("=>")[1]);
                            webDriver.Stringcomparator(ActualText, Value);
                        } else if (entry.getValue().equalsIgnoreCase("NA")) {
                            webDriver.Stringcomparator(ActualText, "");
                        } else {
                            webDriver.Stringcomparator(ActualText, entry.getValue());
                        }
                    }
                    else{
                        webDriver.Stringcomparator(ActualText, "");
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "password".equalsIgnoreCase(type)) {
                    //   webDriver.SendKeys(element, DriverInstance.getThreadLocalMapValue(entry.getKey()));
//                    String ActualText = webDriver.getAttributeValueUsingJavascript(element);
                    String ActualText = webDriver.Getattribute(element, "value");
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

                }
                else if (Tag.equalsIgnoreCase("button") && "button".equalsIgnoreCase(type)) {
                    String ActualText = webDriver.Getattribute(element, "data-value");
                    webDriver.Partialstringcomparator(ActualText, entry.getValue());
                }
                else if (Tag.equalsIgnoreCase("select") ) {
                    // Create a Select object
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        Select select = new Select(element);

                        String selectedText = select.getFirstSelectedOption().getText();
                        System.out.println("Selected Text: " + selectedText);
                        webDriver.Stringcomparator(selectedText, entry.getValue());
                    }
                    else{
                        Select select = new Select(element);
                        List<WebElement> selectedOptions = select.getAllSelectedOptions();
                        if (selectedOptions.isEmpty()) {
                            System.out.println("No valye Selected");
                        }

                    }
                }
            }
        }
    }

    public void validateServicesDataGrid(DataTable dt, Boolean isenabled, Boolean Required, String... gridNames) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            if (gridNames.length == 0) {
                for (Map.Entry<String, String> entry : details.entrySet()) {

                    System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());

                    String fieldName;
                    String Key = "";
                    if (entry.getKey().endsWith("_2")) {
                        Key = entry.getKey().replace("_2", "");
                        System.out.println(Key);
                        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", Key)));
                        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", Key)));
                        fieldName = webDriver.passwebelement(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", Key)).getAttribute("for");
                        System.out.println(fieldName);
                        System.out.println(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", entry.getKey()).replace("_2", ""));
                    } else {

                        fieldName = webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())).getAttribute("for");
                        System.out.println(fieldName);
                        System.out.println(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey()));
                    }
                    WebElement element = webDriver.passwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
                    webDriver.ScrollIntoView(element);
                    String Tag = element.getTagName();

                    String type = element.getAttribute("type");

                    String role = element.getAttribute("role");

                    if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {

                        if (Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {

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
                            if (entry.getKey().contains("Date")) {
                                if (entry.getValue().contains(",") || entry.getValue().contains("/")) {
                                    webDriver.Partialstringcomparator(ActualText, entry.getValue());
                                } else {
                                    webDriver.Partialstringcomparator(ActualText, webDriver.ExpectedDate(entry.getValue()));
                                }
                            } else if (entry.getKey().contains("Start Day")) {
                                if (entry.getValue().contains(",") || entry.getValue().contains("/")) {
                                    webDriver.Partialstringcomparator(ActualText, entry.getValue());
                                } else {
                                    webDriver.Partialstringcomparator(ActualText, webDriver.ReturnDateInSpecifiedFormat(entry.getValue(), "MMM dd, yyyy"));
                                }
                            } else {
                                if (entry.getValue().contains("SysData")) {
                                    String Value = DriverInstance.getVariable(entry.getValue().split("=>")[1]);
                                    webDriver.Partialstringcomparator(ActualText, Value);
                                } else {
                                    webDriver.Partialstringcomparator(ActualText, entry.getValue());
                                }
                            }
                        } else {
                            String ActualText = webDriver.Getattribute(element, "value");
                            if (Required) {
                                Boolean RequiredElement = Boolean.valueOf(webDriver.Getattribute(element, "required"));
                                Assert.assertEquals(RequiredElement, true);
                            }
                            webDriver.Stringcomparator(ActualText, "");

                        }
                    } else if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && "combobox".equalsIgnoreCase(role)) {
                        String ActualText = webDriver.Getattribute(element, "data-value");
                        System.out.println("Value is" + ActualText);
                        Boolean RequiredElement = Boolean.valueOf(webDriver.Getattribute(element, "required"));
                        if (Required) {
                            Assert.assertEquals(RequiredElement, true);
                        }
                        if (Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                            if (entry.getValue().contains("SysData")) {
                                String Value = DriverInstance.getVariable(entry.getValue().split("=>")[1]);
                                webDriver.Stringcomparator(ActualText, Value);
                            } else if (entry.getValue().equalsIgnoreCase("NA")) {
                                webDriver.Stringcomparator(ActualText, "");
                            } else {
                                webDriver.Stringcomparator(ActualText, entry.getValue());
                            }
                        } else {
                            webDriver.Stringcomparator(ActualText, "");
                        }
                    } else if (Tag.equalsIgnoreCase("input") && "password".equalsIgnoreCase(type)) {
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

                    } else if (Tag.equalsIgnoreCase("input") && "checkbox".equalsIgnoreCase(type)) {
                        //    webDriver.SendKeys(element, DriverInstance.getThreadLocalMapValue(entry.getKey()));

                        boolean isChecked = "true".equalsIgnoreCase(element.getAttribute("aria-checked"));
                        System.out.println(isChecked + "" + new Date());
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
                    } else if (Tag.equalsIgnoreCase("button") && "button".equalsIgnoreCase(type)) {
                        String ActualText = webDriver.Getattribute(element, "data-value");
                        Boolean RequiredElement = Boolean.valueOf(webDriver.Getattribute(element, "required"));
                        if (Required) {
                            Assert.assertEquals(RequiredElement, true);
                        }
                        webDriver.Partialstringcomparator(ActualText, entry.getValue());
                    } else if (Tag.equalsIgnoreCase("select")) {
                        // Create a Select object
                        Select select = new Select(element);
                        String selectedText = select.getFirstSelectedOption().getText();
                        System.out.println("Selected Text: " + selectedText);
                        webDriver.Stringcomparator(selectedText, entry.getValue());
                    }
                }
            }
        else {
            String gridName = gridNames[0];
            int rowIndex=0;
                for (Map.Entry<String, String> entry : details.entrySet()) {

                    System.out.println("Verifying " + entry.getKey() + " to " + entry.getValue());
                    String loc1 = "//span[text()='" + gridName + "']/ancestor::div[1]/following-sibling::div[1]//lightning-layout-item";
                    String headerLoc = loc1 + "//lightning-formatted-text";
                    String allValLoc = loc1 + "[.//input | //lightning-formatted-number]";
                    List<String> headers = new ArrayList<>();
                    webDriver.getwebelements(headerLoc).stream().forEach(X -> headers.add(X.getText().trim()));
                    int colIndex = headers.indexOf(entry.getKey()) + 1;
                    System.out.println("VERIFY_DATA: "+entry.getKey() + "\t" + webDriver.getwebelements(allValLoc).get(colIndex + headers.size()).getText()+"\t"+entry.getValue());
                }
            }
        }
    }

    public void getLabelValue(DataTable dt) throws DocumentException, InterruptedException {

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
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", Key)));
                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", Key)));
                    fieldName = webDriver.passwebelement(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", Key)).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", entry.getKey()).replace("_2",""));
                }
                else{
                    fieldName = webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey()));

                }
                WebElement element = webDriver.passwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
                webDriver.ScrollIntoView(element);
                String Tag = element.getTagName();

                String type = element.getAttribute("type");

                String role = element.getAttribute("role");

                if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {
                    String ActualText = webDriver.Getattribute(element, "value");
                    DriverInstance.setVariable(entry.getKey(),ActualText);

                }
                else if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && "combobox".equalsIgnoreCase(role)) {
                    String ActualText = webDriver.Getattribute(element, "data-value");
                    DriverInstance.setVariable(entry.getKey(),ActualText);
                }
                else if (Tag.equalsIgnoreCase("input") && "checkbox".equalsIgnoreCase(type)) {

                    String ActualText  = element.getAttribute("aria-checked");
                    DriverInstance.setVariable(entry.getKey(),ActualText);
                }
                else if (Tag.equalsIgnoreCase("button") && "button".equalsIgnoreCase(type)) {
                    String ActualText = webDriver.Getattribute(element, "data-value");
                    DriverInstance.setVariable(entry.getKey(),ActualText);

                }
                else if (Tag.equalsIgnoreCase("select") ) {
                    Select select = new Select(element);
                    String ActualText = select.getFirstSelectedOption().getText();
                    DriverInstance.setVariable(entry.getKey(),ActualText);

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
                            webDriver.safeJavaScriptClick(element);
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
                if(entry.getKey().contains("Date") || entry.getKey().contains("Start Day")||entry.getKey().contains("Carrier Status as of"))
                {
                    if (entry.getValue().contains("SysData")) {
                        String Value = DriverInstance.getVariable(entry.getValue().split("=>")[1]);
                        if(entry.getKey().contains("Carrier Status as of"))
                        {
                            Value = Value.split(":")[0];
                        }
                        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", Value)));
                        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", Value)));
                        webDriver.verifyElementToBePresent(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", Value));
                    }
                    else if(entry.getKey().contains("Start Day")){
                        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", webDriver.ReturnDateInSpecifiedFormat(entry.getValue(),"MMM dd, yyyy"))));
                        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", webDriver.ReturnDateInSpecifiedFormat(entry.getValue(),"MMM dd, yyyy"))));
                        webDriver.verifyElementToBePresent(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", webDriver.ReturnDateInSpecifiedFormat(entry.getValue(),"MMM dd, yyyy")));

                    }

                    else {
                        try {
                            webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey().trim()).replace("{paramlink2}", webDriver.ReturnDate(entry.getValue()))));
                            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey().trim()).replace("{paramlink2}", webDriver.ReturnDate(entry.getValue().trim()))));
                            webDriver.verifyElementToBePresent(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey().trim()).replace("{paramlink2}", webDriver.ReturnDate(entry.getValue().trim())));
                        } catch (NumberFormatException e) {
                            webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey().trim()).replace("{paramlink2}", entry.getValue().trim())));
                            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey().trim()).replace("{paramlink2}", entry.getValue().trim())));
                            webDriver.verifyElementToBePresent(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey().trim()).replace("{paramlink2}", entry.getValue().trim()));

                        }
                    }
                }
                else {
                    if (entry.getValue().equalsIgnoreCase("NA")|| entry.getValue().equalsIgnoreCase("") )
                    {
                        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", "")));
                        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", "")));
                        webDriver.verifyElementToBePresent(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", ""));
                    }
                    else if (entry.getValue().contains("SysData")){
                        String Value = entry.getValue().split("=>")[1];
                        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", DriverInstance.getVariable(Value))));
                        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", DriverInstance.getVariable(Value))));
                        webDriver.verifyElementToBePresent(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", DriverInstance.getVariable(Value)));

                    }
                    else{
                        try {
                            webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                            webDriver.verifyElementToBePresent(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue()));
                        }
                        catch(NoSuchElementException e)
                        {
                            webDriver.waitForElementLoad(5);
                            webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                            webDriver.verifyElementToBePresent(Generic.getlocator("Verify_Label_Text_Value").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue()));

                        }
                    }
                }
            }
        }
    }

    public void VerifyLabelDataFieldValue2(DataTable dt) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                if(entry.getKey().contains("Date"))
                {
                    try {
                        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value2").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", webDriver.ReturnDate(entry.getValue()))));
                        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value2").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", webDriver.ReturnDate(entry.getValue()))));
                        webDriver.verifyElementToBePresent(Generic.getlocator("Verify_Label_Text_Value2").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", webDriver.ReturnDate(entry.getValue())));
                    }
                    catch(NumberFormatException e){
                        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value2").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value2").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                        webDriver.verifyElementToBePresent(Generic.getlocator("Verify_Label_Text_Value2").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue()));

                    }
                }
                else {
                    if (entry.getValue().equalsIgnoreCase("NA")|| entry.getValue().equalsIgnoreCase("") )
                    {
                        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value2").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", "")));
                        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value2").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", "")));
                        webDriver.verifyElementToBePresent(Generic.getlocator("Verify_Label_Text_Value2").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", ""));

                    }
                    else if (entry.getValue().contains("SysData")){
                        String Value = entry.getValue().split("=>")[1];
                        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value2").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", DriverInstance.getVariable(Value))));
                        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value2").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", DriverInstance.getVariable(Value))));
                        webDriver.verifyElementToBePresent(Generic.getlocator("Verify_Label_Text_Value2").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", DriverInstance.getVariable(Value)));

                    }

                    else{
                        try {
                            webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value2").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value2").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                            webDriver.verifyElementToBePresent(Generic.getlocator("Verify_Label_Text_Value2").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue()));
                        }
                        catch(NoSuchElementException e)
                        {
                            webDriver.waitForElementLoad(5);
                            webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value2").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("Verify_Label_Text_Value2").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                            webDriver.verifyElementToBePresent(Generic.getlocator("Verify_Label_Text_Value2").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue()));

                        }
                    }
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
                else if(entry.getKey().contains("Load") && !entry.getKey().contains("Load Accessorial: Name"))
                {
                    webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("HandleTabRowValue").replace("{paramlink}", TableName).replace("{paramlink2}", entry.getKey()).replace("{paramlink3}", DriverInstance.getVariable(entry.getValue()))));
                    WebElement wl= webDriver.getwebelement(Generic.getlocator("HandleTabRowValue").replace("{paramlink}", TableName).replace("{paramlink2}", entry.getKey()).replace("{paramlink3}", DriverInstance.getVariable(entry.getValue())));
                    String GetText= webDriver.getText(wl);
                    Assert.assertTrue(GetText.contains(DriverInstance.getVariable(entry.getValue())));
                }
                else if(entry.getValue().contains("SysData"))
                {
                    String Value = entry.getValue().split("=>")[1];
                    webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("HandleTabRowValue").replace("{paramlink}", TableName).replace("{paramlink2}", entry.getKey()).replace("{paramlink3}", DriverInstance.getVariable(Value))));
                    WebElement wl= webDriver.getwebelement(Generic.getlocator("HandleTabRowValue").replace("{paramlink}", TableName).replace("{paramlink2}", entry.getKey()).replace("{paramlink3}", DriverInstance.getVariable(Value)));
                    String GetText= webDriver.getText(wl);
                    Assert.assertTrue(GetText.contains(DriverInstance.getVariable(Value)));
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
                    if (Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        if (entry.getValue().equalsIgnoreCase("Company Email")) {
                            webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                        }
                        else if (entry.getKey().contains("Date")) {

                            if (entry.getValue().contains("/")) {
                                webDriver.EnterTimeUsingJS(element, entry.getValue());
                                webDriver.Clickon(element);
                                webDriver.waitForElementLoad(1);

                            } else if (entry.getValue().contains("SysData")) {
                                webDriver.EnterTimeUsingJS(element, DriverInstance.getVariable(entry.getValue().split("=>")[1]));
                                webDriver.waitForElementLoad(1);

                            } else if (entry.getValue().contains("NA")) {
                                webDriver.EnterTimeUsingJS(element, "");
                                webDriver.Clickon(element);
                                webDriver.waitForElementLoad(1);

                            } else {
                                webDriver.EnterTimeUsingJS(element, webDriver.ReturnDate(entry.getValue()));
                            }
                        }

                        else {
                            webDriver.SendKeys(element, entry.getValue());
                        }
                    }
                    else{
                        webDriver.SendKeys(element, "");
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

                    if(entry.getKey().contains("Address Search"))
                    {
                        webDriver.SendKeys(element, entry.getValue().split("=>")[0]);
                        webDriver.Clickon(element);
                        webDriver.waitForElementLoad(1);
                        webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconLegendTitle").replace("{paramlink1}",legend).replace("{paramlink2}", entry.getValue().split("=>")[1]));
                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconLegendTitle").replace("{paramlink1}",legend).replace("{paramlink2}", entry.getValue().split("=>")[1])));
                    }
                    else
                    {
                        String ActualText = webDriver.Getattribute(element, "data-value");
                        if (ActualText.equalsIgnoreCase("")) {
                            webDriver.SendKeys(element, entry.getValue());
                            if (!LabelName.contains("Time")) {
                                webDriver.Clickon(element);
                                webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue())));
                            }
                        } else if (ActualText.equalsIgnoreCase(entry.getValue())) {
                            System.out.println("Already selected");
                        } else {
                            if (!LabelName.contains("Time")) {
                                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("LabelClearIcon").replace("{paramlink}", entry.getKey())));
                                webDriver.SendKeys(element, entry.getValue());
                                webDriver.Clickon(element);
                                webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue())));
                            } else {
                                if(entry.getValue().contains("SysData")){
                                    String value=DriverInstance.getVariable(entry.getValue().split("=>")[1]);
                                    webDriver.Clear(element);
                                    webDriver.SendKeys(element,value);
                                }else {
                                    webDriver.Clear(element);
                                    webDriver.SendKeys(element, entry.getValue());
                                }
                            }
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

    public void VerifyServicesDataWithLegend(DataTable dt) throws Exception {

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
                    if (Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {

                        String ActualText = webDriver.Getattribute(element, "value");
                        System.out.println("Actual Test:" + ActualText);

                        if (entry.getValue().contains("SysData")) {
                            String Value = entry.getValue().split("=>")[1];
                            webDriver.Partialstringcomparator(ActualText, DriverInstance.getVariable(Value));
                        }
                        else if (entry.getKey().contains("Date")) {
                            webDriver.Partialstringcomparator(ActualText, webDriver.ExpectedDate(entry.getValue()));
                        }
                        else {
                            webDriver.Partialstringcomparator(ActualText, entry.getValue());
                        }
                    } else {
                        String ActualText = webDriver.Getattribute(element, "value");
                        webDriver.Stringcomparator(ActualText, "");
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && "combobox".equalsIgnoreCase(role)) {
                    if (Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        if (entry.getValue().contains("SysData")) {
                            String Value = DriverInstance.getVariable(entry.getValue().split("=>")[1]);
                            String ActualText = webDriver.Getattribute(element, "data-value");
                            webDriver.Stringcomparator(ActualText, Value);
                        } else {
                            String ActualText = webDriver.Getattribute(element, "data-value");
                            webDriver.Stringcomparator(ActualText, entry.getValue());
                        }

                    }
                    else {
                        String ActualText = webDriver.Getattribute(element, "data-value");
                        webDriver.Stringcomparator(ActualText, "");
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "checkbox".equalsIgnoreCase(type)) {
                    boolean isChecked  = "true".equalsIgnoreCase(element.getAttribute("aria-checked"));
                    System.out.println( isChecked+"" +new Date());
                    if (isChecked) {
                        System.out.println("Checkbox is checked");
                    } else {
                        System.out.println("Checkbox is unchecked");
                    }
                }
                else if (Tag.equalsIgnoreCase("button") && "button".equalsIgnoreCase(type)) {
                    String ActualText = webDriver.Getattribute(element, "data-value");
                    webDriver.Partialstringcomparator(ActualText, entry.getValue());
                }
                else if (Tag.equalsIgnoreCase("select") ) {
                    Select select = new Select(element);
                    String selectedText = select.getFirstSelectedOption().getText();
                    System.out.println("Selected Text: " + selectedText);
                    webDriver.Stringcomparator(selectedText, entry.getValue());
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
                    System.out.println("Text is "+Text);
                    if(Text.equalsIgnoreCase("Preview"))
                    {
                        WebElement element1 = webDriver.passwebelement(Generic.getlocator("DetailsFieldValueAssistive").replace("{paramlink1}", entry.getKey()));
                        Text = element1.getText();
                    }
                    System.out.println("Text is "+Text);
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        if(entry.getValue().trim().equalsIgnoreCase("NA"))
                        {
                            System.out.println("Values are: " + Text);
                            Assert.assertEquals(Text, "",entry.getKey()+": Actual value is "+Text+ " But Expected as "+entry.getValue());
                        }
                        else if(entry.getKey().contains("Date")&&!entry.getValue().trim().contains("/")&&!entry.getValue().contains("SysData"))
                        {
                            System.out.println("Values are: " + webDriver.ReturnDate(entry.getValue()));
                            Assert.assertEquals(Text,  webDriver.ReturnDate(entry.getValue()),entry.getKey()+": Actual value is "+Text+ " But Expected as "+ webDriver.ReturnDate(entry.getValue()));
                        }
                        else if(entry.getValue().equalsIgnoreCase("SysData=>ContactEmail"))
                        {
                            System.out.println("Values are: " + Text);
                            Assert.assertEquals(Text, propertyReader.readproperty("EmailID"),entry.getKey()+": Actual value is "+Text+ " But Expected as "+propertyReader.readproperty("EmailID"));
                        }
                        else if(entry.getValue().contains("SysData"))
                        {
                            String Value = entry.getValue().split("=>")[1];
                            Assert.assertTrue(Text.contains(DriverInstance.getVariable(Value)),entry.getKey()+": Actual value is "+Text+ " But Expected as "+DriverInstance.getVariable(Value));

                        }
                        else {
                            System.out.println("Values are: " + Text);
                            Assert.assertTrue(Text.contains(entry.getValue()),entry.getKey()+": Actual value is "+Text+ " But Expected as "+entry.getValue());
                        }
                    }
                    else{
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, "",entry.getKey()+": Actual value is "+Text+ " But Expected as "+entry.getValue());
                    }
                }
                catch(Exception e)
                {
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", entry.getKey())));
                    WebElement element = webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", entry.getKey()));
                    String Text = element.getText();
                    if(entry.getValue().equalsIgnoreCase("NA"))
                    {
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, "",entry.getKey()+": Actual value is "+Text+ " But Expected as "+entry.getValue());
                    }
                    else {
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, entry.getValue(),entry.getKey()+": Actual value is "+Text+ " But Expected as "+entry.getValue());
                    }
                }
            }
        }
    }

    public void ValidateDetailsWithParam(String Label, String Value) throws DocumentException, InterruptedException {

        try{
            webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", Label)));
            WebElement element = webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", Label));
            String Text = element.getText();
            System.out.println("Text is "+Text);
            if(Text.equalsIgnoreCase("Preview"))
            {
                WebElement element1 = webDriver.passwebelement(Generic.getlocator("DetailsFieldValueAssistive").replace("{paramlink1}", Label));
                Text = element1.getText();
            }
            System.out.println("Text is "+Text);
            if ( Objects.nonNull(Value) && !Value.isEmpty()) {
                if(Value.trim().equalsIgnoreCase("NA"))
                {
                    System.out.println("Values are: " + Text);
                    Assert.assertEquals(Text, "",Label+": Actual value is "+Text+ " But Expected as "+Value);
                }
                else if(Label.contains("Date")&&!Value.trim().contains("/")&&!Value.contains("SysData"))
                {
                    System.out.println("Values are: " + webDriver.ReturnDate(Value));
                    Assert.assertEquals(Text,  webDriver.ReturnDate(Value),Label+": Actual value is "+Text+ " But Expected as "+ webDriver.ReturnDate(Value));
                }
                else if(Value.equalsIgnoreCase("SysData=>ContactEmail"))
                {
                    System.out.println("Values are: " + Text);
                    Assert.assertEquals(Text, propertyReader.readproperty("EmailID"),Label+": Actual value is "+Text+ " But Expected as "+propertyReader.readproperty("EmailID"));
                }
                else if(Value.contains("SysData"))
                {
                    String Values = Value.split("=>")[1];
                    Assert.assertTrue(Text.contains(DriverInstance.getVariable(Values)),Label+": Actual value is "+Text+ " But Expected as "+DriverInstance.getVariable(Values));

                }
                else {
                    System.out.println("Values are: " + Text);
                    Assert.assertTrue(Text.contains(Value),Label+": Actual value is "+Text+ " But Expected as "+Value);
                }
            }
            else{
                System.out.println("Values are: " + Text);
                Assert.assertEquals(Text, "",Label+": Actual value is "+Text+ " But Expected as "+Value);
            }
        }
        catch(Exception e)
        {
            webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", Label)));
            WebElement element = webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", Label));
            String Text = element.getText();
            if(Value.equalsIgnoreCase("NA"))
            {
                System.out.println("Values are: " + Text);
                Assert.assertEquals(Text, "",Label+": Actual value is "+Text+ " But Expected as "+Value);
            }
            else {
                System.out.println("Values are: " + Text);
                Assert.assertEquals(Text, Value,Label+": Actual value is "+Text+ " But Expected as "+Value);
            }
        }
    }




    public void ValidateStopDetails(String Stop,DataTable dt) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                try{
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("VerifyStopDetails").replace("{paramlink1}", Stop).replace("{paramlink2}", entry.getKey())));
                    WebElement element = webDriver.passwebelement(Generic.getlocator("VerifyStopDetails").replace("{paramlink1}", Stop).replace("{paramlink2}", entry.getKey()));
                    String Text = element.getText();
                    System.out.println("Text is "+Text);
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        if(entry.getValue().trim().equalsIgnoreCase("NA"))
                        {
                            System.out.println("Values are: " + Text);
                            Assert.assertEquals(Text, "",entry.getKey()+": Actual value is "+Text+ " But Expected as "+entry.getValue());
                        }
                        else if(entry.getKey().contains("Date")&&!entry.getValue().trim().contains("/")&&!entry.getValue().contains("SysData"))
                        {
                            System.out.println("Values are: " + webDriver.ReturnDate(entry.getValue()));
                            Assert.assertEquals(Text,  webDriver.ReturnDate(entry.getValue()),entry.getKey()+": Actual value is "+Text+ " But Expected as "+ webDriver.ReturnDate(entry.getValue()));
                        }
                        else if(entry.getValue().equalsIgnoreCase("SysData=>ContactEmail"))
                        {
                            System.out.println("Values are: " + Text);
                            Assert.assertEquals(Text, propertyReader.readproperty("EmailID"),entry.getKey()+": Actual value is "+Text+ " But Expected as "+propertyReader.readproperty("EmailID"));
                        }
                        else if(entry.getValue().contains("SysData"))
                        {
                            String Value = entry.getValue().split("=>")[1];
                            Assert.assertTrue(Text.contains(DriverInstance.getVariable(Value)),entry.getKey()+": Actual value is "+Text+ " But Expected as "+propertyReader.readproperty("EmailID"));

                        }
                        else {
                            System.out.println("Values are: " + Text);
                            Assert.assertTrue(Text.contains(entry.getValue()),entry.getKey()+": Actual value is "+Text+ " But Expected as "+entry.getValue());
                        }
                    }
                    else{
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, "",entry.getKey()+": Actual value is "+Text+ " But Expected as "+entry.getValue());
                    }
                }
                catch(Exception e)
                {
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", entry.getKey())));
                    WebElement element = webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", entry.getKey()));
                    String Text = element.getText();
                    if(entry.getValue().equalsIgnoreCase("NA"))
                    {
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, "",entry.getKey()+": Actual value is "+Text+ " But Expected as "+entry.getValue());
                    }
                    else {
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, entry.getValue(),entry.getKey()+": Actual value is "+Text+ " But Expected as "+entry.getValue());
                    }
                }
            }
        }
    }
    public void GetDetails(DataTable dt) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                try{
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", entry.getKey())));
                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", entry.getKey())));
                    WebElement element = webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", entry.getKey()));
                    String Text = element.getText();
                    System.out.println("Text is "+Text);
                    if(Text.equalsIgnoreCase("Preview"))
                    {
                        WebElement element1 = webDriver.passwebelement(Generic.getlocator("DetailsFieldValueAssistive").replace("{paramlink1}", entry.getKey()));
                        Text = element1.getText();
                    }
                    System.out.println("Text is "+Text);
                    DriverInstance.setVariable(entry.getKey(), Text.replaceAll("(?i)\\s*Preview\\s*", " ").trim());
                    System.out.println("Value: "+Text);
                }
                catch(Exception e)
                {
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", entry.getKey())));
                    WebElement element = webDriver.passwebelement(Generic.getlocator("DetailsFieldValue").replace("{paramlink1}", entry.getKey()));
                    String Text = element.getText();
                    DriverInstance.setVariable(entry.getKey(), Text);
                    System.out.println("Value: "+Text);
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
                    if(entry.getValue().contains("SysData"))
                    {
                        String Value = entry.getValue().split("=>")[1];
                        Assert.assertTrue(Text.contains(DriverInstance.getVariable(Value)),entry.getKey()+": Actual value is "+Text+ " But Expected as "+DriverInstance.getVariable(Value));

                    }
                    else if(entry.getValue().equalsIgnoreCase("NA"))
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

                    else if (entry.getKey().contains("Date") && !entry.getValue().contains("/"))
                    {
                        webDriver.Partialstringcomparator(Text,webDriver.ReturnDate( entry.getValue()));
                    }
                    else {
                        System.out.println("Values are: " + Text);
                        Assert.assertEquals(Text, entry.getValue());
                    }
                }
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

    public void VerifyBannerCheckbox(DataTable dt) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("FieldCheck").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("FieldCheck").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                webDriver.verifyElementToBePresent(Generic.getlocator("FieldCheck").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue()));
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
                String Key = "";
                if(entry.getKey().endsWith("_2"))
                {
                    Key= entry.getKey().replace("_2","");
                    System.out.println(Key);
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", Key)));
                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", Key)));
                    fieldName = webDriver.passwebelement(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", Key)).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", entry.getKey()).replace("_2",""));
                }
                else{
                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
                    fieldName = webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey()));

                }
                WebElement element = webDriver.passwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
                try {
                    webDriver.waitUntilElementIsVisible(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
                    webDriver.ScrollIntoView(element);
                }
                catch (Exception e)
                {
                    webDriver.waitForElementLoad(5);
                    webDriver.ScrollIntoView(element);
                }
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
                        }
                        else if (entry.getKey().contains("Date")) {
                            if(entry.getValue().contains("/"))
                            {
                                webDriver.EnterTimeUsingJS(element, entry.getValue());
                                webDriver.Clickon(element);
                                webDriver.waitForElementLoad(1);
                            }
                            else if (entry.getValue().contains("SysData"))
                            {
                                webDriver.EnterTimeUsingJS(element, DriverInstance.getVariable(entry.getValue().split("=>")[1]));
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
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        if (entry.getValue().equalsIgnoreCase("Company Email")) {
                            webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                        } else if (entry.getKey().contains("Date")) {
                            webDriver.SendKeys(element, webDriver.ReturnDate(entry.getValue()));
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
                else if (Tag.equalsIgnoreCase("input") && "file".equalsIgnoreCase(type)) {
                    webDriver.ScrollIntoView(element);
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty())
                    {
                        String scenarioName= DriverInstance.getScenarioName();
                        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");

                        String Root = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator;
                        String FilePath = Root + "UploadFiles" + File.separator+TID+ File.separator + entry.getValue();
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
                        if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                            if (entry.getValue().contains("SysData")) {
                                String Value = DriverInstance.getVariable(entry.getValue().split("=>")[1]);
                                webDriver.SendKeys(element, Value);
                                webDriver.Clickon(element);

                                int count = webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                                if (count > 0) {
                                    if (Value.startsWith("L-") || entry.getKey().equalsIgnoreCase("Load")) {
                                        webDriver.waitForElementLoad(2);
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("*", "lightning-base-combobox-formatted-text").replace("{paramlink}", Value));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("*", "lightning-base-combobox-formatted-text").replace("{paramlink}", Value)));
                                    } else {
                                        webDriver.waitForElementLoad(2);
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value)));
                                    }
                                } else {
                                    webDriver.waitForElementLoad(1);
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for")));
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("SelectTextRadio").replace("{paramlink}", Value));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SelectTextRadio").replace("{paramlink}", Value)));
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("GlobalText2").replace("{paramlink}", "Select"));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("GlobalText2").replace("{paramlink}", "Select")));
                                }
                            }
                            else if (entry.getValue().trim().contains("Add New")) {
                                webDriver.Clickon(element);
                            }
                            else {
                                webDriver.SendKeys(element, entry.getValue());
                                if (!entry.getKey().contains("Time")) {
                                    webDriver.waitForElementLoad(1);
                                    webDriver.ClickOnElement(element);
                                    webDriver.waitForElementLoad(1);
                                    int count = webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitleWithLabel").replace("{paramlink}", entry.getKey().replace("_2", "")).replace("{paramlink2}", entry.getValue()));
                                    if (count > 0) {
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitleWithLabel").replace("{paramlink}", entry.getKey().replace("_2", "")).replace("{paramlink2}", entry.getValue()));
                                        webDriver.Clickon(webDriver.getwebelement(Generic.getlocator("ButtonIconTitleWithLabel").replace("{paramlink}", entry.getKey().replace("_2", "")).replace("{paramlink2}", entry.getValue())));
                                    } else {
                                        int Numcount = webDriver.getwebelementscount(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                        if (Numcount == 1) {
                                            webDriver.waitforElementtobeclickable(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for")));
                                        } else {
                                            webDriver.waitforElementtobeclickable(Generic.getlocator("SpanText").replace("{paramlink}", entry.getValue()));
                                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SpanText").replace("{paramlink}", entry.getValue())));
                                        }
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("SelectTextRadio").replace("{paramlink}", entry.getValue()));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SelectTextRadio").replace("{paramlink}", entry.getValue())));
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonOnModal").replace("{paramlink}", "Select"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonOnModal").replace("{paramlink}", "Select")));

                                    }
                                }
                            }
                        }

                        else{
                            System.out.println("Already not selected");
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
                            flag=  webDriver.getwebelementscount(Generic.getlocator("LabelClearIcon_2").replace("{paramlink}", entry.getKey().replace("_2","")));
                        }
                        else {
                            flag=  webDriver.getwebelementscount(Generic.getlocator("LabelClearIcon").replace("{paramlink}", entry.getKey()));
                        }
                        System.out.println("Flag is "+flag);
                        if(flag>0) {
                            if (entry.getKey().endsWith("_2")) {
                                System.out.println(111111);
                                webDriver.Clickon(webDriver.getwebelement(Generic.getlocator("LabelClearIcon_2").replace("{paramlink}", Key).replace("_2","")));
                            } else {
                                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("LabelClearIcon").replace("{paramlink}", entry.getKey())));
                            }
                            if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                                if (entry.getValue().contains("SysData"))
                                {
                                    String Value = DriverInstance.getVariable(entry.getValue().split("=>")[1]);
                                    webDriver.SendKeys(element, Value);
                                    webDriver.Clickon(element);

                                    int count= webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                                    if(count>0) {
                                        if(Value.startsWith("L-")||entry.getKey().equalsIgnoreCase("Load")) {
                                            webDriver.waitForElementLoad(2);
                                            webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("*","lightning-base-combobox-formatted-text").replace("{paramlink}", Value));
                                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("*","lightning-base-combobox-formatted-text").replace("{paramlink}", Value)));
                                        }
                                        else {
                                            webDriver.waitForElementLoad(2);
                                            webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value)));
                                        }
                                    }
                                    else{
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SpanText").replace("{paramlink}","Show more results for")));
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("SelectTextRadio").replace("{paramlink}", Value));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SelectTextRadio").replace("{paramlink}", Value)));
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonOnModal").replace("{paramlink}", "Select"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonOnModal").replace("{paramlink}", "Select")));
                                    }
                                }
                                else{
                                    System.out.println(111112);
                                    webDriver.SendKeys(element, entry.getValue());
                                    webDriver.Clickon(element);
                                    int count = webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                                    if (count > 0) {
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue())));
                                    } else {
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for")));
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("SelectTextRadio").replace("{paramlink}", entry.getValue()));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SelectTextRadio").replace("{paramlink}", entry.getValue())));
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonOnModal").replace("{paramlink}", "Select"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonOnModal").replace("{paramlink}", "Select")));
                                    }
                                }
                            }
                        }
                        else {
                            if (Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                                System.out.println(111113);
                                webDriver.Clickon(element);
                                webDriver.waitForElementLoad(1);
                                if (entry.getKey().contains("_2")) {
                                    String key = entry.getKey().replace("_2", "");
                                    String value = entry.getValue();
                                    if (value.contains("SysData")) {
                                        value = DriverInstance.getVariable(value.split("=>")[1]);
                                    }
                                    if (webDriver.getwebelementscount(Generic.getlocator("Div_aria_Label").replace("{paramlink}", key)) > 0) {
                                        webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("Div_aria_Label").replace("{paramlink}", key)), webDriver.getwebelement(Generic.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", key).replace("{paramlink2}", value)));
                                    } else {
                                        webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("DropdownListBox").replace("{paramlink}", fieldName)), webDriver.getwebelement(Generic.getlocator("DropdownListBoxOptionList").replace("{paramlink}", fieldName).replace("{paramlink2}", value)));

                                    }
                                }
                                else {
                                    String key = entry.getKey();
                                    String value = entry.getValue();
                                    if (value.contains("SysData")) {
                                        value = DriverInstance.getVariable(value.split("=>")[1]);
                                    }
                                    if (webDriver.getwebelementscount(Generic.getlocator("Div_aria_Label").replace("{paramlink}", key)) > 0) {
                                        webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("Div_aria_Label").replace("{paramlink}", key)), webDriver.getwebelement(Generic.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", key).replace("{paramlink2}", value)));
                                    } else {
                                        webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("DropdownListBox").replace("{paramlink}", fieldName)), webDriver.getwebelement(Generic.getlocator("DropdownListBoxOptionList").replace("{paramlink}", fieldName).replace("{paramlink2}", value)));

                                    }
//
                                }
                            }
                            else{
                                webDriver.SendKeys(element, "");
//                                webDriver.EnterTimeUsingJS(element, "");
                            }
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
                                webDriver.safeJavaScriptClick(element);
                            } catch (Exception e) {
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
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
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
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
                    if (entry.getKey().endsWith("_2")) {
                        Key = entry.getKey().replace("_2", "");
                        webDriver.safeJavaScriptClick(element);
                        List<WebElement> div_Aria_Label=webDriver.getwebelements(Generic.getlocator("Div_aria_Label").replace("{paramlink}", Key));
                        List<WebElement> div_Aria_Label_Span=webDriver.getwebelements(Generic.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", Key).replace("{paramlink2}", entry.getValue()));
                        for(int i=0;i<div_Aria_Label.size();i++){
                            if(div_Aria_Label.get(i).isDisplayed()){
                                if(div_Aria_Label_Span.size() ==1){
                                    webDriver.SelectComboBoxOption(div_Aria_Label.get(i), div_Aria_Label_Span.get(0));
                                    break;
                                }else {
                                    webDriver.SelectComboBoxOption(div_Aria_Label.get(i), div_Aria_Label_Span.get(i));
                                    break;
                                }
                            }
                        }

                    } else {
                        webDriver.safeJavaScriptClick(element);
                        String key=entry.getKey();
                        String value = entry.getValue();
                        if (value.contains("SysData")) {
                            value = DriverInstance.getVariable(value.split("=>")[1]);
                        }
                        if (webDriver.getwebelementscount(Generic.getlocator("Div_aria_Label").replace("{paramlink}", key)) > 0) {
                            webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("Div_aria_Label").replace("{paramlink}", key)), webDriver.getwebelement(Generic.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", key).replace("{paramlink2}", value)));
                        } else {
                            webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("DropdownListBox").replace("{paramlink}", fieldName)), webDriver.getwebelement(Generic.getlocator("DropdownListBoxOptionList").replace("{paramlink}", fieldName).replace("{paramlink2}", value)));

                        }
//                        webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("Div_aria_Label").replace("{paramlink}", entry.getKey())), webDriver.getwebelement(Generic.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                    }
                }
            }
        }
    }

    public void updateHazmatDetails(String arg0, DataTable dt) throws Exception {

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
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", Key)));
                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", Key)));
                    fieldName = webDriver.passwebelement(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", Key)).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", entry.getKey()).replace("_2",""));
                }
                else{
                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("LabelTextWithIndex2").replace("{index}",arg0).replace("{paramlink}", entry.getKey())));
                    fieldName = webDriver.passwebelement(Generic.getlocator("LabelTextWithIndex2").replace("{index}",arg0).replace("{paramlink}", entry.getKey())).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(Generic.getlocator("LabelTextWithIndex2").replace("{index}",arg0).replace("{paramlink}", entry.getKey()));

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
                        } else if (entry.getKey().contains("Date")) {
                            if(entry.getValue().contains("/"))
                            {
                                webDriver.EnterTimeUsingJS(element, entry.getValue());
                                webDriver.Clickon(element);
                                webDriver.waitForElementLoad(1);
                            }
                            else if (entry.getValue().contains("SysData"))
                            {
                                webDriver.EnterTimeUsingJS(element, DriverInstance.getVariable(entry.getValue().split("=>")[1]));
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
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        if (entry.getValue().equalsIgnoreCase("Company Email")) {
                            webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                        } else if (entry.getKey().contains("Date")) {
                            webDriver.SendKeys(element, webDriver.ReturnDate(entry.getValue()));
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
                else if (Tag.equalsIgnoreCase("input") && "file".equalsIgnoreCase(type)) {
                    webDriver.ScrollIntoView(element);
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty())
                    {
                        String scenarioName= DriverInstance.getScenarioName();
                        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");

                        String Root = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator;
                        String FilePath = Root + "UploadFiles" + File.separator+TID+ File.separator + entry.getValue();
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

                            int count= webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                            if(count>0) {
                                if(Value.startsWith("L-")||entry.getKey().equalsIgnoreCase("Load")) {
                                    webDriver.waitForElementLoad(2);
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("*","lightning-base-combobox-formatted-text").replace("{paramlink}", Value));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("*","lightning-base-combobox-formatted-text").replace("{paramlink}", Value)));
                                }
                                else {
                                    webDriver.waitForElementLoad(2);
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value)));
                                }
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
                        else{
                            webDriver.SendKeys(element, entry.getValue());
                            if(!entry.getKey().contains("Time"))
                            {
                                webDriver.Clickon(element);
                                int count= webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitleWithLabel").replace("{paramlink}", entry.getKey().replace("_2","")).replace("{paramlink2}", entry.getValue()));
                                if(count>0) {
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitleWithLabel").replace("{paramlink}", entry.getKey().replace("_2","")).replace("{paramlink2}", entry.getValue()));
                                    webDriver.Clickon(webDriver.getwebelement(Generic.getlocator("ButtonIconTitleWithLabel").replace("{paramlink}", entry.getKey().replace("_2","")).replace("{paramlink2}", entry.getValue())));
                                }
                                else{
                                    int Numcount=webDriver.getwebelementscount(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                    if(Numcount==1) {
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for")));
                                    }
                                    else{
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("SpanText").replace("{paramlink}", entry.getValue()));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SpanText").replace("{paramlink}", entry.getValue())));
                                    }
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("SelectTextRadio").replace("{paramlink}", entry.getValue()));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SelectTextRadio").replace("{paramlink}", entry.getValue())));
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonOnModal").replace("{paramlink}", "Select"));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonOnModal").replace("{paramlink}", "Select")));

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
                            flag=  webDriver.getwebelementscount(Generic.getlocator("LabelClearIcon_2").replace("{paramlink}", entry.getKey().replace("_2","")));
                        }
                        else {
                            flag=  webDriver.getwebelementscount(Generic.getlocator("LabelClearIcon").replace("{paramlink}", entry.getKey()));
                        }
                        System.out.println("Flag is "+flag);
                        if(flag>0) {
                            if (entry.getKey().endsWith("_2")) {
                                System.out.println(111111);
                                webDriver.Clickon(webDriver.getwebelement(Generic.getlocator("LabelClearIcon_2").replace("{paramlink}", Key).replace("_2","")));
                            } else {
                                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("LabelClearIcon").replace("{paramlink}", entry.getKey())));
                            }
                            if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                                if (entry.getValue().contains("SysData"))
                                {
                                    String Value = DriverInstance.getVariable(entry.getValue().split("=>")[1]);
                                    webDriver.SendKeys(element, Value);
                                    webDriver.Clickon(element);

                                    int count= webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                                    if(count>0) {
                                        if(Value.startsWith("L-")||entry.getKey().equalsIgnoreCase("Load")) {
                                            webDriver.waitForElementLoad(2);
                                            webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("*","lightning-base-combobox-formatted-text").replace("{paramlink}", Value));
                                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("*","lightning-base-combobox-formatted-text").replace("{paramlink}", Value)));
                                        }
                                        else {
                                            webDriver.waitForElementLoad(2);
                                            webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value)));
                                        }
                                    }
                                    else{
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SpanText").replace("{paramlink}","Show more results for")));
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("SelectTextRadio").replace("{paramlink}", Value));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SelectTextRadio").replace("{paramlink}", Value)));
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonOnModal").replace("{paramlink}", "Select"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonOnModal").replace("{paramlink}", "Select")));
                                    }
                                }
                                else{
                                    System.out.println(111112);
                                    webDriver.SendKeys(element, entry.getValue());
                                    webDriver.Clickon(element);
                                    int count = webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                                    if (count > 0) {
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue())));
                                    } else {
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for")));
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("SelectTextRadio").replace("{paramlink}", entry.getValue()));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SelectTextRadio").replace("{paramlink}", entry.getValue())));
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonOnModal").replace("{paramlink}", "Select"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonOnModal").replace("{paramlink}", "Select")));
                                    }}
                            }
                        }
                        else{
                            System.out.println(111113);
                            webDriver.Clickon(element);
                            webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("Div_aria_Label").replace("{paramlink}", entry.getKey())), webDriver.getwebelement(Generic.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
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
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
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
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
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
                    webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("Div_aria_Label").replace("{paramlink}", entry.getKey())), webDriver.getwebelement(Generic.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                }
            }
        }
    }

    public void updateServicesDataForSections(String sectionName, DataTable dt) throws Exception {



        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                String fieldName;
                WebElement Labelel;
                String Key = "";
                if(entry.getKey().endsWith("_2"))
                {
                    Key= entry.getKey().replace("_2","");
                    System.out.println(Key);
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("LabelTextUnderSectionWithIndex").replace("{SectionName}",sectionName).replace("{paramlink}", Key)));
                    Labelel= webDriver.passwebelement(Generic.getlocator("LabelTextUnderSectionWithIndex").replace("{SectionName}",sectionName).replace("{paramlink}", Key));
                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("LabelTextUnderSectionWithIndex").replace("{SectionName}",sectionName).replace("{paramlink}", Key)));
                    fieldName = webDriver.passwebelement(Generic.getlocator("LabelTextUnderSectionWithIndex").replace("{SectionName}",sectionName).replace("{paramlink}", Key)).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(Generic.getlocator("LabelTextUnderSectionWithIndex").replace("{SectionName}",sectionName).replace("{paramlink}", entry.getKey()).replace("_2",""));
                }
                else{
                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("LabelTextUnderSection").replace("{SectionName}",sectionName).replace("{paramlink}", entry.getKey())));
                    Labelel= webDriver.passwebelement(Generic.getlocator("LabelTextUnderSection").replace("{SectionName}",sectionName).replace("{paramlink}", entry.getKey()));
                    fieldName = webDriver.passwebelement(Generic.getlocator("LabelTextUnderSection").replace("{SectionName}",sectionName).replace("{paramlink}", entry.getKey())).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(Generic.getlocator("LabelTextUnderSection").replace("{SectionName}",sectionName).replace("{paramlink}", entry.getKey()));

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
                        }
                        else if (entry.getKey().contains("Date")) {
                            if(entry.getValue().contains("/"))
                            {
                                webDriver.EnterTimeUsingJS(element, entry.getValue());
                                webDriver.Clickon(element);
                                webDriver.waitForElementLoad(1);
                            }
                            else if (entry.getValue().contains("SysData"))
                            {
                                webDriver.EnterTimeUsingJS(element, DriverInstance.getVariable(entry.getValue().split("=>")[1]));
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
                        }
                        else {
                            webDriver.SendKeys(element, entry.getValue());
                        }
                    }
                    else{
                        webDriver.SendKeys(element, "");
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "search".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {
                    webDriver.ScrollIntoView(element);
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        if (entry.getValue().equalsIgnoreCase("Company Email")) {
                            webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                        } else if (entry.getKey().contains("Date")) {
                            webDriver.SendKeys(element, webDriver.ReturnDate(entry.getValue()));
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
                else if (Tag.equalsIgnoreCase("input") && "file".equalsIgnoreCase(type)) {
                    webDriver.ScrollIntoView(element);
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty())
                    {
                        String scenarioName= DriverInstance.getScenarioName();
                        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");

                        String Root = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator;
                        String FilePath = Root + "UploadFiles" + File.separator+TID+ File.separator + entry.getValue();
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

                            int count= webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                            if(count>0) {
                                if(Value.startsWith("L-")||entry.getKey().equalsIgnoreCase("Load")) {
                                    webDriver.waitForElementLoad(2);
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("*","lightning-base-combobox-formatted-text").replace("{paramlink}", Value));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("*","lightning-base-combobox-formatted-text").replace("{paramlink}", Value)));
                                }
                                else {
                                    webDriver.waitForElementLoad(2);
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value)));
                                }
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
                        else{
                            webDriver.SendKeys(element, entry.getValue());
                            if(!entry.getKey().contains("Time"))
                            {
                                webDriver.Clickon(element);
                                int count= webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitleWithLabel").replace("{paramlink}", entry.getKey().replace("_2","")).replace("{paramlink2}", entry.getValue()));
                                if(count>0) {
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitleWithLabel").replace("{paramlink}", entry.getKey().replace("_2","")).replace("{paramlink2}", entry.getValue()));
                                    webDriver.Clickon(webDriver.getwebelement(Generic.getlocator("ButtonIconTitleWithLabel").replace("{paramlink}", entry.getKey().replace("_2","")).replace("{paramlink2}", entry.getValue())));
                                }
                                else{
                                    int Numcount=webDriver.getwebelementscount(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                    if(Numcount==1) {
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for")));
                                    }
                                    else{
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("SpanText").replace("{paramlink}", entry.getValue()));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SpanText").replace("{paramlink}", entry.getValue())));
                                    }
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("SelectTextRadio").replace("{paramlink}", entry.getValue()));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SelectTextRadio").replace("{paramlink}", entry.getValue())));
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("GlobalText2").replace("{paramlink}", "Select"));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("GlobalText2").replace("{paramlink}", "Select")));
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
                            flag=  webDriver.getwebelementscount(Generic.getlocator("LabelClearIcon_2").replace("{paramlink}", entry.getKey().replace("_2","")));
                        }
                        else {
                            flag=  webDriver.getwebelementscount(Generic.getlocator("LabelClearIcon").replace("{paramlink}", entry.getKey()));
                        }
                        System.out.println("Flag is "+flag);
                        if(flag>0) {
                            if (entry.getKey().endsWith("_2")) {
                                System.out.println(111111);
                                webDriver.Clickon(webDriver.getwebelement(Generic.getlocator("LabelClearIcon_2").replace("{paramlink}", Key).replace("_2","")));
                            } else {
                                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("LabelClearIcon").replace("{paramlink}", entry.getKey())));
                            }
                            if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                                if (entry.getValue().contains("SysData"))
                                {
                                    String Value = DriverInstance.getVariable(entry.getValue().split("=>")[1]);
                                    webDriver.SendKeys(element, Value);
                                    webDriver.Clickon(element);

                                    int count= webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                                    if(count>0) {
                                        if(Value.startsWith("L-")||entry.getKey().equalsIgnoreCase("Load")) {
                                            webDriver.waitForElementLoad(2);
                                            webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("*","lightning-base-combobox-formatted-text").replace("{paramlink}", Value));
                                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("*","lightning-base-combobox-formatted-text").replace("{paramlink}", Value)));
                                        }
                                        else {
                                            webDriver.waitForElementLoad(2);
                                            webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value)));
                                        }
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
                                else{
                                    System.out.println(111112);
                                    webDriver.SendKeys(element, entry.getValue());
                                    webDriver.Clickon(element);
                                    int count = webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                                    if (count > 0) {
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue())));
                                    } else {
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for")));
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("SelectTextRadio").replace("{paramlink}", entry.getValue()));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SelectTextRadio").replace("{paramlink}", entry.getValue())));
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("GlobalText2").replace("{paramlink}", "Select"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("GlobalText2").replace("{paramlink}", "Select")));
                                    }}
                            }
                        }
                        else{
                            System.out.println(111113);
                            webDriver.Clickon(element);
                            webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("Div_aria_Label").replace("{paramlink}", entry.getKey())), webDriver.getwebelement(Generic.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
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
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
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
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
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
                    webDriver.ScrollIntoView(Labelel);
                    webDriver.waitUntilTheElementIsVisible(Labelel);
                    webDriver.safeJavaScriptClick(Labelel);
                }
                else if (Tag.equalsIgnoreCase("button") && "button".equalsIgnoreCase(type)) {

                    webDriver.safeJavaScriptClick(element);
                    webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("Div_aria_Label").replace("{paramlink}", entry.getKey())), webDriver.getwebelement(Generic.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                }
            }
        }
    }

    public void updateServicesLayoutDetails(DataTable dt) throws Exception {

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
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("LayoutDetailsLabelTextWithIndex").replace("{paramlink}", Key)));
                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("LayoutDetailsLabelTextWithIndex").replace("{paramlink}", Key)));
                    fieldName = webDriver.passwebelement(Generic.getlocator("LayoutDetailsLabelTextWithIndex").replace("{paramlink}", Key)).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(Generic.getlocator("LayoutDetailsLabelTextWithIndex").replace("{paramlink}", entry.getKey()).replace("_2",""));
                }
                else{
                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("LayoutDetailsLabelText").replace("{paramlink}", entry.getKey())));
                    fieldName = webDriver.passwebelement(Generic.getlocator("LayoutDetailsLabelText").replace("{paramlink}", entry.getKey())).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(Generic.getlocator("LayoutDetailsLabelText").replace("{paramlink}", entry.getKey()));

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
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        if (entry.getValue().equalsIgnoreCase("Company Email")) {
                            webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                        } else if (entry.getKey().contains("Date")) {
                            webDriver.SendKeys(element, webDriver.ReturnDate(entry.getValue()));
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
                else if (Tag.equalsIgnoreCase("input") && "file".equalsIgnoreCase(type)) {
                    webDriver.ScrollIntoView(element);
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty())
                    {
                        String scenarioName= DriverInstance.getScenarioName();
                        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");

                        String Root = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator;
                        String FilePath = Root + "UploadFiles" + File.separator+TID+ File.separator + entry.getValue();
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

                            int count= webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                            if(count>0) {
                                if(Value.startsWith("L-")||entry.getKey().equalsIgnoreCase("Load")) {
                                    webDriver.waitForElementLoad(2);
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("*","lightning-base-combobox-formatted-text").replace("{paramlink}", Value));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("*","lightning-base-combobox-formatted-text").replace("{paramlink}", Value)));
                                }
                                else {
                                    webDriver.waitForElementLoad(2);
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value)));
                                }
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
                        else{
                            webDriver.SendKeys(element, entry.getValue());
                            if(!entry.getKey().contains("Time"))
                            {
                                webDriver.Clickon(element);
                                int count= webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitleWithLabel").replace("{paramlink}", entry.getKey().replace("_2","")).replace("{paramlink2}", entry.getValue()));
                                if(count>0) {
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitleWithLabel").replace("{paramlink}", entry.getKey().replace("_2","")).replace("{paramlink2}", entry.getValue()));
                                    webDriver.Clickon(webDriver.getwebelement(Generic.getlocator("ButtonIconTitleWithLabel").replace("{paramlink}", entry.getKey().replace("_2","")).replace("{paramlink2}", entry.getValue())));
                                }
                                else{
                                    int Numcount=webDriver.getwebelementscount(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                    if(Numcount==1) {
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for")));
                                    }
                                    else{
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("SpanText").replace("{paramlink}", entry.getValue()));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SpanText").replace("{paramlink}", entry.getValue())));
                                    }
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("SelectTextRadio").replace("{paramlink}", entry.getValue()));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SelectTextRadio").replace("{paramlink}", entry.getValue())));
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("GlobalText2").replace("{paramlink}", "Select"));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("GlobalText2").replace("{paramlink}", "Select")));
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
                            flag=  webDriver.getwebelementscount(Generic.getlocator("LabelClearIcon_2").replace("{paramlink}", entry.getKey().replace("_2","")));
                        }
                        else {
                            flag=  webDriver.getwebelementscount(Generic.getlocator("LabelClearIcon").replace("{paramlink}", entry.getKey()));
                        }
                        System.out.println("Flag is "+flag);
                        if(flag>0) {
                            if (entry.getKey().endsWith("_2")) {
                                System.out.println(111111);
                                webDriver.Clickon(webDriver.getwebelement(Generic.getlocator("LabelClearIcon_2").replace("{paramlink}", Key).replace("_2","")));
                            } else {
                                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("LabelClearIcon").replace("{paramlink}", entry.getKey())));
                            }
                            if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                                if (entry.getValue().contains("SysData"))
                                {
                                    String Value = DriverInstance.getVariable(entry.getValue().split("=>")[1]);
                                    webDriver.SendKeys(element, Value);
                                    webDriver.Clickon(element);

                                    int count= webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                                    if(count>0) {
                                        if(Value.startsWith("L-")||entry.getKey().equalsIgnoreCase("Load")) {
                                            webDriver.waitForElementLoad(2);
                                            webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("*","lightning-base-combobox-formatted-text").replace("{paramlink}", Value));
                                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("*","lightning-base-combobox-formatted-text").replace("{paramlink}", Value)));
                                        }
                                        else {
                                            webDriver.waitForElementLoad(2);
                                            webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value)));
                                        }
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
                                else{
                                    System.out.println(111112);
                                    webDriver.SendKeys(element, entry.getValue());
                                    webDriver.Clickon(element);
                                    int count = webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                                    if (count > 0) {
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue())));
                                    } else {
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for")));
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("SelectTextRadio").replace("{paramlink}", entry.getValue()));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SelectTextRadio").replace("{paramlink}", entry.getValue())));
                                        webDriver.waitforElementtobeclickable(Generic.getlocator("GlobalText2").replace("{paramlink}", "Select"));
                                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("GlobalText2").replace("{paramlink}", "Select")));
                                    }}
                            }
                        }
                        else{
                            System.out.println(111113);
                            webDriver.Clickon(element);
                            webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("Div_aria_Label").replace("{paramlink}", entry.getKey())), webDriver.getwebelement(Generic.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
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
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
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
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
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
                    webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("Div_aria_Label").replace("{paramlink}", entry.getKey())), webDriver.getwebelement(Generic.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                }
            }
        }
    }

    public void updateDataWithSetValue(DataTable dt) throws Exception {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + DriverInstance.getVariable(entry.getValue()));

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
                    System.out.println(fieldName);
                    System.out.println(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey()));

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
                    if (DriverInstance.getVariable(entry.getValue()).equalsIgnoreCase("Company Email")) {
                        webDriver.EnterTextUsingJS(element, propertyReader.readproperty("Company_Email"));
                    }
                    else if (entry.getKey().contains("Date")) {
                        webDriver.EnterTextUsingJS(element,webDriver.ReturnDate(DriverInstance.getVariable(entry.getValue())));
                    }
                    else {
                        webDriver.EnterTextUsingJS(element, DriverInstance.getVariable(entry.getValue()));
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "search".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {
                    webDriver.ScrollIntoView(element);
                    if (DriverInstance.getVariable(entry.getValue()).equalsIgnoreCase("Company Email")) {
                        webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                    }
                    else if (entry.getKey().contains("Date")) {
                        webDriver.SendKeys(element,webDriver.ReturnDate(DriverInstance.getVariable(entry.getValue())));
                    }
                    else {
                        webDriver.SendKeys(element, DriverInstance.getVariable(entry.getValue()));
                    }
                }
                else if (Tag.equalsIgnoreCase("textarea")) {
                    webDriver.ScrollIntoView(element);

                    if (DriverInstance.getVariable(entry.getValue()).equalsIgnoreCase("Company Email")) {
                        webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                    }
                    else {
                        webDriver.SendKeys(element, DriverInstance.getVariable(entry.getValue()));
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && "combobox".equalsIgnoreCase(role)) {
                    webDriver.ScrollIntoView(element);
                    String ActualText = webDriver.Getattribute(element, "data-value");
                    if (ActualText.equalsIgnoreCase(""))
                    {
                        webDriver.SendKeys(element, DriverInstance.getVariable(entry.getValue()));
                        if(!entry.getKey().contains("Time"))
                        {
                            webDriver.Clickon(element);
                            int count= webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", DriverInstance.getVariable(entry.getValue())));
                            if(count>0) {
                                webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", DriverInstance.getVariable(entry.getValue())));
                                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", DriverInstance.getVariable(entry.getValue()))));
                            }
                            else{
                                webDriver.waitforElementtobeclickable(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SpanText").replace("{paramlink}","Show more results for")));
                                webDriver.waitforElementtobeclickable(Generic.getlocator("SelectTextRadio").replace("{paramlink}", DriverInstance.getVariable(entry.getValue())));
                                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SelectTextRadio").replace("{paramlink}", DriverInstance.getVariable(entry.getValue()))));
                                webDriver.waitforElementtobeclickable(Generic.getlocator("GlobalText2").replace("{paramlink}", "Select"));
                                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("GlobalText2").replace("{paramlink}", "Select")));
                            }
                        }
                    }
                    else if (ActualText.equalsIgnoreCase(DriverInstance.getVariable(entry.getValue()))) {
                        System.out.println("Already selected");
                    }
                    else {
                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("LabelClearIcon").replace("{paramlink}", entry.getKey())));
                        webDriver.SendKeys(element, DriverInstance.getVariable(entry.getValue()));
                        webDriver.Clickon(element);

                        int count= webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", DriverInstance.getVariable(entry.getValue())));
                        if(count>0) {
                            webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", DriverInstance.getVariable(entry.getValue())));
                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", DriverInstance.getVariable(entry.getValue()))));
                        }
                        else{
                            webDriver.waitforElementtobeclickable(Generic.getlocator("SpanText").replace("{paramlink}", "Show more results for"));
                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SpanText").replace("{paramlink}","Show more results for")));
                            webDriver.waitforElementtobeclickable(Generic.getlocator("SelectTextRadio").replace("{paramlink}", DriverInstance.getVariable(entry.getValue())));
                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SelectTextRadio").replace("{paramlink}", DriverInstance.getVariable(entry.getValue()))));
                            webDriver.waitforElementtobeclickable(Generic.getlocator("GlobalText2").replace("{paramlink}", "Select"));
                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("GlobalText2").replace("{paramlink}", "Select")));
                        }
                        webDriver.Clickon(element);
                        webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", DriverInstance.getVariable(entry.getValue())));
                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", DriverInstance.getVariable(entry.getValue()))));

                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "password".equalsIgnoreCase(type)) {
                    webDriver.SendKeys(element, DriverInstance.getVariable(entry.getValue()));
                }
                else if (Tag.equalsIgnoreCase("input") && "checkbox".equalsIgnoreCase(type)) {

                    webDriver.ScrollIntoView(element);
                    boolean isChecked  = "true".equalsIgnoreCase(element.getAttribute("checked"));
                    if(!isChecked) {
                        try {
                            webDriver.ClickOnElement(element);
                        } catch (Exception e) {
                            webDriver.safeJavaScriptClick(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
                        }
                    }
                }
                else if (Tag.equalsIgnoreCase("select") ) {
                    System.out.println("inn");
                    webDriver.ScrollIntoView(element);
                    webDriver.waitUntilTheElementIsVisible(element);
                    webDriver.selectOptionByText(element,DriverInstance.getVariable(entry.getValue()));
                }
                else if (Tag.equalsIgnoreCase("input") && "radio".equalsIgnoreCase(type)) {
                    System.out.println("inn");
                    webDriver.ScrollIntoView(element);
                    webDriver.waitUntilTheElementIsVisible(element);
                    webDriver.ClickOnElement(element);
                }
                else if (Tag.equalsIgnoreCase("button") && "button".equalsIgnoreCase(type)) {
                    webDriver.Clickon(element);
                    webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("Div_aria_Label").replace("{paramlink}", entry.getKey())), webDriver.getwebelement(Generic.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", DriverInstance.getVariable(entry.getValue()))));
                }
            }
        }
    }

    public void updateServicesData1(String key, String Value) throws Exception {


        System.out.println("Setting " + key + " to " + Value);
        String fieldName;
        if(key.endsWith("_2"))
        {
            String Key= key.replace("_2","");
            System.out.println(Key);
            fieldName = webDriver.passwebelement(Generic.getlocator("LabelTextWithIndex").replace("{paramlink}", Key)).getAttribute("for");
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
            if (Objects.nonNull(Value) && !Value.isEmpty()) {
                if (Value.equalsIgnoreCase("Company Email")) {
                    webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                } else if (key.contains("Date")) {
                    webDriver.SendKeys(element, webDriver.ReturnDate(Value));
                } else {
                    webDriver.SendKeys(element, Value);
                }
            }
            else{
                webDriver.SendKeys(element, Value);
            }
        }
        if (Tag.equalsIgnoreCase("input") && "search".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {
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

            String ActualText = webDriver.Getattribute(element, "data-value");
            if (ActualText.equalsIgnoreCase("")) {
                webDriver.SendKeys(element, Value);
                if(!key.contains("Time"))
                {
                    webDriver.Clickon(element);
                    webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value)));
                }
            } else if (ActualText.equalsIgnoreCase(Value)) {
                System.out.println("Already selected");
            } else {

                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("LabelClearIcon").replace("{paramlink}", Value)));
                webDriver.SendKeys(element, Value);
                webDriver.Clickon(element);
                webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value)));

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
                        webDriver.ClickOnElement(element);
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

    public void moveOptionToChosen(String FieldName,String option) throws Exception {
        if(webDriver.getwebelementscount(Generic.getlocator("OptionAvailableList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option))>0) {
            // Click Options from Available Options
            webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("OptionAvailableList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option)));
            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("OptionAvailableList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option)));
            webDriver.ClickOnElement(webDriver.passwebelement(Generic.getlocator("OptionAvailableList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option)));
            // Click "Move to Chosen" (right arrow button)
            webDriver.waitForElementLoad(1);
            webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("WithFieldNameAndTitle").replace("{paramlink1}", FieldName).replace("{paramlink2}", "Move selection to Chosen")));
            webDriver.WaitforElementtobeclickable(Generic.getlocator("WithFieldNameAndTitle").replace("{paramlink1}", FieldName).replace("{paramlink2}", "Move selection to Chosen"));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(Generic.getlocator("WithFieldNameAndTitle").replace("{paramlink1}", FieldName).replace("{paramlink2}", "Move selection to Chosen")));
            webDriver.waitForElementLoad(1);
        }
        //Verify selected and displaying on cosen List
        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("OptionChosenList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option)));
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("OptionChosenList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option)));
        webDriver.verifyElementToBePresent(Generic.getlocator("OptionChosenList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option));
    }

    public void moveOptionToAvailable(String FieldName,String option) throws DocumentException, InterruptedException {
        // Click Options from Available Options
        if(webDriver.getwebelementscount(Generic.getlocator("OptionChosenList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option))>0) {
            webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("OptionChosenList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option)));
            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("OptionChosenList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option)));
            webDriver.ClickOnElement(webDriver.passwebelement(Generic.getlocator("OptionChosenList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option)));
            // Click "Move to Chosen" (right arrow button)
            webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("WithFieldNameAndTitle").replace("{paramlink1}", FieldName).replace("{paramlink2}", "Move selection to Available")));
            webDriver.WaitforElementtobeclickable(Generic.getlocator("WithFieldNameAndTitle").replace("{paramlink1}", FieldName).replace("{paramlink2}", "Move selection to Available"));
            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("WithFieldNameAndTitle").replace("{paramlink1}", FieldName).replace("{paramlink2}", "Move selection to Available")));
            webDriver.waitForElementLoad(1);
        }
        //Verify selected and displaying on cosen List
        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("OptionAvailableList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option)));
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("OptionAvailableList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option)));
        webDriver.verifyElementToBePresent(Generic.getlocator("OptionAvailableList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option));

    }


    public void VerifyChosen(String FieldName,String option) throws DocumentException, InterruptedException {
        //Verify selected and displaying on cosen List
        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("OptionChosenList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option)));
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("OptionChosenList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option)));
        webDriver.verifyElementToBePresent(Generic.getlocator("OptionChosenList").replace("{paramlink1}", FieldName).replace("{paramlink2}", option));
    }

    public void ListViewControl(DataTable dt) throws DocumentException, InterruptedException {

        webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("WithTitle").replace("{paramlink}", "List View Controls")));
        webDriver.WaitforElementtobeclickable(Generic.getlocator("WithTitle").replace("{paramlink}", "List View Controls"));
        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("WithTitle").replace("{paramlink}", "List View Controls")));
        webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("Global_Text").replace("{paramlink}","Select Fields to Display")));
        webDriver.waitforElementtobeclickable(Generic.getlocator("Global_Text").replace("{paramlink}","Select Fields to Display"));
        Thread.sleep(1000);
        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("Global_Text").replace("{paramlink}","Select Fields to Display")));
        Thread.sleep(1000);

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());

                // Click Options from Available Options
                if(webDriver.getwebelementscount(Generic.getlocator("VisibleField").replace("{paramlink}", entry.getValue()))>0) {
                    //Verify selected and displaying on cosen List
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("VisibleField").replace("{paramlink}", entry.getValue())));
                    webDriver.waitForElementLoad(1);
                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("VisibleField").replace("{paramlink}", entry.getValue())));
                    webDriver.verifyElementToBePresent(Generic.getlocator("VisibleField").replace("{paramlink}", entry.getValue()));
                }
                else{
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("AvaialbleField").replace("{paramlink}", entry.getValue())));
                    webDriver.waitForElementLoad(1);
                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("AvaialbleField").replace("{paramlink}", entry.getValue())));
                    webDriver.ClickOnElement(webDriver.passwebelement(Generic.getlocator("AvaialbleField").replace("{paramlink}", entry.getValue())));
                    // Click "Move to Chosen" (right arrow button)
                    webDriver.waitForElementLoad(1);
                    webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("WithoutActiveTitle").replace("{paramlink}", "Move selection to Visible Fields")));
                    webDriver.WaitforElementtobeclickable(Generic.getlocator("WithoutActiveTitle").replace("{paramlink}", "Move selection to Visible Fields"));
                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("WithoutActiveTitle").replace("{paramlink}", "Move selection to Visible Fields")));
                    webDriver.waitForElementLoad(1);
                    //Verify selected and displaying on cosen List
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("VisibleField").replace("{paramlink}", entry.getValue())));
                    webDriver.waitForElementLoad(1);
                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("VisibleField").replace("{paramlink}", entry.getValue())));
                    webDriver.verifyElementToBePresent(Generic.getlocator("VisibleField").replace("{paramlink}", entry.getValue()));

                }

            }
        }

        webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("SelectFieldToDisplaySave")));
        webDriver.WaitforElementtobeclickable(Generic.getlocator("SelectFieldToDisplaySave"));
        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("SelectFieldToDisplaySave")));


    }

    public void ListViewControlDual(String Action, DataTable dt) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                ListViewControlDualWithoutDataTable(Action,entry.getValue());
//                // Click Options from Available Options
//                if(webDriver.getwebelementscount(Generic.getlocator("AvaialbleField").replace("{paramlink}", entry.getValue()))>0) {
//                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("AvaialbleField").replace("{paramlink}", entry.getValue())));
//                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("AvaialbleField").replace("{paramlink}", entry.getValue())));
//                    webDriver.ClickOnElement(webDriver.passwebelement(Generic.getlocator("AvaialbleField").replace("{paramlink}", entry.getValue())));
//                    // Click "Move to Chosen" (right arrow button)
//                    webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("WithoutActiveTitle").replace("{paramlink}", Action)));
//                    webDriver.WaitforElementtobeclickable(Generic.getlocator("WithoutActiveTitle").replace("{paramlink}", Action));
//                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("WithoutActiveTitle").replace("{paramlink}", Action)));
//                    webDriver.waitForElementLoad(1);
//                }
//                //Verify selected and displaying on cosen List
//                webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("VisibleField").replace("{paramlink}", entry.getValue())));
//                webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("VisibleField").replace("{paramlink}", entry.getValue())));
//                webDriver.verifyElementToBePresent(Generic.getlocator("VisibleField").replace("{paramlink}", entry.getValue()));

            }
        }
    }

    public void ListViewControlDualWithoutDataTable(String Action, String Option) throws DocumentException, InterruptedException {
        // Click Options from Available Options
        if(webDriver.getwebelementscount(Generic.getlocator("AvaialbleField").replace("{paramlink}", Option))>0) {
            webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("AvaialbleField").replace("{paramlink}", Option)));
            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("AvaialbleField").replace("{paramlink}", Option)));
            webDriver.ClickOnElement(webDriver.passwebelement(Generic.getlocator("AvaialbleField").replace("{paramlink}", Option)));
            // Click "Move to Chosen" (right arrow button)
            webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("WithoutActiveTitle").replace("{paramlink}", Action)));
            webDriver.WaitforElementtobeclickable(Generic.getlocator("WithoutActiveTitle").replace("{paramlink}", Action));
            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("WithoutActiveTitle").replace("{paramlink}", Action)));
            webDriver.waitForElementLoad(1);
        }
        //Verify selected and displaying on cosen List
        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("VisibleField").replace("{paramlink}", Option)));
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("VisibleField").replace("{paramlink}", Option)));
        webDriver.verifyElementToBePresent(Generic.getlocator("VisibleField").replace("{paramlink}", Option));

    }


    public void ListViewControlDualSelected(String Action, DataTable dt) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                ListViewControlDualSelectedWithoutDataTable(Action,entry.getValue());
//                // Click Options from Available Options
//                if(webDriver.getwebelementscount(Generic.getlocator("VisibleField").replace("{paramlink}", entry.getValue()))>0) {
//                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("VisibleField").replace("{paramlink}", entry.getValue())));
//                    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("VisibleField").replace("{paramlink}", entry.getValue())));
//                    webDriver.ClickOnElement(webDriver.passwebelement(Generic.getlocator("VisibleField").replace("{paramlink}", entry.getValue())));
//                    // Click "Move to Chosen" (right arrow button)
//                    webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("WithoutActiveTitle").replace("{paramlink}", Action)));
//                    webDriver.WaitforElementtobeclickable(Generic.getlocator("WithoutActiveTitle").replace("{paramlink}", Action));
//                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("WithoutActiveTitle").replace("{paramlink}", Action)));
//                    webDriver.waitForElementLoad(1);
//                }
//                //Verify selected and displaying on cosen List
//                webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("AvaialbleField").replace("{paramlink}", entry.getValue())));
//                webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("AvaialbleField").replace("{paramlink}", entry.getValue())));
//                webDriver.verifyElementToBePresent(Generic.getlocator("AvaialbleField").replace("{paramlink}", entry.getValue()));

            }
        }
    }
    public void ListViewControlDualSelectedWithoutDataTable(String Action, String Option) throws DocumentException, InterruptedException {

        // Click Options from Available Options
        if(webDriver.getwebelementscount(Generic.getlocator("VisibleField").replace("{paramlink}", Option))>0) {
            webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("VisibleField").replace("{paramlink}", Option)));
            webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("VisibleField").replace("{paramlink}", Option)));
            webDriver.ClickOnElement(webDriver.passwebelement(Generic.getlocator("VisibleField").replace("{paramlink}", Option)));
            // Click "Move to Chosen" (right arrow button)
            webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("WithoutActiveTitle").replace("{paramlink}", Action)));
            webDriver.WaitforElementtobeclickable(Generic.getlocator("WithoutActiveTitle").replace("{paramlink}", Action));
            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("WithoutActiveTitle").replace("{paramlink}", Action)));
            webDriver.waitForElementLoad(1);
        }
        //Verify selected and displaying on cosen List
        webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("AvaialbleField").replace("{paramlink}", Option)));
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(Generic.getlocator("AvaialbleField").replace("{paramlink}", Option)));
        webDriver.verifyElementToBePresent(Generic.getlocator("AvaialbleField").replace("{paramlink}", Option));

    }




    public void VerifyLabelCheckboxValue(DataTable dt) throws Exception {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                String Key = "";
                String CheckboxValue;
                if(entry.getKey().endsWith("_2"))
                {
                    Key= entry.getKey().replace("_2","");
                    System.out.println(Key);
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("LabelCheckboxValueWithIndex").replace("{paramlink}", Key)));
                    webDriver.waitUntilElementIsVisible(Generic.getlocator("LabelCheckboxValueWithIndex").replace("{paramlink}", Key));
                    CheckboxValue = webDriver.passwebelement(Generic.getlocator("LabelCheckboxValueWithIndex").replace("{paramlink}", Key)).getAttribute("title");
                    System.out.println(CheckboxValue);
                    System.out.println(Generic.getlocator("LabelCheckboxValueWithIndex").replace("{paramlink}", entry.getKey()).replace("_2",""));
                }
                else{
                    webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("LabelCheckboxValue").replace("{paramlink}", entry.getKey())));
                    webDriver.waitUntilElementIsVisible(Generic.getlocator("LabelCheckboxValue").replace("{paramlink}", entry.getKey()));
                    CheckboxValue = webDriver.passwebelement(Generic.getlocator("LabelCheckboxValue").replace("{paramlink}", entry.getKey())).getAttribute("title");
                    System.out.println(CheckboxValue);
                    System.out.println(Generic.getlocator("LabelCheckboxValue").replace("{paramlink}", entry.getKey()));

                }
                boolean isChecked = "true".equalsIgnoreCase(CheckboxValue);
                Assert.assertEquals(isChecked,Boolean.valueOf(entry.getValue().toLowerCase()));
            }
        }
    }

    public void VerifyLabelCheckboxWithParam(String Keys, String Value) throws Exception {
        String Key = "";
        String CheckboxValue;
        if(Keys.endsWith("_2"))
        {
            Key= Keys.replace("_2","");
            System.out.println(Key);
            webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("LabelCheckboxValueWithIndex").replace("{paramlink}", Key)));
            webDriver.waitUntilElementIsVisible(Generic.getlocator("LabelCheckboxValueWithIndex").replace("{paramlink}", Key));
            CheckboxValue = webDriver.passwebelement(Generic.getlocator("LabelCheckboxValueWithIndex").replace("{paramlink}", Key)).getAttribute("title");
            System.out.println(CheckboxValue);
            System.out.println(Generic.getlocator("LabelCheckboxValueWithIndex").replace("{paramlink}", Keys).replace("_2",""));
        }
        else{
            webDriver.ScrollIntoView(webDriver.passwebelement(Generic.getlocator("LabelCheckboxValue").replace("{paramlink}", Keys)));
            webDriver.waitUntilElementIsVisible(Generic.getlocator("LabelCheckboxValue").replace("{paramlink}", Keys));
            CheckboxValue = webDriver.passwebelement(Generic.getlocator("LabelCheckboxValue").replace("{paramlink}", Keys)).getAttribute("title");
            System.out.println(CheckboxValue);
            System.out.println(Generic.getlocator("LabelCheckboxValue").replace("{paramlink}", Keys));
        }
        boolean isChecked = "true".equalsIgnoreCase(CheckboxValue);
        Assert.assertEquals(isChecked,Boolean.valueOf(Value.toLowerCase()));
    }




    public void updateServicesDataWithKeyValue(String key, String Value) throws Exception {


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
                webDriver.SendKeys(element,webDriver.ReturnDate(Value));
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
                        webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("LabelClearIcon").replace("{paramlink}", key)));
                    }
                    if ( Objects.nonNull(Value) && !Value.isEmpty()) {
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

//                else if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && "combobox".equalsIgnoreCase(role)) {
//                    webDriver.ScrollIntoView(element);
//
//                    String ActualText = webDriver.Getattribute(element, "data-value");
//                    if (ActualText.equalsIgnoreCase("")) {
//                        webDriver.SendKeys(element, Value);
//                        if(!key.contains("Time"))
//                        {
//                            webDriver.Clickon(element);
//                            webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
//                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value)));
//                        }
//                    } else if (ActualText.equalsIgnoreCase(Value)) {
//                        System.out.println("Already selected");
//                    }
//                    else {
//
//                        if(key.endsWith("_2"))
//                        {
//                            webDriver.Clickon(webDriver.HandlingMultipleElements(Generic.getlocator("LabelClearIcon").replace("{paramlink}", Keyd),2));
//                            webDriver.SendKeys(element, Value);
//                            webDriver.Clickon(element);
//                            if(webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value))>1) {
//                                webDriver.Clickon(webDriver.HandlingMultipleElements(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value),2));
//                            }
//                            else{
//                                webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
//                                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value)));
//                            }
//                        }
//                        else {
//                            if(webDriver.getwebelementscount(Generic.getlocator("LabelClearIcon").replace("{paramlink}", Value))>0){
//                                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("LabelClearIcon").replace("{paramlink}", Value)));
//                                webDriver.SendKeys(element, Value);
//
//                            }
//                            webDriver.Clickon(element);
////                            webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value));
////                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", Value)));
//                            webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("Div_aria_Label").replace("{paramlink}", key)), webDriver.getwebelement(Generic.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", key).replace("{paramlink2}", Value)));
//                        }
//
//                    }
//                }
        else if (Tag.equalsIgnoreCase("input") && "password".equalsIgnoreCase(type)) {
            webDriver.SendKeys(element, Value);
        }
        else if (Tag.equalsIgnoreCase("input") && "checkbox".equalsIgnoreCase(type)) {

            webDriver.ScrollIntoView(element);
            if(Value.equalsIgnoreCase("True")) {
                boolean isChecked = "true".equalsIgnoreCase(element.getAttribute("checked"));
                if (!isChecked) {
                    try {
                        webDriver.ClickOnElement(element);
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
            //webDriver.waitUntilTheElementIsVisible(element);
            webDriver.ClickOnElement(element);
        }
        else if (Tag.equalsIgnoreCase("select") ) {
            System.out.println("inn");
            webDriver.ScrollIntoView(element);
            //webDriver.waitUntilTheElementIsVisible(element);
            webDriver.selectOptionByText(element,Value);
        }
        else if (Tag.equalsIgnoreCase("button") && "button".equalsIgnoreCase(type)) {
            webDriver.Clickon(element);
            webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("Div_aria_Label").replace("{paramlink}", key)), webDriver.getwebelement(Generic.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", key).replace("{paramlink2}", Value)));
        }
    }
}
