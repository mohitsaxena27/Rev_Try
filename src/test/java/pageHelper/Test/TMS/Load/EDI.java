package pageHelper.Test.TMS.Load;

import com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import io.restassured.http.Method;
import lombok.extern.log4j.Log4j;
import org.dom4j.DocumentException;
import org.json.JSONObject;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import org.xmlunit.builder.DiffBuilder;
import org.xmlunit.diff.DefaultNodeMatcher;
import org.xmlunit.diff.Diff;
import org.xmlunit.diff.ElementSelectors;
import pageHelper.Utility.Common_Steps;
import pageHelper.bddDriver;
import utils.Json.JsonArrayComparator;
import utils.Json.JsonComparator;
import utils.JsonTimeUpdater;
import utils.PropertyReader;
import utils.XMLUtils;
import utils.Xml.XmlComparisonUtil;
import utils.xmlreader;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Log4j
public class EDI {
    public webHelper webDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader pageObject;
    public PropertyReader propertyReader = new PropertyReader();
    public EDI(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        pageObject = new xmlreader("TMS" + File.separator + "Load" + File.separator + "EDI.xml");
        xml = new xmlreader("Generics" + File.separator + "Common.xml");
    }
    @Then("Verify {string} {string} {string} count as {string}")
    public void verifyEDICount(String arg0, String arg1, String arg2,String arg3) throws Exception {
        Load_Quote_And_Invoice cm = new Load_Quote_And_Invoice(DriverInstance);
        cm.scrollIntoOnQuoteInvoiceTab(arg0);
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("VerifyTableColumnData").replace("{paramlink}",arg0).replace("{paramlink2}",arg1).replace("{paramlink3}",arg2));
        int count = webDriver.getwebelementscount(pageObject.getlocator("VerifyTableColumnData").replace("{paramlink}",arg0).replace("{paramlink2}",arg1).replace("{paramlink3}",arg2));
        try {
            Assert.assertEquals(String.valueOf(count), arg3, "Count not matched");
        }
        catch (AssertionError e)
        {
            refresh("EDI Transactions");
            webDriver.waitForElementLoad(1);
            Assert.assertEquals(String.valueOf(count), arg3, "Count not matched");
        }
    }
    @Then("Verify {string} {string} is displaying as {string}")
    public void verifyIsDisplayingAs(String arg0, String arg1, String arg2) throws Exception {
        Load_Quote_And_Invoice cm = new Load_Quote_And_Invoice(DriverInstance);
        cm.scrollIntoOnQuoteInvoiceTab(arg0);
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("VerifyTableColumnData").replace("{paramlink}",arg0).replace("{paramlink2}",arg1).replace("{paramlink3}",arg2));
        webDriver.verifyElementToBePresent(pageObject.getlocator("VerifyTableColumnData").replace("{paramlink}",arg0).replace("{paramlink2}",arg1).replace("{paramlink3}",arg2));
    }
    @Then("Verify {string} {string} is not displaying as {string}")
    public void verifyIsDisplayingNotAs(String arg0, String arg1, String arg2) throws DocumentException, InterruptedException {
        webDriver.verifyElementNotToBePresent(pageObject.getlocator("VerifyTableColumnData").replace("{paramlink}",arg0).replace("{paramlink2}",arg1).replace("{paramlink3}",arg2));
    }

    @Then("Select {string} with {string} as {string} and {string} as {string}")
    public void selectWithAsAndAs(String arg0, String arg1, String arg2, String arg3, String arg4) throws Exception {
        Load_Quote_And_Invoice cm = new Load_Quote_And_Invoice(DriverInstance);
        cm.scrollIntoOnQuoteInvoiceTab(arg0);
        System.out.println(pageObject.getlocator("SelectEDIRecords").replace("{paramlink}",arg0).replace("{paramlink2}",arg1).replace("{paramlink3}",arg2).replace("{paramlink4}",arg3).replace("{paramlink5}",arg4));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("SelectEDIRecords").replace("{paramlink}",arg0).replace("{paramlink2}",arg1).replace("{paramlink3}",arg2).replace("{paramlink4}",arg3).replace("{paramlink5}",arg4));
        webDriver.waitForElementLoad(1);
        webDriver.safeJavaScriptClick(webDriver.passwebelement(pageObject.getlocator("SelectEDIRecords").replace("{paramlink}",arg0).replace("{paramlink2}",arg1).replace("{paramlink3}",arg2).replace("{paramlink4}",arg3).replace("{paramlink5}",arg4)));
    }
    @Then("Verify {string} with {string} as {string} and {string} as {string}")
    public void VerifyWithAsAndAs(String arg0, String arg1, String arg2, String arg3, String arg4) throws Exception {
        Load_Quote_And_Invoice cm = new Load_Quote_And_Invoice(DriverInstance);
        cm.scrollIntoOnQuoteInvoiceTab(arg0);
        System.out.println(pageObject.getlocator("SelectEDIRecords").replace("{paramlink}",arg0).replace("{paramlink2}",arg1).replace("{paramlink3}",arg2).replace("{paramlink4}",arg3).replace("{paramlink5}",arg4));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("SelectEDIRecords").replace("{paramlink}",arg0).replace("{paramlink2}",arg1).replace("{paramlink3}",arg2).replace("{paramlink4}",arg3).replace("{paramlink5}",arg4));
        webDriver.waitForElementLoad(1);
        webDriver.verifyElementToBePresent(pageObject.getlocator("SelectEDIRecords").replace("{paramlink}",arg0).replace("{paramlink2}",arg1).replace("{paramlink3}",arg2).replace("{paramlink4}",arg3).replace("{paramlink5}",arg4));

    }
    @Then("Select {string} {string} with {string} as {string} and {string} as {string}")
    public void selectWithAsAndAs(String number, String arg0, String arg1, String arg2, String arg3, String arg4) throws Exception {
        Load_Quote_And_Invoice cm = new Load_Quote_And_Invoice(DriverInstance);
        cm.scrollIntoOnQuoteInvoiceTab(arg0);
        System.out.println(pageObject.getlocator("SelectEDIRecordsWithIndex").replace("{paramlink}",arg0).replace("{paramlink2}",arg1).replace("{paramlink3}",arg2).replace("{paramlink4}",arg3).replace("{paramlink5}",arg4).replace("{index}",number));
        webDriver.waitUntilElementIsVisible(pageObject.getlocator("SelectEDIRecordsWithIndex").replace("{paramlink}",arg0).replace("{paramlink2}",arg1).replace("{paramlink3}",arg2).replace("{paramlink4}",arg3).replace("{paramlink5}",arg4).replace("{index}",number));
        webDriver.waitForElementLoad(1);
        webDriver.safeJavaScriptClick(webDriver.passwebelement(pageObject.getlocator("SelectEDIRecordsWithIndex").replace("{paramlink}",arg0).replace("{paramlink2}",arg1).replace("{paramlink3}",arg2).replace("{paramlink4}",arg3).replace("{paramlink5}",arg4).replace("{index}",number)));
    }

    @Then("Verify {string} with File {string}")
    public void verifyWithFile(String arg0, String arg1,DataTable dt) throws Exception {
        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);

        String actualText= DriverInstance.getVariable(arg0).replace("\n", "").trim();

        String scenarioName= DriverInstance.getScenarioName();
        System.out.println("scenarioName:"+scenarioName);
        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");
        System.out.println("TID:"+TID);
        String Root = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator;
        File file = new File(Root + "TestCaseFiles" + File.separator +TID+ File.separator + arg1);
        String expectedText = readFile(file.getAbsolutePath());
        expectedText = expectedText.replace("\n", "")
                .replace("\r", "")
                .trim();
        ZoneId chicagoZone = ZoneId.of("America/Chicago");
        LocalDate today = LocalDate.now(chicagoZone);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            for (Map.Entry<String, String> entry : details.entrySet()) {
                if (!entry.getKey().equalsIgnoreCase("No Update Required")) {
                    System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                    if (entry.getValue().contains("SysData")) {
                        String value = entry.getValue().split("=>")[1];
                        if(entry.getKey().contains("{"))
                        {
                            expectedText = expectedText.replace(entry.getKey() , DriverInstance.getVariable(value));
                        }
                        else {
                            expectedText = expectedText.replace("{" + entry.getKey() + "}", DriverInstance.getVariable(value));
                        }
                        }
                    else if (entry.getKey().contains("ScratchOrgEmail")) {

                        System.out.println(entry.getKey()+" is the value to be replaced from expected ");
                        String value = propertyReader.readproperty(entry.getValue());
                        System.out.println(entry.getValue()+" is the property and read value is "+value);
                        expectedText = expectedText.replace(entry.getKey(), value);
                    }

                    else if (entry.getKey().contains("OrgID")) {
                        String value = propertyReader.readproperty(entry.getValue());
                        expectedText = expectedText.replace(entry.getKey(), value);
                    }
                     else if (entry.getKey().contains("CurrentDateWithSlash")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("M/d/yyyy"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDateMM/dd/yyyy")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("MM/dd/yyyy"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                     else if (entry.getKey().contains("CurrentDateYYYYMMDD")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDateYYYY/MM/DD")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                     else if (entry.getKey().contains("CurrentDate")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    } else {
                        expectedText = expectedText.replace(entry.getKey(), entry.getValue());
                    }
                }
            }
        }
        actualText = actualText.replaceAll("<auth>.*?</auth>", "");
        Diff diff = XmlComparisonUtil.compareXml(expectedText, actualText);


        System.out.println(expectedText);
        System.out.println(actualText);
        Assert.assertFalse(diff.hasDifferences(),
                "Expected : " + expectedText + " but getting " + actualText + "XML Mismatch Found: " + diff.toString());

    }
    private String normalizeXml(String xml) {
        return xml.replaceAll(">\\s+<", "><")      // remove formatting gaps
                .replaceAll(">\\s+", ">")        // remove leading
                .replaceAll("\\s+<", "<")        // remove trailing
                .trim();
    }
    public  String readFile(String filePath) throws IOException {
        return new String(Files.readAllBytes(Paths.get(filePath)));
    }

    @Then("Verify Json {string} with File {string}")
    public void updateAndVerifyJsonForEDI(String arg0,String arg1, DataTable dt) throws Exception{

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        String actualText= DriverInstance.getVariable(arg0).replace("\n", "").trim();
        JSONObject Actual_request_Json_Object = new JSONObject(actualText);
        Actual_request_Json_Object.remove("AuthenticationData");

        String scenarioName= DriverInstance.getScenarioName();
        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");
        String Root = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator;
        String Path = Root + "TestCaseFiles" + File.separator +TID+ File.separator + arg1;

        String expectedText =readFile(Path);
        ZoneId chicagoZone = ZoneId.of("America/Chicago");
        LocalDate today = LocalDate.now(chicagoZone);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            for (Map.Entry<String, String> entry : details.entrySet()) {
                if (!entry.getKey().equalsIgnoreCase("No Update Required")) {
                    System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                    if (entry.getValue().contains("SysData")) {
                        String value = entry.getValue().split("=>")[1];
                        if(entry.getKey().contains("{"))
                        {
                            expectedText = expectedText.replace(entry.getKey() , DriverInstance.getVariable(value));
                        }
                        else {
                            expectedText = expectedText.replace("{" + entry.getKey() + "}", DriverInstance.getVariable(value));
                        }
                    }
                    else if (entry.getKey().contains("ScratchOrgEmail")) {

                        System.out.println(entry.getKey()+" is the value to be replaced from expected ");
                        String value = propertyReader.readproperty(entry.getValue());
                        System.out.println(entry.getValue()+" is the property and read value is "+value);
                        expectedText = expectedText.replace(entry.getKey(), value);
                    }

                    else if (entry.getKey().contains("OrgID")) {
                        String value = propertyReader.readproperty(entry.getValue());
                        expectedText = expectedText.replace(entry.getKey(), value);
                    }
                    else if (entry.getKey().contains("CurrentDateWithSlash")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("M/d/yyyy"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDateMM/dd/yyyy")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("MM/dd/yyyy"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDateYYYYMMDD")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDateYYYY/MM/DD")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDate")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("WednesdayDate")) {
                        // Get next Wednesday
                        LocalDate nextWednesday = today.with(TemporalAdjusters.nextOrSame(DayOfWeek.WEDNESDAY));
                        String formattedDate = nextWednesday.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        System.out.println(formattedDate);
                        expectedText = expectedText.replace(entry.getKey(), formattedDate);
                    }
                    else {
                        expectedText = expectedText.replace(entry.getKey(), entry.getValue());
                    }
                }
            }
        }
        if(DriverInstance.getVariable("TestCaseTimeZoneDSTEnabled").equalsIgnoreCase("Yes"))
        {
            expectedText= JsonTimeUpdater.updateAllUtcTimes(expectedText);
        }
        System.out.println("Man "+expectedText);
        JSONObject Expected_request_Json_Object = new JSONObject(expectedText);
        // Deep diff using Jackson
        ObjectMapper mapper = new ObjectMapper();
        JsonNode expectedNode = mapper.readTree(Expected_request_Json_Object.toString());
        JsonNode actualNode   = mapper.readTree(Actual_request_Json_Object.toString());
