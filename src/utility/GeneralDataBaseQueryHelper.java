package utility;

import datastruct.Comment;
import datastruct.personalInfo.PersonalInfo;
import datastruct.teamInfo.TeamInfo;

import java.sql.*;
import java.util.ArrayList;

/**
 * Created by huangzhengyue on 6/5/16.
 */
public class GeneralDataBaseQueryHelper {

//    private static final String databaseUrl="jdbc:postgresql://localhost/scu_team_helper";
//    private static final String databaseUserName="huangzhengyue";
//    private static final String databaseUserPassword=null;
    private static final String databaseUrl="jdbc:postgresql://115.28.68.253:5432/scu_team_helper";
    private static final String databaseUserName="postgres";
    private static final String databaseUserPassword="199606128";

    public static Connection getDBConnection(){
        Connection dbConnection=null;
        Driver driver=new org.postgresql.Driver();
        try {
            DriverManager.registerDriver(driver);
            dbConnection=DriverManager.getConnection(databaseUrl,databaseUserName,databaseUserPassword);

        } catch (SQLException e) {
            for (Throwable t:
                    e) {
                t.printStackTrace();
            }
        }

        return dbConnection;
    }

    public static PersonalInfo getPersonalInfo(String user_account_name){
        PersonalInfo personalInfo=null;
        Connection dbConnection=getDBConnection();
        //query
        try {
            //(realName,gender,college,major,grade,academic_background,qq,email,introduction)
            PreparedStatement prStat=dbConnection.prepareStatement("SELECT *FROM  personal_introduction NATURAL JOIN user_table WHERE user_account_name=?");
            prStat.setString(1,user_account_name);
            ResultSet resultSet=prStat.executeQuery();
            if (resultSet.next()){
                ArrayList<String> abilities=new ArrayList<>();
                prStat=dbConnection.prepareStatement("SELECT *FROM user_table NATURAL JOIN has_ability WHERE user_account_name=?");
                prStat.setString(1,user_account_name);
                ResultSet abilitiesResultSet=prStat.executeQuery();
                while (abilitiesResultSet.next()){
                    abilities.add(abilitiesResultSet.getString("ability_name"));
                }
                String realNameName=resultSet.getString("realName");
                String gender=resultSet.getString("gender");
                String college=resultSet.getString("college");
                String major=resultSet.getString("major");
                String grade=resultSet.getString("grade");
                String academic_background=resultSet.getString("academic_background");
                String introduction=resultSet.getString("introduction");
                String QQ=resultSet.getString("qq");
                String email=resultSet.getString("email");
                personalInfo=new PersonalInfo(user_account_name, realNameName,gender,college,major,grade,academic_background,introduction,abilities,QQ,email);

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            //close the database connection
            try {
                dbConnection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return personalInfo;
    }


    public static PersonalInfo getBriefPersonalInfo(String user_account_name){
        PersonalInfo personalInfo=null;
        Connection dbConnection=getDBConnection();
        //query
        try {
            //(realName,gender,college,major,grade,academic_background,qq,email,introduction)
            PreparedStatement prStat=dbConnection.prepareStatement("SELECT *FROM  user_table WHERE user_account_name=?");
            prStat.setString(1,user_account_name);
            ResultSet resultSet=prStat.executeQuery();
            if (resultSet.next()){
                ArrayList<String> abilities=new ArrayList<>();
                prStat=dbConnection.prepareStatement("SELECT *FROM user_table NATURAL JOIN has_ability WHERE user_account_name=?");
                prStat.setString(1,user_account_name);
                ResultSet abilitiesResultSet=prStat.executeQuery();
                while (abilitiesResultSet.next()){
                    abilities.add(abilitiesResultSet.getString("ability_name"));
                }
                String realNameName=resultSet.getString("realName");
                String gender=resultSet.getString("gender");
                String college=resultSet.getString("college");
                String major=resultSet.getString("major");
                String grade=resultSet.getString("grade");
                String academic_background=resultSet.getString("academic_background");
                personalInfo=new PersonalInfo(user_account_name, realNameName,gender,college,major,grade,academic_background,"",abilities,"","");

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            //close the database connection
            try {
                dbConnection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return personalInfo;
    }


    public static TeamInfo getTeamInfo(String team_id){
        TeamInfo teamInfo=null;
        Connection dbConnection=getDBConnection();

        try {
            dbConnection=DriverManager.getConnection(databaseUrl,"huangzhengyue",null);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        //query
        //--team(team_id,owner_user_account,team_name,competition_name,email,qq,team_introduction)
        try {
            PreparedStatement prStat= null;
            prStat = dbConnection.prepareStatement("SELECT* FROM team WHERE team_id=?");
            prStat.setInt(1,Integer.valueOf(team_id));
            ResultSet resultSet=prStat.executeQuery();
            if (resultSet.next()){
                String teamID=team_id;
                String ownerUserAccount=resultSet.getString("owner_user_account");
                String teamName=resultSet.getString("team_name");
                String competitionName=resultSet.getString("competition_name");
                String email=resultSet.getString("email");
                String qq=resultSet.getString("qq");
                String teamIntroduction=resultSet.getString("team_introduction");
                teamInfo=new TeamInfo(teamID,ownerUserAccount,teamName,teamIntroduction,competitionName,qq,email);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            //close the database connection
            try {
                dbConnection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return teamInfo;
    }


    private static ArrayList<Comment> constructCommentsFromResultSet(ResultSet resultSet) throws SQLException {
        ArrayList<Comment> comments=new ArrayList<>();
        while (resultSet.next()){
            String sent_user_account=resultSet.getString("sent_user_account_name");
            String content=resultSet.getString("content");
            String time_stamp=resultSet.getString("sent_time");
            comments.add(new Comment(sent_user_account,content,time_stamp));
        }
        return comments;
    }


    public static  ArrayList<Comment> getPersonalComments(String master_account_name){
        ArrayList<Comment> comments=null;
        Connection dbConnection=getDBConnection();

        try {
            PreparedStatement preparedStatement=dbConnection.prepareStatement("SELECT * FROM personal_comments WHERE master_account_name=? ORDER BY sent_time ASC ");
            preparedStatement.setString(1,master_account_name);
            ResultSet resultSet=preparedStatement.executeQuery();
            comments=constructCommentsFromResultSet(resultSet);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            try {
                dbConnection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return comments;
    }

    static public ArrayList<Comment> getTeamComments(String team_id){
        ArrayList<Comment> comments=null;
        Connection dbConnection=getDBConnection();

        try {
            PreparedStatement preparedStatement=dbConnection.prepareStatement("SELECT * FROM team_comments WHERE team_id=? ORDER BY sent_time ASC ");
            preparedStatement.setInt(1,Integer.valueOf(team_id));
            ResultSet resultSet=preparedStatement.executeQuery();
            comments=constructCommentsFromResultSet(resultSet);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            try {
                dbConnection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return  comments;
    }


}
