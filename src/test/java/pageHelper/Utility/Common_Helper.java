package pageHelper.Utility;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import core.apiHelper;
import core.baseDriverHelper;
import core.webHelper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.Then;
import io.restassured.response.Response;
import lombok.extern.log4j.Log4j;
import org.apache.pdfbox.cos.COSName;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDResources;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;
import org.apache.pdfbox.text.PDFTextStripper;
import org.dom4j.DocumentException;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pageHelper.bddDriver;
import utils.*;
import utils.Image.PdfLogoValidator;
import utils.MailUtility.maiUtility;
import utils.OnePassword.OnePasswordUtil;

import javax.imageio.ImageIO;
import javax.mail.BodyPart;
import javax.mail.MessagingException;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.NumberFormat;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import static org.testng.Assert.assertTrue;
import static utils.MailUtility.maiUtility.GetMessageContent;
import static utils.MailUtility.maiUtility.getEmailBodyFromMessage;

@Log4j
public class Common_Helper {
    public webHelper webDriver;
    public apiHelper apiDriver;
    private bddDriver DriverInstance;
    public xmlreader xml;
    public xmlreader iframexml;
    public xmlreader fe_xml;
    public PropertyReader propertyReader = new PropertyReader();
    static String dir;
    public Common_Helper(bddDriver contextSteps) throws Exception {
        this.DriverInstance = contextSteps;
        System.out.println(this.DriverInstance);
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        webDriver = new baseDriverHelper(bddDriver.getWebDriver());
        apiDriver=new baseDriverHelper(DriverInstance.getApiDriver(),DriverInstance.API_RESPONCE_THREAD_LOCAL.get());
        xml=new xmlreader("Generics"+ File.separator+"Common.xml");
        iframexml=new xmlreader("Generics"+ File.separator+"CommonFrame.xml");
        fe_xml=new xmlreader("FMS"+ File.separator+"Fleet_Equipment.xml");
    }

