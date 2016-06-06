<%@ page import="utility.GeneralDataBaseQueryHelper" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %><%--
  Created by IntelliJ IDEA.
  User: huangzhengyue
  Date: 6/4/16
  Time: 23:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<!doctype html>
<html class="colorfulBack">
<head>
    <meta charset="UTF-8"  name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes">
    <title>创建队伍</title>
    <link rel="stylesheet" href="css/newstyle.css" />
    <link rel="stylesheet" href="css/newTeam.css" />
    <script  src="js/jquery-2.1.4.min.js"></script>
    <script src="js/personal_center.js"></script>
    <script src="js/newTeam.js"></script>
</head>

<body>


<%

    String username=(String) session.getAttribute("username");
    if(username!=null && !username.isEmpty()){
        String gender="";
        String realName="";
        String college="";
        String major="";
        String grade="";
        String academic_background="";
        ArrayList<String> team_ids=new ArrayList<>();
        ArrayList<String> team_names=new ArrayList<>();

        Connection dbConnection= GeneralDataBaseQueryHelper.getDBConnection();
        try {
            PreparedStatement preparedStatement=dbConnection.prepareStatement("SELECT gender,realname,college,major,grade,academic_background FROM user_table WHERE user_account_name=?");
            preparedStatement.setString(1,username);
            ResultSet resultSet=preparedStatement.executeQuery();

            if (resultSet.next()){
                gender=resultSet.getString("gender");
                realName=resultSet.getString("realName");
                college=resultSet.getString("college");
                major=resultSet.getString("major");
                grade=resultSet.getString("grade");
                academic_background=resultSet.getString("academic_background");
            }

            preparedStatement=dbConnection.prepareStatement("SELECT team_name,team_id FROM user_table, team WHERE user_table.user_account_name=team.owner_user_account AND user_account_name=? ORDER BY team_id ASC ");
            preparedStatement.setString(1,username);

            ResultSet resultSet1=preparedStatement.executeQuery();
            while (resultSet1.next()){
                team_ids.add(resultSet1.getString("team_id"));
                team_names.add(resultSet1.getString("team_name"));
            }
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        Iterator<String> team_ids_it=team_ids.iterator();
        Iterator<String> team_names_it=team_names.iterator();
%>

<div class="container">
    <div class="colorBlock redBack">
        <a class="go_back" href="index.jsp"><img id="goBack" src="css/images/back.png"> </a><p>创建新队伍</p>
    </div>
</div>
<div class="container">
    <div class="midleInformation">
        <div class="tuple"><h2>个人信息</h2></div>
        <div class="tuple"><a class="specialbutton">重置个人信息</a></div>
        <div class="tuple"><label>用户名:</label> <%out.print(username);%></div>
        <div class="tuple"><label>性别:</label><%out.print(gender);%></div>
        <div class="tuple"><label>姓名:</label><%out.print(realName);%></div>
        <div class="tuple"><label>学院:</label> <%out.print(college);%> </div>
        <div class="tuple"><label>专业:</label> <%out.print(major);%> </div>
        <div class="tuple">
            <label>学历:</label> <%out.print(academic_background);%>
            <label>年级:</label> <%out.print(grade);%>
        </div>

    </div>
</div>

<div class="container">
    <div class="midleInformation">
        <section>
            <div class="tuple"><h2>已有队伍:</h2></div>
            <table cellpadding="0" cellspacing="0" class="list_operation_table">
                <tr class="listTitle">
                    <td>队伍名</td><td>操作</td>
                </tr>
                <%
                    while (team_ids_it.hasNext()){
                        String team_id=team_ids_it.next();
                        String team_name=team_names_it.next();
                %>
                        <tr class="listBar">
                        <td><%out.print(team_name);%></td>
                        <td><%out.print("<a href=team_comments'?team_id="+team_id+"'>查看</a>");%> / <a class="special" href="deleteTeamServlet?<%out.print("team_id="+team_id);%>">删除</a></td>
                        </tr>
                   <% }
                %>
            </table>
            <div class="tuple"><a id="createTeamButton" class="specialbutton">创建新队伍</a></div>

            <form id="newTeam" method="post" action="publishNewTeamServlet">
                <div class="tuple"><h2>新队伍:</h2></div>
                <div class="tuple"><label>队伍名:</label> <input type="text" name="team_name" /></div>
                <div class="tuple"><label>email:</label> <input type="text" name="email" /></div>
                <div class="tuple"><label>Q Q:</label><input type="text" name="qq" /></div>
                <div class="tuple"><label>参加比赛名:</label><input type="text" name="competition_name" /></div>
                <div class="tuple">介绍:</div>
                <div class="tuple">
                    <textarea class="introduction" name="introduction" ></textarea>
                </div>
                <div class="tuple">
                    <input type="submit" class="button"  value="创建"  />
                </div>
                <div class="tuple">
                    <span class="error"><%out.print(session.getAttribute("error"));%></span>
                </div>
            </form>

        </section>
    </div>

</div>

<%}else {%>
<p>登录过期!<a href="index.jsp">点击返回主页</a></p>
<%}%>
</body>
</html>
