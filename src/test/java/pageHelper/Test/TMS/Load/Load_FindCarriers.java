package pageHelper.Test.TMS.Load;

import com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter;
import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pageHelper.Utility.Common_Steps;
import pageHelper.Utility.TableVerifier;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;
import java.util.stream.Collectors;

import java.io.File;
import java.io.IOException;
import java.util.*;
import org.testng.Assert;

@Log4j
public class Load_FindCarriers {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    public Common_Steps cs;

    public Load_FindCarriers(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("TMS" + File.separator + "Load" + File.separator + "Load_FindCarriers.xml");
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        cs = new Common_Steps(DriverInstance);
    }

    @Then("Click on Carrier Match Refresh button in {string}")
    public void clickOnCarrierMatchRefreshButton(String buttonName) throws DocumentException, InterruptedException {
        String index;
        switch (buttonName.trim()) {
            case "Filter":
                index = "3";
                break;
            case "CarrierMatchesHeader":
                index = "1";
                break;
            case "CarrierMatchesFilterRefresh":
                index = "2";
                break;
            default:
                throw new IllegalArgumentException("Invalid Carrier Match Refresh button: " + buttonName);
        }
        try {
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("CarrierMatchesRefresh").replace("{index}", index)));
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("CarrierMatchesRefresh").replace("{index}", index));
            webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("CarrierMatchesRefresh").replace("{index}", index)));
        } catch (Exception e1) {
            webDriver.waitForElementLoad(2);
            webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("CarrierMatchesRefresh").replace("{index}", index)));
            webDriver.WaitforElementtobeclickable(pageObject.getlocator("CarrierMatchesRefresh").replace("{index}", index));
            webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("CarrierMatchesRefresh").replace("{index}", index)));
        }
    }

    @Then("Select checkbox with {string} as {string} under {string} section")
    public void selectCheckboxWithAsUnderSection(String columnName, String value, String tableName) throws Exception {
    webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("CarrierMatchCheckbox").replace("{paramlink1}", tableName).replace("{paramlink2}", columnName).replace("{paramlink3}", value)));
    webDriver.WaitforElementtobeclickable(pageObject.getlocator("CarrierMatchCheckbox").replace("{paramlink1}", tableName).replace("{paramlink2}", columnName).replace("{paramlink3}", value));
    webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("CarrierMatchCheckbox").replace("{paramlink1}", tableName).replace("{paramlink2}", columnName).replace("{paramlink3}", value)));
    }

    @Then("Verify {string} column in Carrier Matches section should be sorted in {string} order")
    public void verifyColumnInCarrierMatchesSectionShouldBeSortedInOrder(String columnName, String sortOrder) throws DocumentException, InterruptedException {
        List<WebElement> elements = webDriver.getwebelements( pageObject.getlocator("InNetworkColumn").replace("{paramlink}", columnName));
        List<String> actualValues = elements.stream()
                .map(e -> e.getText().trim())
                .filter(v -> !v.isEmpty())
                .toList();
        System.out.println("Actual  : " + actualValues);
        Comparator<String> comparator = String.CASE_INSENSITIVE_ORDER;
        if ("descending".equalsIgnoreCase(sortOrder)) {
            comparator = comparator.reversed();
        } else if (!"ascending".equalsIgnoreCase(sortOrder)) {
            throw new IllegalArgumentException("Invalid sort order: " + sortOrder);
        }
        List<String> expectedValues = actualValues.stream()
                .sorted(comparator)
                .toList();
        Assert.assertEquals(actualValues, expectedValues, "Column '" + columnName + "' is not sorted in " + sortOrder + " order");

    }

    @Then("Verify Table {string} details should {string} below values")
    public void verifyTableDetails(String tableName, String condition, DataTable dt) throws DocumentException, InterruptedException {
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (dataRows.isEmpty()) {
            return;
        }
        String locatorName;
        if (tableName.equalsIgnoreCase("In Network")) {
            locatorName = "VerifyInNetworkTableDetails";
        } else if (tableName.equalsIgnoreCase("Loads Delivering") || tableName.equalsIgnoreCase("Truck Postings")) {
            locatorName = "VerifyCapacityTableDetails";
        } else {
            throw new IllegalArgumentException("Unsupported table name: " + tableName + ". Supported tables are: In Network, Loads Delivering, Truck Postings");
        }
        for (Map<String, String> row : dataRows) {

            for (Map.Entry<String, String> entry : row.entrySet()) {

                String columnName = entry.getKey();
                String expectedValue = entry.getValue();
                if (expectedValue == null || expectedValue.trim().isEmpty()) {
                    continue;
                }
                if (entry.getValue().contains("SysData")) {
                    String Value = entry.getValue().split("=>")[1];
                    expectedValue = DriverInstance.getVariable(Value);
                }
                String locator = pageObject.getlocator(locatorName).replace("{paramlink1}", tableName).replace("{paramlink2}", columnName).replace("{paramlink3}", expectedValue);
                if (condition.equalsIgnoreCase("contain")) {
                    System.out.println("Checking value is present: " + "Table=" + tableName + ", Column=" + columnName + ", Value=" + expectedValue);
                    WebElement element = null;
                    try {
                        element = webDriver.getwebelement(locator);
                    } catch (Exception e) {
                        element = null;
                    }

                    boolean found = (element != null);

                    if (!found) {

                        throw new AssertionError("Expected value was not found. " + "Table: " + tableName + ", Column: " + columnName + ", Value: " + expectedValue);
                    }
                    System.out.println("PASS: Value found - " + expectedValue);
                }
                else if (condition.equalsIgnoreCase("not contain")) {

                    int maxAttempts = 10;
                    int waitTimeMillis = 500;
                    boolean found = false;
                    for (int attempt = 1; attempt <= maxAttempts; attempt++) {
                        WebElement element = null;
                        try {
                            element = webDriver.getwebelement(locator);
                        } catch (Exception e) {
                            element = null;
                        }
                        found = (element != null);
                        if (found) {

                            System.out.println("Attempt " + attempt + "/" + maxAttempts + " - Value still present: " + expectedValue);
                            Thread.sleep(waitTimeMillis);
                        } else {

                            System.out.println("Attempt " + attempt + "/" + maxAttempts + " - Value not found: " + expectedValue);
                            break;
                        }
                    }

                    if (found) {
                        throw new AssertionError("Unexpected value was found after waiting. " + "Table: " + tableName + ", Column: " + columnName + ", Value: " + expectedValue);
                    }
                    System.out.println("PASS: Value not found - " + expectedValue);
                }
                else {
                    throw new IllegalArgumentException("Invalid condition: " + condition + ". Use 'contain' or 'not contain'.");
                }
            }
        }
    }

    @Then("Verify values in {string} {string} is within {string} range")
    public void verifyValuesWithinRange(String tableName, String columnName, String range) throws DocumentException, InterruptedException {
        String actualColumnName = columnName;
        int columnIndex = 1;
        if (columnName.endsWith("_2")) {
            actualColumnName = columnName.substring(0, columnName.length() - 2);
            columnIndex = 2;
        }
        String locator = pageObject.getlocator("RangeColumn").replace("{paramlink1}", tableName).replace("{paramlink2}", actualColumnName).replace("{columnIndex}", String.valueOf(columnIndex));
        List<WebElement> elements = webDriver.getwebelements(locator);
        Assert.assertFalse(elements.isEmpty(), "No values found for column '" + columnName + "' in table '" + tableName + "'");
        for (WebElement element : elements) {
            String valueText = element.getText().trim();
            double value = Double.parseDouble(valueText);
            if (range.toLowerCase().startsWith("below")) {
                double max = Double.parseDouble(range.replaceAll("(?i)below\\s*", ""));
                Assert.assertTrue(value < max, "Value " + value + " is not below " + max);
            } else if (range.matches("\\d+(\\.\\d+)?\\s*-\\s*\\d+(\\.\\d+)?")) {
                String[] rangeValues = range.split("-");
                double min = Double.parseDouble(rangeValues[0].trim());
                double max = Double.parseDouble(rangeValues[1].trim());
                Assert.assertTrue(value >= min && value <= max, "Value " + value + " is outside the range " + min + "-" + max);
            } else {
                Assert.fail("Invalid range format: " + range);
            }
        }
    }

    @Then("Verify values in the {string} column of In Network should contain {string}")
    public void verifyInNetworkColumnContains(String columnName, String expectedValue) throws DocumentException, InterruptedException {
        List<WebElement> elements = webDriver.getwebelements(pageObject.getlocator("InNetworkColumn").replace("{paramlink}", columnName));
        Assert.assertFalse(elements.isEmpty(), "No values found in the '" + columnName + "' column");
        List<String> invalidValues = new ArrayList<>();
        for (WebElement element : elements) {
            String actualValue = element.getText().trim();
            if (!actualValue.toLowerCase().contains(expectedValue.toLowerCase())) {
                invalidValues.add(actualValue);
            }
        }
        Assert.assertTrue(invalidValues.isEmpty(), "The following values in the '" + columnName + "' column do not contain '" + expectedValue + "': " + invalidValues);
    }

    @Then("Verify Table {string} details should only have below values")
    public void verifyTableDetailsShouldOnlyHaveBelowValues(String tableName, DataTable dt) throws DocumentException, InterruptedException {
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        if (dataRows.isEmpty()) {
            return;
        }
        String locatorName;
        if (tableName.equalsIgnoreCase("In Network")) {
            locatorName = "InNetworkColumn";
        } else if (tableName.equalsIgnoreCase("Loads Delivering") || tableName.equalsIgnoreCase("Truck Postings")) {
            locatorName = "CapacityTableColumn";
        } else {
            throw new IllegalArgumentException("Unsupported table name: " + tableName);
        }
        for (Map<String, String> row : dataRows) {
            for (Map.Entry<String, String> entry : row.entrySet()) {
                String columnName = entry.getKey();
                String expectedValue = entry.getValue();
                if (expectedValue == null || expectedValue.trim().isEmpty()) {
                    continue;
                }
                String locator = pageObject.getlocator(locatorName).replace("{paramlink}", columnName);

                List<WebElement> elements = webDriver.getwebelements(locator);
                if (elements == null || elements.isEmpty()) {
                    throw new AssertionError("No values displayed after filtering. " + "Table: " + tableName + ", Column: " + columnName + ", Expected value: " + expectedValue);
                }
                for (WebElement element : elements) {
                    String actualValue = element.getText().trim();
                    Assert.assertEquals(actualValue, expectedValue.trim(), "Unexpected value found after filtering. " + "Table: " + tableName + ", Column: " + columnName + ", Expected: " + expectedValue + ", Actual: " + actualValue);
                }
                System.out.println("PASS: All displayed values in column '" + columnName + "' are '" + expectedValue + "'");
            }
        }
    }

    @Then("Verify if all status in {string} column are displayed under {string}")
    public void verifyIfAllStatusInColumnAreDisplayedUnder(String columnName, String networkName) throws Exception {
        // Get count before removing the filter
        String countLocator = pageObject.getlocator("InNetworkCount");
        List<WebElement> countElements = webDriver.getwebelements(countLocator);
        int countBefore = Integer.parseInt(countElements.get(0).getText().trim().replaceAll("[()]", ""));

        String columnLocator = pageObject.getlocator("InNetworkColumn").replace("{paramlink}", columnName);
        List<WebElement> columnElementsBefore = webDriver.getwebelements(columnLocator);
        Set<String> valuesBefore = columnElementsBefore.stream()
                .map(WebElement::getText)
                .map(String::trim)
                .filter(value -> !value.isEmpty())
                .collect(Collectors.toSet());

        //Remove filter
        cs.clickOnCheckbox("Approved","False");
        clickOnCarrierMatchRefreshButton("Filter");
        cs.waitForSeconds("2");

        // Get count after removing the filter
        countElements = webDriver.getwebelements(countLocator);
        int countAfter = Integer.parseInt(countElements.get(0).getText().trim().replaceAll("[()]", ""));

        // Get column values after removing the filter
        List<WebElement> columnElementsAfter = webDriver.getwebelements(columnLocator);
        Set<String> valuesAfter = columnElementsAfter.stream()
                .map(WebElement::getText)
                .map(String::trim)
                .filter(value -> !value.isEmpty())
                .collect(Collectors.toSet());

        Assert.assertTrue(countAfter >= countBefore, networkName + " count decreased after removing the filter. " + "Before: " + countBefore + ", After: " + countAfter);
        Assert.assertTrue(valuesAfter.containsAll(valuesBefore), "Values are missing from '" + columnName + "' under " + "'" + networkName + "' after removing the filter. " + "Before: " + valuesBefore + ", After: " + valuesAfter);
    }
}