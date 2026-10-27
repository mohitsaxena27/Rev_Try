package utils;

import javax.mail.Folder;
import javax.mail.Store;

public class MailConnection {
    public Store store;
    public Folder inbox;

    public MailConnection(Store store, Folder inbox) {
        this.store = store;
        this.inbox = inbox;
    }
}
