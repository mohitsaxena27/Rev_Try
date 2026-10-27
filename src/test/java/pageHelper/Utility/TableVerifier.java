package pageHelper.Utility;

import core.apiHelper;
import core.baseDriverHelper;
import core.webHelper;
import org.dom4j.DocumentException;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pageHelper.bddDriver;
import utils.PropertyReader;
import utils.xmlreader;

import java.io.File;
import java.util.*;
import java.util.stream.Collectors;

public class TableVerifier {

    public webHelper webDriver;
    public apiHelper apiDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader iframexml;
//    WebDriver driver;
    public xmlreader fe_xml;
    public PropertyReader propertyReader = new PropertyReader();
    static String dir;
    public TableVerifier(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        apiDriver=new baseDriverHelper(DriverInstance.getApiDriver(),DriverInstance.API_RESPONCE_THREAD_LOCAL.get());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
        iframexml=new xmlreader("Generics"+ File.separator+"CommonFrame.xml");
        fe_xml=new xmlreader("FMS"+ File.separator+"Fleet_Equipment.xml");
    }

    public void verifyTableDetails(String tableXpath, List<Map<String, String>> expectedRows, List<String> columnsToVerify) {
        List<Map<String, String>> actualRows = extractTableData(tableXpath);
        System.out.println(actualRows.toString());

        for (Map<String, String> expected : expectedRows) {
            boolean matchFound = actualRows.stream().anyMatch(actual ->
                    partialMatch(expected, actual, columnsToVerify)
            );

            Assert.assertTrue(
                    matchFound,
                    "❌ No matching row found for expected (in given columns): " + expected
            );
        }

        System.out.println("✅ Table verification successful for " + expectedRows.size() + " rows.");
    }

    private Map<String, String> replacePlaceholders(Map<String, String> row) {

        Map<String, String> updatedRow = new HashMap<>();

        for (Map.Entry<String, String> entry : row.entrySet()) {

            String value = entry.getValue();

            if (value.contains("SysData")) {
                value = DriverInstance.getVariable(value.split("=>")[1]);  // Replace with your runtime value
            }
            updatedRow.put(entry.getKey(), value);
        }

        return updatedRow;
    }

    public void verifyTableDetails1(String tableXpath, List<Map<String, String>> expectedRows, List<String> columnsToVerify) {
        List<Map<String, String>> actualRows = extractTableData(tableXpath);
        System.out.println(actualRows.toString());
        // Replace placeholders before verification
        List<Map<String, String>> processedExpectedRows = expectedRows.stream()
                .map(this::replacePlaceholders)
                .toList();


        for (Map<String, String> expected : processedExpectedRows) {
            boolean matchFound = actualRows.stream().anyMatch(actual ->
                    partialMatch(expected, actual, columnsToVerify)
            );

            Assert.assertTrue(
                    matchFound,
                    "❌ No matching row found for expected (in given columns): " + expected
            );
        }

        System.out.println("✅ Table verification successful for " + expectedRows.size() + " rows.");
    }


