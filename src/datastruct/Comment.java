package datastruct;

/**
 * Created by huangzhengyue on 6/6/16.
 */
public class Comment {
    private String sent_user_account;
    private String content;
    private String timestamp;

    public Comment(String sent_user_account, String content, String timestamp) {
        this.sent_user_account = sent_user_account;
        this.content = content;
        this.timestamp = timestamp;
    }

    public String getSent_user_account() {
        return sent_user_account;
    }

    public String getContent() {
        return content;
    }

    public String getTimestamp() {
        return timestamp;
    }
}
