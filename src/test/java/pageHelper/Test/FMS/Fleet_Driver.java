package pageHelper.Test.FMS;

import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;
import org.testng.Assert;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.TimeZone.TimeZoneUpdate;
import utils.xmlreader;

import java.io.File;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Log4j
public class Fleet_Driver {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader Generic;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    Common_Steps cs;
    public Fleet_Driver(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("FMS" + File.separator + "Fleet_Driver.xml");
        Generic = new xmlreader("Generics" + File.separator + "Common.xml");
        cs = new Common_Steps(DriverInstance);
    }

    @Then("Verify Recent Driver Assignment")
    public void verify_recent_driver_assignment(DataTable dataTable) throws DocumentException, InterruptedException {
        boolean matchFound;
        List<Map<String, String>> expectedData = dataTable.asMaps(String.class, String.class);

        List<WebElement> cells = webDriver.getwebelements(pageObject.getlocator("DriverRecentAssignment"));

        int columnSize = 6;

        List<Map<String, String>> actualData = new ArrayList<>();

        for (int i = 0; i < cells.size(); i += columnSize) {

            Map<String, String> row = new HashMap<>();

            row.put("Fleet Asset", cells.get(i).getText().trim());
            row.put("Driver", cells.get(i + 1).getText().trim());
            row.put("Driver Type", cells.get(i + 2).getText().trim());
            row.put("Start Date", cells.get(i + 3).getText().trim());
            row.put("End Date", cells.get(i + 4).getText().trim());
            actualData.add(row);
        }

        // ✅ Validation
        for (Map<String, String> expectedRow : expectedData) {
            String FullDateTime;
            String FullDateTimeEnd;
            String StartDate=expectedRow.get("Start Date");
            String EndDate=expectedRow.get("End Date");
                if (!StartDate.contains("NA")) {
                    String Date = StartDate.split(">")[0];
                    String Time = StartDate.split(">")[1];
                    System.out.println(Date);
                    System.out.println(Time);
                    String FullDate = webDriver.ReturnDateInSpecifiedFormat(Date, "M/d/yyyy");
                    System.out.println(FullDate);
                    FullDateTime = TimeZoneUpdate.convertTime(FullDate, Time, "America/Chicago");
                    System.out.println(FullDateTime);
                } else {
                    FullDateTime = "";
                }
                if (!EndDate.contains("NA")) {
                    if(EndDate.contains("SysData"))
                    {
                        String FullDateEnd =DriverInstance.getVariable(EndDate.split("=>")[1]);
                        FullDateTimeEnd = TimeZoneUpdate.convertTime(FullDateEnd, "America/Chicago");
                        System.out.println(FullDateTimeEnd);
                    }
                    else {
                        String Date1 = EndDate.split(">")[0];
                        String Time1 = EndDate.split(">")[1];
                        System.out.println(Date1);
                        System.out.println(Time1);
                        String FullDateEnd = webDriver.ReturnDateInSpecifiedFormat(Date1, "M/d/yyyy");
                        System.out.println(FullDateEnd);
                        FullDateTimeEnd = TimeZoneUpdate.convertTime(FullDateEnd, Time1, "America/Chicago");
                        System.out.println(FullDateTimeEnd);
                    }
                } else {
                    FullDateTimeEnd = "";
                }
                if(EndDate.contains("SysData"))
                {
                    matchFound = actualData.stream().anyMatch(actual ->
                            actual.get("Fleet Asset").equals(expectedRow.get("Fleet Asset")) &&
                                    actual.get("Driver").equals(expectedRow.get("Driver")) &&
                                    actual.get("Driver Type").equals(expectedRow.get("Driver Type")) &&
                                    actual.get("Start Date").equals(FullDateTime) &&
                                    validateDateWithTolerance(actual.get("End Date"),FullDateTimeEnd,"M/d/yyyy, h:mm:ss a")
                    );
                }
                else {
                    matchFound = actualData.stream().anyMatch(actual ->
                            actual.get("Fleet Asset").equals(expectedRow.get("Fleet Asset")) &&
                                    actual.get("Driver").equals(expectedRow.get("Driver")) &&
                                    actual.get("Driver Type").equals(expectedRow.get("Driver Type")) &&
                                    actual.get("Start Date").equals(FullDateTime) &&
                                    actual.get("End Date").equals(FullDateTimeEnd)
                    );
                }

                if (!matchFound) {
                    throw new AssertionError("Row not found: " + expectedRow);
                }

        }
    }

    public boolean validateDateWithTolerance(String Actual, String Expected, String Timezone)
    {
         webDriver.ToleranceTime(Actual, Expected, Timezone);
         return true;
    }
    @Then("Click on Records having {string} contains {string} with index {string}")
    public void clickOnRecordsHavingContainsWithIndex(String arg0, String arg1, String arg2) throws Exception {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("TableDataContains").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1).replace("{index}", arg2)));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("TableDataContains").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1).replace("{index}", arg2));
        webDriver.safeJavaScriptClick(webDriver.passwebelement(pageObject.getlocator("TableDataContains").replace("{paramlink1}", arg0).replace("{paramlink2}", arg1).replace("{index}", arg2)));
    }

    @Then("Verify No Driver Assignment was showing")
    public void verify_recent_driver_assignment() throws DocumentException, InterruptedException {
        List<WebElement> cells = webDriver.getwebelements(pageObject.getlocator("DriverRecentAssignment"));
        Assert.assertEquals(cells.size(),0,"Driver Assignment are displaying after Delete");
    }

}
