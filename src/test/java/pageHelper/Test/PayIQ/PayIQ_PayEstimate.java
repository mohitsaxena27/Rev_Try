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
import utils.TimeZone.DateRangeUtil;
import utils.xmlreader;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


@Log4j
public class PayIQ_PayEstimate {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    Common_Steps cs;

    public PayIQ_PayEstimate(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("PayIQ" + File.separator + "PayIQ_Details.xml");
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        cs = new Common_Steps(DriverInstance);
    }

    @Then("Calculate value {string} from existing value {string} and store in {string}")
    public void calculateValueFromExistingValueAndStoreIn(String arg0, String arg1, String arg2) {
        if (arg1.contains("SysData")) {
            arg1 = DriverInstance.getVariable(arg1.split("=>")[1]);
        }
        double existingValue = Double.parseDouble(arg1.replaceAll("[^0-9.-]", ""));
        double modificationValue = Double.parseDouble(arg0.replaceAll("[^0-9.-]", ""));
        double calculatedValue = existingValue + modificationValue;
        DriverInstance.setVariable(arg2, String.valueOf(calculatedValue));
        System.out.println("Existing Value    : " + existingValue);
        System.out.println("Modification Value: " + modificationValue);
        System.out.println("Calculated Value  : " + calculatedValue);
        System.out.println("Stored Variable   : " + arg2);
    }


    @Then("Get {string} value from Estimated Pay Section {string} into {string}")
    public void getEstimatedPayValue(String field, String section, String variable) throws Exception {
        String xpath = pageObject.getlocator("EstimateInputField").replace("{paramlink1}", section);
        int count = webDriver.getwebelementscount(xpath.replace("[{index}]", ""));
        String getID = webDriver.Getattribute(webDriver.passwebelement(xpath.replace("{index}", String.valueOf(count))), "for");
        WebElement element = webDriver.passwebelement(xml.getlocator("FormFields").replace("{paramlink}", getID));
        webDriver.ScrollIntoView(element);
        String ActualText = webDriver.Getattribute(element, "value");
        DriverInstance.setVariable(variable, ActualText);
    }

    @Then("Update Estimated Pay Amount {string} to {string} in Section {string}")
    public void updateEstimatedPayAmount(String existingAmount, String newAmount, String section) throws Exception {
        if (existingAmount.contains("SysData")) {
            existingAmount = DriverInstance.getVariable(existingAmount.split("=>")[1]);
        }
        int matchedIndex = -1;
        String xpath = pageObject.getlocator("EstimatedPayAmountByRow").replace("{paramlink1}", section);
        webDriver.waitUntilElementIsVisible(xpath.replace("[index]", ""));
        int count = webDriver.getwebelementscount(xpath.replace("[index]", ""));
        for (int i = 1; i <= count; i++) {
            String rowXpath = xpath.replace("[index]", "[" + i + "]");
            WebElement amountElement = webDriver.passwebelement(rowXpath);
            String actualAmount = webDriver.Getattribute(amountElement, "value");
            if (actualAmount != null && !actualAmount.trim().isEmpty()) {
                double actualValue = Double.parseDouble(actualAmount.trim());
                double expectedValue = Double.parseDouble(existingAmount.trim());
                if (Double.compare(actualValue, expectedValue) == 0) {
                    matchedIndex = i;
                    break;
                }
            }
        }
        if (matchedIndex == -1) {
            throw new AssertionError("Estimated Pay Amount '" + existingAmount + "' was not found in Section '" + section + "'");
        }
        String matchedAmountXpath = xpath.replace("[index]", "[" + matchedIndex + "]");
        String editXpath = pageObject.getlocator("EstimatedPayEditButtonByRow").replace("{paramlink1}", section).replace("[index]", "[" + matchedIndex + "]");
        WebElement editButton = webDriver.getwebelement(editXpath);
        webDriver.ScrollIntoView(editButton);
        webDriver.WaitforElementtobeclickable(editXpath);
        webDriver.ClickOnElement(editButton);
        WebElement matchedAmountElement = webDriver.passwebelement(matchedAmountXpath);
        webDriver.SendKeys(matchedAmountElement, newAmount);
    }

    @Then("Update {string} value to {string} in Estimated Pay Section {string}")
    public void updateValueToInEstimatedPaySection(String field, String value, String section) throws DocumentException, InterruptedException, IOException {
        if (value.contains("SysData")) {
            value = DriverInstance.getVariable(value.split("=>")[1]);
        }
        String xpath = pageObject.getlocator("EstimateInputField").replace("{paramlink1}", section);
        int count=webDriver.getwebelementscount(xpath.replace("[{index}]",""));
        if (field.equalsIgnoreCase("Comment")) {
            for (int i = 1; i <= count; i++) {
                String tempID = webDriver.Getattribute(webDriver.passwebelement(xpath.replace("{index}", String.valueOf(i))), "for");
                WebElement tempElement = webDriver.passwebelement(xml.getlocator("FormFields").replace("{paramlink}", tempID));
                String placeholder = tempElement != null ? tempElement.getAttribute("placeholder") : null;
                if (placeholder != null && placeholder.toLowerCase().contains("enter comment")) {
                    count = i;
                    break;
                }
            }
        }
        String getID=webDriver.Getattribute(webDriver.passwebelement(xpath.replace("{index}",String.valueOf(count))),"for");
        WebElement element = webDriver.passwebelement(xml.getlocator("FormFields").replace("{paramlink}", getID));
        webDriver.ScrollIntoView(element);
        webDriver.SendKeys(element, value);
    }
}