    public void verifyFinancialTableDetails(String tableXpath, List<Map<String, String>> expectedRows, List<String> columnsToVerify) {
        List<Map<String, String>> actualRows = extractFinancialSummaryTable(tableXpath);
        System.out.println(actualRows.toString());
        for (Map<String, String> expected : expectedRows) {
            boolean matchFound = actualRows.stream().anyMatch(actual ->
                    partialMatch(expected, actual, columnsToVerify)
            );

            Assert.assertTrue(
                    matchFound,
                    "❌ No matching row found for expected (in given columns): " + expected
            );
        }

        System.out.println("✅ Table verification successful for " + expectedRows.size() + " rows.");
    }
    private List<Map<String, String>> extractTableData(String tableXpath) {
        List<Map<String, String>> tableData = new ArrayList<>();

        List<WebElement> rows = bddDriver.getWebDriver().findElements(By.xpath(
                tableXpath + "//tr | " + tableXpath + "//*[@role='row']"
        ));

        for (WebElement row : rows) {
            Map<String, String> rowData = new LinkedHashMap<>();
            List<WebElement> cells = row.findElements(By.xpath(".//*[@role='gridcell' or self::td or self::th]"));

            for (WebElement cell : cells) {
                String label = cell.getAttribute("data-label");
                if (label == null || label.isEmpty()) continue;

                String value = "";
                try {
                    // 1️⃣ Standard direct text
                    value = cell.getText().trim();

                    // 2️⃣ If empty, try nested <a>/<span>/<div> within LWC cells
                    if (value.isEmpty()) {
                        List<WebElement> nestedTexts = cell.findElements(By.xpath(
                                ".//a[normalize-space(text())!=''] | .//span[normalize-space(text())!=''] | .//div[normalize-space(text())!='']"
                        ));

                        // Pick the *deepest* visible, non-empty element text
                        for (WebElement nested : nestedTexts) {
                            String text = nested.getText().trim();
                            if (!text.isEmpty()) {
                                value = text;
                                break;
                            }
                        }
                    }

                    // 3️⃣ Fallback — try 'title' attribute (common in <a title="Stop 1">)
                    if (value.isEmpty()) {
                        String title = cell.getAttribute("title");
                        if (title != null && !title.isEmpty()) {
                            value = title.trim();
                        } else {
                            // Sometimes <a> contains title, not <td>
                            WebElement anchor = cell.findElement(By.xpath(".//a[@title]"));
                            value = anchor.getAttribute("title").trim();
                        }
                    }

                } catch (NoSuchElementException ignored) {}

                rowData.put(label, value);
            }

            if (!rowData.isEmpty()) {
                tableData.add(rowData);
            }
        }

        return tableData;
    }

    private boolean partialMatch(Map<String, String> expected, Map<String, String> actual, List<String> columnsToVerify) {
        Set<String> keysToCheck = (columnsToVerify == null || columnsToVerify.isEmpty())
                ? expected.keySet()
                : new HashSet<>(columnsToVerify);

        for (String key : keysToCheck) {
            if (!expected.containsKey(key)) continue;
            String expVal = expected.get(key).trim();
            String actVal = actual.getOrDefault(key, "").trim();
            if (!expVal.equalsIgnoreCase(actVal)) {
                return false;
            }
        }
        return true;
    }

    private List<String> getFinancialSummaryTableHeaders(String tableXpath) {
        List<WebElement> headers = bddDriver.getWebDriver().findElements(
                By.xpath(tableXpath + "//thead//th//div[@title]")
        );

        List<String> headerNames = new ArrayList<>();
        headerNames.add("Row"); // First column is row label

        for (WebElement h : headers) {
            String text = h.getAttribute("title").trim();
            if (!text.isEmpty()) {
                headerNames.add(text);
            }
        }
        return headerNames;
    }
    private List<Map<String, String>> extractFinancialSummaryTable(String tableXpath) {
        List<Map<String, String>> tableData = new ArrayList<>();
        List<String> headers = getFinancialSummaryTableHeaders(tableXpath);

        List<WebElement> rows = bddDriver.getWebDriver().findElements(
                By.xpath(tableXpath + "//tbody/tr")
        );

        for (WebElement row : rows) {
            Map<String, String> rowData = new LinkedHashMap<>();
            List<WebElement> cells = row.findElements(By.xpath("./td"));

            for (int i = 0; i < cells.size(); i++) {
                String header = headers.get(i);
                String value = normalize(cells.get(i).getText());
                rowData.put(header, value);
            }
            tableData.add(rowData);
        }
        return tableData;
    }
    private String normalize(String value)
    {
         return value == null ? "" :value.replace("\u00A0", " ").replaceAll("\\s+", " ").trim();
    }


