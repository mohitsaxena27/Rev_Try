package pageHelper.Test.TMS.Admin;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
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
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Log4j
public class Fuel_Surcharges {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader PageObject;
    public xmlreader Generic;
    public PropertyReader propertyReader = new PropertyReader();
    public List<String> searchResults = new ArrayList<>();

    public Fuel_Surcharges(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        PageObject = new xmlreader("TMS Admin" + File.separator + "Fuel_Surcharges.xml");
        Generic = new xmlreader("Generics" + File.separator + "Common.xml");
    }

    @Then("Find Matching Percent value and store in {string}")
    public void findMatchingPercentValueAndStoreIn(String arg0) throws DocumentException, InterruptedException {
        int effectiveIndex =  (int) Double.parseDouble(DriverInstance.getVariable("Index_Effective_Value"));
        String final_Percent = webDriver.getText(webDriver.passwebelement(PageObject.getlocator("Fuel_Surcharge_Grid_Items").replace("{paramlink}",String.valueOf(effectiveIndex))));
        DriverInstance.setVariable(arg0,final_Percent);
    }

    @Then("Get {string} value and store in {string}")
    public void storeIn(String arg0, String arg1) throws DocumentException, InterruptedException {
    String extractedText= webDriver.getwebelement(PageObject.getlocator("IndicativeTax").replace("{paramlink}",arg0)).getText();
    DriverInstance.setVariable(arg1,extractedText);
    }

    @Then("Convert percentage {string} value to decimal and store in {string}")
    public void convertPercentageValueToDecimalAnsStoreIn(String arg0, String arg1) {
        String value ="";
        double decimalValue=0.00;
        if (arg0.contains("SysData")) {
            String key = arg0.split("=>")[1];
            value = DriverInstance.getVariable(key);
            System.out.println("Fetched value: " + value);

            if (value != null && value.contains("%")) {
                value = value.replace("%", "").trim();
            }
            decimalValue = Double.parseDouble(value) / 100;
//            decimalValue = ((long) (decimalValue * 1000)) / 1000.0;
            decimalValue = Math.round(decimalValue * 1000.0) / 1000.0;
        }
        DriverInstance.setVariable(arg1, String.valueOf(decimalValue));
        System.out.println(arg1 + " value is: " + decimalValue);
    }

    @Then("Perform Calculations for {string} value and store in {string}")
    public void performCalculations(String arg0, String arg1) {

        double decimalValue = Double.parseDouble(arg0.replace("%", "")) / 100;
        DriverInstance.setVariable(arg1, String.valueOf(decimalValue));
        System.out.println(decimalValue);
    }

    @Then("{string} {string} value with {string} and store in {string}")
    public void calculateValueWith(String arg0, String arg1, String arg2, String arg3) {
        double arg1_numeric = 0.00;

        if (arg1.contains("SysData")) {
            String key = arg1.split("=>")[1];
            String value = DriverInstance.getVariable(key);

            if (value.contains("%")) {
                value = value.replace("%", "").trim();
                arg1_numeric = Double.parseDouble(value) / 100;
            } else {
                arg1_numeric = Double.parseDouble(value);
            }
        }
        if (arg0.contains("Multiply")) {
            double ag2_numeric = Double.parseDouble(arg2);
            arg1_numeric = arg1_numeric * ag2_numeric;
        }
        DriverInstance.setVariable(arg3, String.valueOf(arg1_numeric));
    }

