package utils.MailUtility;

import org.apache.commons.text.StringEscapeUtils;
import org.apache.commons.text.similarity.LevenshteinDistance;
import org.jsoup.Jsoup;
import pageHelper.Utility.Common_Apis;
import pageHelper.Utility.Common_Helper;
import utils.MailConnection;
import utils.PropertyReader;

import java.io.*;
import java.time.Instant;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import javax.mail.search.*;

public class maiUtility {

    static Store store;
    static Folder inbox;
    static Message[] messages;
    public static Instant testStartTime;
    public static PropertyReader propertyReader = new PropertyReader();

    public static void main(String args[]) throws IOException, MessagingException {
      maiUtility ml=new maiUtility();
      verifyCC("Sandbox: Carrier Removal Notification","testautomation3602025@gmail.com");

   }
    public void SendEmail(String m,String filepath) throws IOException {
        String username = propertyReader.readproperty("EmailID");
        String password = propertyReader.readproperty("Email_App_Passowrd");
        String to = propertyReader.readproperty("ToEmailList");

        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");

            Session session = Session.getInstance(props,
                    new javax.mail.Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(username, password);
                        }
                    });
         MimeMessage message = new MimeMessage(session);

         // Set From: header field of the header.
         message.setFrom(new InternetAddress(username));

         // Set To: header field of the header.
         //message.setRecipient(Message.RecipientType.TO,new InternetAddress(to));
         message.setRecipients(Message.RecipientType.TO,to);
         //message.setRecipient(Message.RecipientType.TO,new InternetAddress("pranav.m@360logica.com"));
         // Set Subject: header field
         message.setSubject("Automation Script Execution Report");

         // Create the message part 
         BodyPart messageBodyPart = new MimeBodyPart();

         // Fill the message
         messageBodyPart.setContent(m,"text/html");

         // Create a multipar message
         Multipart multipart = new MimeMultipart();

         // Set text message part
         multipart.addBodyPart(messageBodyPart);

         // Part two is attachment
         messageBodyPart = new MimeBodyPart();
         String filename = filepath;
         DataSource source = new FileDataSource(filename);
         messageBodyPart.setDataHandler(new DataHandler(source));
         messageBodyPart.setFileName(filename);
         multipart.addBodyPart(messageBodyPart);

         // Send the complete message parts
         message.setContent(multipart );

         // Send message
         Transport.send(message);
         System.out.println("Sent message successfully....");
      } catch (MessagingException mex) {
         mex.printStackTrace();
      }
   }
    public void SendEmail(String m, String filepath1, String filepath2) throws IOException {
        String username = propertyReader.readproperty("EmailID");
        String password = propertyReader.readproperty("Email_App_Passowrd");
        String to = propertyReader.readproperty("ToEmailList");

        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");

            Session session = Session.getInstance(props,
                    new javax.mail.Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(username, password);
                        }
                    });

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, to);
            message.setSubject("Automation Script Execution Report");

            Multipart multipart = new MimeMultipart();

            // ✅ Email Body
            BodyPart bodyPart = new MimeBodyPart();
            bodyPart.setContent(m, "text/html");
            multipart.addBodyPart(bodyPart);

            // ✅ Attachment 1
            MimeBodyPart attachment1 = new MimeBodyPart();
            String zippedFilePath = zipFile(filepath1);
            Thread.sleep(30000);
            DataSource source1 = new FileDataSource(zippedFilePath);
            attachment1.setDataHandler(new DataHandler(source1));
            attachment1.setFileName(new File(zippedFilePath).getName());
            multipart.addBodyPart(attachment1);

            System.out.println("=== EMAIL DEBUG START ===");
            System.out.println("Username: " + username);
            System.out.println("To: " + to);
            System.out.println("Password present: " + (password != null));
            System.out.println("File1 exists: " + new File(filepath1).exists());
            System.out.println("File1 exists: " + new File(zippedFilePath).exists());
            System.out.println("File2 exists: " + new File(filepath2).exists());
            System.out.println("=== EMAIL DEBUG END ===");

            // ✅ Attachment 2
            MimeBodyPart attachment2 = new MimeBodyPart();
            DataSource source2 = new FileDataSource(filepath2);
            attachment2.setDataHandler(new DataHandler(source2));
            attachment2.setFileName(new File(filepath2).getName());
            multipart.addBodyPart(attachment2);

            message.setContent(multipart);

            Transport.send(message);
            System.out.println("Sent message successfully....");

        } catch (MessagingException mex) {
            mex.printStackTrace();
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }
    public static String zipFile(String sourceFilePath) throws IOException {
        String zipFilePath = sourceFilePath + ".zip";

        FileOutputStream fos = new FileOutputStream(zipFilePath);
        ZipOutputStream zipOut = new ZipOutputStream(fos);

        File fileToZip = new File(sourceFilePath);
        FileInputStream fis = new FileInputStream(fileToZip);

        ZipEntry zipEntry = new ZipEntry(fileToZip.getName());
        zipOut.putNextEntry(zipEntry);

        byte[] bytes = new byte[1024];
        int length;
        while ((length = fis.read(bytes)) >= 0) {
            zipOut.write(bytes, 0, length);
        }

        zipOut.close();
        fis.close();
        fos.close();

        return zipFilePath;
    }
    public static void startTest()
    {
        testStartTime = Instant.now();
    }
    public static Message waitForNewMessageBySubject(
            String subject) throws Exception {
        int timeoutSeconds = 200;
        if(propertyReader.readproperty("MailProvider").equalsIgnoreCase("IMAP")) {
            return GmailUtil.waitForNewMessageBySubject(subject, testStartTime, timeoutSeconds);
        }
        else{
            return  GmailReader.convertToJavaMailMessage(GmailReader.waitForNewMessageBySubject(subject,testStartTime,timeoutSeconds));
        }
    }

    public static synchronized utils.MailConnection connectInbox() throws Exception {

        Properties props = new Properties();
        props.put("mail.store.protocol", "imaps");
        props.put("mail.imaps.host", "imap.gmail.com");
        props.put("mail.imaps.port", "993");
        props.put("mail.imaps.ssl.enable", "true");

        // Increased stability configs
        props.put("mail.imaps.connectiontimeout", "30000");
        props.put("mail.imaps.timeout", "30000");
        props.put("mail.imaps.writetimeout", "30000");
        props.put("mail.imaps.keepalive", "true");

        // Optional: enable debug (VERY useful on Jenkins)
        props.put("mail.debug", "true");

        String username = propertyReader.readproperty("EmailID");
        String password = propertyReader.readproperty("Email_App_Passowrd");

        int retries = 3;
        int waitTime = 5000;

        while (retries > 0) {
            Store store = null;
            Folder inbox = null;

            try {
                Session session = Session.getInstance(props); // NEW session each retry

                store = session.getStore("imaps");
                store.connect("imap.gmail.com", username, password);

                inbox = store.getFolder("INBOX");
                inbox.open(Folder.READ_ONLY);

                return new MailConnection(store, inbox);

            } catch (MessagingException e) {
                retries--;

                System.out.println("IMAP connection failed. Attempts left: " + retries);
                e.printStackTrace();

                if (retries == 0) throw e;

                // Exponential backoff 👇
                Thread.sleep(waitTime);
                waitTime *= 2; // 5s → 10s → 20s
            }
        }

        throw new RuntimeException("Unable to connect to mailbox");
    }
    public static String getLink(String Subject,String Linkname) throws Exception
    {
       String Link = "";
        Message message=waitForNewMessageBySubject(Subject);
       try{
            String emailContent = getTextFromMessage(message);
            Link= extractAndPrintLinks1(emailContent,Linkname);
        }
        catch (Exception e) {
        e.printStackTrace();
        }
         return  Link;

    }
