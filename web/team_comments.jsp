<%@ page import="datastruct.personalInfo.PersonalInfo" %>
<%@ page import="utility.GeneralDataBaseQueryHelper" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="datastruct.Comment" %>
<%@ page import="datastruct.teamInfo.TeamInfo" %><%--
  Created by IntelliJ IDEA.
  User: huangzhengyue
  Date: 6/6/16
  Time: 10:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="colorfulBack">
<head>
    <meta charset="UTF-8"  name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes">
    <title>评论or留言</title>
    <link rel="stylesheet" href="css/newstyle.css" />
</head>

<body>

<%
    String username=(String) session.getAttribute("username");
    String team_id=request.getParameter("team_id");
    if( team_id!=null && !team_id.isEmpty()){

        TeamInfo teamInfo=GeneralDataBaseQueryHelper.getTeamInfo(team_id);
        PersonalInfo pioneerInfo=GeneralDataBaseQueryHelper.getBriefPersonalInfo(teamInfo.getOwnerUserAccount());
        ArrayList<Comment> comments=GeneralDataBaseQueryHelper.getTeamComments(team_id);

%>

<div class="container">
    <div class="colorBlock greenBack">
        <a class="go_back" href="index.jsp"><img id="goBack" src="css/images/back.png"> </a><p>评论区</p>
    </div>
    <div class="midleInformation">
        <h2><%out.print(teamInfo.getTeamName());%></h2>
        <div class="tuple"><label>Email: </label><%out.print(teamInfo.getEmail());%></div>
        <div class="tuple"><label>Q Q: </label><%out.print(teamInfo.getQQ());%></div>
        <div class="tuple"><label>参加比赛: </label><%out.print(teamInfo.getCompetitionName());%></div>
        <div class="tuple"><label>创建者姓名: </label><%out.print(pioneerInfo.getRealName());%></div>
        <div class="tuple"><label>创建者学院: </label><%out.print(pioneerInfo.getCollege());%></div>
        <div class="tuple"><label>创建者专业: </label><%out.print(pioneerInfo.getMajor());%></div>
        <div class="tuple"><label>创建者年级: </label><%out.print(pioneerInfo.getGrade());%></div>
        <div class="tuple"><label>创建者学历: </label><%out.print(pioneerInfo.getAcademicBackground());%></div>
        <div class="tuple"><label>团队介绍:</label></div>
        <%out.print("<p>"+teamInfo.getTeamIntroduction()+"</p>");%>
        <%
            for (int i = 0; i < comments.size() ; i++) {%>
        <div class="comments">
            <p class="comments"><%out.print(comments.get(i).getSent_user_account()+":  "+comments.get(i).getContent());%></p>
        </div>
        <%}%>
    </div>
</div>
<div class="commentsSubmit">
    <form name="input" method="post" action="/addCommentsServlet" >
        <input type="hidden" name="team_id" value="<%out.print(team_id);%>"/>
        <input type="hidden" name="last_url" value="<%out.print(request.getRequestURL() + "?" + request.getQueryString());%>"/>
        <textarea class="comments" placeholder="我有话想说^_^" name="content"></textarea>
            <%if(username==null||username.isEmpty()){%>
                <input onclick="alert('请先登录!');window.location='login.jsp';" type ="button" id="CommentsRightSendButton" value="留言完毕">
            <%}else{%>
                <input name="submit" type ="submit" id="CommentsRightSendButton" value="留言完毕">
            <%}%>
    </form>
</div>

<%}else {%>
<p>系统错误!<a href="index.jsp">点击返回主页</a></p>
<%}%>


</body>

</html>
