package utils.Excel;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelUpdater {
    public static void updateStatus1(String scenarioName, String status) {

        String testId = scenarioName.trim().split("-")[0].trim().replace(" ","");
        String path = System.getProperty("user.dir") + File.separator + "Report" + File.separator + "TestResults.xlsx";
        try {
            FileInputStream fis = new FileInputStream(path);
            Workbook wb = new XSSFWorkbook(fis);
            Sheet sheet = wb.getSheetAt(0);

            DataFormatter formatter = new DataFormatter();
            // 🔴 FAIL style
            CellStyle failStyle = wb.createCellStyle();
            failStyle.setFillForegroundColor(IndexedColors.RED.getIndex());
            failStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            // 🟢 PASS style
            CellStyle passStyle = wb.createCellStyle();
            passStyle.setFillForegroundColor(IndexedColors.BRIGHT_GREEN.getIndex());
            passStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            // ⚪ Default style (used to clear previous styles)
            CellStyle defaultStyle = wb.createCellStyle();
            defaultStyle.setFillPattern(FillPatternType.NO_FILL);

            for (Row row : sheet) {
                Cell idCell = row.getCell(0);
                if (idCell != null) {
                    String excelTestId = formatter.formatCellValue(idCell);
                    if (excelTestId.equalsIgnoreCase(testId)) {
                        Cell statusCell = row.getCell(1);
                        if (statusCell == null)
                            statusCell = row.createCell(1);
                        statusCell.setCellValue(status);
                        // ✅ Decide which style to apply
                        CellStyle styleToApply;
                        if (status.equalsIgnoreCase("FAIL")) {
                            styleToApply = failStyle;
                            Cell FailedCell = row.getCell(2);
                            FailedCell.setCellValue("Yes");
                        } else {
                            styleToApply = passStyle; // or defaultStyle if no green needed
                        }
                        // 🔥 Fix: Reset old style before applying new one
                        for (int i = 0; i < row.getLastCellNum(); i++) {
                            Cell cell = row.getCell(i);
                            if (cell == null) {
                                cell = row.createCell(i);
                            }
                            // Remove old style (important for retry)
                            cell.setCellStyle(defaultStyle);
                            // Apply new style
                            cell.setCellStyle(styleToApply);
                        }
                        break;
                    }
                }
            }
            fis.close();
            FileOutputStream fos = new FileOutputStream(path);
            wb.write(fos);
            wb.close();
            fos.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void updateStatus(String scenarioName, String status,String Org, String BrowserName) {
        String testId = "";
        Matcher matcher = Pattern.compile("^\\d+").matcher(scenarioName.trim());
        if (matcher.find()) {
            testId = matcher.group();
        }
        String path = System.getProperty("user.dir") + File.separator + "Report" + File.separator + "TestResults.xlsx";
        try {
            FileInputStream fis = new FileInputStream(path);
            Workbook wb = new XSSFWorkbook(fis);
            Sheet sheet = wb.getSheetAt(0);
            DataFormatter formatter = new DataFormatter();
            // Styles
            Font font = wb.createFont();
            font.setBold(true);

            CellStyle failStyle = wb.createCellStyle();
            failStyle.setFillForegroundColor(IndexedColors.ROSE.getIndex());
            failStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            failStyle.setFont(font);

            CellStyle passStyle = wb.createCellStyle();
            passStyle.setFillForegroundColor(IndexedColors.LIGHT_GREEN.getIndex());
            passStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            passStyle.setFont(font);

            // 🔥 Start from row 1 (skip header)
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {

                Row row = sheet.getRow(i);
                if (row == null) continue;

                Cell idCell = row.getCell(0);
                if (idCell == null) continue;

                String excelTestId = formatter.formatCellValue(idCell)
                        .trim()
                        .replace(" ", "");
                if (excelTestId.equalsIgnoreCase(testId)) {

                    Cell statusCell = row.getCell(1);
                    if (statusCell == null) {
                        statusCell = row.createCell(1);
                    }

                    statusCell.setCellValue(status);

                    if (status.equalsIgnoreCase("FAIL")) {
                        statusCell.setCellStyle(failStyle);
                        Cell FailedCell = row.getCell(2);
                        if (FailedCell == null) {
                            FailedCell = row.createCell(2);
                        }
                        FailedCell.setCellValue("Yes");
                    } else {
                        statusCell.setCellStyle(passStyle);
                    }
                    //Org Name Display
                    Cell OrgCell = row.getCell(3);
                    if (OrgCell == null) {
                        OrgCell = row.createCell(3);
                    }
                    OrgCell.setCellValue(Org);

                    //Browser Name Display
                    Cell BowserCell = row.getCell(4);
                    if (BowserCell == null) {
                        BowserCell = row.createCell(4);
                    }
                    BowserCell.setCellValue(BrowserName);

                    System.out.println("✅ Updated row: " + i);
                    break;
                }
            }

            fis.close();
            FileOutputStream fos = new FileOutputStream(path);
            wb.write(fos);
            wb.close();
            fos.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void resetExecutionStatus() {

        String path = System.getProperty("user.dir") + File.separator + "Report" + File.separator + "TestResults.xlsx";

        try {

            FileInputStream fis = new FileInputStream(path);
            Workbook wb = new XSSFWorkbook(fis);
            Sheet sheet = wb.getSheetAt(0);

            CellStyle defaultStyle = wb.createCellStyle();

            for (Row row : sheet) {

                // Skip header row
                if (row.getRowNum() == 0)
                    continue;

                // Clear Status Column (Column 1)
                Cell statusCell = row.getCell(1);
                Cell retryCell = row.getCell(2);
                Cell ExecutedOrg = row.getCell(3);
                Cell ExecutedBrowser = row.getCell(4);

                if (statusCell != null) {
                    statusCell.setCellValue("");
                }
                if (retryCell != null) {
                    retryCell.setCellValue("");
                }
                if (ExecutedOrg != null) {
                    ExecutedOrg.setCellValue("");
                }
                if (ExecutedBrowser != null) {
                    ExecutedBrowser.setCellValue("");
                }

                // Remove highlight from entire row
                for (int i = 0; i < row.getLastCellNum(); i++) {

                    Cell cell = row.getCell(i);

                    if (cell != null) {
                        cell.setCellStyle(defaultStyle);
                    }
                }
            }

            fis.close();

            FileOutputStream fos = new FileOutputStream(path);
            wb.write(fos);
            wb.close();
            fos.close();

            System.out.println("Excel execution status reset successfully");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void generateSummary() throws InterruptedException {
        Thread.sleep(5000);
        System.out.println("Inside generateSummary()");
        String path = System.getProperty("user.dir") + File.separator + "Report" + File.separator + "TestResults.xlsx";

        try {

            FileInputStream fis = new FileInputStream(path);
            Workbook wb = new XSSFWorkbook(fis);
            Sheet testSheet = wb.getSheet("TestCases");

            int pass = 0;
            int fail = 0;
            int retry = 0;
            int total = 0;
            int skip = 0;

            DataFormatter formatter = new DataFormatter();

            for (Row row : testSheet) {

                if (row.getRowNum() == 0)
                    continue;

                Cell statusCell = row.getCell(1);
                Cell RetryTest = row.getCell(2);


                if (statusCell == null)
                    continue;

                String status = formatter.formatCellValue(statusCell);
                String retryStatus = formatter.formatCellValue(RetryTest);

                if (status.equalsIgnoreCase("PASS"))
                    pass++;
                if (status.equalsIgnoreCase("SKIP"))
                    skip++;

                if (status.equalsIgnoreCase("FAIL"))
                    fail++;

                if (!status.isEmpty())
                    total++;
                if(retryStatus.equalsIgnoreCase("Yes"))
                    retry++;
            }

            double successRate = total == 0 ? 0 : ((double) pass / total) * 100;

            Sheet summarySheet = wb.getSheet("Execution_Summary");

            if (summarySheet != null)
                wb.removeSheetAt(wb.getSheetIndex(summarySheet));

            summarySheet = wb.createSheet("Execution_Summary");

            // ---------- FONT ----------
            Font boldFont = wb.createFont();
            boldFont.setBold(true);

            // ---------- HEADER STYLE ----------
            CellStyle headerStyle = wb.createCellStyle();
            headerStyle.setFont(boldFont);
            headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            // ---------- PASS STYLE ----------
            CellStyle passStyle = wb.createCellStyle();
            passStyle.setFillForegroundColor(IndexedColors.LIGHT_GREEN.getIndex());
            passStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            // ---------- SKIPPED STYLE ----------
            CellStyle skippedStyle = wb.createCellStyle();
            skippedStyle.setFillForegroundColor(IndexedColors.LIGHT_BLUE.getIndex());
            skippedStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            // ---------- Retry STYLE ----------
            CellStyle retryStyle = wb.createCellStyle();
            retryStyle.setFillForegroundColor(IndexedColors.LIGHT_ORANGE.getIndex());
            retryStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            // ---------- FAIL STYLE ----------
            CellStyle failStyle = wb.createCellStyle();
            failStyle.setFillForegroundColor(IndexedColors.ROSE.getIndex());
            failStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            // ---------- TOTAL STYLE ----------
            CellStyle totalStyle = wb.createCellStyle();
            totalStyle.setFillForegroundColor(IndexedColors.LIGHT_CORNFLOWER_BLUE.getIndex());
            totalStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            // ---------- SUCCESS RATE STYLE ----------
            CellStyle rateStyle = wb.createCellStyle();
            rateStyle.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
            rateStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            // ---------- HEADER ----------
            Row header = summarySheet.createRow(0);

            Cell h1 = header.createCell(0);
            h1.setCellValue("Metric");
            h1.setCellStyle(headerStyle);

            Cell h2 = header.createCell(1);
            h2.setCellValue("Value");
            h2.setCellStyle(headerStyle);

            // ---------- TOTAL ----------
            Row totalRow = summarySheet.createRow(1);
            totalRow.createCell(0).setCellValue("Total Tests");
            Cell totalCell = totalRow.createCell(1);
            totalCell.setCellValue(total);
            totalCell.setCellStyle(totalStyle);
            System.setProperty("Total_Test",String.valueOf(total));

            // ---------- PASS ----------
            Row passRow = summarySheet.createRow(2);
            passRow.createCell(0).setCellValue("Passed");
            Cell passCell = passRow.createCell(1);
            passCell.setCellValue(pass);
            passCell.setCellStyle(passStyle);
            System.setProperty("Total_Passed",String.valueOf(pass));

            // ---------- SKIPPED ----------
            Row skippedRow = summarySheet.createRow(3);
            skippedRow.createCell(0).setCellValue("Skipped");
            Cell skippedCell = skippedRow.createCell(1);
            skippedCell.setCellValue(skip);
            skippedCell.setCellStyle(skippedStyle);   // or create a separate skipped style
            System.setProperty("Total_Skipped", String.valueOf(skip));


            // ---------- FAIL ----------
            Row failRow = summarySheet.createRow(4);
            failRow.createCell(0).setCellValue("Failed");
            Cell failCell = failRow.createCell(1);
            failCell.setCellValue(fail);
            failCell.setCellStyle(failStyle);
            System.setProperty("Total_Failed",String.valueOf(fail));


            // ---------- Retry count ----------
            Row Retry = summarySheet.createRow(5);
            Retry.createCell(0).setCellValue("Retry Count");
            Cell retryCell = Retry.createCell(1);
            retryCell.setCellValue(retry);
            retryCell.setCellStyle(retryStyle);
            System.setProperty("Total_retry",String.valueOf(retry));


            // ---------- SUCCESS RATE ----------
            Row rateRow = summarySheet.createRow(6);
            rateRow.createCell(0).setCellValue("Success Rate");
            Cell rateCell = rateRow.createCell(1);
            rateCell.setCellValue(String.format("%.2f%%", successRate));
            rateCell.setCellStyle(rateStyle);

            // ---------- AUTO SIZE ----------
            summarySheet.autoSizeColumn(0);
            summarySheet.autoSizeColumn(1);

            fis.close();

            FileOutputStream fos = new FileOutputStream(path);
            wb.write(fos);
            wb.close();
            fos.close();

            System.out.println("Execution Summary Dashboard Generated");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static boolean needToRunFailedTest(String scenarioName) {

        String testId = "";

        Matcher matcher = Pattern.compile("^\\d+").matcher(scenarioName.trim());
        if (matcher.find()) {
            testId = matcher.group();
        }

        String path = System.getProperty("user.dir")
                + File.separator + "Report"
                + File.separator + "TestResults.xlsx";

        try (FileInputStream fis = new FileInputStream(path);
             Workbook wb = new XSSFWorkbook(fis)) {

            Sheet sheet = wb.getSheetAt(0);
            DataFormatter formatter = new DataFormatter();

            // Skip header row
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {

                Row row = sheet.getRow(i);

                if (row == null) {
                    continue;
                }

                Cell testIdCell = row.getCell(0);

                if (testIdCell == null) {
                    continue;
                }

                String excelTestId = formatter.formatCellValue(testIdCell)
                        .trim()
                        .replace(" ", "");

                if (excelTestId.equalsIgnoreCase(testId)) {

                    // Status column
                    Cell statusCell = row.getCell(1);

                    // Retry Status column
                    Cell retryStatusCell = row.getCell(2);

                    String status = statusCell == null
                            ? ""
                            : formatter.formatCellValue(statusCell).trim();

                    String retryStatus = retryStatusCell == null
                            ? ""
                            : formatter.formatCellValue(retryStatusCell).trim();

                    boolean needToRun =
                            (status.isBlank()
                                    && (retryStatus.isBlank()
                                    || retryStatus.equalsIgnoreCase("Yes")))
                                    || (status.equalsIgnoreCase("FAIL")
                                    && retryStatus.equalsIgnoreCase("Yes"));

                    System.out.println(
                            "TestCaseID: " + testId
                                    + " | Status: " + status
                                    + " | Retry Status: " + retryStatus
                                    + " | Need To Run: " + needToRun
                    );

                    return needToRun;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


}
