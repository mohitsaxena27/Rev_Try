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
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Log4j
public class Configuration {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader PageObject;
    public xmlreader Generic;
    public PropertyReader propertyReader = new PropertyReader();
    public List<String> searchResults = new ArrayList<>();

    public Configuration(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        PageObject = new xmlreader("TMS Admin" + File.separator + "Configuration.xml");
        Generic = new xmlreader("Generics" + File.separator + "Common.xml");
    }

    @Then("Select Fleet Management Job as {string}")
    public void selectFleetManagementJobAs(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(PageObject.getlocator(("FMJ"))));
        webDriver.selectOptionByText(webDriver.getwebelement(PageObject.getlocator(("FMJ"))), arg0);
    }

    @Then("Subtract {int} minutes from {string} and store on {string}")
    public void subtractMinutesAndStoreOn(int minutes, String dateTime, String variableName) {
         if(dateTime.contains("SysData"))
         {
             dateTime= DriverInstance.getVariable(dateTime.split("=>")[1]);
         }
        DateTimeFormatter inputFormatter =
                DateTimeFormatter.ofPattern("M/d/yyyy, h:mm a");

        DateTimeFormatter outputFormatter =
                DateTimeFormatter.ofPattern("M/d/yyyy h:mm a");

        LocalDateTime dateTimeValue =
                LocalDateTime.parse(dateTime, inputFormatter);

        LocalDateTime updatedDateTime =
                dateTimeValue.minusMinutes(minutes);

        String formattedDateTime =
                updatedDateTime.format(outputFormatter);

        DriverInstance.setVariable(variableName, formattedDateTime);
    }


    @Then("{string} : Select {string} as {string}")
    public void selectAs(String arg0, String arg1, String arg2) throws Exception {

        String index= "2";
        if(arg1.equalsIgnoreCase("Carrier Upload"))
        {
            index= "4";
        }

        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(PageObject.getlocator("SelectCIDFlobalSettings").replace("{paramlink}", arg0).replace("{index}",index)));
        String fieldName = webDriver.passwebelement(PageObject.getlocator("SelectCIDFlobalSettings").replace("{paramlink}", arg0).replace("{index}",index)).getAttribute("for");
        WebElement element = webDriver.passwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldName));
        webDriver.ScrollIntoView(element);
        String Tag = element.getTagName();
        System.out.println(Tag);
        String type = element.getAttribute("type");
        System.out.println(type);
        String role = element.getAttribute("role");

        if (Tag.equalsIgnoreCase("input") && "checkbox".equalsIgnoreCase(type)) {
            webDriver.ScrollIntoView(element);
            if (arg2.equalsIgnoreCase("False")) {
                boolean isChecked = element.isSelected();
                if (isChecked) {
                    try {
                        webDriver.ClickOnElement(element);
                    } catch (Exception e) {
                        webDriver.safeJavaScriptClick(element);
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
                        webDriver.safeJavaScriptClick(element);                    }
                }
            }
        }
        else if (Tag.equalsIgnoreCase("button") && "button".equalsIgnoreCase(type)) {

                webDriver.safeJavaScriptClick(element);
                if (arg2.contains("SysData")) {
                    arg2 = DriverInstance.getVariable(arg2.split("=>")[1]);
                }
                webDriver.SelectComboBoxOption(webDriver.getwebelement(Generic.getlocator("DropdownListBox").replace("{paramlink}", fieldName)), webDriver.getwebelement(Generic.getlocator("DropdownListBoxOptionList").replace("{paramlink}", fieldName).replace("{paramlink2}", arg2)));
            }
        }



}