//    public static String getLinkUrlFromEmail(String emailBody, String linkName) {
//        String regex = "(?i)" + Pattern.quote(linkName)
//                + "\\s*<\\s*(https?://[^\\s>]+)\\s*>";
//
//        Pattern pattern = Pattern.compile(regex);
//        Matcher matcher = pattern.matcher(emailBody);
//
//        if (matcher.find()) {
//            return matcher.group(1);
//        }
//
//        return null;
//    }
    public static String getLinkUrlFromEmail(String emailBody, String linkName) {

        if (emailBody == null || linkName == null) {
            return null;
        }

        String regex = "(?is)"
                + Pattern.quote(linkName.trim())
                + "\\s*<\\s*(https?://[^\\s<>]+)\\s*>";

        Matcher matcher = Pattern.compile(regex).matcher(emailBody);

        return matcher.find() ? matcher.group(1) : null;
    }
   public static String GetLinkAndPdf(String Subject, String LinkName) throws Exception {
         {
           String Link="";
             Message message=waitForNewMessageBySubject(Subject);
            try {

//                for (Message message : GetMessage(Subject)) {
                    String emailContent = getTextFromMessage(message);
                    // Extract and print links from email content
                    Link= extractAndPrintLinks1(emailContent,LinkName);

                  if (message.getContentType().contains("multipart")) {
                     Multipart multiPart = (Multipart) message.getContent();
                     for (int i = 0; i < multiPart.getCount(); i++) {
                        BodyPart bodyPart = multiPart.getBodyPart(i);
                        if (Part.ATTACHMENT.equalsIgnoreCase(bodyPart.getDisposition()) &&
                                bodyPart.getFileName().endsWith(".pdf")) {

                           // Save the PDF attachment
                           saveAttachment(bodyPart);
                        }
                     }
                  }
                  
//               }
            } catch (Exception e) {
               e.printStackTrace();
            }
            return  Link;
         }
      }
   public static void GetPdf(String Subject) throws Exception {
         {
             Message message=waitForNewMessageBySubject(Subject);
            try {
                  if (message.getContentType().contains("multipart")) {
                     Multipart multiPart = (Multipart) message.getContent();
                     for (int i = 0; i < multiPart.getCount(); i++) {
                        BodyPart bodyPart = multiPart.getBodyPart(i);
                        if (Part.ATTACHMENT.equalsIgnoreCase(bodyPart.getDisposition()) &&
                                bodyPart.getFileName().endsWith(".pdf")) {
                           // Save the PDF attachment
                           Common_Helper.saveAttachment(bodyPart);
                        }
                     }
                  }
            } catch (Exception e) {
               e.printStackTrace();
            }
         }
      }
    public static boolean verifyCC(String Subject,String personalGmail) throws MessagingException {
        try {
             Message latestMessage=waitForNewMessageBySubject(Subject);
            System.out.println("Checking CC in latest email: " + latestMessage.getSubject());
            Address[] ccAddresses = latestMessage.getRecipients(Message.RecipientType.CC);
            if (ccAddresses != null) {
                for (Address cc : ccAddresses) {
                    if (cc.toString().contains(personalGmail)) { // case-insensitive match
                        System.out.println("Personal Gmail is CCed: " + personalGmail);
                        return true; // stop immediately when found
                    }
                }
            }
            System.out.println(" Personal Gmail NOT CCed: " + personalGmail);
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean verifyTo(String Subject,String personalGmail) throws MessagingException {
        try {
            Message latestMessage=waitForNewMessageBySubject(Subject);
            System.out.println("Checking TO in latest email: " + latestMessage.getSubject());
            Address[] ccAddresses = latestMessage.getRecipients(Message.RecipientType.TO);
            if (ccAddresses != null) {
                for (Address cc : ccAddresses) {
                    if (cc.toString().contains(personalGmail)) { // case-insensitive match
                        System.out.println("Personal Gmail is not present in TO: " + personalGmail);
                        return true; // stop immediately when found
                    }
                }
            }
            System.out.println("Personal Gmail is not present in TO" + personalGmail);
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static String verifyAttachmentByName(String subject, String expectedFileName) {

        boolean attachmentTypeFound = false;

        try {

            Message message = waitForNewMessageBySubject(subject);
            System.out.println("Checking latest email: " + message.getSubject());

            if (message.getContentType().contains("multipart")) {

                Multipart multiPart = (Multipart) message.getContent();

                String expectedExtension = expectedFileName.substring(expectedFileName.lastIndexOf("."));

                for (int i = 0; i < multiPart.getCount(); i++) {

                    BodyPart bodyPart = multiPart.getBodyPart(i);

                    if (Part.ATTACHMENT.equalsIgnoreCase(bodyPart.getDisposition())) {

                        String filename = bodyPart.getFileName();

                        if (filename != null && filename.endsWith(expectedExtension)) {

                            attachmentTypeFound = true;
                            if (filename.equalsIgnoreCase(expectedFileName)) {
                                System.out.println("✔ Attachment Verified: " + filename);
                                return "Valid";
                            } else {
                                System.out.println("Attachment name mismatch: " + filename);
                            }
                        }
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        if (attachmentTypeFound) {
            return "Invalid";  // same type found but wrong name
        }

        return "No"; // attachment type not found
    }

    public static String verifyAttachmentByNameEither(String subject, String expectedFileName, String expectedFile2) {

        boolean attachmentTypeFound = false;

        try {

            Message message = waitForNewMessageBySubject(subject);
            System.out.println("Checking latest email: " + message.getSubject());

            if (message.getContentType().contains("multipart")) {

                Multipart multiPart = (Multipart) message.getContent();

                String expectedExtension = expectedFileName.substring(expectedFileName.lastIndexOf("."));

                for (int i = 0; i < multiPart.getCount(); i++) {

                    BodyPart bodyPart = multiPart.getBodyPart(i);

                    if (Part.ATTACHMENT.equalsIgnoreCase(bodyPart.getDisposition())) {

                        String filename = bodyPart.getFileName();

                        if (filename != null && filename.endsWith(expectedExtension)) {

                            attachmentTypeFound = true;
                            if (filename.equalsIgnoreCase(expectedFileName)) {
                                System.out.println("✔ Attachment Verified: " + filename);
                                return "Valid";
                            }
                            else if (filename.equalsIgnoreCase(expectedFile2)) {
                                System.out.println("✔ Attachment Verified: " + filename);
                                return "Valid";
                            }
                            else {
                                System.out.println("Attachment name mismatch: " + filename);
                            }
                        }
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        if (attachmentTypeFound) {
            return "Invalid";  // same type found but wrong name
        }

        return "No"; // attachment type not found
    }


    public static String GetMessageContent(String Subject) {
        String emailContent = "";
        try {
            Message message=waitForNewMessageBySubject(Subject);
            System.out.println("Checking latest email: " + message.getSubject());
             emailContent = getTextFromMessageAlwaysReturnText(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println(emailContent);
       return emailContent;
    }
    public static boolean matchTemplateWithThreshold(String Subject, String regexTemplate) {
        // First normalize email body (trim spaces, lowercase if needed)
        String emailBody=GetMessageContent(Subject);

        String normalizedTemplate = regexTemplate.trim();
        String normalizedEmail = emailBody.trim();

        // Regex check (rough filter for structure)
        Pattern pattern = Pattern.compile(normalizedTemplate, Pattern.DOTALL);
        Matcher matcher = pattern.matcher(normalizedEmail);

        if (matcher.matches()) {
            System.out.println("Template matched 100% by regex!");
            return true;
        } else {
            // If regex fails, measure similarity
            LevenshteinDistance ld = new LevenshteinDistance();
            int distance = ld.apply(normalizedTemplate, normalizedEmail);

            int maxLen = Math.max(normalizedTemplate.length(), normalizedEmail.length());
            double similarity = 1 - ((double) distance / maxLen);

            System.out.println("Similarity % = " + (similarity * 100));

            if (similarity >= 0.80) { // 80% threshold
                System.out.println("Template matched with >= 80% similarity!");
                return true;
            } else {
                System.out.println("Template did not match!");
                return false;
            }
        }
    }
    public static String  saveAttachment(BodyPart bodyPart) throws IOException, MessagingException {
         String fileName = bodyPart.getFileName();
          String dir = System.getProperty("user.dir")+File.separator+"DownloadedFiles"+File.separator+fileName;
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
         return file.getAbsolutePath();
      }
    public static String getTextFromMessage(Message message) throws Exception {
      if (message.isMimeType("text/plain")) {
         return message.getContent().toString();
      } else if (message.isMimeType("text/html")) {
         return message.getContent().toString();
      } else if (message.isMimeType("multipart/*")) {
         MimeMultipart mimeMultipart = (MimeMultipart) message.getContent();
         return getTextFromMimeMultipart(mimeMultipart);
      }
      return "";
   }
    public static String getEmailBodyFromMessage(String subject) throws Exception {
        String emailContent = "";

        try {
            Message message = waitForNewMessageBySubject(subject);
            System.out.println("Checking latest email: " + message.getSubject());

            Object content = message.getContent();

            if (content instanceof String) {
                emailContent = content.toString();
            }
            else if (content instanceof MimeMultipart) {
                MimeMultipart mimeMultipart = (MimeMultipart) content;
                emailContent = getTextFromMimeMultipart(mimeMultipart);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println(emailContent);
        return emailContent;
    }
    private static String getTextFromMimeMultipart(MimeMultipart mimeMultipart) throws Exception {
      StringBuilder result = new StringBuilder();
      int count = mimeMultipart.getCount();
      for (int i = 0; i < count; i++) {
         BodyPart bodyPart = mimeMultipart.getBodyPart(i);
         if (bodyPart.isMimeType("text/plain")) {
            result.append(bodyPart.getContent().toString());
         } else if (bodyPart.isMimeType("text/html")) {
            // Prefer HTML if plain text is empty
            return bodyPart.getContent().toString();
         } else if (bodyPart.getContent() instanceof MimeMultipart) {
            result.append(getTextFromMimeMultipart((MimeMultipart) bodyPart.getContent()));
         }
      }
      return result.toString();
   }
    public static String extractAndPrintLinks1(String emailContent, String LinkName) {
      String Link = "";

      // Decode HTML entities in case of encoded content
      emailContent = StringEscapeUtils.unescapeHtml4(emailContent);

      // Updated regex to handle variations
      Pattern linkPattern = Pattern.compile("<a[^>]+href=['\"](https?://[^'\"]+)['\"][^>]*>(.*?)</a>", Pattern.CASE_INSENSITIVE);
      Matcher matcher = linkPattern.matcher(emailContent);

      System.out.println("Extracted Links:");
      while (matcher.find()) {
         String url = matcher.group(1);          // Extract URL
         String displayText = matcher.group(2);  // Extract visible text

         // Normalize text (remove extra spaces, line breaks)
         displayText = displayText.replaceAll("\\s+", " ").trim();

         System.out.println(displayText + " -> " + url);

         // Case-insensitive matching for "UPDATE STATUS"
         if (displayText.toLowerCase().contains(LinkName.toLowerCase())) {
            Link = url;
         }
      }
      return Link;
   }
    public static String getTextFromMessageAlwaysReturnText(Message message) throws Exception {
        if (message.isMimeType("text/plain")) {
            return message.getContent().toString();
        } else if (message.isMimeType("text/html")) {
            String html = (String) message.getContent();
            return Jsoup.parse(html).text(); // ✅ convert html → plain text
        } else if (message.isMimeType("multipart/*")) {
            MimeMultipart mimeMultipart = (MimeMultipart) message.getContent();
            return getPlainTextFromMimeMultipart(mimeMultipart);
        }
        return "";
    }
    private static String getPlainTextFromMimeMultipart(MimeMultipart mimeMultipart) throws Exception {
        String plainText = null;
        String htmlText = null;

        for (int i = 0; i < mimeMultipart.getCount(); i++) {
            BodyPart bodyPart = mimeMultipart.getBodyPart(i);

            if (bodyPart.isMimeType("text/plain")) {
                // ✅ Prefer plain text immediately
                return bodyPart.getContent().toString();
            } else if (bodyPart.isMimeType("text/html")) {
                htmlText = (String) bodyPart.getContent(); // keep as fallback
            } else if (bodyPart.getContent() instanceof MimeMultipart) {
                String nested = getPlainTextFromMimeMultipart((MimeMultipart) bodyPart.getContent());
                if (!nested.isEmpty()) {
                    return nested;
                }
            }
        }

        // ✅ fallback: convert HTML → plain text
        if (htmlText != null) {
            return Jsoup.parse(htmlText).text();
        }

        return plainText != null ? plainText : "";
    }
    public static void  SeenAndProcessEmail(Message message) throws MessagingException {
        message.setFlag(Flags.Flag.SEEN, true);
        // 1. Get or create the folder
        Folder processedFolder = store.getFolder("Processed");

        if (!processedFolder.exists()) {
            processedFolder.create(Folder.HOLDS_MESSAGES);
        }

        // 2. Open the folder in READ_WRITE
        processedFolder.open(Folder.READ_WRITE);

        // 3. Copy the message to "Processed" folder
        processedFolder.appendMessages(new Message[]{message});

        // 4. Mark original INBOX email for deletion
        message.setFlag(Flags.Flag.DELETED, true);

        // 5. Close folders
        processedFolder.close(false);
    }
    }

