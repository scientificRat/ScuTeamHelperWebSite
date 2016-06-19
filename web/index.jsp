<%@ page import="utility.MainDisplayInfoGetter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="datastruct.teamInfo.TeamInfo" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="datastruct.personalInfo.PersonalInfo" %><%--
  Created by IntelliJ IDEA.
  User: huangzhengyue
  Date: 6/4/16
  Time: 00:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session.setAttribute("error","");
    MainDisplayInfoGetter mainDisplayInfoGetter=new MainDisplayInfoGetter();
    String username=(String) session.getAttribute("username");
    boolean isLogin=false;
    if(username!=null){
        isLogin=true;
    }
%>
<!DOCTYPE html>
<!--此网站旨在服务川大学生，提供组队平台，具体比赛可以再做修改，以下采用“小挑”赛名-->
<html id="base" class="colorfulBack">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="UTF-8"  name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes">
    <title>四川大学学术交流</title>
    <script src="js/jquery-2.1.4.min.js"></script>
    <script src="js/jquery.scrollTo.min.js"></script>
    <script src="js/panel.js"></script>
    <link rel="stylesheet" href="css/newstyle.css" />
</head>

<body>


<div class="title_bar">

    <%if(isLogin){%>
        <a href="account.jsp"><%out.print(username+",您好");%></a> | <a href="logout.jsp">退出</a>
    <%}else{%>
    <a href="login.jsp" class="login_info">立即登录</a>
    <%}%>
</div>


<section id="header">
    <div id="front" class="title">
        <h1>学术•组队•交流</h1>
        <p>四川大学组队交流平台</p>
        <img class="navagationIcon" src="images/navagation.png" alt=" " width="22" height="63"> </div>
    <div class="bottomLocation">
        <div class="container down">
            <div class="midleInformation">
                <a href="#team" class="button" id="nav_team">寻找队伍</a>
                <%if(isLogin){%>
                <a href="#publish" class="specialbutton" id="nav_publish">立即挂上信息</a>
                <%}else{%>
                <a href="#sign_up" class="specialbutton" id="nav_sign_up">立即挂上信息</a>
                <%}%>
                <a href="#teamFinder" class="button" id="nav_team_finder">寻找队友</a>
            </div>
        </div>
    </div>
</section>

<section id="team">
    <div class="container">
        <div class="midleInformation">
            <h9>｛ 已有队伍 ｝</h9>
            <p class="specialp">－众里寻你千百度－</p>
            <a class="search"><img src="images/search.png" class="search"></a>
        </div>
    </div>
    <%
        ArrayList<TeamInfo> teamInfos=mainDisplayInfoGetter.queryAllTeamInfo();
        if(teamInfos!=null){
            Iterator<TeamInfo> teamIterator=teamInfos.iterator();
            while (teamIterator.hasNext()){
                TeamInfo teamInfo=teamIterator.next();
    %>

    <div class="container">
        <div class="midleInformation">
            <h2><pre><%out.print(teamInfo.getTeamName());%></pre></h2>
            <div class="abilityBoxsContainer">
                <div class="abilityBox"><%out.print(teamInfo.getCompetitionName());%></div>
            </div>
            <p><%out.print(teamInfo.getTeamIntroduction());%></p>
            <a class="contact" href="team_comments.jsp?team_id=<% out.print(teamInfo.getTeamId());%>"><img src="images/envelope.png" class="contact"></a>
        </div>
    </div>




    <%
            }
        }
    %>


</section>

<section id="teamFinder">
    <div class="container">
        <div class="midleInformation">
            <h9>｛ 实力选手 ｝</h9>
            <p class="specialp">－我需要一个队伍－</p>
            <a class="search"><img src="images/search.png" class="search"></a>
        </div>
    </div>
    <%
        ArrayList<PersonalInfo> personalInfos=mainDisplayInfoGetter.queryAllPersonalInfo();
        Iterator<PersonalInfo> personalInfoIterator=personalInfos.iterator();
        while (personalInfoIterator.hasNext()){
            PersonalInfo personalInfo=personalInfoIterator.next();
    %>

    <div class="container">
        <div class="midleInformation">
            <h2><%out.print(personalInfo.getRealName());%></h2>
            <h5><%out.print(personalInfo.getGrade()+personalInfo.getAcademicBackground()+" "+personalInfo.getCollege());%></h5>
            <div class="abilityBoxsContainer">
                <%
                    Iterator<String> abilityIterator=personalInfo.getAbilities().iterator();
                    while (abilityIterator.hasNext()){
                        out.print("<div class=\"abilityBox\">"+abilityIterator.next()+"</div>");
                    }
                %>
            </div>
            <%out.print("<p>"+personalInfo.getIntroduction()+"</p>");%>
            <a class="contact" href="personal_comments.jsp?master=<% out.print(personalInfo.getUser_account());%>"><img src="images/envelope.png" class="contact"></a></div>


    </div>

    <%}%>
</section>


<%if(isLogin){%>
<section id="publish">
    <div class="container">
        <div class="midleInformation">
            <h9>｛ 立即发布信息 ｝</h9>
            <p class="specialp">－Add Imformation－</p>
            <a href="publishPersonalInfo.jsp" class="specialbutton">寻找队伍</a>
            <a href="createTeam.jsp" class="specialbutton">创建队伍</a>
        </div>
    </div>


</section>
<%}else{%>

<section id="sign_up">
    <div class="container">
        <div class="midleInformation">
            <h9>｛ 立即登录 ｝</h9>
            <p class="specialp">－PleaseSignIn－</p>
            <p>登录后可以发表信息,查看联系方式哦~</p>
            <a href="login.jsp" class="specialbutton">立即登录</a>
        </div>
    </div>
</section>
<%}%>


<div class="btm"> 友情链接：<a class="btm" href="https://github.com/scientificRat/ScuTeamHelperWebSite.git"> 源代码</a> |<a class="btm" href="http://www.scu.edu.cn"> 四川大学</a><br/>
    Copyright © 2015  scientificRat<br/>

</div>
</body>
</html>