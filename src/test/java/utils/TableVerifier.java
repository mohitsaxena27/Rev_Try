package utils;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.testng.Assert;

import java.util.*;

public class TableVerifier {

    WebDriver driver;

    public TableVerifier(WebDriver driver) {
        this.driver = driver;
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

        List<WebElement> rows = driver.findElements(By.xpath(
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
        List<WebElement> headers = driver.findElements(
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

        List<WebElement> rows = driver.findElements(
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


}

