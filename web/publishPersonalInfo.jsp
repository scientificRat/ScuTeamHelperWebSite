<%@ page import="java.sql.Connection" %>
<%@ page import="utility.GeneralDataBaseQueryHelper" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: huangzhengyue
  Date: 6/4/16
  Time: 23:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>
<html class="colorfulBack">
<head>
    <meta charset="UTF-8"  name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes">
    <title>寻找队伍</title>
    <link rel="stylesheet" href="css/newstyle.css" />
    <script  src="js/jquery-2.1.4.min.js"></script>
    <script src="js/personal_center.js"></script>
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
        Connection dbConnection= GeneralDataBaseQueryHelper.getDBConnection();
        try {
            PreparedStatement preparedStatement=dbConnection.prepareStatement("SELECT * FROM user_table WHERE user_account_name=?");
            preparedStatement.setString(1,username);
            ResultSet resultSet=preparedStatement.executeQuery();

            dbConnection.close();

            if (resultSet.next()){
                gender=resultSet.getString("gender");
                realName=resultSet.getString("realName");
                college=resultSet.getString("college");
                major=resultSet.getString("major");
                grade=resultSet.getString("grade");
                academic_background=resultSet.getString("academic_background");
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }

%>

<div class="container">
    <div class="colorBlock redBack">
        <a class="go_back" href="index.jsp"><img id="goBack" src="css/images/back.png"></a><p>寻找队伍</p>
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

        <%

        %>
        <section>
            <div class="tuple"><h2>请补充:</h2></div>
            <form method="post" action="/publishPersonalInfoServlet">
                <div class="tuple">email: <input type="text" name="email" /></div>
                <div class="tuple">Q Q:<input type="text" name="qq" /></div>
                <div class="tuple">拥有能力:</div>
                <div class="abilityForm">
                <span class="checkBox">
                    <input type="checkbox" name="ability" value="办公软件" />办公软件
                </span>
                <span class="checkBox">
                    <input type="checkbox" name="ability" value="PS/CDR" />PS/CDR
                </span>
                <span class="checkBox">
                    <input type="checkbox" name="ability" value="视频剪辑" />视频剪辑
                </span>
                <span class="checkBox">
                    <input type="checkbox" name="ability" value="前端设计" />前端设计
                </span>
                <span class="checkBox">
                    <input type="checkbox" name="ability" value="后端开发" />后端开发
                </span>
                <span class="checkBox">
                    <input type="checkbox" name="ability" value="安卓开发" />安卓开发
                </span>
                <span class="checkBox">
                    <input type="checkbox" name="ability" value="IOS开发" />IOS开发
                </span>
                <span class="checkBox">
                    <input type="checkbox" name="ability" value="数学建模" />数学建模
                </span>
                <span class="checkBox">
                    <input type="checkbox" name="ability" value="机械设计" />机械设计
                </span>
                <span class="checkBox">
                    <input type="checkbox" name="ability" value="电路设计" />电路设计
                </span>
                <span class="checkBox">
                    <input type="checkbox" name="ability" value="嵌入式开发" />嵌入式开发
                </span>
                <span class="checkBox">
                    <input type="checkbox" name="ability" value="市场调研" />市场调研
                </span>
                <span class="checkBox">
                    <input type="checkbox" name="ability" value="财务分析" />财务分析
                </span>
                <span class="checkBox">
                    <input type="checkbox" name="ability" value="市场营销" />市场营销
                </span>
                <span class="checkBox">
                    <input type="checkbox" name="ability" value="法律" />法律
                </span>
                <span class="checkBox">
                    <input type="checkbox" name="ability" value="医学" />医学
                </span>
                </div>
                <div class="tuple">介绍:</div>
                <div class="tuple">
                    <textarea name="introduction" ></textarea>
                </div>
                <div class="tuple">
                    <input type="submit" class="button"  value="提交"  />
                </div>
                <div class="tuple">
                    <span class="error"><%out.print(session.getAttribute("error"));%></span>
                </div>
            </form>
        </section>

        <%

        %>


    </div>
</div>

<%}else {%>
<p>登录过期!<a href="index.jsp">点击返回主页</a></p>
<%}%>

</body>


</html>

