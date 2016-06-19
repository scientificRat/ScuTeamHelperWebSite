package utility;

import datastruct.personalInfo.PersonalInfo;
import datastruct.teamInfo.TeamInfo;

import java.sql.*;
import java.util.ArrayList;

/**
 * Created by huangzhengyue on 6/3/16.
 */
public class MainDisplayInfoGetter {

    //    private static final String databaseUrl="jdbc:postgresql://localhost/scu_team_helper";
//    private static final String databaseUserName="huangzhengyue";
//    private static final String databaseUserPassword=null;
    private static final String databaseUrl="jdbc:postgresql://115.28.68.253:5432/scu_team_helper";
    private static final String databaseUserName="postgres";
    private static final String databaseUserPassword="199606128";

    private Driver driver=null;

    private Connection dbConnection=null;

    public MainDisplayInfoGetter() {
        driver=new org.postgresql.Driver();
        try {
            DriverManager.registerDriver(driver);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public TeamInfo queryTeamInfo(String userID){
        return null;
    }
    public PersonalInfo queryPersonalInfo(String teamID){
        return null;
    }


    public ArrayList<TeamInfo> queryAllTeamInfo(){
        ArrayList<TeamInfo> teamInfos=null;
        //connect
        try {
            dbConnection=DriverManager.getConnection(databaseUrl,databaseUserName,databaseUserPassword);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        //query
        //--team(team_id,owner_user_account,team_name,competition_name,email,qq,team_introduction)
        try {
            teamInfos=new ArrayList<>();
            PreparedStatement prStat= null;
            prStat = dbConnection.prepareStatement("SELECT* FROM team ORDER BY convert_to(competition_name,'GBK') ASC ");
            ResultSet resultSet=prStat.executeQuery();
            while (resultSet.next()){
                String teamID=resultSet.getString("team_id");
                String ownerUserAccount=resultSet.getString("owner_user_account");
                String teamName=resultSet.getString("team_name");
                String competitionName=resultSet.getString("competition_name");
                String email=resultSet.getString("email");
                String qq=resultSet.getString("qq");
                String teamIntroduction=resultSet.getString("team_introduction");
                teamInfos.add(new TeamInfo(teamID,ownerUserAccount,teamName,teamIntroduction,competitionName,qq,email));
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
        return teamInfos;
    }


    public ArrayList<PersonalInfo> queryAllPersonalInfo(){
        ArrayList<PersonalInfo> personalInfos=null;
        //connect
        try {
            dbConnection=DriverManager.getConnection(databaseUrl,databaseUserName,databaseUserPassword);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        //query
        try {
            //(realName,gender,college,major,grade,academic_background,qq,email,introduction)
            personalInfos=new ArrayList<>();
            PreparedStatement prStat=dbConnection.prepareStatement("SELECT *FROM team_finder NATURAL JOIN personal_introduction NATURAL JOIN  user_table");
            ResultSet resultSet=prStat.executeQuery();

            while (resultSet.next()){
                ArrayList<String> abilities=new ArrayList<>();
                String user_account_name=resultSet.getString("user_account_name");
                prStat=dbConnection.prepareStatement("SELECT *FROM team_finder NATURAL JOIN has_ability WHERE user_account_name=?");
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
                personalInfos.add(new PersonalInfo(user_account_name, realNameName,gender,college,major,grade,academic_background,introduction,abilities,QQ,email));

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
        return personalInfos;

    }




}
