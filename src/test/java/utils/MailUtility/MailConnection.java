package utils.MailUtility;

import javax.mail.Folder;
import javax.mail.Store;

public class MailConnection {

    private final Store store;
    private final Folder inbox;

    public MailConnection(Store store, Folder inbox) {
        this.store = store;
        this.inbox = inbox;
    }
    public Store getStore() {
        return store;
    }
    public Folder getInbox() {
        return inbox;
    }
}
