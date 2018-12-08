<%--
  Created by IntelliJ IDEA.
  UserMess: 龙猫
  Date: 2018/11/24
  Time: 17:46
  email: foxmaillucien@126.com
  Description:登录验证不通过提示页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("refresh","3;url='/tomcat/login.jsp'");     //延迟3秒重定向
%>
<html>
<head>
    <title>用户名或密码错误或未激活！</title>
</head>
<body>
    <h3 style="text-align: center">
        用户名或密码错误或未激活！
    </h3>
    <h5 style="text-align: center">
        3秒后跳转至登录界面
    </h5>
    <h5 style="text-align: center">
        <a href="login.jsp">
            如若未跳转请手动点击链接
        </a>
    </h5>
</body>
</html>
