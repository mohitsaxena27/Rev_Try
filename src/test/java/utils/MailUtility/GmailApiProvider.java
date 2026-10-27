package utils.MailUtility;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpRequestInitializer;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.services.gmail.Gmail;
import com.google.auth.http.HttpCredentialsAdapter;
import com.google.auth.oauth2.UserCredentials;
import java.io.FileInputStream;

public class GmailApiProvider {

    private static final GsonFactory JSON_FACTORY =
            GsonFactory.getDefaultInstance();

    public static Gmail createService(String credentialsFile) throws Exception {

        NetHttpTransport httpTransport =
                GoogleNetHttpTransport.newTrustedTransport();

        UserCredentials credentials =
                UserCredentials.fromStream(
                        new FileInputStream(credentialsFile));

        HttpRequestInitializer requestInitializer =
                new HttpCredentialsAdapter(credentials);

        return new Gmail.Builder(
                httpTransport,
                JSON_FACTORY,
                requestInitializer)
                .setApplicationName("Unite")
                .build();
    }

}
