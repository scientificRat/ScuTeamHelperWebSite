<%@ page import="datastruct.personalInfo.PersonalInfo" %>
<%@ page import="utility.GeneralDataBaseQueryHelper" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="datastruct.Comment" %><%--
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
    String master_account=request.getParameter("master");
    if( master_account!=null && !master_account.isEmpty()){

        PersonalInfo personalInfo= GeneralDataBaseQueryHelper.getPersonalInfo(master_account);
        ArrayList<Comment> comments=GeneralDataBaseQueryHelper.getPersonalComments(master_account);

%>

<div class="container">
    <div class="colorBlock greenBack">
        <a class="go_back" href="index.jsp"><img id="goBack" src="css/images/back.png"> </a><p>评论区</p>
    </div>
    <div class="midleInformation">
        <h2><%out.print(personalInfo.getRealName());%></h2>
        <h5><%out.print(personalInfo.getGrade()+personalInfo.getAcademicBackground()+" "+personalInfo.getCollege());%></h5>
        <div class="tuple"><label>Email:</label><%out.print(personalInfo.getEmail());%></div>
        <div class="tuple"><label>Q Q:</label><%out.print(personalInfo.getQQ());%></div>
        <div class="tuple"><label>性别:</label><%out.print(personalInfo.getGender());%></div>
        <div class="tuple"><label>擅长技能:</label></div>
        <div class="abilityBoxsContainer">
            <%
                Iterator<String> abilityIterator=personalInfo.getAbilities().iterator();
                while (abilityIterator.hasNext()){
                    out.print("<div class=\"abilityBox\">"+abilityIterator.next()+"</div>");
                }
            %>
        </div>
        <div class="tuple"><label>个人简介:</label></div>
        <%out.print("<p>"+personalInfo.getIntroduction()+"</p>");%>
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
        <input type="hidden" name="master_account_name" value="<%out.print(master_account);%>"/>
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
