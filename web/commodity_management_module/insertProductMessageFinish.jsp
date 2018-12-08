<%--
  Created by IntelliJ IDEA.
  UserMess: 龙猫
  Date: 2018/11/24
  Time: 17:14
  email: foxmaillucien@126.com
  Description:商品信息成功插入页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("refresh","3;url='/tomcat/commodity_management_module/addCommodity.jsp'");     //重定向
%>
<html>
<head>
    <title>插入成功</title>
</head>
<body>
<h3 style="text-align: center">
    插入成功！
</h3>
<h5 style="text-align: center">
    3秒后跳转至添加商品页面
</h5>
<h5 style="text-align: center">
    <a href="/tomcat/commodity_management_module/addCommodity.jsp">
        如若未跳转请手动点击链接
    </a>
</h5>
</body>
</html>
