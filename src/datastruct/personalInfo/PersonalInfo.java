package datastruct.personalInfo;

import java.util.AbstractList;

/**
 * Created by huangzhengyue on 6/2/16.
 */
public class PersonalInfo {
    //(realName,gender,college,major,grade,academic_background,qq,email,introduction)

    private String user_account;
    private String realName;
    private String gender;
    private String college;
    private String major;
    private String grade;
    private String academicBackground;
    private String introduction;
    private AbstractList<String> abilities;
    private String QQ;
    private String email;
    //constructor

    public PersonalInfo(String user_account, String realName, String gender, String college, String major, String grade, String academicBackground, String introduction, AbstractList<String> abilities, String QQ, String email) {
        this.user_account = user_account;
        this.realName = realName;
        this.gender = gender;
        this.college = college;
        this.major = major;
        this.grade = grade;
        this.academicBackground = academicBackground;
        this.introduction = introduction;
        this.abilities = abilities;
        this.QQ = QQ;
        this.email = email;
    }

    public String getUser_account() {
        return user_account;
    }

    public String getRealName() {
        return realName;
    }

    public String getGender() {
        return gender;
    }

    public String getCollege() {
        return college;
    }

    public String getMajor() {
        return major;
    }

    public String getGrade() {
        return grade;
    }

    public String getAcademicBackground() {
        return academicBackground;
    }

    public String getIntroduction() {
        return introduction;
    }

    public AbstractList<String> getAbilities() {
        return abilities;
    }

    public String getQQ() {
        return QQ;
    }

    public String getEmail() {
        return email;
    }
}
