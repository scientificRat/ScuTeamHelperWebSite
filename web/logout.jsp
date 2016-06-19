<%--
  Created by IntelliJ IDEA.
  User: huangzhengyue
  Date: 6/19/16
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>logout</title>
</head>
<body>
<%
    session.setAttribute("username",null);
    response.sendRedirect("index.jsp");
%>


</body>
</html>
