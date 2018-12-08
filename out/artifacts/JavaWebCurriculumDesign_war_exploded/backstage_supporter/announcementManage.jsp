<%@ page import="Data.Database" %><%--
  Created by IntelliJ IDEA.
  User: 龙猫
  Date: 2018/12/8
  Time: 14:10
  email: foxmaillucien@126.com
  Description:公告管理页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>公告管理</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <style>
        h3{
            background-image: linear-gradient(to right , #7A88FF, #4fceff);
        }
        .row{
            padding: 5px;
        }
        .button input{
            margin-left: 10px;
            margin-right: 10px;
        }
    </style>
</head>
<body>
<%
    Database database = new Database();
%>
    <form method="post" action="/tomcat/updateAnnouncement">
        <h3 class="text-center">设置公告</h3>
        <div class="row">
            <textarea cols="30" rows="5" name="announcement" class="col-md-6 col-md-offset-3"><%=database.queryAnnouncement()%></textarea>
        </div>
        <div class="row text-center button">
            <input type="submit" name="submit" value="确定" class="btn btn-primary">
            <input type="button" name="reset" value="重置" class="btn btn-primary" id="reset">
            <input type="button" name="return" value="返回" class="btn btn-primary" onclick="window.location.href='/tomcat/commodity_management_module/directory.jsp'">
        </div>
    </form>
</body>
</html>
