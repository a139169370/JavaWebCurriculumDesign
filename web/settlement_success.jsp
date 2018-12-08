<%--
  Created by IntelliJ IDEA.
  User: 龙猫
  Date: 2018/11/28
  Time: 20:16
  email: foxmaillucien@126.com
  Description:结算成功页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("refresh","3;url='/tomcat/directory.jsp'");     //延迟3秒重定向
%>
<html>
<head>
    <title>结算成功</title>
</head>
<body>
    <h3 style="text-align: center">结算成功！3秒后返回首页！</h3>
</body>
</html>