    @Then("Verify Text displaying as {string} with {string} as {string}")
    public void verifyTextDisplayingAsWithAs(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException {
        WebElement wl;
        if (arg0.contains("SysData")) {
            String Value = arg0.split("=>")[1];
            wl= webDriver.passwebelement((Generic.getlocator("Global_Text").replace("{paramlink}", DriverInstance.getVariable(Value))));
            webDriver.waitUntilElementIsVisible(Generic.getlocator("Global_Text").replace("{paramlink}", DriverInstance.getVariable(Value)));
            webDriver.verifyElementToBePresent(Generic.getlocator("Global_Text").replace("{paramlink}", DriverInstance.getVariable(Value)));
        }
        else{
            wl=webDriver.passwebelement(Generic.getlocator("Global_Text").replace("{paramlink}", arg0));
            webDriver.waitUntilElementIsVisible(Generic.getlocator("Global_Text").replace("{paramlink}", arg0));
            webDriver.verifyElementToBePresent(Generic.getlocator("Global_Text").replace("{paramlink}", arg0));
        }
        //Verify CSS
        String style = wl.getCssValue(arg1);
        if(arg1.equalsIgnoreCase("font-weight")) {
            if (style.equals("700") || style.equalsIgnoreCase("bold")) {
                style="bold";
                webDriver.Stringcomparator(style,arg2);

                System.out.println("Font is bold");
            }
        }
        else {
            webDriver.Stringcomparator(style, arg2);
        }
    }

    @Then("Fuel Surcharge : Verify Fuel Index History column")
    public void fuelSurchargeVerifyFuelIndexHistoryColumn() throws DocumentException, InterruptedException {
        List<WebElement> values = webDriver.getwebelements(PageObject.getlocator("AllFuelIndexValue"));
        List<WebElement> dates = webDriver.getwebelements(PageObject.getlocator("DateFormatted"));


        List<WebElement> rows = webDriver.getwebelements(PageObject.getlocator("TotalGridRow"));;

        for (WebElement row : rows) {
            String border = row.getCssValue("border-bottom");
            System.out.println("Border color: " + border);
        }

        //Date Format Logic
        for (WebElement date : dates) {
            String text = date.getText().trim();

            // Format check
            boolean isValid = text.matches("^[A-Za-z]{3} \\d{1,2}, \\d{4}$");
            System.out.println(text + " -> " + isValid);

            // Alignment check
            String align = date.getCssValue("text-align");
            System.out.println("Alignment: " + align);
        }
        //Number Logic
        for (WebElement val : values) {
            String text = val.getText().replace("\u00A0", " ").trim(); // handle &nbsp;

            // Format check
            boolean isValid = text.matches("^USD \\d+\\.\\d{3}$");
            System.out.println(text + " -> " + isValid);

            // Alignment check
            String align = val.getCssValue("text-align");
            System.out.println("Alignment: " + align);
        }

        //Vertical Alignment
        int size = Math.min(dates.size(), values.size());
        for (int i = 0; i < size; i++) {
            int yDate = dates.get(i).getLocation().getY();
            int yValue = values.get(i).getLocation().getY();
            System.out.println("Dates size: " + dates.size());
            System.out.println("Values size: " + values.size());
            System.out.println("Row " + i + " aligned: " + (yDate == yValue));
        }

    }

    @Then("verify fuel surcharge table")
    public void verifyFuelSurchargeTable(DataTable dataTable) throws DocumentException, InterruptedException {
            List<Map<String, String>> expectedTable = dataTable.asMaps(String.class, String.class);

            List<WebElement> allCells = webDriver.getWebElements(PageObject.getlocator("FuelSurchargeEntries"));

            int columnCount = 4;

            if (allCells.size() % columnCount != 0) {
                throw new RuntimeException("UI table structure is broken!");
            }

            for (int row = 0; row < expectedTable.size(); row++) {

                int baseIndex = row * columnCount;

                // 🔹 Fetch actual UI values
                String actualEntry = allCells.get(baseIndex).getText().trim();
                String actualFrom = normalize(allCells.get(baseIndex + 1).getText());
                String actualTo = normalize(allCells.get(baseIndex + 2).getText());
                String actualPercent = allCells.get(baseIndex + 3).getText().trim();

                // 🔹 Expected values from DataTable
                Map<String, String> expectedRow = expectedTable.get(row);

                String expectedEntry = expectedRow.get("Entry");
                String expectedFrom = expectedRow.get("From Value");
                String expectedTo = expectedRow.get("To Value");
                String expectedPercent;
                
                if (expectedRow.containsKey("Percent") && Objects.nonNull(expectedRow.get("Percent"))
                        && !expectedRow.get("Percent").isEmpty()) {
                    expectedPercent = expectedRow.get("Percent");

                } else if (expectedRow.containsKey("Rate") && Objects.nonNull(expectedRow.get("Rate"))
                        && !expectedRow.get("Rate").isEmpty()) {
                    expectedPercent = expectedRow.get("Rate");
                }
                else{
                    expectedPercent ="";
                }

                // 🔹 Assertions
                Assert.assertEquals(actualEntry, expectedEntry, "Mismatch in Entry at row " + row);
                Assert.assertEquals(actualFrom, expectedFrom, "Mismatch in From Value at row " + row);
                Assert.assertEquals(actualTo, expectedTo, "Mismatch in To Value at row " + row);
                Assert.assertEquals(actualPercent, expectedPercent, "Mismatch in Percent/Rate at row " + row);
            }
        }
    private String normalize(String value) {
        return value.replace("\u00A0", " ").trim();
    }

    @Then("Fuel Surcharge : Get Fuel Index Value from {string} Records and store on {string}")
    public void fuelSurchargeGetFuelIndexValueFromRecords(String arg0, String agr1) throws DocumentException, InterruptedException {
      String text = webDriver.GetText(webDriver.passwebelement(PageObject.getlocator("GettingFuelIndex").replace("{index}",arg0)));
      DriverInstance.setVariable(agr1,text);
    }

    @Then("Fuel Surcharge : Verify Entry Field is Readonly")
    public void fuelSurchargeVerifyEntryFieldIsReadonly() throws DocumentException, InterruptedException {
        WebElement element= webDriver.passwebelement(PageObject.getlocator("EntryFieldReadOnly"));
        String ActualText = webDriver.Getattribute(element, "value");
        Assert.assertEquals(ActualText,"Entry 1");
    }

    @Then("Fuel Surcharge : Verify {string} Field is ediatble")
    public void fuelSurchargeVerifyFieldIsEdiatble(String arg0) throws DocumentException, InterruptedException {
        webDriver.verifyElementToBePresent(PageObject.getlocator("FuelInputField").replace("{paramlink}",arg0));
    }

    @When("Fuel Surcharge : Update Fuel Surcharge Entry")
    public void fuelSurchargeUpdateFuelSurchargeEntry(io.cucumber.datatable.DataTable dataTable) throws DocumentException, InterruptedException, IOException {
        List<Map<String, String>> rows = dataTable.asMaps(String.class, String.class);

        List<WebElement> fromFields = webDriver.getwebelements(PageObject.getlocator("FormValueFields"));
        for (int i = 0; i < rows.size(); i++) {
            String entryId = fromFields.get(i).getAttribute("data-entry-id");
            WebElement from = webDriver.passwebelement(PageObject.getlocator("FuelSurcharge_Entry").replace("{paramlink1}","From_Value").replace("{paramlink2}",entryId));
            System.out.println(PageObject.getlocator("FuelSurcharge_Entry").replace("{paramlink1}","From_Value").replace("{paramlink2}}",entryId));
            WebElement to = webDriver.passwebelement(PageObject.getlocator("FuelSurcharge_Entry").replace("{paramlink1}","To_Value").replace("{paramlink2}",entryId));
            System.out.println(PageObject.getlocator("FuelSurcharge_Entry").replace("{paramlink1}","To_Value").replace("{paramlink2}",entryId));
            WebElement rate = webDriver.passwebelement(PageObject.getlocator("FuelSurcharge_Entry").replace("{paramlink1}","Rate").replace("{paramlink2}",entryId));
            System.out.println(PageObject.getlocator("FuelSurcharge_Entry").replace("{paramlink1}","Rate").replace("{paramlink2}",entryId));

            webDriver.SendKeys(from,rows.get(i).get("From Value"));
            webDriver.SendKeys(to,rows.get(i).get("To Value"));
            webDriver.SendKeys(rate,rows.get(i).get("Rate"));

        }
    }
}