//        System.out.println("Diff: " + expectedNode.equals(actualNode));
//        JSONObject expectedNormalized = new JSONObject(Expected_request_Json_Object.toString());
//        JSONObject actualNormalized   = new JSONObject(Actual_request_Json_Object.toString());
//        Assert.assertTrue(expectedNormalized.similar(actualNormalized), "Assertion failed as Expected is :\n" + Expected_request_Json_Object.toString() + " \nAnd Actual is:\n" + Actual_request_Json_Object);
        boolean result = JsonComparator.compare(expectedNode, actualNode);
        Assert.assertTrue(result,
                "Assertion failed as Expected is :\n" +
                        expectedNode.toPrettyString() +
                        "\nAnd Actual is:\n" +
                        actualNode.toPrettyString());

        ExtentCucumberAdapter.addTestStepLog("<b><span style='font-size:16px;'>Request Payload:</span></b>");


    }

    @Then("TimeZone Specific - Verify Json {string} with File {string}")
    public void updateAndVerifyJson(String arg0,String arg1, DataTable dt) throws Exception{

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        String actualText= DriverInstance.getVariable(arg0).replace("\n", "").trim();
        JSONObject Actual_request_Json_Object = new JSONObject(actualText);
        Actual_request_Json_Object.remove("AuthenticationData");

        String scenarioName= DriverInstance.getScenarioName();
        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");
        String Root = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator;
        String Path;
        ZoneId zone = ZoneId.of("America/Chicago");
        ZonedDateTime now = ZonedDateTime.now(zone);
        boolean isDST = zone.getRules().isDaylightSavings(now.toInstant());
        if (isDST) {
            //2026-03-11T06:15:00+00:00
            System.out.println("Currently CDT (Daylight Saving Time)");
            Path = Root + "TestCaseFiles" + File.separator +TID+ File.separator +"CDT"+ File.separator + arg1;
        }
        else {
            System.out.println("Currently CST (Standard Time)");
            Path = Root + "TestCaseFiles" + File.separator +TID+ File.separator +"CST"+ File.separator + arg1;

        }

        String expectedText =readFile(Path);
        ZoneId chicagoZone = ZoneId.of("America/Chicago");
        LocalDate today = LocalDate.now(chicagoZone);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            for (Map.Entry<String, String> entry : details.entrySet()) {
                if (!entry.getKey().equalsIgnoreCase("No Update Required")) {
                    System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                    if (entry.getValue().contains("SysData")) {
                        String value = entry.getValue().split("=>")[1];
                        if(entry.getKey().contains("{"))
                        {
                            expectedText = expectedText.replace(entry.getKey() , DriverInstance.getVariable(value));
                        }
                        else {
                            expectedText = expectedText.replace("{" + entry.getKey() + "}", DriverInstance.getVariable(value));
                        }
                    }
                    else if (entry.getKey().contains("ScratchOrgEmail")) {

                        System.out.println(entry.getKey()+" is the value to be replaced from expected ");
                        String value = propertyReader.readproperty(entry.getValue());
                        System.out.println(entry.getValue()+" is the property and read value is "+value);
                        expectedText = expectedText.replace(entry.getKey(), value);
                    }

                    else if (entry.getKey().contains("OrgID")) {
                        String value = propertyReader.readproperty(entry.getValue());
                        expectedText = expectedText.replace(entry.getKey(), value);
                    }
                    else if (entry.getKey().contains("CurrentDateWithSlash")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("M/d/yyyy"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDateMM/dd/yyyy")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("MM/dd/yyyy"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDateYYYYMMDD")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDateYYYY/MM/DD")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDate")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("WednesdayDate")) {
                        // Get next Wednesday
                        LocalDate nextWednesday = today.with(TemporalAdjusters.nextOrSame(DayOfWeek.WEDNESDAY));
                        String formattedDate = nextWednesday.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        System.out.println(formattedDate);
                        expectedText = expectedText.replace(entry.getKey(), formattedDate);
                    }
                    else {
                        expectedText = expectedText.replace(entry.getKey(), entry.getValue());
                    }
                }
            }
        }
        if(DriverInstance.getVariable("TestCaseTimeZoneDSTEnabled").equalsIgnoreCase("Yes"))
        {
            expectedText= JsonTimeUpdater.updateAllUtcTimes(expectedText);
        }
        System.out.println("Man "+expectedText);
        JSONObject Expected_request_Json_Object = new JSONObject(expectedText);
        // Deep diff using Jackson
        ObjectMapper mapper = new ObjectMapper();
        JsonNode expectedNode = mapper.readTree(Expected_request_Json_Object.toString());
        JsonNode actualNode   = mapper.readTree(Actual_request_Json_Object.toString());