    public void verifyTable(String tableName,
                           List<Map<String, String>> expectedRows)
            throws Exception {

        WebElement table = webDriver.passwebelement(
                xml.getlocator("LocateTable")
                        .replace("{paramlink1}", tableName));

        Map<String, Integer> headerMap = getHeaderMap(table);

        System.out.println("======= HEADER MAP =======");
        headerMap.forEach((k, v) -> System.out.println(k + " -> " + v));

        for (Map<String, String> expectedRow : expectedRows) {

            // Validate columns exist
            for (String column : expectedRow.keySet()) {
                if (!headerMap.containsKey(column)) {
                    Assert.fail("Column '" + column + "' not found.\nAvailable Columns : "
                            + headerMap.keySet());
                }
            }

            System.out.println(">>> BEFORE findMatchingRow");
            System.out.println("Expected Row: " + expectedRow);

            WebElement matchedRow = findMatchingRow(table, headerMap, expectedRow);

            System.out.println("<<< AFTER findMatchingRow");
            System.out.println("Matched Row: " + matchedRow);

            StringBuilder error = new StringBuilder();
            error.append("\nExpected row not found\n\n");

            expectedRow.forEach((k, v) ->
                    error.append(k)
                            .append(" : ")
                            .append(resolveVariable(v))
                            .append("\n"));

            Assert.assertNotNull(matchedRow, error.toString());
        }
    }

    /**
     * Build Header Map
     */
    private Map<String, Integer> getHeaderMap(WebElement table) {

        Map<String, Integer> map = new LinkedHashMap<>();

        List<WebElement> headers =
                table.findElements(By.xpath(".//thead//th"));

        int columnIndex = 1;

        for (WebElement header : headers) {

            List<WebElement> labels = header.findElements(
                    By.xpath(".//*[@title]"));

            if (labels.isEmpty()) {
                columnIndex++;
                continue;
            }

            String title = labels.get(0).getAttribute("title");

            if (title != null && !title.trim().isEmpty()) {
                map.put(title.trim(), columnIndex);
            }

            columnIndex++;
        }

        return map;
    }

    /**
     * Search the complete table for one matching row.
     */
//    private WebElement findMatchingRow(WebElement table,
//                                       Map<String, Integer> headerMap,
//                                       Map<String, String> expectedRow) {
//
//        JavascriptExecutor js =
//                (JavascriptExecutor) bddDriver.getWebDriver();
//
//        WebElement scrollable =
//                table.findElement(
//                        By.xpath("./ancestor::div[contains(@class,'slds-scrollable_y')][1]"));
//
//        Set<String> processedRows = new HashSet<>();
//
//        while (true) {
//
//            List<WebElement> rows =
//                    table.findElements(By.xpath(".//tbody/tr"));
//
//            for (WebElement row : rows) {
//
//                System.out.println("\n================ ROW ================");
//
//                boolean matched = true;
//
//                for (Map.Entry<String, String> entry : expectedRow.entrySet()) {
//
//                    String column = entry.getKey();
//                    Integer columnIndex = headerMap.get(column);
//
////                    WebElement cell = row.findElement(By.xpath("./td[" + columnIndex + "]"));
//
//                    String actual = getCellValue(row, columnIndex);
//                    String expected = normalize(resolveVariable(entry.getValue()));
//
//                    System.out.println(column);
//                    System.out.println("Expected : [" + expected + "]");
//                    System.out.println("Actual   : [" + actual + "]");
//                    System.out.println("------------------------");
//
//                    if (!normalize(actual).equals(expected)) {
//                        matched = false;
//                    }
//                }
//
//                if (matched) {
//                    return row;
//                }
//            }
//
//            long top = ((Number) js.executeScript(
//                    "return arguments[0].scrollTop;", scrollable)).longValue();
//
//            long max = ((Number) js.executeScript(
//                    "return arguments[0].scrollHeight-arguments[0].clientHeight;",
//                    scrollable)).longValue();
//
//            if (top >= max)
//                break;
//
//            js.executeScript(
//                    "arguments[0].scrollTop = arguments[0].scrollTop + 250;",
//                    scrollable);
//
//            webDriver.waitForElementLoad(1);
//
//        }
//
//        return null;
//    }


