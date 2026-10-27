package pageHelper.Test.PayIQ;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.java.After;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import pageHelper.Utility.CommonFunction_Frame;
import pageHelper.Utility.Common_Apis;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

@Log4j
public class PayIQ_Advance {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    Common_Apis ca;
    Common_Steps cs;
    CommonFunction_Frame cff;

    public PayIQ_Advance(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
        pageObject = new xmlreader("PayIQ" + File.separator + "PayIQ_Advance.xml");
        ca = new Common_Apis(DriverInstance);
        cs = new Common_Steps(DriverInstance);
        cff = new CommonFunction_Frame(DriverInstance);
    }

@Then("Set {string} month day {string} into {string}")
public void setMonthDayInto(String monthType, String day, String variableName) {

    ZoneId chicagoZone = ZoneId.of("America/Chicago");

    YearMonth yearMonth = YearMonth.from(

            ZonedDateTime.now(chicagoZone).toLocalDate()

    );

    if (monthType.equalsIgnoreCase("Next")) {

        yearMonth = yearMonth.plusMonths(1);

    } else if (monthType.equalsIgnoreCase("Previous")) {

        yearMonth = yearMonth.minusMonths(1);

    } else if (!monthType.equalsIgnoreCase("Current")) {

        throw new IllegalArgumentException(

                "Invalid month type: " + monthType +

                        ". Expected Current, Next, or Previous."

        );

    }

    LocalDate date;

    // If day is "last", use the last date of the selected month

    if (day.equalsIgnoreCase("last")) {

        date = yearMonth.atEndOfMonth();

    } else {

        int dayOfMonth = Integer.parseInt(day);

        if (dayOfMonth < 1 || dayOfMonth > yearMonth.lengthOfMonth()) {

            throw new IllegalArgumentException(

                    "Invalid day " + dayOfMonth +

                            " for month " + yearMonth

            );

        }

        date = yearMonth.atDay(dayOfMonth);

    }

    String formattedDate = date.format(

            DateTimeFormatter.ofPattern("M/d/yyyy")

    );

    DriverInstance.setVariable(variableName, formattedDate);

    System.out.println(variableName + " = " + formattedDate);

}

    @Then("Store current Pay Advance as {string}")
    public void storeCurrentPayAdvanceAs(String variableName) throws Exception {
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("PayAdvanceHighlightsName"));
        String payAdvanceName = webDriver.GetText(webDriver.getwebelement(pageObject.getlocator("PayAdvanceHighlightsName"))).trim();
        String currentUrl = webDriver.GetCurrentURL();
        String[] urlParts = currentUrl.split("/lightning/r/")[1].split("/");
        String objectName = urlParts[0];
        String recordId = urlParts[1];

        DriverInstance.setVariable(variableName, payAdvanceName);
        DriverInstance.setVariable(variableName + "_Url", currentUrl);
        DriverInstance.setVariable(variableName + "_Object", objectName);
        DriverInstance.setVariable(variableName + "_Id", recordId);
        System.out.println(variableName + " = " + payAdvanceName);
        System.out.println(variableName + "_Object = " + objectName);
        System.out.println(variableName + "_Id = " + recordId);
    }

    @Then("Verify Pay Adjustment with Source {string} is not displayed")
    public void verifyPayAdjustmentWithSourceIsNotDisplayed(String source) throws Exception {
        String resolvedSource = resolve(source);
        String locator = pageObject.getlocator("PayAdjustmentRowBySource").replace("{paramlink}", resolvedSource);
        webDriver.verifyElementNotToBePresent(locator);
    }

    private String resolve(String value) {
        if (value != null && value.contains("SysData=>")) {
            return DriverInstance.getVariable(value.split("=>")[1]);
        }
        return value;
    }



    @Then("Set {string} {string} by {string} and store into {string}")
    public void setBy(String arg0, String arg1, String arg2, String arg3) {
        double expectedValue = 0;
        if(arg0.contains("SysData"))
        {
            arg0= DriverInstance.getVariable(arg0.split("=>")[1]);
        }
        if(arg2.contains("SysData"))
        {
            arg2= DriverInstance.getVariable(arg2.split("=>")[1]);
        }

        // Remove currency and convert to double
        double initialValue = Double.parseDouble(
                arg0.replaceAll("[^0-9.-]", "")
        );

        double incrementValue = Double.parseDouble(
                arg2.replaceAll("[^0-9.-]", "")
        );

        if(arg1.contains("increased")) {
            expectedValue = initialValue + incrementValue;
        }
        else if(arg1.contains("decreased"))
        {
            expectedValue = initialValue - incrementValue;
        }
       DriverInstance.setVariable(arg3, String.valueOf(expectedValue));
    }

    @Then("Sum of {string} and {string} and Store on to {string}")
    public void sumOfAndAndStoreOnTo(String arg0, String arg1, String arg2) {
       if(arg0.contains("SysData"))
       {
           arg0= DriverInstance.getVariable(arg0.split("=>")[1]).replace("USD","").replace(",","").trim();
       }
        if(arg1.contains("SysData"))
        {
            arg1= DriverInstance.getVariable(arg1.split("=>")[1]).replace("USD","").replace(",","").trim();
        }
        double total = Double.parseDouble(arg0)+Double.parseDouble(arg1);
        BigDecimal value = new BigDecimal(total);
        DecimalFormat formatter = new DecimalFormat("#,##0.00");
        String formattedNumber = formatter.format(value);

        if(arg0.contains("USD")) {
            formattedNumber = "USD " + formattedNumber;
        }
        DriverInstance.setVariable(arg2,formattedNumber);
    }
}