//        System.out.println("Diff: " + expectedNode.equals(actualNode));
//        JSONObject expectedNormalized = new JSONObject(Expected_request_Json_Object.toString());
//        JSONObject actualNormalized   = new JSONObject(Actual_request_Json_Object.toString());
//        Assert.assertTrue(expectedNormalized.similar(actualNormalized), "Assertion failed as Expected is :\n" + Expected_request_Json_Object.toString() + " \nAnd Actual is:\n" + Actual_request_Json_Object);
        boolean result = JsonComparator.compare(expectedNode, actualNode);
        Assert.assertTrue(result,
                "Assertion failed as Expected is :\n" +
                        expectedNode.toPrettyString() +
                        "\nAnd Actual is:\n" +
                        actualNode.toPrettyString());

        ExtentCucumberAdapter.addTestStepLog("<b><span style='font-size:16px;'>Request Payload:</span></b>");


    }

    @Then("Get Attribute {string} and store into {string} from {string}")
    public void getAttributeFrom(String arg0,String arg4, String arg1) {
            String _Actual=  DriverInstance.getVariable(arg1);
            String AttributeValue= webDriver.getJsonValue(_Actual,arg0);
            System.out.println(AttributeValue);
            DriverInstance.setVariable(arg4,AttributeValue);
    }

    public static boolean compareJson(JsonNode expected, JsonNode actual) {

        Iterator<String> fieldNames = expected.fieldNames();

        while (fieldNames.hasNext()) {

            String field = fieldNames.next();

            JsonNode eNode = expected.get(field);
            JsonNode aNode = actual.get(field);

            if (aNode == null) {
                return false;
            }

            // Mileage comparison
            if (field.equals("mileage")||field.equals("amount")) {
                try {
                    BigDecimal e = new BigDecimal(eNode.asText().replace(",", ""))
                            .setScale(2, RoundingMode.HALF_UP);

                    BigDecimal a = new BigDecimal(aNode.asText().replace(",", ""))
                            .setScale(2, RoundingMode.HALF_UP);

                    if (e.compareTo(a) != 0) {
                        return false;
                    }
                    continue;
                } catch (Exception ignored) {}
            }

            // Time tolerance comparison
            if (field.equals("respondByTime")) {
                try {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");

                    LocalTime eTime = LocalTime.parse(eNode.asText(), formatter);
                    LocalTime aTime = LocalTime.parse(aNode.asText(), formatter);

                    long diff = Math.abs(Duration.between(eTime, aTime).toMinutes());
                    if (diff > 5) { // tolerance
                        return false;
                    }
                    continue;
                } catch (Exception ignored) {}
            }

            // Nested JSON
            if (eNode.isObject()) {
                if (!compareJson(eNode, aNode)) {
                    return false;
                }
            }

            // Normal comparison
            else if (!eNode.equals(aNode)) {
                return false;
            }
        }

        return true;
    }

    @Then("Verify Json Array {string} with File {string}")
    public void updateAndVerifyJsonArrayForEDI(String arg0,String arg1, DataTable dt) throws Exception{

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);
        String actualText= DriverInstance.getVariable(arg0).replace("\n", "").trim();

        String scenarioName= DriverInstance.getScenarioName();
        String TID = scenarioName.trim().split("-")[0].trim().replace(" ","");
        String Root = System.getProperty("user.dir") + File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "Documents" + File.separator;
        String Path = Root + "TestCaseFiles" + File.separator +TID+ File.separator + arg1;
        String expectedText =readFile(Path);
        ZoneId chicagoZone = ZoneId.of("America/Chicago");
        LocalDate today = LocalDate.now(chicagoZone);
        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);
            for (Map.Entry<String, String> entry : details.entrySet()) {
                if (!entry.getKey().equalsIgnoreCase("No Update Required")) {
                    System.out.println("Setting " + entry.getKey() + " to " + entry.getValue());
                    if (entry.getValue().contains("SysData")) {
                        String value = entry.getValue().split("=>")[1];
                        if(entry.getKey().contains("{"))
                        {
                            expectedText = expectedText.replace(entry.getKey() , DriverInstance.getVariable(value));
                        }
                        else {
                            expectedText = expectedText.replace("{" + entry.getKey() + "}", DriverInstance.getVariable(value));
                        }
                    }
                    else if (entry.getKey().contains("ScratchOrgEmail")) {

                        System.out.println(entry.getKey()+" is the value to be replaced from expected ");
                        String value = propertyReader.readproperty(entry.getValue());
                        System.out.println(entry.getValue()+" is the property and read value is "+value);
                        expectedText = expectedText.replace(entry.getKey(), value);
                    }

                    else if (entry.getKey().contains("OrgID")) {
                        String value = propertyReader.readproperty(entry.getValue());
                        expectedText = expectedText.replace(entry.getKey(), value);
                    }
                    else if (entry.getKey().contains("CurrentDateWithSlash")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("M/d/yyyy"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDateMM/dd/yyyy")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("MM/dd/yyyy"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDateYYYYMMDD")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDateYYYY/MM/DD")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("CurrentDate")) {
                        LocalDate expectedDate1 = today.plusDays(Integer.parseInt(entry.getValue()));
                        String formattedDate11 = expectedDate1.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        expectedText = expectedText.replace(entry.getKey(), formattedDate11);
                    }
                    else if (entry.getKey().contains("WednesdayDate")) {
                        // Get next Wednesday
                        LocalDate nextWednesday = today.with(TemporalAdjusters.nextOrSame(DayOfWeek.WEDNESDAY));
                        String formattedDate = nextWednesday.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        System.out.println(formattedDate);
                        expectedText = expectedText.replace(entry.getKey(), formattedDate);
                    }
                    else {
                        expectedText = expectedText.replace(entry.getKey(), entry.getValue());
                    }
                }
            }
        }
        if(DriverInstance.getVariable("TestCaseTimeZoneDSTEnabled").equalsIgnoreCase("Yes"))
        {
            expectedText= JsonTimeUpdater.updateAllUtcTimes(expectedText);
        }
        System.out.println("Man "+expectedText);
        JsonArrayComparator.verifyEdiJsonResponse(actualText,expectedText);
    }



    @Then("Get All Record id- via data-row-key-value")
    public void GetAllRecordID() throws IOException, DocumentException, InterruptedException {
     int count = webDriver.getwebelementscount(pageObject.getlocator("TotalRowforcount"));
     for(int i=1;i<=count;i++)
     {
         String id= webDriver.Getattribute(webDriver.passwebelement(pageObject.getlocator("TotalRowforDelete").replace("{paramlink}",String.valueOf(i))), "data-row-key-value");
         DriverInstance.setVariable("DeleteRecords"+i,id);
     }

    }


    @Then("Remove {string} and Set {string} on to {string}")
    public void removeAndSetOnTo(String arg0, String arg1, String arg2) {

        String text = DriverInstance.getVariable(arg1).replace(arg0, "");
        DriverInstance.setVariable(arg2,text);
    }

    @Then("Store EDI {string}")
    public void storeEDI(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.passwebelement(pageObject.getlocator("EDICreatedBy")));
        String Text =webDriver.GetText(webDriver.passwebelement(pageObject.getlocator("EDICreatedBy")));
        DriverInstance.setVariable(arg0,Text);
    }

    @Then("Manage {string} in {string} Order")
    public void manageInAscendingOrder(String arg0,String arg1) throws Exception {

        if(arg1.equalsIgnoreCase("ascending"))
        {
            int count = webDriver.getwebelementscount(pageObject.getlocator("EDI_Order").replace("{paramlink}",arg0).replace("{paramlink1}","sorted_asc"));
            if(count==0)
            {
                Common_Steps cm = new Common_Steps(DriverInstance);
                cm.clickOnButtonWithTitle(arg0);
            }
        }
        else{
            int count = webDriver.getwebelementscount(pageObject.getlocator("EDI_Order").replace("{paramlink}",arg0).replace("{paramlink1}","sorted_desc"));
            if(count==0)
            {
                Common_Steps cm = new Common_Steps(DriverInstance);
                cm.clickOnButtonWithTitle(arg0);
            }
        }

    }

    @Then("Refresh {string}")
    public void refresh(String arg0) throws DocumentException, InterruptedException {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("EDIRefresh").replace("{paramlink}", arg0)));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("EDIRefresh").replace("{paramlink}", arg0));
        webDriver.ClickOnElement(webDriver.getwebelement(pageObject.getlocator("EDIRefresh").replace("{paramlink}", arg0)));
    }

    @Then("Click on {string} TextArea")
    public void clickOnTextArea(String arg0) throws Exception {
        webDriver.ScrollIntoView(webDriver.getwebelement(pageObject.getlocator("TransactionPayloadTextArea").replace("{paramlink}", arg0)));
        webDriver.WaitforElementtobeclickable(pageObject.getlocator("TransactionPayloadTextArea").replace("{paramlink}", arg0));
        webDriver.safeJavaScriptClick(webDriver.getwebelement(pageObject.getlocator("TransactionPayloadTextArea").replace("{paramlink}", arg0)));
    }


    @Then("Verify {string} for {string} {string} {string} as {string}")
    public void verifyCreatedDateForAs(String arg, String arg0, String arg1, String arg2, String arg3) throws DocumentException, InterruptedException {

        if(arg3.contains("SysData"))
        {
            arg3 = DriverInstance.getVariable(arg3.split("=>")[1]);
        }
        String text =   webDriver.GetText(webDriver.passwebelement(pageObject.getlocator("GetRecordsFromTable").replace("{paramlink}",arg0).replace("{paramlink2}",arg1).replace("{paramlink3}",arg2).replace("{paramlink4}",arg)));
       if(arg.equalsIgnoreCase("Created Date"))
       {
           webDriver.ToleranceTime(text,arg3,"M/d/yyyy, h:mm a");
       }
       else{
           Assert.assertEquals(text,arg3, text+" not matched with "+arg3);
       }
    }


    @Then("Verify EDI Transactions Table")
    public void verifyEDITransactionsTable(DataTable dataTable) throws Exception {
        Load_Quote_And_Invoice cm = new Load_Quote_And_Invoice(DriverInstance);
        cm.scrollIntoOnQuoteInvoiceTab("EDI Transactions");
        webDriver.waitForElementLoad(1);
        List<Map<String, String>> expectedRows = dataTable.asMaps(String.class, String.class);
        for (Map<String, String> row : expectedRows) {
            String Status = row.get("Status");
            String TransactionType = row.get("Transaction Type");
            String Direction = row.get("Direction");
            String Purpose = row.get("Purpose");
            String EDI_Provider = row.get("EDI Provider");
            String Trading_Partner = row.get("Trading Partner");
            String EDI_Location = row.get("EDI Location");
            webDriver.waitUntilElementIsVisible(pageObject.getlocator("EDIRowValue").replace("{paramlink1}", Status).replace("{paramlink2}", TransactionType));
            List<WebElement> cells = webDriver.getwebelements(pageObject.getlocator("EDIRowValue").replace("{paramlink1}", Status).replace("{paramlink2}", TransactionType));
            List<WebElement> LinkCells = webDriver.getwebelements(pageObject.getlocator("EDIRowValueLink").replace("{paramlink1}", Status).replace("{paramlink2}", TransactionType));
            webDriver.waitForElementLoad(2);
           // Map columns (adjust index based on table)
            String actualStatus = cells.get(3).getText().trim();
            String actualTransactionType = cells.get(4).getText().trim();
            String actualDirection = cells.get(6).getText().trim();
            String actualPurpose = cells.get(7).getText().trim();
            String actualEdiProvider = cells.get(8).getText().trim();
            String actualTradingPartner = LinkCells.get(0).getText().trim();
            String actualEdiLocation = LinkCells.get(1).getText().trim();
             System.out.println(actualTransactionType +"and" +TransactionType);
// Assert other details
            Assert.assertEquals(actualStatus,Status,"Status Mismatch");
            Assert.assertEquals(actualTransactionType,TransactionType,"TransactionType Mismatch");
            Assert.assertEquals(actualDirection,Direction,"Direction Mismatch");
            Assert.assertEquals(actualPurpose,Purpose,"Purpose Mismatch");
            Assert.assertEquals(actualEdiProvider,EDI_Provider,"EDI_Provider Mismatch");
            Assert.assertEquals(actualTradingPartner,Trading_Partner,"Trading_Partner Mismatch");
            Assert.assertEquals(actualEdiLocation,EDI_Location,"EDI_Location Mismatch");

        }
    }

}