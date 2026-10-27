package pageHelper.Test.FMS;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;
import org.testng.Assert;
import pageHelper.Utility.CommonFunction;
import pageHelper.Utility.Common_Apis;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.DateTimeInWords;
import utils.PropReader;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static utils.MailUtility.maiUtility.getLink;
import static utils.MailUtility.maiUtility.getLinkUrlFromEmail;

@Log4j
public class Fleet_Common {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader Generic;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    Common_Steps cs;
    public Fleet_Common(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("FMS" + File.separator + "Fleet_Common.xml");
        Generic = new xmlreader("Generics" + File.separator + "Common.xml");
        cs = new Common_Steps(DriverInstance);
    }

    @Then("Select the Trip plan next to Load {string}")
    public void selectTheTripPlanNextToLoad(String arg0) throws Exception {
        CommonFunction  cm = new CommonFunction(DriverInstance);
        Common_Steps  cs = new Common_Steps(DriverInstance);
        try {
            cm.updateServicesData1("Load", DriverInstance.getVariable(arg0));
        }
        catch (Exception e)
        {
            webDriver.Refresh();
            webDriver.waitForElementLoad(4);
            cm.updateServicesData1("Page", "Trip Planning");
            webDriver.waitForElementLoad(3);
            cs.scrollIntoSection("View - Fleet Load");
            cs.scrollDownWithTimes("4");
            cm.updateServicesData1("Load", DriverInstance.getVariable(arg0));
        }
        webDriver.waitForElementLoad(2);
        clickOnUnderSection("Refresh","View - Fleet Load");
        webDriver.waitForElementLoad(2);
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("TripPlanWithLoad").replace("{paramlink}", DriverInstance.getVariable(arg0))));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("TripPlanWithLoad").replace("{paramlink}",  DriverInstance.getVariable(arg0))));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("TripPlanWithLoad").replace("{paramlink}",  DriverInstance.getVariable(arg0))));
    }

    @Then("Update {string} Segment details")
    public void updateSegmentDetails1( String legnum, DataTable dt) throws Exception {
        try {
            webDriver.waitForElementLoad(1);
            updateSegmentDetails(legnum, dt);
        }
        catch(Exception e)
        {
            try {
                webDriver.waitForElementLoad(2);
                updateSegmentDetails(legnum, dt);
            }
            catch (Exception e1)
            {
               Assert.fail(legnum+ " : Issue with entering details " + e1.getMessage());
            }
        }
    }
    @Then("Update {string} leg details")
    public void updateLegDetails1( String legnum, DataTable dt) throws Exception {
        updateLegDetails(legnum,dt);
    }

    @Then("Update {string} leg location")
    public void updateLegDetails2( String legnum, DataTable dt) throws Exception {
        webDriver.waitForElementLoad(3);
        updateLegLocationDetails(legnum,dt);
    }

    public void updateSegmentDetails(String SegNumber, DataTable dt) throws Exception {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                webDriver.waitForElementLoad(2);
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                String fieldName;
                if(entry.getKey().endsWith("_2"))
                {
                    String Key= entry.getKey().replace("_2","");
                    System.out.println(Key);
                    fieldName = webDriver.passwebelement(pageObject.getlocator("SegmentTextWithIndex").replace("{paramlink1}",SegNumber).replace("{paramlink}", Key)).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(pageObject.getlocator("SegmentTextWithIndex").replace("{paramlink1}",SegNumber).replace("{paramlink}", entry.getKey()).replace("_2",""));
                }
                else{
                    fieldName = webDriver.passwebelement(pageObject.getlocator("SegmentText").replace("{paramlink1}",SegNumber).replace("{paramlink}", entry.getKey())).getAttribute("for");
                    System.out.println(pageObject.getlocator("SegmentText").replace("{paramlink1}",SegNumber).replace("{paramlink}", entry.getKey()).replace("_2",""));

                }
                WebElement element = webDriver.getwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
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
                        if (entry.getValue().contains("SysData")) {
                            String Value = entry.getValue().split("=>")[1];
                            webDriver.SendKeys(element, DriverInstance.getVariable(Value));
                        } else {
                            webDriver.SendKeys(element,webDriver.ReturnDate(entry.getValue()));
                        }
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
                        if (entry.getValue().contains("SysData")) {
                            String Value = entry.getValue().split("=>")[1];
                            webDriver.SendKeys(element, DriverInstance.getVariable(Value));
                        } else {
                            webDriver.SendKeys(element,webDriver.ReturnDate(entry.getValue()));
                        }
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
                    System.out.println("Act"+ActualText);
                    String trimmedActual = (ActualText == null) ? "" : ActualText.trim();
                    System.out.println("trimmedActual : "+trimmedActual);
                    if(trimmedActual.isEmpty()) {
                        if (entry.getValue().contains("SysData")) {
                            String Value = entry.getValue().split("=>")[1];
                            webDriver.Clickon(element);
                            webDriver.SendKeys(element, DriverInstance.getVariable(Value));
                            webDriver.Clickon(element);
                            webDriver.waitForElementLoad(1);
                            int i=webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", DriverInstance.getVariable(Value)));
                            if(i==1) {
                                webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", DriverInstance.getVariable(Value)));
                                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", DriverInstance.getVariable(Value))));
                            }
                            else{
                                webDriver.waitforElementtobeclickable(pageObject.getlocator("ButtonIconTitle").replace("{paramlink}", DriverInstance.getVariable(Value)).replace("{index}",SegNumber));
                                webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("ButtonIconTitle").replace("{paramlink}", DriverInstance.getVariable(Value)).replace("{index}",SegNumber)));
                            }
                            }
                        else {
                        webDriver.Clickon(element);
                        webDriver.SendKeys(element, entry.getValue());
                        if(!entry.getKey().contains("Time"))
                        {
                            webDriver.Clickon(element);
                            webDriver.waitForElementLoad(1);
                            int i=webDriver.getwebelementscount(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                            if(i==1) {
                                webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue())));
                            }
                            else{
                                webDriver.waitforElementtobeclickable(pageObject.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()).replace("{index}",SegNumber));
                                webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()).replace("{index}",SegNumber)));
                            }
                        }
                    }}
                    else if(trimmedActual.equalsIgnoreCase(entry.getValue())) {
                        System.out.println("trimmedActual2 : "+trimmedActual);
                        System.out.println("Already selected");
                    }
                    else {
                          System.out.println("trimmedActual3 : "+trimmedActual);
                         if (entry.getValue().contains("SysData")) {
                            String Value = entry.getValue().split("=>")[1];
                             webDriver.Clickon(element);
                             webDriver.SendKeys(element, DriverInstance.getVariable(Value));
                             webDriver.Clickon(element);
                         }
                         else {
                             webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("LabelClearIcon").replace("{paramlink}", entry.getKey().replace("_2",""))));
                             webDriver.SendKeys(element, entry.getValue());
                             webDriver.Clickon(element);
                             webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                             webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue())));
                         }
                    }
                    if(!entry.getValue().contains("SysData")) {
                        webDriver.waitForElementLoad(2);
                        ActualText = webDriver.waitForAttributeValue(element, "data-value", 40);
                        System.out.println("Selected Data : "+ActualText);
                        if (!ActualText.contains(entry.getValue())) {
                            if (ActualText.equalsIgnoreCase("")) {
                                webDriver.Clickon(element);
                                webDriver.SendKeys(element, entry.getValue());
                                if (!entry.getKey().contains("Time")) {
                                    webDriver.Clickon(element);
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue())));
                                }
                            } else if (ActualText.equalsIgnoreCase(entry.getValue())) {
                                System.out.println("Already selected");
                            } else {
                                if (entry.getValue().contains("SysData")) {
                                    String Value = entry.getValue().split("=>")[1];
                                    // Value=DriverInstance.getLoadNum();
                                    webDriver.Clickon(element);
                                    webDriver.SendKeys(element, DriverInstance.getVariable(Value));
                                    webDriver.Clickon(element);
                                    //webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}",  DriverInstance.getVariable(Value)));
                                    //webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}",  DriverInstance.getVariable(Value))));
                                } else {
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("LabelClearIcon").replace("{paramlink}", entry.getKey())));
                                    webDriver.SendKeys(element, entry.getValue());
                                    webDriver.Clickon(element);
                                    webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                                    webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue())));
                                }
                            }
                        }
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
                    System.out.println("man12345");
                    WebElement element1 = webDriver.passwebelement(Generic.getlocator("FormFieldsSpan").replace("{paramlink}", fieldName));
                    System.out.println(element1);
                    webDriver.ScrollIntoView(element1);
                    webDriver.waitUntilTheElementIsVisible(element1);
                    webDriver.safeJavaScriptClick(element1);
                    webDriver.waitForElementLoad(1);
                    webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("Segment_Option_Span_Text").replace("{index}",SegNumber).replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                }
            }
        }
    }

    public void updateLegDetails(String LegNumber, DataTable dt) throws Exception {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                webDriver.waitForElementLoad(2);
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                String fieldName;
                if(entry.getKey().contains("Location")) {
                    if(entry.getKey().endsWith("_2"))
                    {
                        String Key= entry.getKey().replace("_2","");
                        System.out.println(Key);
                        fieldName = webDriver.passwebelement(pageObject.getlocator("Location2").replace("{paramlink1}",LegNumber)).getAttribute("for");
                        System.out.println(fieldName);
                        System.out.println(pageObject.getlocator("Location2").replace("{paramlink1}",LegNumber));
                    }
                    else{
                        fieldName = webDriver.passwebelement(pageObject.getlocator("Location").replace("{paramlink1}",LegNumber)).getAttribute("for");
                        System.out.println(pageObject.getlocator("Location").replace("{paramlink1}",LegNumber));

                    }
                }
                else{
                    if (entry.getKey().endsWith("_2")) {
                        String Key = entry.getKey().replace("_2", "");
                        System.out.println(Key);
                        fieldName = webDriver.passwebelement(pageObject.getlocator("LabelTextWithIndex").replace("{paramlink1}", LegNumber).replace("{paramlink}", Key)).getAttribute("for");
                        System.out.println(fieldName);
                        System.out.println(pageObject.getlocator("LabelTextWithIndex").replace("{paramlink1}", LegNumber).replace("{paramlink}", entry.getKey()).replace("_2", ""));
                    } else {
                        fieldName = webDriver.passwebelement(pageObject.getlocator("LabelText").replace("{paramlink1}", LegNumber).replace("{paramlink}", entry.getKey())).getAttribute("for");
                        System.out.println(pageObject.getlocator("LabelText").replace("{paramlink1}", LegNumber).replace("{paramlink}", entry.getKey()).replace("_2", ""));

                    }
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
                            if (entry.getValue().contains("SysData")) {
                                webDriver.SendKeys(element, DriverInstance.getVariable(entry.getValue().split("=>")[1]));
                            } else {
                                webDriver.SendKeys(element, webDriver.ReturnDate(entry.getValue()));
                            }
                        }else if (entry.getValue().contains("SysData")) {
                            String Value = entry.getValue().split("=>")[1];
                            webDriver.SendKeys(element, DriverInstance.getVariable(Value));
                        } else if (entry.getValue().contains("NA")) {
                            webDriver.Clickon(element);
                        } else {
                            webDriver.SendKeys(element, entry.getValue());
                        }
                    }
                    else{
                        webDriver.EnterTimeUsingJS(element, "");

                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "search".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {
                    webDriver.ScrollIntoView(element);
                    if (entry.getValue().equalsIgnoreCase("Company Email")) {
                        webDriver.SendKeys(element, propertyReader.readproperty("Company_Email"));
                    }
                    else if (entry.getKey().contains("Date")) {
                        if (entry.getValue().contains("SysData")) {
                            String Value = entry.getValue().split("=>")[1];
                            webDriver.SendKeys(element, DriverInstance.getVariable(Value));
                        } else {
                            webDriver.SendKeys(element,webDriver.ReturnDate(entry.getValue()));
                        }
                    }
                    else {
                        int count = webDriver.getwebelementscount(pageObject.getlocator("LabelClaer").replace("{paramlink}", fieldName));
                        if(count>0)
                        {
                            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("LabelClaer").replace("{paramlink}", fieldName)));
                            webDriver.waitforElementtobeclickable(pageObject.getlocator("LabelClaer").replace("{paramlink}", fieldName));
                            webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("LabelClaer").replace("{paramlink}", fieldName)));
                        }
                        webDriver.waitForElementLoad(1);
                        webDriver.waitUntilTheElementIsVisible(element);
                        webDriver.SendKeys(element, entry.getValue());
                        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("SelectSearchResult").replace("{paramlink}", entry.getValue())));
                        webDriver.waitforElementtobeclickable(pageObject.getlocator("SelectSearchResult").replace("{paramlink}", entry.getValue()));
                        webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("SelectSearchResult").replace("{paramlink}", entry.getValue())));
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
                    if (entry.getKey().contains("Time")){
                        if (Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                            webDriver.waitUntilTheElementIsVisible(element);
                            String timeValue = entry.getValue();
                            if (timeValue.contains("SysData")) {
                                timeValue = DriverInstance.getVariable(timeValue.split("=>")[1]);
                            }
                            System.out.println("Time value after SysData resolution: " + timeValue);

                            webDriver.EnterTimeUsingJS(element, timeValue);
                        }
                        else{
                            webDriver.EnterTimeUsingJS(element, "");
                        }
//                        webDriver.EnterTimeUsingJS(element, entry.getValue());
                    }
                    else{
                        String ActualText = webDriver.Getattribute(element, "data-value");
                        if (ActualText.equalsIgnoreCase("")) {
                                webDriver.SendKeys(element, entry.getValue());
                                webDriver.Clickon(element);
                                webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                                webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue())));
                                webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue())));

                        }
                        else if (ActualText.equalsIgnoreCase(entry.getValue())) {
                            System.out.println("Already selected");
                        }
                        else if (ActualText.equalsIgnoreCase("--None--")) {
                            webDriver.Clickon(element);
                            webDriver.waitForElementLoad(1);
                            webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("Div_aria_Label").replace("{paramlink}", entry.getKey())), webDriver.getwebelement(Generic.getlocator("Div_aria_Label_Span_Text").replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                        }
                        else {
                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("LabelClearIcon").replace("{paramlink}", entry.getKey())));
                            webDriver.SendKeys(element, entry.getValue());
                            webDriver.Clickon(element);
                            webDriver.waitforElementtobeclickable(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue()));
                            webDriver.ClickOnElement(webDriver.getwebelement(Generic.getlocator("ButtonIconTitle").replace("{paramlink}", entry.getValue())));

                        }
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "password".equalsIgnoreCase(type)) {
                    webDriver.SendKeys(element, entry.getValue());
                }
                else if (Tag.equalsIgnoreCase("input") && "checkbox".equalsIgnoreCase(type)) {

                    webDriver.ScrollIntoView(element);
                    if(entry.getValue().equalsIgnoreCase("true")) {
                        boolean isChecked = element.isSelected();
                        if (!isChecked) {
                            try {
                                webDriver.safeJavaScriptClick(element);
                            } catch (Exception e) {
                                webDriver.safeJavaScriptClick(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
                            }
                        }
                    }
                    else {
                        boolean isChecked = element.isSelected();
                        System.out.println("Checked :"+isChecked);
                        if (isChecked) {
                            try {
                                webDriver.safeJavaScriptClick(element);
                            } catch (Exception e) {
                                webDriver.Clickon(element);
//                                //webDriver.safeJavaScriptClick(webDriver.passwebelement(Generic.getlocator("LabelText").replace("{paramlink}", entry.getKey())));
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
                else if (Tag.equalsIgnoreCase("select")) {
                    System.out.println("inn");
                    webDriver.ScrollIntoView(element);
                    webDriver.waitUntilTheElementIsVisible(element);
                    webDriver.selectOptionByText(element, entry.getValue());

                }
                else if (Tag.equalsIgnoreCase("button") && "button".equalsIgnoreCase(type)) {
                    webDriver.Clickon(element);
                    webDriver.waitForElementLoad(1);
                    if(entry.getKey().contains("Location"))
                    {
                       webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("Div_aria_Span_Text").replace("{paramlink3}",LegNumber).replace("{paramlink2}", entry.getValue())));
                    }
                    else{
                        if(entry.getKey().contains("_2"))
                        {
                            if(webDriver.getwebelementscount(pageObject.getlocator("Div_aria_Label_Span_Text").replace("{paramlink3}", LegNumber).replace("{paramlink1}", entry.getKey().replace("_2","")).replace("{paramlink2}", entry.getValue()))>1)
                            {
                                webDriver.SelectComboBoxOption(webDriver.getwebelement(pageObject.getlocator("Div_aria_Label").replace("{paramlink3}", LegNumber).replace("{paramlink}", entry.getKey().replace("_2",""))), webDriver.getwebelement(pageObject.getlocator("Div_aria_Label_Span_Text2").replace("{paramlink3}", LegNumber).replace("{paramlink1}", entry.getKey().replace("_2","")).replace("{paramlink2}", entry.getValue())));

                            }
                            else{
                            webDriver.SelectComboBoxOption(webDriver.getwebelement(pageObject.getlocator("Div_aria_Label").replace("{paramlink3}", LegNumber).replace("{paramlink}", entry.getKey().replace("_2",""))), webDriver.getwebelement(pageObject.getlocator("Div_aria_Label_Span_Text").replace("{paramlink3}", LegNumber).replace("{paramlink1}", entry.getKey().replace("_2","")).replace("{paramlink2}", entry.getValue())));
                           }
                        }
                        else {
                            webDriver.SelectComboBoxOption(webDriver.getwebelement(pageObject.getlocator("Div_aria_Label").replace("{paramlink3}", LegNumber).replace("{paramlink}", entry.getKey())), webDriver.getwebelement(pageObject.getlocator("Div_aria_Label_Span_Text").replace("{paramlink3}", LegNumber).replace("{paramlink1}", entry.getKey()).replace("{paramlink2}", entry.getValue())));
                        }
                    }}


            }
        }
    }

    public void updateLegLocationDetails(String LegNumber, DataTable dt) throws Exception {

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
                    fieldName = webDriver.passwebelement(pageObject.getlocator("Location2").replace("{paramlink1}",LegNumber)).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(pageObject.getlocator("Location2").replace("{paramlink1}",LegNumber));
                }
                else{
                    fieldName = webDriver.passwebelement(pageObject.getlocator("Location").replace("{paramlink1}",LegNumber)).getAttribute("for");
                    System.out.println(pageObject.getlocator("Location").replace("{paramlink1}",LegNumber));

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
                        webDriver.waitUntilTheElementIsVisible(element);
                        webDriver.SendKeys(element, entry.getValue());
                        webDriver.waitforElementtobeclickable(pageObject.getlocator("SelectSearchResult").replace("{paramlink}", entry.getValue()));
                        webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("SelectSearchResult").replace("{paramlink}", entry.getValue())));
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

    @Then("Select the Trip plan next to {string}")
    public void selectTheTripPlanNextTo(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("TripPlanWithLoad").replace("{paramlink}", arg0)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("TripPlanWithLoad").replace("{paramlink}",  arg0)));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("TripPlanWithLoad").replace("{paramlink}", arg0)));

    }

    @Then("Verify {string} Segment Driver Confirmation Status as {string}")
    public void verifySegmentDriverConfirmationStatusAs(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("Driver_ConfirmationStatus").replace("{paramlink1}", arg0).replace("{paramlink2}",  arg1)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("Driver_ConfirmationStatus").replace("{paramlink1}",  arg0).replace("{paramlink2}",  arg1)));
        webDriver.verifyElementToBePresent(pageObject.getlocator("Driver_ConfirmationStatus").replace("{paramlink1}",  arg0).replace("{paramlink2}",  arg1));
    }

    @Then("Verify {string} Segment Status as {string}")
    public void verifySegmentStatusAs(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("SegmentStatus").replace("{paramlink1}", arg0).replace("{paramlink2}",  arg1)));
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("SegmentStatus").replace("{paramlink1}",  arg0).replace("{paramlink2}",  arg1)));
        webDriver.verifyElementToBePresent(pageObject.getlocator("SegmentStatus").replace("{paramlink1}",  arg0).replace("{paramlink2}",  arg1));
    }

    @Then("Get Trip Plan ID and store as {string}")
    public void getTripPlanIDAndStoreAs(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("TripPlanID")));
        String tripPlan= webDriver.GetText(webDriver.getwebelement(pageObject.getlocator("TripPlanID")));
        if(tripPlan.contains("New Trip Plan"))
        {
            webDriver.waitForElementLoad(10);
            tripPlan= webDriver.GetText(webDriver.getwebelement(pageObject.getlocator("TripPlanID")));
        }
        DriverInstance.setVariable(arg0,tripPlan.split(" - ")[1].trim());
    }

    @Then("Get {string} link from Email for Driver Trip Confirmation")
    public void getLinkFromEmailForDriverTripConfirmation(String arg0) throws Exception {
        String Subject = "Driver Trip Confirmation - "+DriverInstance.getVariable("Trip_Plan_ID");
        try {
            String Link = getLink(Subject, arg0);
            DriverInstance.setVariable("Link", Link);
        }
        catch (Exception e)
        {
            try {
                Common_Apis ca = new Common_Apis(DriverInstance);
                ca.verifyEmailMessageAfterTestStart(Subject.replace("Sandbox:","").trim(),"GetMessage");
                String Link = getLinkUrlFromEmail(DriverInstance.getVariable("GetMessage"), arg0);
                DriverInstance.setVariable("Link", Link);
            }
            catch (Exception e1)
            {
                Assert.fail("Mail not found for Subject "+ Subject);
            }
        }
    }

    @Then("Move to Element {string}")
    public void moveToElement(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitForElementLoad(5);
        webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("InputPlaceHolder").replace("{paramlink}",arg0)));
        webDriver.move_to_element(webDriver.getwebelement(pageObject.getlocator("InputPlaceHolder").replace("{paramlink}",arg0)));
    }

    @Then("Click on button {string} on Trip Plan")
    public void clickOnButtonOnTripPlan(String arg0) throws DocumentException, InterruptedException {
        if(webDriver.getwebelementscount(pageObject.getlocator("ButtonTitle").replace("{paramlink}", arg0))>0)
        {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("ButtonTitle").replace("{paramlink}", arg0)));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("ButtonTitle").replace("{paramlink}", arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("ButtonTitle").replace("{paramlink}", arg0)));
       }
    }

    @Then("Click on button {string} on Trip Event")
    public void clickOnButtonOnTripEvent(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("Trip_Event_Action").replace("{paramlink}", arg0)));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("Trip_Event_Action").replace("{paramlink}", arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("Trip_Event_Action").replace("{paramlink}", arg0)));

    }

    @Then("Verify Trip Plan Segment Records With Trip Plan {string} and ELD Trip Id as {string}")
    public void verifyTripPlanSegmentRecordsWithTripPlanAndELDTripIdAs(String arg0, String arg1) throws Exception {

        webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("WithTitle").replace("{paramlink}", "Created Date")));
        webDriver.WaitforElementtobeclickable(Generic.getlocator("WithTitle").replace("{paramlink}", "Created Date"));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(Generic.getlocator("WithTitle").replace("{paramlink}", "Created Date")));
        webDriver.waitForElementLoad(1);
        if(arg1.contains("SysData"))
        {
            arg1=DriverInstance.getVariable(arg1.split(">")[1]);
        }
        if(webDriver.getwebelementscount(pageObject.getlocator("VerifyEldIDwithTripPlan").replace("{paramlink1}", DriverInstance.getVariable(arg0)).replace("{paramlink2}", arg1))>0) {
         System.out.println("Element is visible");
        }
        else{
            webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("WithTitle").replace("{paramlink}", "Created Date")));
            webDriver.WaitforElementtobeclickable(Generic.getlocator("WithTitle").replace("{paramlink}", "Created Date"));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(Generic.getlocator("WithTitle").replace("{paramlink}", "Created Date")));
            webDriver.waitForElementLoad(1);
        }
          if (arg1.contains("SysData")) {
              System.out.println(pageObject.getlocator("VerifyEldIDwithTripPlan").replace("{paramlink1}", DriverInstance.getVariable(arg0)).replace("{paramlink2}", DriverInstance.getVariable(arg1.split(">")[1])));
              webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyEldIDwithTripPlan").replace("{paramlink1}", DriverInstance.getVariable(arg0)).replace("{paramlink2}", DriverInstance.getVariable(arg1.split(">")[1])));
          } else {
              webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyEldIDwithTripPlan").replace("{paramlink1}", DriverInstance.getVariable(arg0)).replace("{paramlink2}", arg1));
          }

    }

    @Then("Store {string} for Records having {string} as {string}")
    public void storeForRecordsHavingAs(String arg0, String arg1, String arg2) throws Exception {
        if (arg2.contains("SysData"))
        {
            arg2=DriverInstance.getVariable(arg2.split("=>")[1].trim());
        }
        int maxRetries = 10;
        String text = "";
        int retry = 0;

            while (retry < maxRetries) {
                webDriver.waitForElementLoad(1);
                String Locator = pageObject.getlocator("GetTripPlanSegmentsField")
                        .replace("{paramlink1}", arg1)
                        .replace("{paramlink2}", arg2)
                        .replace("{paramlink3}", arg0);
                WebElement element = webDriver.getwebelement(Locator);

                if(webDriver.getwebelementscount(Locator)>0) {
                    webDriver.ScrollIntoView(element);
                    webDriver.waitUntilTheElementIsVisible(element);
                    text = webDriver.GetText(element);
                }
                else{
                    webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("WithTitle").replace("{paramlink}", "Created Date")));
                    webDriver.WaitforElementtobeclickable(Generic.getlocator("WithTitle").replace("{paramlink}", "Created Date"));
                    webDriver.safeJavaScriptClick(webDriver.getwebelement(Generic.getlocator("WithTitle").replace("{paramlink}", "Created Date")));
                    webDriver.waitForElementLoad(1);
                    if(webDriver.getwebelementscount(Locator)>0) {
                        webDriver.ScrollIntoView(element);
                        webDriver.waitUntilTheElementIsVisible(element);
                        text = webDriver.GetText(element);
                    }
                    else {
                        webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("WithTitle").replace("{paramlink}", "Created Date")));
                        webDriver.WaitforElementtobeclickable(Generic.getlocator("WithTitle").replace("{paramlink}", "Created Date"));
                        webDriver.safeJavaScriptClick(webDriver.getwebelement(Generic.getlocator("WithTitle").replace("{paramlink}", "Created Date")));
                        webDriver.waitForElementLoad(1);
                        webDriver.ScrollIntoView(element);
                        webDriver.waitUntilTheElementIsVisible(element);
                        text = webDriver.GetText(element);
                    }

                }
                if (text != null && !text.trim().isEmpty()) {
                    // Value found → store and break
                    DriverInstance.setVariable(arg0, text);
                    break;
                }
                // If still blank → refresh and retry
                webDriver.waitForElementLoad(1);
                Common_Steps cm = new Common_Steps(DriverInstance);
                cm.clickOnButton("refreshButton");
                webDriver.waitForElementLoad(2);
                retry++;
            }


        if (text == null || text.trim().isEmpty()) {
            throw new RuntimeException("Text not loaded even after 10 refresh retries for param: " + arg0);
        }
    }

    @Then("Store {string} for Records having {string} as {string} and {string} as {string} onto {string}")
    public void storeForRecordsHavingAsWithDoubleVariable(String arg0, String arg1, String arg2, String arg3, String arg4, String arg5) throws Exception {
        if (arg2.contains("SysData"))
        {
            arg2=DriverInstance.getVariable(arg2.split("=>")[1].trim());
        }
        int maxRetries = 10;
        String text = "";
        int retry = 0;

        while (retry < maxRetries) {
            webDriver.waitForElementLoad(1);
            String Locator = pageObject.getlocator("GetTripPlanSegmentsFieldDouble")
                    .replace("{paramlink1}", arg1)
                    .replace("{paramlink2}", arg2)
                    .replace("{paramlink3}", arg3)
                    .replace("{paramlink4}", arg4)
                    .replace("{paramlink5}", arg0);
            WebElement element = webDriver.getwebelement(Locator);

            if(webDriver.getwebelementscount(Locator)>0) {
                webDriver.ScrollIntoView(element);
                webDriver.waitUntilTheElementIsVisible(element);
                text = webDriver.GetText(element);
            }
            else{
                webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("WithTitle").replace("{paramlink}", "Created Date")));
                webDriver.WaitforElementtobeclickable(Generic.getlocator("WithTitle").replace("{paramlink}", "Created Date"));
                webDriver.safeJavaScriptClick(webDriver.getwebelement(Generic.getlocator("WithTitle").replace("{paramlink}", "Created Date")));
                webDriver.waitForElementLoad(1);
                if(webDriver.getwebelementscount(Locator)>0) {
                    webDriver.ScrollIntoView(element);
                    webDriver.waitUntilTheElementIsVisible(element);
                    text = webDriver.GetText(element);
                }
                else {
                    webDriver.ScrollIntoView(webDriver.getwebelement(Generic.getlocator("WithTitle").replace("{paramlink}", "Created Date")));
                    webDriver.WaitforElementtobeclickable(Generic.getlocator("WithTitle").replace("{paramlink}", "Created Date"));
                    webDriver.safeJavaScriptClick(webDriver.getwebelement(Generic.getlocator("WithTitle").replace("{paramlink}", "Created Date")));
                    webDriver.waitForElementLoad(1);
                    webDriver.ScrollIntoView(element);
                    webDriver.waitUntilTheElementIsVisible(element);
                    text = webDriver.GetText(element);
                }

            }
            if (text != null && !text.trim().isEmpty()) {
                // Value found → store and break
                DriverInstance.setVariable(arg5, text);
                break;
            }
            // If still blank → refresh and retry
            webDriver.waitForElementLoad(1);
            Common_Steps cm = new Common_Steps(DriverInstance);
            cm.clickOnButton("refreshButton");
            webDriver.waitForElementLoad(2);
            retry++;
        }


        if (text == null || text.trim().isEmpty()) {
            throw new RuntimeException("Text not loaded even after 10 refresh retries for param: " + arg0);
        }
    }


    @Then("Click on {string} on {string} Leg")
    public void clickOnOnLeg(String arg0, String arg1) throws Exception {
        webDriver.waitForElementLoad(1);
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("LegButton").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0));
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("LegButton").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("LegButton").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
        webDriver.waitForElementLoad(2);
    }

    @Then("Click on icon {string} on {string} Leg")
    public void clickOnOnleg(String arg0, String arg1) throws Exception {
        webDriver.waitForElementLoad(1);
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("LegIcon").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("LegIcon").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("LegIcon").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
        webDriver.waitForElementLoad(2);
    }

    @Then("Verify {string} option is displaying on {string} Leg")
    public void IconDisplayingOnLeg(String arg0, String arg1) throws Exception {
        webDriver.waitForElementLoad(1);
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("LegButton").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("LegButton").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0));
        webDriver.verifyElementToBePresent(pageObject.getlocator("LegButton").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0));
        webDriver.waitForElementLoad(2);
    }

    @Then("Verify {string} option not displaying on {string} Leg")
    public void IconNotDisplayingOnLeg(String arg0, String arg1) throws Exception {
        webDriver.waitForElementLoad(1);
        webDriver.verifyElementNotToBePresent(pageObject.getlocator("LegButton").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0));
        webDriver.waitForElementLoad(1);
    }


    @Then("Click on {string} under {string} Section")
    public void clickOnUnderSection(String arg0, String arg1) throws Exception {

      if(arg0.contains("SysData"))
      {
          webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("ButtonUnderView").replace("{paramlink1}", arg1).replace("{paramlink2}", DriverInstance.getVariable(arg0.split(">")[1].trim()))));
          webDriver.WaitforElementtobeclickable(pageObject.getlocator("ButtonUnderView").replace("{paramlink1}", arg1).replace("{paramlink2}", DriverInstance.getVariable(arg0.split(">")[1].trim())));
          webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("ButtonUnderView").replace("{paramlink1}", arg1).replace("{paramlink2}", DriverInstance.getVariable(arg0.split(">")[1].trim()))));
      }
      else {
          webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("ButtonUnderView").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
          webDriver.WaitforElementtobeclickable(pageObject.getlocator("ButtonUnderView").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0));
          webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("ButtonUnderView").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
      }

    }
    @Then("Click on {string} Text under {string} Section")
    public void clickOnTextUnderSection(String arg0, String arg1) throws Exception {

        if(arg0.contains("SysData"))
        {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("ButtonUnderViewWithText").replace("{paramlink1}", arg1).replace("{paramlink2}", DriverInstance.getVariable(arg0.split(">")[1].trim()))));
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("ButtonUnderViewWithText").replace("{paramlink1}", arg1).replace("{paramlink2}", DriverInstance.getVariable(arg0.split(">")[1].trim())));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("ButtonUnderViewWithText").replace("{paramlink1}", arg1).replace("{paramlink2}", DriverInstance.getVariable(arg0.split(">")[1].trim()))));
        }
        else {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("ButtonUnderViewWithText").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("ButtonUnderViewWithText").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("ButtonUnderViewWithText").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
        }

    }
    @Then("Click on {string} Text under {string}")
    public void clickOnText1UnderSection(String arg0, String arg1) throws Exception {

        if(arg0.contains("SysData"))
        {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("UnderViewWithText").replace("{paramlink1}", arg1).replace("{paramlink2}", DriverInstance.getVariable(arg0.split(">")[1].trim()))));
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("UnderViewWithText").replace("{paramlink1}", arg1).replace("{paramlink2}", DriverInstance.getVariable(arg0.split(">")[1].trim())));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("UnderViewWithText").replace("{paramlink1}", arg1).replace("{paramlink2}", DriverInstance.getVariable(arg0.split(">")[1].trim()))));
        }
        else {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("UnderViewWithText").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("UnderViewWithText").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("UnderViewWithText").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
        }

    }
    @Then("Verify {string} Text under {string}")
    public void VerifyText1UnderSection(String arg0, String arg1) throws Exception {

        if(arg0.contains("SysData"))
        {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("UnderViewWithText").replace("{paramlink1}", arg1).replace("{paramlink2}", DriverInstance.getVariable(arg0.split(">")[1].trim()))));
            webDriver.waitUntilElementIsVisible(pageObject.getlocator("UnderViewWithText").replace("{paramlink1}", arg1).replace("{paramlink2}", DriverInstance.getVariable(arg0.split(">")[1].trim())));
            webDriver.verifyElementToBePresent(pageObject.getlocator("UnderViewWithText").replace("{paramlink1}", arg1).replace("{paramlink2}", DriverInstance.getVariable(arg0.split(">")[1].trim())));
        }
        else {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("UnderViewWithText").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
            webDriver.waitUntilElementIsVisible(pageObject.getlocator("UnderViewWithText").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0));
            webDriver.verifyElementToBePresent(pageObject.getlocator("UnderViewWithText").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0));
        }

    }
    @Then("Verify {string} Text not displaying under {string}")
    public void VerifyText1notdisplayingUnderSection(String arg0, String arg1) throws Exception {

        if(arg0.contains("SysData"))
        {
            webDriver.verifyElementNotToBePresent(pageObject.getlocator("UnderViewWithText").replace("{paramlink1}", arg1).replace("{paramlink2}", DriverInstance.getVariable(arg0.split(">")[1].trim())));
        }
        else {
            webDriver.verifyElementNotToBePresent(pageObject.getlocator("UnderViewWithText").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0));
        }

    }
    @Then("Click on Address {string} under {string} Section")
    public void clickOnAddressSearch(String arg0, String arg1) throws Exception {

        if(arg0.contains("SysData"))
        {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("AddressSearch").replace("{paramlink1}", arg1).replace("{paramlink2}", DriverInstance.getVariable(arg0.split(">")[1].trim()))));
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("AddressSearch").replace("{paramlink1}", arg1).replace("{paramlink2}", DriverInstance.getVariable(arg0.split(">")[1].trim())));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("AddressSearch").replace("{paramlink1}", arg1).replace("{paramlink2}", DriverInstance.getVariable(arg0.split(">")[1].trim()))));
        }
        else {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("AddressSearch").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("AddressSearch").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0));
            webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("AddressSearch").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
        }

    }
    @Then("Verify title {string} under {string} Section")
    public void verifyOnUnderSection(String arg0, String arg1) throws Exception {

        if(arg0.contains("SysData"))
        {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("ButtonUnderView").replace("{paramlink1}", arg1).replace("{paramlink2}", DriverInstance.getVariable(arg0.split(">")[1].trim()))));
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("ButtonUnderView").replace("{paramlink1}", arg1).replace("{paramlink2}", DriverInstance.getVariable(arg0.split(">")[1].trim())));
            webDriver.verifyElementToBePresent(pageObject.getlocator("ButtonUnderView").replace("{paramlink1}", arg1).replace("{paramlink2}", DriverInstance.getVariable(arg0.split(">")[1].trim())));
        }
        else {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("ButtonUnderView").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("ButtonUnderView").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0));
            webDriver.verifyElementToBePresent(pageObject.getlocator("ButtonUnderView").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0));
        }

    }
    @Then("Verify title {string} is disabled under {string} Section")
    public void verifyDisabledOnUnderSection(String arg0, String arg1) throws Exception {

        if(arg0.contains("SysData"))
        {
            webDriver.verifyElementToBePresent(pageObject.getlocator("ButtonUnderViewDisabled").replace("{paramlink1}", arg1).replace("{paramlink2}", DriverInstance.getVariable(arg0.split(">")[1].trim())));
        }
        else {
            webDriver.verifyElementToBePresent(pageObject.getlocator("ButtonUnderViewDisabled").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0));
        }

    }
    @Then("Verify All Filter are not displaying for {string}")
    public void verifyAllFilterAreNotDisplayingFor(String arg0) throws Exception  {
        webDriver.verifyElementNotToBePresent(pageObject.getlocator("VerifyFilter").replace("{paramlink}",arg0));

    }
    @Then("Verify All Filter are displaying for {string}")
    public void verifyAllFilterAreDisplayingFor(String arg0) throws Exception  {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("VerifyFilter").replace("{paramlink}",arg0));
        webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyFilter").replace("{paramlink}",arg0));

    }
    @Then("Verify data grid not displaying for {string}")
    public void verifyDataGridAreNotDisplayingFor(String arg0) throws Exception  {
        webDriver.verifyElementNotToBePresent(pageObject.getlocator("VerifyDataTable").replace("{paramlink}",arg0));

    }
    @Then("Verify data grid displaying for {string}")
    public void verifyDataGridAreDisplayingFor(String arg0) throws Exception  {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("VerifyDataTable").replace("{paramlink}",arg0));
        webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyDataTable").replace("{paramlink}",arg0));

    }
    @Then("Set {string} Time with {string} min before")
    public void setTimeWithMinBefore(String arg0, String arg1) throws DocumentException, InterruptedException {
        if (Objects.nonNull(arg1) && !arg1.isEmpty()) {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("FieldWithNameCombobox").replace("{paramlink1}", arg0)));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("FieldWithNameCombobox").replace("{paramlink1}", arg0)));
            webDriver.EnterTimeUsingJS(webDriver.getwebelement(pageObject.getlocator("FieldWithNameCombobox").replace("{paramlink1}", arg0)), webDriver.getRoundedTimeBeforeNow(Long.parseLong(arg1)));
            DriverInstance.setVariable("ELD_Last_Update",DriverInstance.getVariable("ELD_Last_Update_Date")+" "+webDriver.getRoundedTimeBeforeNow(Long.parseLong(arg1)));
        }
        else{
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("FieldWithNameCombobox").replace("{paramlink1}", arg0)));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("FieldWithNameCombobox").replace("{paramlink1}", arg0)));
            webDriver.EnterTimeUsingJS(webDriver.getwebelement(pageObject.getlocator("FieldWithNameCombobox").replace("{paramlink1}", arg0)), "");
        }
    }
  //12/26/2025 5:46 AM
    @Then("Set {string} Date with {string} days")
    public void setDateWithDays(String arg0, String arg1) throws DocumentException, InterruptedException, IOException {
        if (Objects.nonNull(arg1) && !arg1.isEmpty()) {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("FieldWithNameCombobox").replace("and @role", "").replace("{paramlink1}", arg0)));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("FieldWithNameCombobox").replace("and @role", "").replace("{paramlink1}", arg0)));
            webDriver.SendKeys(webDriver.getwebelement(pageObject.getlocator("FieldWithNameCombobox").replace("and @role", "").replace("{paramlink1}", arg0)), webDriver.ReturnDate(arg1));
            DriverInstance.setVariable("ELD_Last_Update_Date",webDriver.ReturnDate(arg1));
        }
        else{
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("FieldWithNameCombobox").replace("and @role", "").replace("{paramlink1}", arg0)));
            webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(pageObject.getlocator("FieldWithNameCombobox").replace("and @role", "").replace("{paramlink1}", arg0)));
            webDriver.SendKeys(webDriver.getwebelement(pageObject.getlocator("FieldWithNameCombobox").replace("and @role", "").replace("{paramlink1}", arg0)), "");
        }
    }

    @Then("Verify {string} Segment details")
    public void verifySegmentDetails(String SegNumber, DataTable dt) throws DocumentException, InterruptedException {
        validateSegmentData(SegNumber,dt);
    }
    public void validateSegmentData(String SegNumber, DataTable dt) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {

                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                webDriver.waitForElementLoad(2);
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                String fieldName;
                if(entry.getKey().endsWith("_2"))
                {
                    String Key= entry.getKey().replace("_2","");
                    System.out.println(Key);
                    fieldName = webDriver.passwebelement(pageObject.getlocator("SegmentTextWithIndex").replace("{paramlink1}",SegNumber).replace("{paramlink}", Key)).getAttribute("for");
                    System.out.println(fieldName);
                    System.out.println(pageObject.getlocator("SegmentTextWithIndex").replace("{paramlink1}",SegNumber).replace("{paramlink}", entry.getKey()).replace("_2",""));
                }
                else{
                    fieldName = webDriver.passwebelement(pageObject.getlocator("SegmentText").replace("{paramlink1}",SegNumber).replace("{paramlink}", entry.getKey())).getAttribute("for");
                    System.out.println(pageObject.getlocator("SegmentText").replace("{paramlink1}",SegNumber).replace("{paramlink}", entry.getKey()).replace("_2",""));

                }
                WebElement element = webDriver.passwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
                try {
                    webDriver.ScrollIntoView(element);
                }
                catch (Exception e)
                {
                }
                String Tag = element.getTagName();
                String type = element.getAttribute("type");
                String role = element.getAttribute("role");
                if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {
                    String ActualText = webDriver.Getattribute(element, "value");
                    System.out.println("Actual Test:" + ActualText);
                    if(entry.getKey().contains("Date")) {
                        webDriver.Partialstringcomparator(ActualText, webDriver.ExpectedDate(entry.getValue()));
                    }
                    else if (entry.getValue().contains("SysData")) {
                        String Value = entry.getValue().split("=>")[1];
                        webDriver.Partialstringcomparator(ActualText, DriverInstance.getVariable(Value));
                    }
                    else{
                        webDriver.Partialstringcomparator(ActualText, entry.getValue());
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && "combobox".equalsIgnoreCase(role)) {
                    String ActualText = webDriver.Getattribute(element, "data-value");
                    if (entry.getValue().contains("SysData")) {
                        String Value = entry.getValue().split("=>")[1];
                        webDriver.Partialstringcomparator(ActualText, DriverInstance.getVariable(Value));
                    }
                    else {
                        webDriver.Stringcomparator(ActualText, entry.getValue());
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

    @Then("Verify {string} leg details")
    public void verifyLegDetails(String LegNumber, DataTable dt) throws DocumentException, InterruptedException {
        validateLegData(LegNumber, dt);
    }
    public void validateLegData(String LegNumber, DataTable dt) throws DocumentException, InterruptedException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {
                webDriver.waitForElementLoad(2);
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                String fieldName;
                if(entry.getKey().contains("Location")) {
                    if(entry.getKey().endsWith("_2"))
                    {
                        String Key= entry.getKey().replace("_2","");
                        System.out.println(Key);
                        fieldName = webDriver.passwebelement(pageObject.getlocator("Location2").replace("{paramlink1}",LegNumber)).getAttribute("for");
                        System.out.println(fieldName);
                        System.out.println(pageObject.getlocator("Location2").replace("{paramlink1}",LegNumber));
                    }
                    else{
                        webDriver.waitUntilElementIsVisible(pageObject.getlocator("Location").replace("{paramlink1}",LegNumber));
                        fieldName = webDriver.passwebelement(pageObject.getlocator("Location").replace("{paramlink1}",LegNumber)).getAttribute("for");
                        System.out.println(pageObject.getlocator("Location").replace("{paramlink1}",LegNumber));

                    }
                }
                else{
                    if (entry.getKey().endsWith("_2")) {
                        String Key = entry.getKey().replace("_2", "");
                        System.out.println(Key);
                        fieldName = webDriver.passwebelement(pageObject.getlocator("LabelTextWithIndex").replace("{paramlink1}", LegNumber).replace("{paramlink}", Key)).getAttribute("for");
                        System.out.println(fieldName);
                        System.out.println(pageObject.getlocator("LabelTextWithIndex").replace("{paramlink1}", LegNumber).replace("{paramlink}", entry.getKey()).replace("_2", ""));
                    } else {
                        webDriver.waitUntilElementIsVisible(pageObject.getlocator("LabelText").replace("{paramlink1}", LegNumber).replace("{paramlink}", entry.getKey()));
                        fieldName = webDriver.passwebelement(pageObject.getlocator("LabelText").replace("{paramlink1}", LegNumber).replace("{paramlink}", entry.getKey())).getAttribute("for");
                        System.out.println(pageObject.getlocator("LabelText").replace("{paramlink1}", LegNumber).replace("{paramlink}", entry.getKey()).replace("_2", ""));

                    }
                }
                WebElement element = webDriver.passwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
                webDriver.ScrollIntoView(element);
                String Tag = element.getTagName();
                String type = element.getAttribute("type");
                String role = element.getAttribute("role");
                if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {
                    String ActualText = webDriver.Getattribute(element, "value");
                    System.out.println("Actual Test:" + ActualText);
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        if (entry.getKey().contains("Date") && !entry.getValue().trim().equalsIgnoreCase("NA")) {
                            if (entry.getValue().contains(",") || entry.getValue().contains("//")) {
                                webDriver.Partialstringcomparator(ActualText, entry.getValue());
                            } else {
                                webDriver.Partialstringcomparator(ActualText, webDriver.ExpectedDate(entry.getValue()));
                            }
                        } else if (entry.getValue().contains("SysData")) {
                            String Value = entry.getValue().split("=>")[1];
                            webDriver.Partialstringcomparator(ActualText, DriverInstance.getVariable(Value));
                        } else if (entry.getValue().contains("NA")) {
                            webDriver.Partialstringcomparator(ActualText, "");
                        } else {
                            webDriver.Partialstringcomparator(ActualText, entry.getValue());
                        }
                    }
                    else{
                        webDriver.Stringcomparator(ActualText,"");
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "search".equalsIgnoreCase(type) && !"combobox".equalsIgnoreCase(role)) {
                    String ActualText = webDriver.Getattribute(element, "value");
                    System.out.println("Actual Test:" + ActualText);
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        if (entry.getKey().contains("Date")) {
                            webDriver.Partialstringcomparator(ActualText, webDriver.ExpectedDate(entry.getValue()));
                        } else if (entry.getValue().contains("SysData")) {
                            String Value = entry.getValue().split("=>")[1];
                            webDriver.Partialstringcomparator(ActualText, DriverInstance.getVariable(Value));
                        } else {
                            webDriver.Partialstringcomparator(ActualText, entry.getValue());
                        }
                    }
                    else{
                        webDriver.Stringcomparator(ActualText, "");
                    }
                }
                else if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type) && "combobox".equalsIgnoreCase(role)) {
                    String ActualText = webDriver.Getattribute(element, "data-value");
                    System.out.println(ActualText);
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        if (entry.getValue().contains("SysData")) {
                            String Value = entry.getValue().split("=>")[1];
                            webDriver.Partialstringcomparator(ActualText, DriverInstance.getVariable(Value));
                        } else if (entry.getValue().equalsIgnoreCase("NA")) {
                            webDriver.Partialstringcomparator(ActualText, "");
                        } else {
                            webDriver.Stringcomparator(ActualText, entry.getValue());
                        }
                    }
                    else{
                        webDriver.Stringcomparator(ActualText,"");
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

                    webDriver.ScrollIntoView(element);
                    if (entry.getValue().equalsIgnoreCase("False")) {
                        boolean isChecked = element.isSelected();
                        if (isChecked) {
                            Assert.fail(entry.getKey()+" is checked but is should not");
                        }

                    }
                    else {
                        System.out.println("Man" + element.isSelected());
                        boolean isChecked = element.isSelected();
                        if (!isChecked) {
                            Assert.fail(entry.getKey()+" is unchecked but is should be checked");

                        }
                    }
                }
                else if (Tag.equalsIgnoreCase("button") && "button".equalsIgnoreCase(type)) {
                    String ActualText = webDriver.Getattribute(element, "data-value");
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        webDriver.Partialstringcomparator(ActualText, entry.getValue());
                    }
                    else{
                        webDriver.Stringcomparator(ActualText,"");
                    }
                }
                else if (Tag.equalsIgnoreCase("select") ) {
                    Select select = new Select(element);
                    String selectedText = select.getFirstSelectedOption().getText();
                    System.out.println("Selected Text: " + selectedText);
                    if ( Objects.nonNull(entry.getValue()) && !entry.getValue().isEmpty()) {
                        webDriver.Stringcomparator(selectedText, entry.getValue());
                    }
                    else{
                        webDriver.Stringcomparator(selectedText,"");
                    }
                }
            }
        }
    }

    @Then("Click on {string} link for Start time {string}")
    public void clickOnLinkForStartTime(String arg0, String StartTime) throws Exception {

        webDriver.waitforElementtobeclickable(pageObject.getlocator("LogEntry").replace("{paramlink1}", StartTime));
        webDriver.Clickon(webDriver.getwebelement(pageObject.getlocator("LogEntry").replace("{paramlink1}", StartTime)));


    }
    @Then("Set DateTime In Word with Key {string}")
    public void setDateTimeInWordWithKey(String arg0) {
        DriverInstance.setVariable(arg0,DateTimeInWords.GetDateTimeInWord());
//        DriverInstance.setVariable(arg0,"November Twentieth Twenty Five Five Nineteen");
    }
    public  String readFile(String filePath) throws IOException {
        return new String(Files.readAllBytes(Paths.get(filePath)));
    }
    @Then("Set {string} with {string}")
    public void setWith(String arg0, String arg1) throws IOException {

        if(arg1.contains("CurrentDateTime"))
        {
            DriverInstance.setVariable(arg0,arg1.replace("CurrentDateTime",DateTimeInWords.numericTimestamp()));
        }
        else if(arg1.contains("SysData"))
        {
            String Value = arg1.split("=>")[1];
            String Act= DriverInstance.getVariable(Value);
            arg1=arg1.replace("SysData=>","").replace(Value,Act);
            DriverInstance.setVariable(arg0,arg1);
        }
        else if(arg1.contains("EnvData"))
        {
            String Value = arg1.split("=>")[1];
            String Act= propertyReader.readproperty(Value);
            DriverInstance.setVariable(arg0,Act);
        }
        else if(arg1.contains("Email"))
        {
            String Value = arg1.split("=>")[1];
            String scenarioName= DriverInstance.getScenarioName();
            System.out.println("scenarioName:"+scenarioName);
            String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");
            System.out.println("TID:"+TID);
            String Root = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator;
            File file = new File(Root + "TestCaseFiles" + File.separator +TID+ File.separator + Value);
            String expectedText = readFile(file.getAbsolutePath());
            expectedText = expectedText.replace("\n", "")
                    .replace("\r", "")
                    .trim();
            DriverInstance.setVariable(arg1,expectedText);
        }
        else if(arg1.contains("OrgData"))
        {
            String Value = arg1.split("=>")[1];
            String Act = PropReader.get(Value);
            DriverInstance.setVariable(arg0,Act);
        }
        else  if(arg1.contains("Date(yyyy-MM-dd)=>"))
        {
            String Value = arg1.split("=>")[1];
            String Act= webDriver.ReturnDateInSpecifiedFormat(Value,"yyyy-MM-dd");
            arg1=arg1.replace("Date(yyyy-MM-dd)=>","").replace(Value,Act);
            DriverInstance.setVariable(arg0,arg1);
        }
        else  if(arg1.contains("Date(M/d/yyyy)=>"))
        {
            String Value = arg1.split("=>")[1];
            String Act= webDriver.ReturnDateInSpecifiedFormat(Value,"M/d/yyyy");
            arg1=arg1.replace("Date(M/d/yyyy)=>","").replace(Value,Act);
            DriverInstance.setVariable(arg0,arg1);
        }
        else  if(arg1.contains("Date=>"))
        {
            String Value = arg1.split("=>")[1];
            String Act= webDriver.ReturnDateInSpecifiedFormat(Value,"yyyy-M-d");
            arg1=arg1.replace("Date=>","").replace(Value,Act);
            DriverInstance.setVariable(arg0,arg1);
        }
        else  if(arg1.contains("ddMMYY-HHMM=>"))
        {
            String Value = arg1.split("=>")[1];
            String Act= webDriver.ReturnDateTimeInSpecifiedFormat(Value,"ddMMyy-HHmm");
            arg1=arg1.replace("ddMMYY-HHMM=>","").replace(Value,Act);
            DriverInstance.setVariable(arg0,arg1);
        }
        else  if(arg1.contains("ddMMyyyy=>0"))
        {
            String Value = arg1.split("=>")[1];
            String Act= webDriver.ReturnDateInSpecifiedFormat(Value,"yyyy-M-d");
            arg1=arg1.replace("Date=>","").replace(Value,Act);
            DriverInstance.setVariable(arg0,arg1);
        }
        else  if(arg1.contains("MMddyyyy"))
        {
            String Value = arg1.split("=>")[1];
            String Act= webDriver.ReturnDateInSpecifiedFormat(Value,"MM-dd-yyyy");
            arg1=arg1.replace("MMddyyyy=>","").replace(Value,Act);
            DriverInstance.setVariable(arg0,arg1);
        }
        else  if(arg1.contains("MMMdd,yyyy"))
        {
            String Value = arg1.split("=>")[1];
            String Act= webDriver.ReturnDateInSpecifiedFormat(Value,"MMM dd, yyyy");
            arg1=arg1.replace("MMMdd,yyyy=>","").replace(Value,Act);
            DriverInstance.setVariable(arg0,arg1);
        }
        else  if(arg1.contains("MMMd,yyyy"))
        {
            String Value = arg1.split("=>")[1];
            String Act= webDriver.ReturnDateInSpecifiedFormat(Value,"MMM d, yyyy");
            arg1=arg1.replace("MMMdd,yyyy=>","").replace(Value,Act);
            DriverInstance.setVariable(arg0,arg1);
        }
        else{
            DriverInstance.setVariable(arg0,arg1);
        }
    }

    @Then("Set {string} with {string} and {string}")
    public void setWith(String arg0, String arg1, String arg2) throws IOException {

        if(arg2.contains("SysData"))
        {
            String Value = arg2.split("=>")[1];
            String Act= DriverInstance.getVariable(Value);
            arg2=arg2.replace("SysData=>","").replace(Value,Act);
        }

        if(arg1.contains("SysData"))
        {
            String Value = arg1.split("=>")[1];
            String Act= DriverInstance.getVariable(Value);
            arg1=arg1.replace("SysData=>","").replace(Value,Act);
        }
        else if(arg1.contains("EnvData"))
        {
            String Value = arg1.split("=>")[1];
            arg1= propertyReader.readproperty(Value);
        }
        else if(arg1.contains("OrgData"))
        {
            String Value = arg1.split("=>")[1];
            arg1 = PropReader.get(Value);
        }
        else  if(arg1.contains("Date(yyyy-MM-dd)=>"))
        {
            String Value = arg1.split("=>")[1];
            String Act= webDriver.ReturnDateInSpecifiedFormat(Value,"yyyy-MM-dd");
            arg1=arg1.replace("Date(yyyy-MM-dd)=>","").replace(Value,Act);
        }
        else  if(arg1.contains("Date(M/d/yyyy)=>"))
        {
            String Value = arg1.split("=>")[1];
            String Act= webDriver.ReturnDateInSpecifiedFormat(Value,"M/d/yyyy");
            arg1=arg1.replace("Date(M/d/yyyy)=>","").replace(Value,Act);
        }
        else  if(arg1.contains("Date=>"))
        {
            String Value = arg1.split("=>")[1];
            String Act= webDriver.ReturnDateInSpecifiedFormat(Value,"yyyy-M-d");
            arg1=arg1.replace("Date=>","").replace(Value,Act);
        }
        else  if(arg1.contains("ddMMyyyy=>0"))
        {
            String Value = arg1.split("=>")[1];
            String Act= webDriver.ReturnDateInSpecifiedFormat(Value,"yyyy-M-d");
            arg1=arg1.replace("Date=>","").replace(Value,Act);
        }
        else{
            System.out.println("All good");
        }
        DriverInstance.setVariable(arg0,arg1+arg2);
    }

    @Then("Set {string} with {string} and {string} and {string}")
    public void setWith(String arg0, String arg1, String arg2, String arg3) throws IOException {

        if(arg2.contains("SysData"))
        {
            String Value = arg2.split("=>")[1];
            String Act= DriverInstance.getVariable(Value);
            arg2=arg2.replace("SysData=>","").replace(Value,Act);
        }

        if(arg3.contains("SysData"))
        {
            String Value = arg3.split("=>")[1];
            String Act= DriverInstance.getVariable(Value);
            arg3=arg3.replace("SysData=>","").replace(Value,Act);
        }

        if(arg1.contains("SysData"))
        {
            String Value = arg1.split("=>")[1];
            String Act= DriverInstance.getVariable(Value);
            arg1=arg1.replace("SysData=>","").replace(Value,Act);

        }
        else if(arg1.contains("EnvData"))
        {
            String Value = arg1.split("=>")[1];
            arg1= propertyReader.readproperty(Value);
        }
        else if(arg1.contains("OrgData"))
        {
            String Value = arg1.split("=>")[1];
            arg1 = PropReader.get(Value);
        }
        else  if(arg1.contains("Date(yyyy-MM-dd)=>"))
        {
            String Value = arg1.split("=>")[1];
            String Act= webDriver.ReturnDateInSpecifiedFormat(Value,"yyyy-MM-dd");
            arg1=arg1.replace("Date(yyyy-MM-dd)=>","").replace(Value,Act);

        }
        else  if(arg1.contains("Date(M/d/yyyy)=>"))
        {
            String Value = arg1.split("=>")[1];
            String Act= webDriver.ReturnDateInSpecifiedFormat(Value,"M/d/yyyy");
            arg1=arg1.replace("Date(M/d/yyyy)=>","").replace(Value,Act);
        }
        else  if(arg1.contains("Date=>"))
        {
            String Value = arg1.split("=>")[1];
            String Act= webDriver.ReturnDateInSpecifiedFormat(Value,"yyyy-M-d");
            arg1=arg1.replace("Date=>","").replace(Value,Act);
        }
        else  if(arg1.contains("ddMMyyyy=>0"))
        {
            String Value = arg1.split("=>")[1];
            String Act= webDriver.ReturnDateInSpecifiedFormat(Value,"yyyy-M-d");
            arg1=arg1.replace("Date=>","").replace(Value,Act);
        }
        else{
            System.out.println("Adding without condition");
        }
        DriverInstance.setVariable(arg0,arg1+arg2+arg3);
    }

    @Then("Set {string} with {string} and {string} if not exist")
    public void setWithIfnotExist(String arg0, String arg1, String arg2) throws IOException {

        if(arg2.contains("SysData"))
        {
            String Value = arg2.split("=>")[1];
            String Act= DriverInstance.getVariable(Value);
            arg2=arg2.replace("SysData=>","").replace(Value,Act);
        }

        if(arg1.contains("SysData"))
        {
            String Value = arg1.split("=>")[1];
            String Act= DriverInstance.getVariable(Value);
            arg1=arg1.replace("SysData=>","").replace(Value,Act);
            if(arg1.contains(arg2))
            {
                System.out.println("Already Exist");
                if (arg1.trim().endsWith(",")) {
                    arg1 = arg1.substring(0, arg1.length() - 1);
                }
                DriverInstance.setVariable(arg0, arg1);
            }
            else {
                DriverInstance.setVariable(arg0, arg1 + arg2);
                System.out.println(arg0 + " - " + arg1 + arg2);
            }
        }

        else{
            if(arg1.contains(arg2))
            {
                System.out.println("Already Exist");
                if (arg1.trim().endsWith(",")) {
                    arg1 = arg1.substring(0, arg1.length() - 1);
                }
                DriverInstance.setVariable(arg0, arg1);
            }
            else {
                DriverInstance.setVariable(arg0, arg1 + arg2);
            }
        }
    }


    @Then("Set {string} with Email Text as {string}")
    public void setWithEmailTextAsMessageI(String arg0, String arg1) {
        DriverInstance.setVariable(arg0,arg1.replace("{DriverName}",DriverInstance.getVariable("DriverName")).replace("{DriverID}",DriverInstance.getVariable("Driver_SFID")));
    }

    @Then("Set Log entry date as {string} for {string}")
    public void setLogEntryDateWithDST(String dateTimeStr, String arg1) throws Exception {

        // Input format coming from feature file
        DateTimeFormatter inputFormatter =
                DateTimeFormatter.ofPattern("M/d/yyyy, h:mm a", Locale.ENGLISH);

        // Output format
        DateTimeFormatter outputFormatter =
                DateTimeFormatter.ofPattern("M/d/yyyy, h:mm a", Locale.ENGLISH);

        // Parse incoming date-time
        LocalDateTime parsedDateTime = LocalDateTime.parse(dateTimeStr, inputFormatter);

        // Time zone for DST check
        ZoneId chicagoZone = ZoneId.of("America/Chicago");

        // Convert to ZonedDateTime (automatically applies DST rules)
        ZonedDateTime zonedDateTime = parsedDateTime.atZone(chicagoZone);

        // Extract final adjusted time
        String finalDateTime = zonedDateTime.format(outputFormatter);

        System.out.println("DST Adjusted Log Date: " + finalDateTime);

        // Store it in your driver variable (optional)
        DriverInstance.setVariable(arg1, finalDateTime);
    }


    @Then("Set {string} Link to {string}")
    public void setLinkTo(String arg0, String arg1) {
        String url = webDriver.GetCurrentURL();
        String baseUrl = url.replaceAll("(\\.com).*", ".com");
        System.out.println(baseUrl);
        DriverInstance.setVariable(arg0,baseUrl+arg1);
    }


    @Then("Click on button with Title {string} on {string}")
    public void clickOnButtonWithTitleOn(String arg0, String arg1) throws Exception {
        webDriver.waitForElementLoad(1);
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("ButtonunderSegments").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("ButtonunderSegments").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("ButtonunderSegments").replace("{paramlink1}", arg1).replace("{paramlink2}", arg0)));
        webDriver.waitForElementLoad(2);
    }
    @Then("Click on {string} on {string} Segment")
    public void clickOnOnSegment(String arg0, String arg1) throws DocumentException, InterruptedException {
        if(arg0.contains("Add Driver"))
        {
            int count = webDriver.getwebelementscount(pageObject.getlocator("NumberOfDriver").replace("{index}", arg1));
            System.out.println("Count is: "+count);
            if(count==1) {
                webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("Segment_Button").replace("{index}", arg1).replace("{paramlink}", arg0)));
                webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("Segment_Button").replace("{index}", arg1).replace("{paramlink}", arg0)));
            }
        }
        else {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("Segment_Button").replace("{index}", arg1).replace("{paramlink}", arg0)));
            webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("Segment_Button").replace("{index}", arg1).replace("{paramlink}", arg0)));
        }
    }

    @Then("Verify Segment {string} {string} is {string}")
    public void verifySegmentIs(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException {
        String fieldName = webDriver.passwebelement(pageObject.getlocator("SegmentText").replace("{paramlink1}",arg0).replace("{paramlink}", arg1)).getAttribute("for");
        System.out.println(pageObject.getlocator("SegmentText").replace("{paramlink1}",arg0).replace("{paramlink}", arg1).replace("_2",""));

        WebElement element = webDriver.getwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
        webDriver.ScrollIntoView(element);
        boolean isChecked = element.isSelected();
        if(arg2.equalsIgnoreCase("true")) {
            Assert.assertTrue(isChecked,arg1 +" is not Checked");
        }
        else {
            Assert.assertFalse(isChecked,arg1 +" is Checked");
        }
    }

    @Then("Verify {string} leg Timezone is {string}")
    public void verifyLegTimezoneIs(String arg0, String arg1) throws DocumentException, InterruptedException {
       int count = webDriver.getwebelementscount(pageObject.getlocator("Timezone").replace("[{paramlink1}]","").replace("{paramlink2}", arg1));
       if(count>1) {
           webDriver.verifyElementToBePresent(pageObject.getlocator("Timezone").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1));
       }
       else{
           webDriver.verifyElementToBePresent(pageObject.getlocator("Timezone").replace("{paramlink1}", "1").replace("{paramlink2}", arg1));
       }
    }

    @Then("Verify {string} icon is displaying")
    public void verifyIconIsDisplaying(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementToBePresent(pageObject.getlocator("CloseIcon").replace("{paramlink}",arg0));

    }

    @Then("Click on {string} icon for close modal")
    public void clickOnIconForCloseModal(String arg0) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("CloseIcon").replace("{paramlink}",arg0));
        webDriver.ClickOnElement(webDriver.passwebelement(pageObject.getlocator("CloseIcon").replace("{paramlink}",arg0)));

    }

    @Then("Verify LWC Heading displaying as {string}")
    public void verifyLWCHeadingDisplayingAs(String arg0) throws DocumentException, InterruptedException {
         webDriver.waitUntilElementIsVisible(pageObject.getlocator("LwcHeading").replace("{paramlink}",arg0));
         webDriver.verifyElementToBePresent(pageObject.getlocator("LwcHeading").replace("{paramlink}",arg0));
    }

    @Then("Click on X to close LWC")
    public void clickOnXToCloseLWC() throws Exception {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("XIcon"));
        webDriver.safeJavaScriptClick(webDriver.passwebelement(pageObject.getlocator("XIcon")));

    }

    @Then("Verify {string} Table is empty")
    public void verifyTableIsEmpty(String arg0) throws DocumentException, InterruptedException {
       webDriver.waitUntilElementIsVisible(pageObject.getlocator("TableunderSelectedView").replace("{paramlink1}",arg0));
       webDriver.verifyElementToBePresent(pageObject.getlocator("TableunderSelectedView").replace("{paramlink1}",arg0));
    }
    @Then("Verify {string} Table count is {string}")
    public void verifyTableCount(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("TableunderSelectedViewCount").replace("{paramlink1}",arg0));
        String count= webDriver.Getattribute(webDriver.passwebelement(pageObject.getlocator("TableunderSelectedViewCount").replace("{paramlink1}",arg0)), "data-num-rows");
       webDriver.Stringcomparator(count,arg1);
    }


    @Then("Verify {string} Table count is more than {string}")
    public void verifyTableCountIsMoreThan(String arg0, String arg1) throws DocumentException, InterruptedException {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("TableunderSelectedViewCount").replace("{paramlink1}",arg0));
        String count= webDriver.Getattribute(webDriver.passwebelement(pageObject.getlocator("TableunderSelectedViewCount").replace("{paramlink1}",arg0)), "data-num-rows");
        Assert.assertTrue(Integer.parseInt(count)>Integer.parseInt(arg1));
    }

    @Then("Clear {string} field on {string} Segment")
    public void clearFieldOnSegment(String arg0, String arg1) throws Exception {
        String locator = pageObject.getlocator("SegmentClearIcon").replace("{paramlink1}", arg1).replace("{paramlink}", arg0);
        int count = webDriver.getwebelementscount(locator);
        if (count > 0) {
            WebElement clearBtn = webDriver.getwebelement(locator);
            webDriver.ScrollIntoView(clearBtn);
            webDriver.safeJavaScriptClick(clearBtn);
            webDriver.waitForElementLoad(2);
        }
    }

}