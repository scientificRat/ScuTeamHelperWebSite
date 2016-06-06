package datastruct.teamInfo;

/**
 * Created by huangzhengyue on 6/2/16.
 */
public class TeamInfo {

    private String teamId;
    private String OwnerUserAccount;
    private String teamName;
    private String teamIntroduction;
    private String competitionName;
    private String QQ;
    private String email;

    public TeamInfo(String teamId, String ownerUserAccount, String teamName, String teamIntroduction, String competitionName, String QQ, String email) {
        this.teamId = teamId;
        this.OwnerUserAccount = ownerUserAccount;
        this.teamName = teamName;
        this.teamIntroduction = teamIntroduction;
        this.competitionName = competitionName;
        this.QQ = QQ;
        this.email = email;
    }

    public String getTeamId() {
        return teamId;
    }

    public String getTeamName() {
        return teamName;
    }

    public String getOwnerUserAccount() {
        return OwnerUserAccount;
    }

    public String getTeamIntroduction() {
        return teamIntroduction;
    }

    public String getCompetitionName() {
        return competitionName;
    }

    public String getQQ() {
        return QQ;
    }

    public String getEmail() {
        return email;
    }
}
