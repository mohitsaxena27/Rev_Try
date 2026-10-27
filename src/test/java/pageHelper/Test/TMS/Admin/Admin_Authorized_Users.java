package pageHelper.Test.TMS.Admin;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pageHelper.bddDriver;
import utils.Exception.SkipTestException;
import utils.xmlreader;

import java.io.File;
import java.util.List;
import java.util.Map;

@Log4j
public class Admin_Authorized_Users {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader PageObject;
    public xmlreader Generic;

    public Admin_Authorized_Users(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        PageObject = new xmlreader("TMS Admin" + File.separator + "Global_Authorized_User.xml");
        Generic = new xmlreader("Generics" + File.separator + "Common.xml");
    }

    @Then("Update checkbox {string} as {string} for {string} credential card")
    public void updateCheckboxAsForCredentialCard(String field, String Value, String CardName) throws Exception {

        webDriver.ScrollToElement(webDriver.getwebelement(PageObject.getlocator("CredentialCheckboxes").replace("{paramlink1}", CardName).replace("{paramlink2}", field)));
        WebElement element=webDriver.getwebelement(PageObject.getlocator("CredentialCheckboxes").replace("{paramlink1}", CardName).replace("{paramlink2}", field));
        String fieldN= element.getAttribute("for");
        WebElement element1  = webDriver.passwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldN));

        webDriver.ScrollIntoView(element);
        if (Value.equalsIgnoreCase("false")) {
            boolean isChecked = "true".equalsIgnoreCase(element1.getAttribute("checked"));
            System.out.println("iChecked value:"+isChecked);
            if (isChecked) {
                try {
                    webDriver.ClickOnElement(element1);
                } catch (Exception e) {
                    webDriver.safeJavaScriptClick(element1);
                }
            }

        }
        else {
            System.out.println("Man" + element1.getAttribute("checked"));
            boolean isChecked = "true".equalsIgnoreCase(element1.getAttribute("checked"));
            if (!isChecked) {
                try {
                    webDriver.ClickOnElement(element1);
                } catch (Exception e) {
                    webDriver.safeJavaScriptClick(element1);
                }
            }
        }
    }

    @Then("Verify {string} is disabled or not")
    public void verifyIsDisabledOrNot(String fieldName) throws DocumentException, InterruptedException {

        String locator = PageObject
                .getlocator("CallbackEndpointCreatedDisabledAndChecked")
                .replace("{paramlink}", fieldName);

        int elementCount = webDriver.getwebelementscount(locator);

        System.out.println(
                fieldName + " disabled and checked element count: " + elementCount);

        if (elementCount > 0) {
            DriverInstance.setVariable("SMC3_End_Point_disabled", "Yes");

            String message = "Skipping this test case because "
                    + fieldName + " is disabled and checked.";

            System.out.println(message);
            throw new SkipTestException(message);
        }

        DriverInstance.setVariable("SMC3_End_Point_disabled", "No");

        System.out.println(
                fieldName + " is not disabled and checked. Continuing execution.");
    }

    @Then("Select {string} user from lookup dropdown")
    public void selectUserFromLookupDropdown(String userName) throws Exception {
        String locator = PageObject.getlocator("LookupOption").replace("{paramlink}", userName);
        webDriver.waitUntilElementIsVisible(locator);
        List<WebElement> options = webDriver.getwebelements(locator);
        WebElement option = null;
        for (WebElement candidate : options) {
            if (candidate.isDisplayed()) {
                option = candidate;
                break;
            }
        }
        Assert.assertNotNull(option, "Lookup option not found for user: " + userName);
        webDriver.ClickOnElement(option);
        webDriver.waitForElementLoad(1);
    }

    @Then("Clear and search text {string} in the {string} search box")
    public void clearAndSearchTextInSearchBox(String text, String placeholder) throws Exception {
        String locator = PageObject.getlocator("AuthorizedUserSearchBox").replace("{paramlink}", placeholder);
        webDriver.waitUntilElementIsVisible(locator);
        WebElement el = webDriver.getwebelement(locator);
        webDriver.ScrollIntoView(el);
        el.sendKeys(Keys.chord(Keys.CONTROL, "a"), Keys.DELETE);
        webDriver.SendKeys(el, text);
        webDriver.waitForElementLoad(1);
    }

    @Then("Search text {string} in the active {string} search box")
    public void searchTextInActiveSearchBox(String searchText, String placeholder) throws Exception {
        String locator = Generic.getlocator("ModalSearchBox").replace("{paramlink}", placeholder);
        webDriver.waitUntilElementIsVisible(locator);
        List<WebElement> searchBoxes = webDriver.getwebelements(locator);
        WebElement activeSearchBox = null;
        for (WebElement searchBox : searchBoxes) {
            if (searchBox.isDisplayed() && searchBox.isEnabled()) {
                activeSearchBox = searchBox;
            }
        }
        Assert.assertNotNull(activeSearchBox, "No active modal search box found for: " + placeholder);
        webDriver.SendKeys(activeSearchBox, searchText);
        webDriver.waitForElementLoad(1);
    }

