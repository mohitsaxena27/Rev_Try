package utils.MailUtility;

import utils.PropertyReader;

import javax.mail.*;
import javax.mail.search.*;
import java.time.Instant;
import java.util.Date;
import java.util.Properties;

public class GmailUtil {
    private static final ThreadLocal<MailConnection> THREAD_MAIL =
            new ThreadLocal<>();
    public static PropertyReader propertyReader = new PropertyReader();
    private static final int CONNECTION_TIMEOUT = 30000;
    private static final int READ_TIMEOUT = 30000;

    /**
     * Create isolated mail connection per thread
     */
    private static MailConnection createConnection() throws Exception {

        Properties props = new Properties();
        props.put("mail.store.protocol", "imaps");
        props.put("mail.imaps.host", "imap.gmail.com");
        props.put("mail.imaps.port", "993");
        props.put("mail.imaps.ssl.enable", "true");

        props.put("mail.imaps.connectiontimeout",
                String.valueOf(CONNECTION_TIMEOUT));

        props.put("mail.imaps.timeout",
                String.valueOf(READ_TIMEOUT));

        props.put("mail.imaps.writetimeout",
                String.valueOf(READ_TIMEOUT));

        props.put("mail.imaps.peek", "true");

        // Prevent stale connection issues
        props.put("mail.imaps.usesocketchannels", "false");

        // Better stability for parallel runs
        props.put("mail.imaps.connectionpoolsize", "5");

        props.put("mail.debug", "false");

        String username = propertyReader.readproperty("EmailID");
        String password = propertyReader.readproperty("Email_App_Passowrd");

        Session session = Session.getInstance(props);

        Store store = session.getStore("imaps");

        store.connect(
                "imap.gmail.com",
                username,
                password
        );

        Folder inbox = store.getFolder("INBOX");

        inbox.open(Folder.READ_ONLY);

        return new MailConnection(store, inbox);
    }

    /**
     * Thread-safe connection retrieval
     */
    private static MailConnection getConnection() throws Exception {

        MailConnection connection = THREAD_MAIL.get();

        if (connection == null
                || !connection.getStore().isConnected()
                || !connection.getInbox().isOpen()) {

            closeConnection();

            connection = createConnection();

            THREAD_MAIL.set(connection);
        }

        return connection;
    }

    /**
     * Main stable email wait method
     */
    public static Message waitForNewMessageBySubject(
            String subject,
            Instant testStartTime,
            int timeoutSeconds) throws Exception {

        long endTime =
                System.currentTimeMillis()
                        + timeoutSeconds * 1000L;

        Exception lastException = null;

        while (System.currentTimeMillis() < endTime) {

            try {

                MailConnection connection = getConnection();

                Folder inbox = connection.getInbox();

                // Search only recent messages
                SearchTerm subjectTerm =
                        new SubjectTerm(subject);

                SearchTerm dateTerm =
                        new ReceivedDateTerm(
                                ComparisonTerm.GE,
                                Date.from(testStartTime)
                        );

                SearchTerm combined =
                        new AndTerm(subjectTerm, dateTerm);

                Message[] messages =
                        inbox.search(combined);

                if (messages.length > 0) {

                    // Latest message
                    Message latest =
                            messages[messages.length - 1];

                    if (latest.getReceivedDate()
                            .toInstant()
                            .isAfter(testStartTime)) {

                        return latest;
                    }
                }

            } catch (Exception e) {

                lastException = e;

                System.out.println(
                        "Recovering IMAP connection..."
                );

                closeConnection();

                Thread.sleep(5000);
            }

            Thread.sleep(3000);
        }

        throw new RuntimeException(
                "Mail not received for subject: "
                        + subject,
                lastException
        );
    }

    /**
     * Cleanup
     */
    public static void closeConnection() {

        MailConnection connection = THREAD_MAIL.get();

        if (connection != null) {

            try {

                if (connection.getInbox() != null
                        && connection.getInbox().isOpen()) {

                    connection.getInbox().close(false);
                }

            } catch (Exception ignored) {
            }

            try {

                if (connection.getStore() != null
                        && connection.getStore().isConnected()) {

                    connection.getStore().close();
                }

            } catch (Exception ignored) {
            }

            THREAD_MAIL.remove();
        }
    }
}
