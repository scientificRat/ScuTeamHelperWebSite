<%--
  Created by IntelliJ IDEA.
  User: huangzhengyue
  Date: 6/4/16
  Time: 16:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html class="baseColorBack colorfulBack">
<head>
    <meta charset="UTF-8" content="width=device-width,user-scalable=yes"/>
    <title>登陆页面</title>
    <link rel="stylesheet" href="css/MainStyle.css"/>
    <link rel="stylesheet" href="css/login.css"/>
    <script  src="js/jquery-2.1.4.min.js"></script>
    <script src="js/login.js"></script>
</head>
<body>
<div class="midleInformation LoginPage_topAlign">
    <h1>四川大学组队平台</h1>
    <p class="TitleDescreption">-网内存知己,天涯若比邻-</p>
    <div class="formBox">
        <form method="POST" id="login_form" action="loginservlet">
            <%
                String error=(String) session.getAttribute("error");
                if(error!=null && !error.isEmpty()){
                    out.print("<p class=\"error\">"+session.getAttribute("error")+"</p>");
                }
            %>
            <label class="formLabel">用户名:</label>
            <input id="user" name="account_name" type="text"/>
            <label class="formLabel">密 码:</label>
            <input id="password" name="password" type="password" />
            <a id="submitButton" class="submitButton">登陆</a>
            <a id="forgetPassword" class="left" >忘记密码</a>
            <a id="sign_up_button" class="right">注册新用户</a>

        </form>
        <br/><br/>

        <form method="POST" id="sign_up_form" action="/signUpServlet">
            <label class="formLabel">用户名:</label>
            <input id="sign_up_user" name="user_account_name" type="text"/>

            <label class="formLabel">密 码:</label>
            <input id="sign_up_password" name="password" type="password" />

            <label class="formLabel">姓 名:</label>
            <input id="sign_up_name" name="realname" type="text"/>

            <label class="formLabel">性 别:</label>
            男<input type="radio" name="gender" value="男" />
            女<input type="radio" name="gender" value="女"/>
            <br/><br/>

            <label class="formLabel">学 院:</label>
            <input id="sign_up_college" name="college" type="text"/>

            <label class="formLabel">专 业:</label>
            <input  type="text" name="major"/>

            <label class="formLabel">年 级:</label>
            <select name="grade">
                <option value="2016">2016级</option>
                <option value="2015">2015级</option>
                <option value="2014">2014级</option>
                <option value="2013">2013级</option>
                <option value="2012">2012级</option>
            </select>
            <br/>
            <label class="formLabel">学 历:</label>
            <select name="academic_background">
                <option value="本科">本科</option>
                <option value="硕士">硕士</option>
                <option value="博士">博士</option>
            </select>
            <br/><br/>
            <a id="sign_up_submitButton" class="submitButton" >注册</a>
        </form>

    </div>

</div>

</body>
</html>
