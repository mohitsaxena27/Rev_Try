package utils.Excel;

import org.apache.poi.ss.usermodel.*;
import java.io.*;
import java.nio.charset.StandardCharsets;

public class ExcelToCsvConverter {

    public static void CsvConvertor() {
        String excelFile = System.getProperty("user.dir") + File.separator + "Report" + File.separator + "TestResults.xlsx";
        String csvFile = System.getProperty("user.dir") + File.separator + "Report" + File.separator + "TestResults.csv";

        try (
                Workbook workbook = WorkbookFactory.create(new File(excelFile));
                BufferedWriter writer = new BufferedWriter(
                        new OutputStreamWriter(
                                new FileOutputStream(csvFile),
                                StandardCharsets.UTF_8))
        ) {
            Sheet sheet = workbook.getSheetAt(0); // first sheet
            DataFormatter formatter = new DataFormatter();

            for (Row row : sheet) {
                StringBuilder csvRow = new StringBuilder();

                int lastCellNum = row.getLastCellNum();

                for (int i = 0; i < lastCellNum; i++) {
                    Cell cell = row.getCell(i, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK);

                    String value = formatter.formatCellValue(cell);

                    // Escape CSV values containing comma, quote, or newline
                    if (value.contains(",") || value.contains("\"") || value.contains("\n")) {
                        value = "\"" + value.replace("\"", "\"\"") + "\"";
                    }

                    csvRow.append(value);

                    if (i < lastCellNum - 1) {
                        csvRow.append(",");
                    }
                }

                writer.write(csvRow.toString());
                writer.newLine();
            }

            System.out.println("Conversion completed.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void clearCsvFile() {

        String csvFile = System.getProperty("user.dir") + File.separator + "Report" + File.separator + "TestResults.csv";
        try (FileWriter fw = new FileWriter(csvFile, false)) {
            // Opening with append=false truncates the file
            fw.write("");
            System.out.println("CSV file cleared.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
