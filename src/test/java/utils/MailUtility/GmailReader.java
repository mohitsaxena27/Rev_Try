package utils.MailUtility;
import com.google.api.services.gmail.Gmail;
import com.google.api.services.gmail.model.ListMessagesResponse;
import com.google.api.services.gmail.model.Message;
import utils.PropertyReader;

import javax.mail.Session;
import javax.mail.internet.MimeMessage;
import java.time.Instant;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.util.List;

//import jakarta.mail.Session;
//import jakarta.mail.internet.MimeMessage;

import java.io.ByteArrayInputStream;
import java.util.Base64;
import java.util.Properties;

import static utils.MailUtility.GmailApiProvider.createService;

public class GmailReader {
    private final Gmail gmail;

    public GmailReader(Gmail gmail) {
        this.gmail = gmail;
    }

    public List<Message> search(String gmailQuery) throws Exception {

        ListMessagesResponse response =
                gmail.users()
                        .messages()
                        .list("me")
                        .setQ(gmailQuery)
                        .execute();

        return response.getMessages();
    }

    public static Message waitForNewMessageBySubject(
            String subject,
            Instant testStartTime,
            int timeoutSeconds) throws Exception {
        PropertyReader propertyReader=new PropertyReader();
        String Gmail_Credentials = propertyReader.readproperty("Gmail_Credentials_File");
        Gmail gmail = createService(Gmail_Credentials);

        long endTime =
                System.currentTimeMillis()
                        + timeoutSeconds * 1000L;

        while (System.currentTimeMillis() < endTime) {

            String query =
                    "subject:\"" + subject + "\" after:"
                            + formatGmailDate(testStartTime);

            ListMessagesResponse response =
                    gmail.users()
                            .messages()
                            .list("me")
                            .setQ(query)
                            .setMaxResults(20L)
                            .execute();

            Message latestMessage = null;
            Instant latestTime = null;

            if (response.getMessages() != null) {

                for (Message message : response.getMessages()) {

                    Message fullMessage =
                            gmail.users()
                                    .messages()
                                    .get("me", message.getId())
                                    .setFormat("raw")
                                    .execute();

                    Instant receivedTime =
                            Instant.ofEpochMilli(
                                    fullMessage.getInternalDate()
                            );

                    // Ignore old emails
                    if (receivedTime.isAfter(testStartTime)) {

                        if (latestTime == null
                                || receivedTime.isAfter(latestTime)) {

                            latestTime = receivedTime;
                            latestMessage = fullMessage;
                        }
                    }
                }
            }

            if (latestMessage != null) {
                return latestMessage;
            }

            Thread.sleep(3000);
        }

        throw new RuntimeException(
                "No new email found for subject: " + subject);
    }

    private static String formatGmailDate(Instant instant) {
        ZonedDateTime dateTime =
                instant.atZone(ZoneOffset.UTC);
        return String.format(
                "%d/%02d/%02d",
                dateTime.getYear(),
                dateTime.getMonthValue(),
                dateTime.getDayOfMonth()
        );
    }

    public static javax.mail.Message convertToJavaMailMessage(
            com.google.api.services.gmail.model.Message gmailMessage)
            throws Exception {

        byte[] emailBytes =
                Base64.getUrlDecoder().decode(gmailMessage.getRaw());

        Session session = Session.getDefaultInstance(new Properties());

        return new MimeMessage(
                session,
                new ByteArrayInputStream(emailBytes));
    }
}