    private WebElement findMatchingRow(
            WebElement table,
            Map<String, Integer> headerMap,
            Map<String, String> expectedRow) {

        JavascriptExecutor js =
                (JavascriptExecutor) bddDriver.getWebDriver();

        WebElement scrollable =
                table.findElement(
                        By.xpath("./ancestor::div[contains(@class,'slds-scrollable_y')][1]"));

        int maxScrollAttempts = 100;
        int scrollAttempt = 0;

        long previousTop = -1;

        while (scrollAttempt < maxScrollAttempts) {

            scrollAttempt++;

            System.out.println(
                    "\n========== TABLE SCROLL ATTEMPT "
                            + scrollAttempt + " ==========");

            List<WebElement> rows =
                    table.findElements(By.xpath(".//tbody/tr"));

            System.out.println("Rows found: " + rows.size());

            for (WebElement row : rows) {

                System.out.println("\n================ ROW ================");

                boolean matched = true;

                for (Map.Entry<String, String> entry : expectedRow.entrySet()) {

                    String column = entry.getKey();
                    Integer columnIndex = headerMap.get(column);

                    String actual =
                            getCellValue(row, columnIndex);

                    String expected =
                            normalize(resolveVariable(entry.getValue()));

                    System.out.println(column);
                    System.out.println("Expected : [" + expected + "]");
                    System.out.println("Actual   : [" + actual + "]");
                    System.out.println("------------------------");

                    if (!normalize(actual).equals(expected)) {
                        matched = false;
                        break;
                    }
                }

                if (matched) {
                    System.out.println(
                            "MATCH FOUND at scroll attempt: "
                                    + scrollAttempt);

                    return row;
                }
            }

            long top = ((Number) js.executeScript(
                    "return arguments[0].scrollTop;",
                    scrollable)).longValue();

            long max = ((Number) js.executeScript(
                    "return arguments[0].scrollHeight - arguments[0].clientHeight;",
                    scrollable)).longValue();

            System.out.println("Current scrollTop : " + top);
            System.out.println("Max scrollTop     : " + max);

            // Already at bottom
            if (top >= max) {

                System.out.println(
                        "Reached bottom of table.");

                break;
            }

            // Scroll
            js.executeScript(
                    "arguments[0].scrollTop = arguments[0].scrollTop + 250;",
                    scrollable);

            webDriver.waitForElementLoad(1);

            // Verify that scrolling actually happened
            long newTop = ((Number) js.executeScript(
                    "return arguments[0].scrollTop;",
                    scrollable)).longValue();

            System.out.println("New scrollTop      : " + newTop);

            if (newTop == top) {

                System.out.println(
                        "WARNING: Scroll position did not change. "
                                + "Stopping table search.");

                break;
            }

            // Extra protection against unexpected scrolling behavior
            if (newTop == previousTop) {

                System.out.println(
                        "WARNING: Same scroll position detected twice. "
                                + "Stopping table search.");

                break;
            }

            previousTop = newTop;
        }

        System.out.println(
                "Expected row NOT FOUND after "
                        + scrollAttempt
                        + " scroll attempts.");

        return null;
    }


    /**
     * Read text from Lightning cell.
     */
    private String getCellText(WebElement cell) {

        String text = cell.getText();

        if (text == null || text.trim().isEmpty())
            text = cell.getAttribute("title");

        if (text == null || text.trim().isEmpty())
            text = cell.getAttribute("innerText");

        return normalize(text);
    }

    private String getCellValue(WebElement row, int columnIndex) {

        List<WebElement> cells = row.findElements(By.xpath("./th | ./td"));

        if (columnIndex > cells.size()) {
            throw new AssertionError(
                    "Column index " + columnIndex + " not found. Available cells: "
                            + cells.size());
        }

        return getCellText(cells.get(columnIndex - 1));
    }
    private String resolveVariable(String value) {

        if (value == null || value.isEmpty())
            return "";

        if (value.startsWith("SysData=>")) {

            String variable =
                    value.replace("SysData=>", "").trim();

            return DriverInstance.getVariable(variable);
        }

        return value;
    }