//    @Then("Click on modal button with text {string}")
//    public void clickOnModalButtonWithText(String buttonText) throws Exception {
//        String locator = Generic.getlocator("ModalButtonText").replace("{paramlink}", buttonText);
//        webDriver.waitUntilElementIsVisible(locator);
//        List<WebElement> buttons = webDriver.getwebelements(locator);
//        WebElement modalButton = null;
//        for (WebElement button : buttons) {
//            if (button.isDisplayed() && button.isEnabled()) {
//                modalButton = button;
//                break;
//            }
//        }
//        Assert.assertNotNull(modalButton, "Modal button not found: " + buttonText);
//        webDriver.safeJavaScriptClick(modalButton);
//        webDriver.waitForElementLoad(1);
//    }

    @Then("Clear field {string} on {string} credential card")
    public void clearCredentialCardField(String fieldName, String cardName) throws Exception {
        String locator = PageObject.getlocator("CredentialCardFieldInput")
                .replace("{paramlink1}", cardName)
                .replace("{paramlink2}", fieldName);
        webDriver.waitUntilElementIsVisible(locator);
        WebElement field = webDriver.getwebelement(locator);
        webDriver.ScrollIntoView(field);
        webDriver.clearTextBox(field);
        Assert.assertEquals(webDriver.Getattribute(field, "value"), "",
                "Field '" + fieldName + "' in card '" + cardName + "' was not cleared");
    }

    @Then("click on {string} user and select {string} from Show More Dropdown")
    public void inActionsColumnSelectAction(String userName, String action) throws Exception {
        String rowActionLocator = PageObject.getlocator("RowActionCarrot").replace("{paramlink}", userName);
        webDriver.waitUntilElementIsVisible(rowActionLocator);
        webDriver.ClickOnElement(webDriver.getwebelement(rowActionLocator));

        String actionLocator = PageObject.getlocator("RowActionMenuItem").replace("{paramlink}", action);
        webDriver.waitUntilElementIsVisible(actionLocator);
        webDriver.ClickOnElement(webDriver.getwebelement(actionLocator));
        webDriver.waitForElementLoad(1);
    }

    public void deleteUserIfExists(String userName) throws Exception {
        String userLocator = PageObject.getlocator("UserNameLink").replace("{paramlink}", userName);
        if (webDriver.getwebelementscount(userLocator) > 0) {
            inActionsColumnSelectAction(userName, "Delete");
            int attempts = 0;
            while (webDriver.getwebelementscount(userLocator) > 0 && attempts < 5) {
                webDriver.waitForElementLoad(1);
                attempts++;
            }
            Assert.assertEquals(webDriver.getwebelementscount(userLocator), 0,
                    "User was not deleted from Authorized Users: " + userName);
        }
    }

    @Then("Verify details for {string} credential card")
    public void verifyCredentialCardFields(String cardName, DataTable dataTable) throws Exception {
        String cardHeaderLocator = PageObject.getlocator("CredentialCardHeader").replace("{paramlink}", cardName);
        if (webDriver.getwebelementscount(cardHeaderLocator) > 0) {
            webDriver.ScrollIntoView(webDriver.getwebelement(cardHeaderLocator));
        }
        List<Map<String, String>> rows = dataTable.asMaps(String.class, String.class);
        for (Map<String, String> row : rows) {
            boolean verifyUnlistedValuesAreBlank = row.containsKey("Enabled")
                    && row.containsKey("User Id")
                    && row.containsKey("Password 1")
                    && row.containsKey("Service URL")
                    && row.containsKey("Test Service URL");
            for (Map.Entry<String, String> field : row.entrySet()) {
                String name = field.getKey();
                String expected = field.getValue();
                if (expected == null || "null".equalsIgnoreCase(expected)) {
                    expected = "";
                }
                String inputLocator = PageObject.getlocator("CredentialCardFieldInput")
                        .replace("{paramlink1}", cardName)
                        .replace("{paramlink2}", name);
                int inputCount = webDriver.getwebelementscount(inputLocator);
                Assert.assertEquals(inputCount, 1,
                        "Expected one input for field '" + name + "' in credential card '" + cardName + "'");
                WebElement input = webDriver.getwebelement(inputLocator);
                String type = input.getAttribute("type");
                if ("checkbox".equalsIgnoreCase(type)) {
                    boolean actual = webDriver.checkSelectedUsingJS(input);
                    Assert.assertEquals(actual, Boolean.parseBoolean(expected),
                            "Checkbox '" + name + "' in credential card '" + cardName + "'");
                } else if ("REQUIRED".equalsIgnoreCase(expected)) {
                    String actualValue = webDriver.Getattribute(input, "value");
                    String placeholder = webDriver.Getattribute(input, "placeholder");
                    Assert.assertTrue("REQUIRED".equalsIgnoreCase(actualValue)
                                    || "REQUIRED".equalsIgnoreCase(placeholder),
                            "Field '" + name + "' in credential card '" + cardName
                                    + "' did not display REQUIRED (value=" + actualValue + ", placeholder=" + placeholder + ")");
                } else {
                    String actual = webDriver.Getattribute(input, "value");
                    if (actual == null) {
                        actual = "";
                    }
                    String systemAdminKey = "1265_System_Admin_" + cardName + "_" + name;
                    if ("capture system admin".equalsIgnoreCase(expected)) {
                        Assert.assertFalse(actual.trim().isEmpty(),
                                "System-admin baseline field '" + name + "' in credential card '" + cardName + "' was empty");
                        DriverInstance.setVariable(systemAdminKey, actual);
                    } else if ("same as system admin".equalsIgnoreCase(expected)) {
                        String baseline = DriverInstance.getVariable(systemAdminKey);
                        Assert.assertFalse(baseline.trim().isEmpty(),
                                "System-admin baseline field '" + name + "' in credential card '" + cardName + "' was not captured");
                        Assert.assertEquals(actual, baseline,
                                "Field '" + name + "' in credential card '" + cardName + "' did not match the system-admin baseline");
                    } else if ("default".equalsIgnoreCase(expected) || "populated".equalsIgnoreCase(expected)
                            || "not null".equalsIgnoreCase(expected) || "not empty".equalsIgnoreCase(expected)) {
                        Assert.assertFalse(actual.trim().isEmpty(),
                                "Field '" + name + "' in credential card '" + cardName + "' was expected to be populated");
                    } else {
                        Assert.assertEquals(actual, expected, "Field '" + name + "' in credential card '" + cardName + "'");
                    }
                }
            }
            if (verifyUnlistedValuesAreBlank) {
                verifyUnlistedCredentialFieldsAreBlank(cardName);
            }
        }
    }

    private void verifyUnlistedCredentialFieldsAreBlank(String cardName) throws Exception {
        String labelsLocator = PageObject.getlocator("CredentialCardLabels").replace("{paramlink}", cardName);
        List<WebElement> labels = webDriver.getwebelements(labelsLocator);
        Assert.assertFalse(labels.isEmpty(), "No credential fields found in card '" + cardName + "'");
        for (WebElement label : labels) {
            String fieldName = label.getText().replace("*", "").trim();
            if (fieldName.isEmpty() || fieldName.equalsIgnoreCase("Enabled")
                    || fieldName.equalsIgnoreCase("User Id")
                    || fieldName.equalsIgnoreCase("Password 1")
                    || fieldName.equalsIgnoreCase("Service URL")
                    || fieldName.equalsIgnoreCase("Test Service URL")
                    || fieldName.equalsIgnoreCase("Timeout (Seconds)")) {
                continue;
            }

            String fieldId = label.getAttribute("for");
            WebElement input = null;
            if (fieldId != null && !fieldId.isEmpty()) {
                input = webDriver.passwebelement(Generic.getlocator("FormFields").replace("{paramlink}", fieldId));
            }
            if (input == null) {
                String inputLocator = PageObject.getlocator("CredentialCardFieldInput")
                        .replace("{paramlink1}", cardName)
                        .replace("{paramlink2}", fieldName);
                if (webDriver.getwebelementscount(inputLocator) > 0) {
                    input = webDriver.getwebelement(inputLocator);
                }
            }
            if (input == null) {
                continue;
            }

            String type = input.getAttribute("type");
            if ("checkbox".equalsIgnoreCase(type) || "radio".equalsIgnoreCase(type)
                    || "button".equalsIgnoreCase(type) || "hidden".equalsIgnoreCase(type)) {
                continue;
            }
            if (!input.isEnabled() || "true".equalsIgnoreCase(input.getAttribute("readonly"))) {
                continue;
            }
            String value = webDriver.Getattribute(input, "value");
            Assert.assertTrue(value == null || value.trim().isEmpty(),
                    "Unexpected value in credential card '" + cardName + "', field '" + fieldName + "': " + value);
        }
    }

    @Then("Verify detail section is closed")
    public void verifyDetailSectionIsClosed() throws Exception {
        String saveButtonLocator = PageObject.getlocator("DetailSectionSaveButton");
        String cardFieldLocator = PageObject.getlocator("DetailSectionCardField");
        int visibleSaveButtons = 0;
        for (WebElement button : webDriver.getwebelements(saveButtonLocator)) {
            if (button.isDisplayed()) {
                visibleSaveButtons++;
            }
        }
        int visibleCardFields = 0;
        for (WebElement field : webDriver.getwebelements(cardFieldLocator)) {
            if (field.isDisplayed()) {
                visibleCardFields++;
            }
        }
        Assert.assertEquals(visibleSaveButtons + visibleCardFields, 0,
                "Credential detail section is still open");
    }

}
