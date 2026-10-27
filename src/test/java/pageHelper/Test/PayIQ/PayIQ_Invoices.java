package pageHelper.Test.PayIQ;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@Log4j
public class PayIQ_Invoices {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public xmlreader iframexml;
    public PropertyReader propertyReader = new PropertyReader();
    Common_Steps cs;

    public PayIQ_Invoices(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("PayIQ" + File.separator + "PayIQ_Invoices.xml");
        xml = new xmlreader("TMS" + File.separator + "Load" + File.separator + "Load_Quote_And_Invoice.xml");
        iframexml = new xmlreader("Generics" + File.separator + "CommonFrame.xml");
        cs = new Common_Steps(DriverInstance);
    }

    @Then("Update the {string} accessorial data for row {int}")
    public void updateTheAccessoialData(String accessorialName, int rowNumber, DataTable dt) throws Exception {
        webDriver.SwitchToFrameByElement(webDriver.getwebelement("//div[contains(@class,'active')]//iframe"));
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            for (Map.Entry<String, String> entry : details.entrySet()) {
                System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
//                String initialHeaderName = webDriver.passwebelement(xml.getlocator("TableColumnHeader").replace("{paramlink}", entry.getKey())).getAttribute("id");
                String initialHeaderName = "";
                for (int retry = 0; retry < 3; retry++) {
                    try {
                        initialHeaderName = webDriver.passwebelement(xml.getlocator("TableColumnHeader").replace("{paramlink}", entry.getKey())).getAttribute("id");
                        break;
                    } catch (org.openqa.selenium.StaleElementReferenceException e) {
                        System.out.println("Retrying header lookup for : " + entry.getKey());
                        webDriver.waitForElementLoad(1);
                    }
                }
                String HeaderName = initialHeaderName.replace("header:sortDiv", "");
                HeaderName = HeaderName.substring(HeaderName.lastIndexOf(":") + 1);
                webDriver.waitForElementLoad(1);
                String rowLocator = pageObject.getlocator("RowData").replace("{paramlink1}", accessorialName).replace("{paramlink2}", String.valueOf(rowNumber));
                webDriver.waitUntilElementIsVisible(rowLocator);
                webDriver.ScrollIntoView(webDriver.getwebelement(rowLocator));
                String InitialRowID = webDriver.getwebelement(rowLocator).getAttribute("id");
                System.out.println("Row ID : " + InitialRowID);
                String RowID = InitialRowID.substring(0, InitialRowID.lastIndexOf(":"));
                System.out.println("Updated Row ID : " + RowID);
                String FinalElement = RowID + ":" + HeaderName;
                System.out.println("Final Element : " + FinalElement);
                WebElement element = webDriver.getwebelement(pageObject.getlocator("InputField").replace("{paramlink}", FinalElement));
                webDriver.waitForElementLoad(1);
                webDriver.ScrollIntoView(element);
                String Tag = element.getTagName();
                String type = element.getAttribute("type");
                if (Tag.equalsIgnoreCase("input") && "text".equalsIgnoreCase(type)) {
                    webDriver.SendKeys(element, entry.getValue());
                    Thread.sleep(1000);
                }
                else if (Tag.equalsIgnoreCase("input") && "checkbox".equalsIgnoreCase(type)) {
                    webDriver.ScrollIntoView(element);
                    if (entry.getValue().equalsIgnoreCase("False")) {
                        boolean isChecked = element.isSelected();
                        if (isChecked) {
                            try {
                                webDriver.ClickOnElement(element);
                            } catch (Exception e) {
                                webDriver.safeJavaScriptClick(element);
                            }
                        }
                    } else {
                        boolean isChecked = element.isSelected();
                        if (!isChecked) {
                            try {
                                webDriver.waitForElementLoad(1);
                                webDriver.safeJavaScriptClick(element);
                            } catch (Exception e) {
                                webDriver.safeJavaScriptClick(element);
                            }
                        }
                    }
                }
                else if (Tag.equalsIgnoreCase("select")) {
                    webDriver.ScrollIntoView(element);
                    webDriver.waitUntilTheElementIsVisible(element);
                    webDriver.selectOptionByText(element, entry.getValue());
                }
                webDriver.waitForElementLoad(1);
            }
            webDriver.ScrollIntoView(webDriver.getwebelement(iframexml.getlocator("InputValue").replace("{paramlink}", "Save")));
            webDriver.waitforElementtobeclickable(iframexml.getlocator("InputValue").replace("{paramlink}", "Save"));
            webDriver.Clickon(webDriver.getwebelement(iframexml.getlocator("InputValue").replace("{paramlink}", "Save")));
            Thread.sleep(2000);
            webDriver.SwitchToParentFrame();
        }
    }
}
