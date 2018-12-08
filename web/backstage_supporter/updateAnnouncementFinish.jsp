<%--
  Created by IntelliJ IDEA.
  User: 龙猫
  Date: 2018/12/8
  Time: 14:13
  email: foxmaillucien@126.com
  Description:更新公告成功页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("refresh","3;url='/tomcat/backstage_supporter/welcome.html'");     //重定向
%>
<html>
<head>
    <title>更新成功</title>
</head>
<body>
<h3 style="text-align: center">
    更新成功！
</h3>
<h5 style="text-align: center">
    3秒后跳转至欢迎页页面
</h5>
<h5 style="text-align: center">
    <a href="/tomcat/backstage_supporter/welcome.html">
        如若未跳转请手动点击链接
    </a>
</h5>
</body>
</html>