package pageHelper.Test.PayIQ;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.WebElement;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


@Log4j
public class PayIQ_Program {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    Common_Steps cs;

    public PayIQ_Program(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("PayIQ" + File.separator + "PayIQ_Details.xml");
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        cs = new Common_Steps(DriverInstance);
    }


@Then("Verify if {string} field has the following dropdown options")
public void verifyDropdownOptions(String field, DataTable dataTable) throws DocumentException, InterruptedException {
    String labelLocator = xml.getlocator("LabelText").replace("{paramlink}", field);
    webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(labelLocator));
    WebElement labelElement = webDriver.passwebelement(labelLocator);
    String fieldName = labelElement.getAttribute("for");
    System.out.println("Field: " + field);
    System.out.println("Field ID: " + fieldName);
    String formFieldLocator = xml.getlocator("FormFields").replace("{paramlink}", fieldName);
    WebElement element = webDriver.passwebelement(formFieldLocator);
    List<String> actualOptions = webDriver.returnAllOptions(element);
    System.out.println("Actual dropdown options: " + actualOptions);
    List<String> expectedOptions = dataTable.asList(String.class);
    System.out.println("Expected dropdown options: " + expectedOptions);
    List<String> missingOptions = new ArrayList<>();
    for (String expectedOption : expectedOptions) {
        String expected = expectedOption.trim();
        boolean found = actualOptions.stream().anyMatch(option -> option.trim().equals(expected));
        if (!found) {
            missingOptions.add(expected);
        }
    }
    if (!missingOptions.isEmpty()) {
        throw new AssertionError("Expected dropdown option(s) not found for field '" + field + "': " + String.join(", ", missingOptions) + "\nActual dropdown options: " + actualOptions);
    }
    System.out.println("All expected dropdown options are available for field '" + field + "'.");
}

}