    //***************Pdf and Mail Hander *********//
    public static void saveAttachment(BodyPart bodyPart) throws IOException, MessagingException {
        String fileName = bodyPart.getFileName();
        dir = System.getProperty("user.dir")+File.separator+"DownloadedFiles"+File.separator+fileName;
        File file = new File(dir); // Save to "downloads" folder
        try (InputStream is = bodyPart.getInputStream();
             FileOutputStream fos = new FileOutputStream(file)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = is.read(buffer)) != -1) {
                fos.write(buffer, 0, bytesRead);
            }
        }
        System.out.println("Saved PDF: " + file.getAbsolutePath());
    }

    public static boolean deleteAllFilesInDirectory(File directory) {
        if (directory == null || !directory.exists() || !directory.isDirectory()) {
            System.out.println("❌ Invalid directory: " + (directory != null ? directory.getPath() : "null"));
            return false;
        }

        File[] files = directory.listFiles();
        if (files == null || files.length == 0) {
            System.out.println("ℹ️ No files found in: " + directory.getPath());
            return true;
        }

        boolean allDeleted = true;
        for (File file : files) {
            if (file.isFile()) {
                // Skip Help.txt
                if (file.getName().equalsIgnoreCase("Help.txt")||file.getName().equalsIgnoreCase("RevenovaTMS_Logo.png")) {
                    System.out.println("⏭️ Skipped file: " + file.getName());
                    continue;
                }

                boolean deleted = file.delete();
                System.out.println(deleted ? "✅ Deleted file: " + file.getName()
                        : "⚠️ Failed to delete file: " + file.getName());

                if (!deleted) allDeleted = false;
            }
        }

        return allDeleted;
    }

    @Then("Get Pdf content from {string} with Subject {string}")
    public void Get_Pdf_content(String arg0, String arg1) throws Exception {
         if(arg1.contains("{") && arg1.contains("}"))
        {
            int start = arg1.indexOf("{");
            int end = arg1.indexOf("}");
            if (start != -1 && end != -1 && end > start) {
                String before = arg1.substring(0, start);
                String inside = arg1.substring(start + 1, end);
                String after = arg1.substring(end + 1);
                System.out.println("Extracted: " + inside);
                arg1 = before+" "+DriverInstance.getVariable(inside)+" "+after;
            }
        }
        if(arg0.equalsIgnoreCase("Email"))
        {
            if(arg1.contains("=>"))
            {
                String val= arg1.split("=>")[1];
                arg1=arg1.split("=>")[0]+DriverInstance.getVariable(val);
                System.out.println(arg1);
            }
            try {
                maiUtility.GetPdf(arg1);
                webDriver.waitForElementLoad(10);
                // Load PDF document
                PDDocument document = PDDocument.load(new File(dir));
                // Extract text from PDF
                PDFTextStripper pdfStripper = new PDFTextStripper();
                String pdfText = pdfStripper.getText(document);
                DriverInstance.setVariable("PDFText",pdfText);
                // Close the document
                document.close();
            } catch (IOException e) {
                System.err.println("Error reading PDF: " + e.getMessage());
            }
        }
        else if(arg0.equalsIgnoreCase("Preview Attachments"))
        {
            try {
                webDriver.waitForElementLoad(1);
                webDriver.waitUntilElementIsVisible(xml.getlocator("PreviewAttachmentContent"));
                WebElement el = webDriver.getwebelement(xml.getlocator("PreviewAttachmentContent"));
                String url = webDriver.Getattribute(el, "src");
                System.out.println("PDF URL: " + url);
                String contentVersionId = url.substring(url.lastIndexOf("/") + 1);
                if (contentVersionId.contains("?")) {
                    contentVersionId = contentVersionId.substring(0, contentVersionId.indexOf("?"));
                    System.out.println(" contentVersionId "+contentVersionId);
                }
                downloadSalesforcePDF(contentVersionId);
            } catch (NullPointerException e) {
                webDriver.waitUntilElementIsVisible(xml.getlocator("PreviewAttachmentContent"));
                WebElement el = webDriver.getwebelement(xml.getlocator("PreviewAttachmentContent"));
                String url = webDriver.Getattribute(el, "src");
                System.out.println("PDF URL: " + url);
                String contentVersionId = url.substring(url.lastIndexOf("/") + 1);
                if (contentVersionId.contains("?")) {
                    contentVersionId = contentVersionId.substring(0, contentVersionId.indexOf("?"));
                }
                downloadSalesforcePDF(contentVersionId);
            }
        }
        else if(arg0.equalsIgnoreCase("Generate And Preview"))
        {
            //Used only when verifying Table Details - TestcaseID 1932
            WebElement el = webDriver.passwebelement(xml.getlocator("PreviewAttachmentContent"));
            webDriver.waitUntilTheElementIsVisible(el);
            webDriver.ScrollIntoView(el);
            String url = webDriver.Getattribute(el, "src");
            System.out.println("PDF URL: " + url);
            String contentVersionId = url.substring(url.lastIndexOf("/") + 1);
            if (contentVersionId.contains("?")) {
                contentVersionId = contentVersionId.substring(0, contentVersionId.indexOf("?"));
            }
//            String contentVersionId = url.substring(url.lastIndexOf("/download/") + "/download/".length());
            downloadSalesforcePDFAndExtractTableDetails(contentVersionId);
        }
        else if(arg0.equalsIgnoreCase("Generate"))
        {
            //Used only when verifying Table Details - TestcaseID 1932
            WebElement el = webDriver.passwebelement(xml.getlocator("PreviewAttachmentContent"));
            webDriver.waitUntilTheElementIsVisible(el);
            webDriver.ScrollIntoView(el);
            String url = webDriver.Getattribute(el, "src");
            System.out.println("PDF URL: " + url);
            String contentVersionId = url.substring(url.lastIndexOf("/") + 1);
            if (contentVersionId.contains("?")) {
                contentVersionId = contentVersionId.substring(0, contentVersionId.indexOf("?"));
            }
//            String contentVersionId = url.substring(url.lastIndexOf("/download/") + "/download/".length());
            downloadSalesforcePDF(contentVersionId);
        }
        else if(arg0.equalsIgnoreCase("Document"))
        {
            if(arg1.contains("SysData"))
            {
                arg1 =DriverInstance.getVariable(arg1.split("=>")[1]);
            }
            downloadSalesforcePDFUsingID(arg1);
        }
        else if(arg0.equalsIgnoreCase("Visual Force"))
        {
            downloadSalesforcePDFVisualForce();
        }
        else{
            WebElement el = webDriver.passwebelement(xml.getlocator("GettingOriginalUrlfromEmbed"));
            webDriver.waitUntilTheElementIsVisible(el);
            webDriver.ScrollIntoView(el);
            String url= webDriver.Getattribute(el,"original-url");
            try {
                try (InputStream in = new URL(url).openStream();
                     PDDocument document = PDDocument.load(in)) {
                     PDFTextStripper stripper = new PDFTextStripper();
                    String text = stripper.getText(document);
                    DriverInstance.setVariable("PDFText",text);
                    System.out.println("PDF whole content is :"+text);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
    }

    private String normalizePdfText(String text) {
        if (text == null) {
            return "";
        }

        return text
                .replace('\u00A0', ' ')  // NBSP -> normal space
                .replace('\u2007', ' ')  // Figure space
                .replace('\u202F', ' ')  // Narrow NBSP
                .replaceAll("\\s+", " ")
                .trim();
    }

    @Then("Delete Pdf {string} Files after Verification")
    public void Delete_Files(String arg0) throws DocumentException, InterruptedException {
       boolean flag= deleteAllFilesInDirectory(new File(arg0));
       if(flag)
       {
           System.out.println("Files Deleted Successfully");
       }
       else{
           System.out.println("Issue with delete files");

       }
    }
    @Then("Delete {string} after Verification")
    public void Delete_Specific_directory(String arg0) throws DocumentException, InterruptedException {
        boolean flag= deleteAllFilesInDirectory(new File(DriverInstance.getVariable(arg0)));
        if(flag)
        {
            System.out.println("Files Deleted Successfully");
        }
        else{
            System.out.println("Issue with delete files");

        }
    }
    @Then("Verify Pdf contains {string}")
    public void verifyPreviewPdfContains(String arg0) throws DocumentException, InterruptedException {
       if(arg0.contains("SysData"))
       {
           arg0= DriverInstance.getVariable(arg0.split("=>")[1]);
       }
       if(arg0.contains("Date"))
        {
            String number = arg0.replaceAll(".*=>([0-9]+).*", "$1");
            String result = arg0.split(": ")[1];
            ZoneId chicagoZone = ZoneId.of("America/Chicago");
            LocalDate today = LocalDate.now(chicagoZone);
            LocalDate expectedDate = today.plusDays(Integer.parseInt(number));
            String formattedDate1 = expectedDate.format(DateTimeFormatter.ofPattern("MM/dd/yyyy"));
            arg0 = arg0.replace(result, formattedDate1);
        }
        if (DriverInstance.getVariable("PDFText").contains(arg0) ) {
            System.out.println("PDF verification passed!");
        } else {
            Assert.fail("pdf not contains text "+arg0+" but it should ");
            System.out.println("PDF verification failed!");
        }
    }
    @Then("Verify Pdf not contains {string}")
    public void verifyPreviewPdfNotContains(String arg0) throws DocumentException, InterruptedException {
        if (DriverInstance.getVariable("PDFText").contains(arg0) ) {
            System.out.println("PDF verification failed!");
            Assert.fail("pdf contains text "+arg0+" but it should not");
        } else {
            System.out.println("PDF verification passed!");
        }
    }
    //***************File Handler *********//
    public static String readFileAsString(String fileName) throws IOException {
       String path = System.getProperty("user.dir")+File.separator+"src"+File.separator+"test"+File.separator+"resources"+File.separator+"TestCaseFiles"+File.separator+fileName;
        return new String(Files.readAllBytes(Paths.get(path)));
    }

    @Then("Verify Content {string} in the email with Subject {string}")
    public void verifyContentInTheEmailWithSubject(String arg0, String arg1) throws Exception {
        String Value = "";
        if(arg0.contains("SysData"))
          {
              Value = arg0.split("=>")[1];
            String Act= DriverInstance.getVariable(Value);
            arg0=arg0.replace("SysData=>","").replace(Value,Act);
            System.out.println(arg0);
           }
            try {
                String message = GetMessageContent(arg1);
                if(Value.equalsIgnoreCase("Email_Content"))
                {
                    message=message.replace("\n", "")
                            .replace("\r", "")
                            .trim();
                }
                System.out.println(message);
                assertTrue(message.contains(arg0), "Content not matched Actual is "+message +" Expected "+arg0);
            }
            catch (AssertionError e) {
                Common_Apis cm = new Common_Apis(DriverInstance);
                cm.verifyEmailMessageAfterTestStart(arg1.replace("Sandbox:","").trim(),"GetMessage");
                String message = DriverInstance.getVariable("GetMessage");
                assertTrue(message.contains(arg0), "Content not matched");
            }
    }

    @Then("Verify no Content {string} in the email with Subject {string}")
    public void verifyNoContentInTheEmailWithSubject(String arg0, String arg1) throws Exception {
        String Value = "";
        if(arg0.contains("SysData"))
        {
            Value = arg0.split("=>")[1];
            String Act= DriverInstance.getVariable(Value);
            arg0=arg0.replace("SysData=>","").replace(Value,Act);
            System.out.println(arg0);
        }
        try {
            String message = GetMessageContent(arg1);
            if(Value.equalsIgnoreCase("Email_Content"))
            {
                message=message.replace("\n", "")
                        .replace("\r", "")
                        .trim();
            }
            System.out.println(message);
            Assert.assertFalse(message.contains(arg0), "Content matched Actual is "+message +" Expected "+arg0);
        }
        catch (AssertionError e) {
            Common_Apis cm = new Common_Apis(DriverInstance);
            cm.verifyEmailMessageAfterTestStart(arg1.replace("Sandbox:","").trim(),"GetMessage");
            String message = DriverInstance.getVariable("GetMessage");
            Assert.assertFalse(message.contains(arg0), "Content matched");
        }
    }

    @Then("Verify Content {string} in the email body with Subject {string}")
    public void verifyContentInTheEmailBodyWithSubject(String arg0, String arg1) throws Exception {
        String Value = "";
        if(arg0.contains("SysData"))
        {
            Value = arg0.split("=>")[1];
            String Act= DriverInstance.getVariable(Value);
            arg0=arg0.replace("SysData=>","").replace(Value,Act);
            System.out.println(arg0);
        }
        if (arg1.contains("SysData")) {
            String ValueArg1 = arg1.split("=>")[1];
            String ActArg1 = DriverInstance.getVariable(ValueArg1);
            arg1 = arg1.replace("SysData=>", "").replace(ValueArg1, ActArg1);
        }
        try {
            String message = getEmailBodyFromMessage(arg1);
            if(Value.equalsIgnoreCase("Email_Content"))
            {
                message=message.replace("\n", "")
                        .replace("\r", "")
                        .trim();
            }
            System.out.println("Trying to match content from emailbox: "+message);
            assertTrue(message.contains(arg0), "Content not matched Actual is "+message +" Expected "+arg0);
        }
        catch (AssertionError | Exception e) {
            Common_Apis cm = new Common_Apis(DriverInstance);
            System.out.println("Trying to match from Email Messages within TMS UI");
            cm.verifyEmailMessageAfterTestStart(arg1.replace("Sandbox:","").trim(),"GetMessage");
            String message = DriverInstance.getVariable("GetMessage").replace("\n", "")
                    .replace("\r", "")
                    .trim();;
            assertTrue(message.contains(arg0), "Content not matched");
        }
    }

    @Then("Verify Content {string} not in the email with Subject {string}")
    public void verifyContentNotInTheEmailWithSubject(String arg0, String arg1) {
        long startTime = System.currentTimeMillis();
        boolean isPassed = false;
        if(arg0.contains("SysData"))
        {
            String Value = arg0.split("=>")[1];
            String Act= DriverInstance.getVariable(Value);
            arg0=arg0.replace("SysData=>","").replace(Value,Act);
            System.out.println(arg0);
        }
        do {
            try {
                String message = GetMessageContent(arg1);
                Assert.assertFalse(message.contains(arg0), "Content matched but it should not");
                isPassed = true;  // success → exit loop
            }
            catch (AssertionError e) {
                // Wait before retry
                webDriver.waitForElementLoad(40);
            }

        } while (!isPassed &&
                (System.currentTimeMillis() - startTime) < 480_000);

        if(!isPassed)
        {
            Assert.fail("Email Content Not Matched withing 8 Minutes");
        }
    }

    public  void downloadSalesforcePDF( String contentVersionId) {
        try {
            // 1️⃣  Get your Salesforce instance and access token
            Common_Apis ca = new Common_Apis(DriverInstance);
            String accessToken = ca.getSessionID(); // must be a valid OAuth / SOAP session token
            String instanceUrl =PropReader.get("application_url");
            // 2️⃣  Construct VersionData REST URL
            String fileUrl = instanceUrl + "/services/data/v59.0/sobjects/ContentVersion/"
                    + contentVersionId + "/VersionData";
            System.out.println("Fetching PDF from: " + fileUrl);
            // 3️⃣  Make authorized HTTP GET request
            URL url = new URL(fileUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);
            conn.setRequestProperty("Accept", "application/pdf");

            int code = conn.getResponseCode();
            System.out.println("HTTP Response: " + code + " (" + conn.getResponseMessage() + ")");
            System.out.println("Content-Type: " + conn.getContentType());

            if (code != 200) {
                // Print error for debugging
                try (InputStream err = conn.getErrorStream()) {
                    if (err != null) {
                        System.out.println("Error response:\n" + new String(err.readAllBytes()));
                    }
                }
                throw new IOException("Failed to download PDF. HTTP " + code);
            }
            String downloadDir =
                    System.getProperty("user.dir") + File.separator + "DownloadedFiles";
            File dir = new File(downloadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            // 4️⃣  Save file locally for inspection (optional)
            File pdfFile = new File(System.getProperty("user.dir") + File.separator + "DownloadedFiles"+ File.separator +"downloaded_salesforce_file.pdf");
            try (InputStream in = conn.getInputStream();
                 FileOutputStream out = new FileOutputStream(pdfFile)) {
                in.transferTo(out);
            }

            System.out.println("✅ File downloaded: " + pdfFile.getAbsolutePath());

            // 5️⃣  Parse PDF content with Apache PDFBox
            try (InputStream pdfStream = new FileInputStream(pdfFile);
                 PDDocument document = PDDocument.load(pdfStream)) {
                PDFTextStripper stripper = new PDFTextStripper();
                String text = stripper.getText(document);
                System.out.println("✅ Extracted PDF text:");
                System.out.println(text);
                // Save to DriverInstance variable if needed
                DriverInstance.setVariable("PDFText", text);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

public void downloadJsonWithContentDocID(String contentDocumentId, String key) {

    HttpURLConnection conn = null;

    try {
        Common_Apis ca = new Common_Apis(DriverInstance);
        String accessToken = ca.getSessionID();
        String instanceUrl = PropReader.get("application_url");

        /*
         * 1. Get latest ContentVersionId using ContentDocumentId
         */
        String query =
                "SELECT Id, Title, FileExtension, VersionNumber " +
                        "FROM ContentVersion " +
                        "WHERE ContentDocumentId = '" + contentDocumentId + "' " +
                        "ORDER BY VersionNumber DESC " +
                        "LIMIT 1";

        String encodedQuery = URLEncoder.encode(
                query,
                StandardCharsets.UTF_8
        );

        String queryUrl =
                instanceUrl
                        + "/services/data/v59.0/query/?q="
                        + encodedQuery;

        System.out.println("Querying ContentVersion: " + query);

        URL url = new URL(queryUrl);
        conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("GET");
        conn.setRequestProperty(
                "Authorization",
                "Bearer " + accessToken
        );
        conn.setRequestProperty(
                "Accept",
                "application/json"
        );

        int responseCode = conn.getResponseCode();

        if (responseCode != HttpURLConnection.HTTP_OK) {

            try (InputStream err = conn.getErrorStream()) {
                if (err != null) {
                    System.out.println(
                            "Salesforce Query Error:\n"
                                    + new String(
                                    err.readAllBytes(),
                                    StandardCharsets.UTF_8
                            )
                    );
                }
            }

            throw new IOException(
                    "Failed to retrieve ContentVersion. HTTP "
                            + responseCode
            );
        }

        /*
         * 2. Read Salesforce query response
         */
        String response;

        try (InputStream in = conn.getInputStream()) {
            response = new String(
                    in.readAllBytes(),
                    StandardCharsets.UTF_8
            );
        }

        System.out.println(
                "ContentVersion Query Response: " + response
        );

        /*
         * 3. Extract latest ContentVersionId
         */
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode root = objectMapper.readTree(response);

        JsonNode records = root.get("records");

        if (records == null || records.isEmpty()) {
            throw new IOException(
                    "No ContentVersion found for ContentDocumentId: "
                            + contentDocumentId
            );
        }

        JsonNode latestVersion = records.get(0);

        String contentVersionId =
                latestVersion.get("Id").asText();

        String title =
                latestVersion.get("Title").asText();

        String fileExtension =
                latestVersion.has("FileExtension")
                        && !latestVersion.get("FileExtension").isNull()
                        ? latestVersion.get("FileExtension").asText()
                        : "";

        System.out.println(
                "Latest ContentVersionId: "
                        + contentVersionId
        );

        System.out.println("File Title: " + title);
        System.out.println("File Extension: " + fileExtension);

        /*
         * 4. Download VersionData
         */
        String fileUrl =
                instanceUrl
                        + "/services/data/v59.0/sobjects/ContentVersion/"
                        + contentVersionId
                        + "/VersionData";

        System.out.println(
                "Downloading VersionData: " + fileUrl
        );

        conn = (HttpURLConnection) new URL(fileUrl).openConnection();

        conn.setRequestMethod("GET");
        conn.setRequestProperty(
                "Authorization",
                "Bearer " + accessToken
        );
        conn.setRequestProperty(
                "Accept",
                "*/*"
        );

        responseCode = conn.getResponseCode();

        System.out.println(
                "Download Response: "
                        + responseCode
                        + " ("
                        + conn.getResponseMessage()
                        + ")"
        );

        if (responseCode != HttpURLConnection.HTTP_OK) {

            try (InputStream err = conn.getErrorStream()) {
                if (err != null) {
                    System.out.println(
                            "Download Error:\n"
                                    + new String(
                                    err.readAllBytes(),
                                    StandardCharsets.UTF_8
                            )
                    );
                }
            }

            throw new IOException(
                    "Failed to download VersionData. HTTP "
                            + responseCode
            );
        }

        /*
         * 5. Read file content
         */
        byte[] fileBytes;

        try (InputStream in = conn.getInputStream()) {
            fileBytes = in.readAllBytes();
        }

        /*
         * 6. Convert file content to String
         *
         * This is suitable when the Salesforce file is JSON/XML/text.
         */
        String fileContent =
                new String(
                        fileBytes,
                        StandardCharsets.UTF_8
                );

        /*
         * 7. Store file content in framework variable
         */
        DriverInstance.setVariable(
                key,
                fileContent
        );

        System.out.println(
                "File content stored in framework variable: "
                        + key
        );

    } catch (Exception e) {

        throw new RuntimeException(
                "Unable to download file for ContentDocumentId: "
                        + contentDocumentId,
                e
        );

    } finally {

        if (conn != null) {
            conn.disconnect();
        }
    }
}
    public  void downloadSalesforcePDFAndExtractTableDetails( String contentVersionId) {
        try {
            // 1️⃣  Get your Salesforce instance and access token
            Common_Apis ca = new Common_Apis(DriverInstance);
            String accessToken = ca.getSessionID(); // must be a valid OAuth / SOAP session token
            String instanceUrl =PropReader.get("application_url");
            // 2️⃣  Construct VersionData REST URL
            String fileUrl = instanceUrl + "/services/data/v59.0/sobjects/ContentVersion/"
                    + contentVersionId + "/VersionData";
            System.out.println("Fetching PDF from: " + fileUrl);
            // 3️⃣  Make authorized HTTP GET request
            URL url = new URL(fileUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);
            conn.setRequestProperty("Accept", "application/pdf");

            int code = conn.getResponseCode();
            System.out.println("HTTP Response: " + code + " (" + conn.getResponseMessage() + ")");
            System.out.println("Content-Type: " + conn.getContentType());

            if (code != 200) {
                // Print error for debugging
                try (InputStream err = conn.getErrorStream()) {
                    if (err != null) {
                        System.out.println("Error response:\n" + new String(err.readAllBytes()));
                    }
                }
                throw new IOException("Failed to download PDF. HTTP " + code);
            }

            // 4️⃣  Save file locally for inspection (optional)
            String downloadDir =
                    System.getProperty("user.dir") + File.separator + "DownloadedFiles";
            File dir = new File(downloadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            File pdfFile = new File(System.getProperty("user.dir") + File.separator + "DownloadedFiles"+ File.separator +"downloaded_salesforce_file.pdf");
            try (InputStream in = conn.getInputStream();
                 FileOutputStream out = new FileOutputStream(pdfFile)) {
                in.transferTo(out);
            }

            System.out.println("✅ File downloaded: " + pdfFile.getAbsolutePath());
            DriverInstance.setVariable("FilePath",pdfFile.getAbsolutePath());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public  void downloadSalesforcePDFUsingID(String DocumentName) {
        try {
            Common_Apis ca = new Common_Apis(DriverInstance);
            try (InputStream pdfStream = new FileInputStream(ca.DownloadFileWithContentVersion(DocumentName));
                 PDDocument document = PDDocument.load(pdfStream)) {
                PDFTextStripper stripper = new PDFTextStripper();
                String text = stripper.getText(document);
                System.out.println("✅ Extracted PDF text:");
                System.out.println(text);
                // Save to DriverInstance variable if needed
                DriverInstance.setVariable("PDFText", text);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public  void downloadSalesforcePDFVisualForce() {
        try {
            Common_Apis ca = new Common_Apis(DriverInstance);
            try (InputStream pdfStream = new FileInputStream(ca.DownloadFileWithRecordId());
                 PDDocument document = PDDocument.load(pdfStream)) {
                PDFTextStripper stripper = new PDFTextStripper();
                String text = stripper.getText(document);
                text = normalizePdfText(text);
                System.out.println("✅ Extracted PDF text:");
                System.out.println(text);
                // Save to DriverInstance variable if needed
                DriverInstance.setVariable("PDFText", text);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
    @Then("Verify Key {string} with value {string}")
    public void verifyKeyWithValue(String arg0, String arg1) {
        String Expected = DriverInstance.getVariable(arg0);
        if(arg1.contains("SysData"))
        {
            String Value = arg1.split("=>")[1];
            String Act= DriverInstance.getVariable(Value);
            arg1=arg1.replace("SysData=>","").replace(Value,Act);
        }
        Assert.assertEquals(Expected.toLowerCase().trim(),arg1.toLowerCase().trim());
    }


    @Then("Convert Date format {string} from {string} to {string}")
    public void convertDateFormatFromTo(String arg0, String arg1, String arg2) {
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern(arg1);
        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern(arg2);
        LocalDate date = LocalDate.parse(DriverInstance.getVariable(arg0), inputFormatter);
        String formattedDate = date.format(outputFormatter);
        System.out.println(formattedDate);
        DriverInstance.setVariable(arg0,formattedDate);
    }
    @Then("Convert Date Time format {string} from {string} to {string}")
    public void convertDateTimeFormatFromTo(String arg0, String arg1, String arg2) {
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern(arg1, Locale.US);
        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern(arg2,Locale.US);

        LocalDateTime dateTime = LocalDateTime.parse(
                DriverInstance.getVariable(arg0),
                inputFormatter
        );

        String formattedDate = dateTime.format(outputFormatter);

        System.out.println(formattedDate);
        DriverInstance.setVariable(arg0, formattedDate);
    }

    @Then("Verify hover popup for {string}")
    public void verifyHoverPopup(String linkText, DataTable dt) throws InterruptedException, DocumentException {

        List<Map<String, String>> dataRows = dt.asMaps(String.class, String.class);

        // 🔹 Wait for popup
        webDriver.waitUntilTheElementIsVisible(webDriver.passwebelement(xml.getlocator("PopUp")));

        if (!dataRows.isEmpty()) {
            Map<String, String> details = dataRows.get(0);

            for (Map.Entry<String, String> entry : details.entrySet()) {

                String label = entry.getKey();
                String expectedValue = entry.getValue();
                String actualValue = "";

                if (expectedValue.contains("SysData")) {
                    String key = expectedValue.split("=>")[1];
                    expectedValue = DriverInstance.getVariable(key);
                }

                if (label.equalsIgnoreCase("Number")) {
                 //   webDriver.ScrollIntoView(webDriver.getwebelement(fe_xml.getlocator("VerifyOption").replace("{paramlink1}",label).replace("//a","span")));
                    webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(fe_xml.getlocator("VerifyOption").replace("{paramlink}",label).replace("//span","")));
                    actualValue =webDriver.passwebelement(fe_xml.getlocator("VerifyOption").replace("{paramlink}",label).replace("//span","")).getText().trim();
                } else {
                 //   webDriver.ScrollIntoView(webDriver.getwebelement(fe_xml.getlocator("VerifyOption").replace("{paramlink1}",label)));
                    webDriver.waitUntilTheElementIsVisible(webDriver.getwebelement(fe_xml.getlocator("VerifyOption").replace("{paramlink}",label).replace("//span","")));
                    actualValue =webDriver.getwebelement(fe_xml.getlocator("VerifyOption").replace("{paramlink}",label).replace("//span","")).getText().trim();
                    System.out.println("actualValue:"+actualValue);
                }
                Assert.assertEquals(actualValue, expectedValue, "Mismatch for label: " + label);
            }
        }
    }

    @Then("1PW - Set {string} value of {string} on {string}")
    public void pwSetValueOfOn(String arg1, String arg2, String arg3) throws IOException {
        DriverInstance.setVariable(arg3,OnePasswordUtil.getSecret(arg2,arg1));
    }

    @Then("Get Public IP and Store it into {string}")
    public void getPublicIPAndStoreItInto(String arg0) throws IOException {
        URL url = new URL("https://api.ipify.org");
        BufferedReader reader = new BufferedReader(
                new InputStreamReader(url.openStream()));

        String publicIP = reader.readLine();
        reader.close();
        System.out.println("Public IP: " + publicIP);
        DriverInstance.setVariable(arg0,publicIP);
    }

    @Then("Convert {string} into Chicago Timezone with Format {string} and store into {string}")
    public void convertIntoChicagoTimezoneWithFormatAndStoreInto(String arg0, String arg1, String arg2) {

        if(arg0.contains("SysData"))
        {
            arg0=DriverInstance.getVariable(arg0.split("=>")[1]);
        }

        Instant instant = Instant.parse(arg0);

        String chicagoTime = instant
                .atZone(ZoneId.of("America/Chicago"))
                .format(DateTimeFormatter.ofPattern(arg1));

        System.out.println(chicagoTime);
        DriverInstance.setVariable(arg2,chicagoTime);
    }

    @Then("Convert {string} into US Number Format")
    public void convertIntoUSNumberFormat(String arg0) {
        String formatted = NumberFormat.getNumberInstance(Locale.US)
                .format(Integer.parseInt(DriverInstance.getVariable(arg0)));
        System.out.println(formatted);
        DriverInstance.setVariable(arg0,formatted);
    }

    @Then("Convert {string} from Pascal to PSI and store into {string}")
    public void convertPascalToPsi(String sourceVariable, String targetVariable) {
        double pressurePa = Double.parseDouble(DriverInstance.getVariable(sourceVariable));
        double pressurePsi = pressurePa / 6894.757293168;
        DriverInstance.setVariable(targetVariable, String.format("%.2f", pressurePsi));
    }
    @Then("Convert UTC time {string} to Chicago time and store it on to {string}")
    public void convertUtcTimeToChicagoTimeAndStore(String utcTimestamp, String variableName)
    {
        if(utcTimestamp.contains("SysData"))
        {
            utcTimestamp=DriverInstance.getVariable(utcTimestamp.split("=>")[1]);
        }
        Instant instant = Instant.parse(utcTimestamp);
        ZonedDateTime chicagoTime = instant .atZone(ZoneId.of("America/Chicago"));
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("M/d/yyyy, h:mm a");
        String chicagoTimeValue = chicagoTime.format(formatter);
        DriverInstance.setVariable(variableName, chicagoTimeValue);
    }

    @Then("Validate PDF logo matching with {string}")
    public void validatePDFLogoMatchingWith(String arg0) throws IOException {

        String expectedLogoPath =
                System.getProperty("user.dir")
                        + File.separator
                        + "DownloadedFiles"
                        + File.separator
                        + arg0;

        String pdfPath =
                System.getProperty("user.dir")
                        + File.separator
                        + "DownloadedFiles"
                        + File.separator
                        + "downloaded_salesforce_file.pdf";
//        String pdfPath = DriverInstance.getVariable("PDFFilePath");

        double similarityThreshold = 0.75;

        File expectedLogoFile = new File(expectedLogoPath);
        File pdfFile = new File(pdfPath);

        Assert.assertTrue(
                expectedLogoFile.exists(),
                "Expected logo file does not exist: " + expectedLogoPath
        );

        Assert.assertTrue(
                pdfFile.exists(),
                "PDF file does not exist: " + pdfPath
        );

        BufferedImage expectedLogo =
                ImageIO.read(expectedLogoFile);

        Assert.assertNotNull(
                expectedLogo,
                "Unable to read expected logo: " + expectedLogoPath
        );

        boolean logoFound = false;
        double highestSimilarity = 0.0;

        try (PDDocument document = PDDocument.load(pdfFile)) {

            for (PDPage page : document.getPages()) {

                PDResources resources = page.getResources();

                for (COSName xObjectName : resources.getXObjectNames()) {

                    if (!resources.isImageXObject(xObjectName)) {
                        continue;
                    }

                    PDImageXObject pdfImage =
                            (PDImageXObject) resources.getXObject(xObjectName);

                    BufferedImage actualImage =
                            pdfImage.getImage();

                    double similarity =
                            PdfLogoValidator.compareImages(
                                    expectedLogo,
                                    actualImage
                            );

                    highestSimilarity =
                            Math.max(highestSimilarity, similarity);

                    System.out.println(
                            "PDF Image: "
                                    + actualImage.getWidth()
                                    + "x"
                                    + actualImage.getHeight()
                                    + " | Similarity: "
                                    + String.format("%.2f%%",
                                    similarity * 100)
                    );

                    if (similarity >= similarityThreshold) {

                        logoFound = true;

                        System.out.println(
                                "✅ Revenova TMS logo found in PDF."
                                        + " Similarity = "
                                        + String.format("%.2f%%",
                                        similarity * 100)
                        );

                        break;
                    }
                }

                if (logoFound) {
                    break;
                }
            }
        }

        Assert.assertTrue(
                logoFound,
                "❌ Revenova TMS logo was not found in PDF. "
                        + "Required similarity: "
                        + String.format("%.2f%%",
                        similarityThreshold * 100)
                        + ", Highest similarity found: "
                        + String.format("%.2f%%",
                        highestSimilarity * 100)
        );
    }

    @Then("Download Json with ContentDocumentId {string} and store on to {string}")
    public void downloadJsonWithContentDocumentIdAndStoreOnTo(String arg0, String arg1) {
        try{
            downloadJsonWithContentDocID(DriverInstance.getVariable(arg0),arg1);
        } catch (Exception e) {
            downloadJsonWithContentDocID(DriverInstance.getVariable(arg0),arg1);

        }
    }

    @Then("swap $ and - from {string} and store in {string}")
    public void swapDollarAndMinus(String value, String variableName) {

        if (value.contains("SysData")) {
            String key = value.split("=>")[1];
            value = DriverInstance.getVariable(key);
        }

        if (value != null) {
            if (value.startsWith("$-")) {
                value = "-$" + value.substring(2);
            } else if (value.startsWith("-$")) {
                value = "$-" + value.substring(2);
            }
        }

        DriverInstance.setVariable(variableName, value);
    }
}