package utils;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;

import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URL;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PDFTableExtractor {

    private static final List<String> HEADERS = Arrays.asList(
            "Load Number",
            "Expected Ship Date",
            "Expected Delivery Date",
            "Cargo Summary",
            "Transportation Total",
            "Invoice Total",
            "Billing Account",
            "Billing Method",
            "Created Date",
            "Customer Quote",
            "Disputed"
    );

    // Detect a single row (dynamic Load Number + two dates)
    private static final Pattern ROW_PATTERN = Pattern.compile(
            "(\\S+)\\s+(\\d{2}/\\d{2}/\\d{4})\\s+(\\d{2}/\\d{2}/\\d{4})(.*?)false",
            Pattern.DOTALL
    );

    public static List<Map<String, String>> extractRows(String pdfUrl) {

        try (InputStream in = new FileInputStream(pdfUrl);
             PDDocument document = PDDocument.load(in)) {

            PDFTextStripper stripper = new PDFTextStripper();
            String fullText = stripper.getText(document);

            List<Map<String, String>> rows = new ArrayList<>();

            Matcher m = ROW_PATTERN.matcher(fullText);

            while (m.find()) {
                String loadNumber = m.group(1);
                String shipDate = m.group(2);
                String deliveryDate = m.group(3);
                String remaining = m.group(4);

                rows.add(parseRemainingColumns(loadNumber, shipDate, deliveryDate, remaining));
            }

            return rows;

        } catch (Exception e) {
            throw new RuntimeException("Error extracting PDF rows", e);
        }
    }

    private static Map<String, String> parseRemainingColumns(
            String loadNumber, String shipDate, String deliveryDate, String block) {

        Map<String, String> row = new LinkedHashMap<>();

        row.put("Load Number", loadNumber);
        row.put("Expected Ship Date", shipDate);
        row.put("Expected Delivery Date", deliveryDate);

        // NORMALIZED BLOCK FOR SEARCHING (everything in one line)
        String normalized = block.replaceAll("[\\r\\n]+", " ").replaceAll("\\s{2,}", " ").trim();

        // ===== Cargo Summary =====
        Matcher cargo = Pattern.compile("(Banana.*,?\\s*\\d+\\s*lbs)", Pattern.CASE_INSENSITIVE).matcher(normalized);
        row.put("Cargo Summary", cargo.find() ? cargo.group(1).trim() : "");

        // ===== Transportation Total & Invoice Total =====
        Matcher usd = Pattern.compile("USD\\s?([0-9,]+\\.\\d{2})").matcher(normalized);

        String transportation = "";
        String invoice = "";

        if (usd.find()) transportation = "USD " + usd.group(1);     // 1st USD = Transportation
        if (usd.find()) invoice = "USD " + usd.group(1);            // 2nd USD = Invoice Total

        row.put("Transportation Total", transportation);
        row.put("Invoice Total", invoice);

        // ===== Billing account & method =====
        row.put("Billing Account", normalized.contains("Boston Beans") ? "Boston Beans" : "");
        row.put("Billing Method", normalized.contains("Email") ? "Email" : "");

        // ===== Created Date (ORIGINAL MULTI-LINE BLOCK) =====
        Matcher dt = Pattern.compile(
                "(Mon|Tue|Wed|Thu|Fri|Sat|Sun)\\s+" +
                        "(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\\s+" +
                        "\\d{2}\\s+" +
                        "\\d{2}:\\d{2}:\\d{2}\\s+GMT\\s+\\d{4}",
                Pattern.CASE_INSENSITIVE
        ).matcher(block);

        String createdDate = "";
        if (dt.find()) {
            createdDate = dt.group(0)
                    .replaceAll("[\\r\\n]+", " ")    // Turn multiple lines into 1 line
                    .replaceAll("\\s{2,}", " ")      // Remove extra spaces
                    .trim();
        }

        row.put("Created Date", createdDate);

        // ===== Quote ID =====
        Matcher q = Pattern.compile("\\b(a[A-Za-z0-9]{14}(?:[A-Za-z0-9]{3})?)\\b")
                .matcher(normalized);
        row.put("Customer Quote", q.find() ? q.group(1) : "");

        row.put("Disputed", "false");

        return row;
    }
}