    /**
     * Normalize text.
     */
    private String normalize1(String text) {

        if (text == null)
            return "";

        return text.replace('\u00A0', ' ')
                .replace("\n", " ")
                .replace("\r", " ")
                .replaceAll("\\s+", " ")
                .trim();
    }

    public void verifyTableInOrder(String tableName, List<Map<String, String>> expectedRows) throws Exception {
        WebElement table = webDriver.passwebelement(xml.getlocator("LocateTable").replace("{paramlink1}", tableName));
        Map<String, Integer> headerMap = getHeaderMap(table);

        List<WebElement> actualRows = table.findElements(By.xpath(".//tbody/tr"));

        if (actualRows.size() < expectedRows.size()) {
            Assert.fail("Expected at least " + expectedRows.size() + " rows, but found " + actualRows.size());
        }

        for (int rowIndex = 0; rowIndex < expectedRows.size(); rowIndex++) {
            WebElement actualRow = actualRows.get(rowIndex);
            Map<String, String> expectedRow = expectedRows.get(rowIndex);
            System.out.println("\n========== VERIFYING ROW " + (rowIndex + 1) + " ==========");

            for (Map.Entry<String, String> entry : expectedRow.entrySet()) {
                String column = entry.getKey();
                if (!headerMap.containsKey(column)) {
                    Assert.fail("Column '" + column + "' not found.\n" + "Available Columns: " + headerMap.keySet());
                }

                Integer columnIndex = headerMap.get(column);
                String actual = normalize(getCellValue(actualRow, columnIndex));

                String expected = normalize(resolveVariable(entry.getValue()));

                System.out.println(column);
                System.out.println("Expected : [" + expected + "]");
                System.out.println("Actual   : [" + actual + "]");

                Assert.assertEquals(actual, expected, "Table row order mismatch at row " + (rowIndex + 1) + ", column '" + column + "'" + "\nExpected: [" + expected + "]" + "\nActual: [" + actual + "]");
            }
        }
    }


public void verifyColumnOrder(String tableName, List<String> expectedColumns) throws Exception {
    WebElement table = webDriver.passwebelement(xml.getlocator("LocateTable").replace("{paramlink1}", tableName));
    Map<String, Integer> headerMap = getHeaderMap(table);
    for (String column : expectedColumns) {
        if (!headerMap.containsKey(column)) {
            Assert.fail("Column '" + column + "' not found.\n" + "Available Columns: " + headerMap.keySet());
        }
    }
    // Find position of first expected column
    int startPosition = headerMap.get(expectedColumns.get(0));
    for (int i = 0; i < expectedColumns.size(); i++) {
        String expectedColumn = expectedColumns.get(i);
        int expectedPosition = startPosition + i;
        Integer actualPosition = headerMap.get(expectedColumn);
        Assert.assertEquals(actualPosition, expectedPosition, "Column order mismatch." + "\nExpected column: " + expectedColumn + "\nExpected position: " + expectedPosition + "\nActual position: " + actualPosition);
    }
}

    public void verifyColumnPresence(String tableName, String columnName, String presence) throws Exception {

        WebElement table = webDriver.passwebelement(xml.getlocator("LocateTable").replace("{paramlink1}", tableName));
        Map<String, Integer> headerMap = getHeaderMap(table);
        boolean columnPresent = headerMap.containsKey(columnName);
        if (presence.equalsIgnoreCase("Present")) {
            Assert.assertTrue(columnPresent, "Column '" + columnName + "' is not present.\n" + "Available Columns: " + headerMap.keySet());

        } else if (presence.equalsIgnoreCase("Not Present")) {
            Assert.assertFalse(columnPresent, "Column '" + columnName + "' is present but should NOT be present.\n" + "Available Columns: " + headerMap.keySet());

        } else {
            Assert.fail("Invalid presence value: '" + presence + "'. Expected 'Present' or 'Not Present'.");
        }
    }

}

