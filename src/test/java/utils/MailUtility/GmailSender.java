package utils.MailUtility;

import com.google.api.services.gmail.Gmail;
import com.google.api.services.gmail.model.Message;
import utils.PropertyReader;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.util.Base64;
import java.util.Properties;

import static utils.MailUtility.GmailApiProvider.createService;

public class GmailSender {
    private final Gmail gmail;

    public GmailSender(Gmail gmail) {
        this.gmail = gmail;
    }

    public void sendEmail(String to,
                          String subject,
                          String body,
                          String attachmentPath) throws Exception {

        Session session = Session.getDefaultInstance(new Properties());

        MimeMessage email = new MimeMessage(session);

        email.setFrom(new InternetAddress("me"));
        email.setRecipients(javax.mail.Message.RecipientType.TO, to);
        email.setSubject(subject);

        Multipart multipart = new MimeMultipart();

        // Body
        MimeBodyPart bodyPart = new MimeBodyPart();
        bodyPart.setContent(body, "text/html");
        multipart.addBodyPart(bodyPart);

        // Attachment
        if (attachmentPath != null && !attachmentPath.isEmpty()) {

            MimeBodyPart attachmentPart = new MimeBodyPart();

            File file = new File(attachmentPath);

            DataSource source = new FileDataSource(file);

            attachmentPart.setDataHandler(new DataHandler(source));
            attachmentPart.setFileName(file.getName());

            multipart.addBodyPart(attachmentPart);
        }

        email.setContent(multipart);

        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
        email.writeTo(buffer);

        String encodedEmail = Base64.getUrlEncoder()
                .withoutPadding()
                .encodeToString(buffer.toByteArray());

        Message message = new Message();
        message.setRaw(encodedEmail);

        gmail.users()
                .messages()
                .send("me", message)
                .execute();

        System.out.println("Email sent successfully.");
    }

    public static Gmail getService() throws Exception {
        PropertyReader propertyReader=new PropertyReader();
        String Gmail_Credentials = propertyReader.readproperty("Gmail_Credentials_File");
        return GmailApiProvider.createService(Gmail_Credentials);
    }
}
