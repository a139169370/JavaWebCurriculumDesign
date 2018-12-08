<%--
  Created by IntelliJ IDEA.
  UserMess: 龙猫
  Date: 2018/11/24
  Time: 17:14
  email: foxmaillucien@126.com
  Description:注册表单信息插入数据库成功页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("refresh","3;url='/tomcat/login.jsp'");     //重定向
%>
<html>
<head>
    <title>注册成功</title>
</head>
<body>
    <h3 style="text-align: center">
        注册成功！
    </h3>
    <h5 style="text-align: center">
        3秒后跳转至登录界面
    </h5>
    <h5 style="text-align: center">
        <a href="/tomcat/login.jsp">
            如若未跳转请手动点击链接
        </a>
    </h5>
</body>
</html>
