<%--
  Created by IntelliJ IDEA.
  User: 龙猫
  Date: 2018/12/4
  Time: 21:52
  email: foxmaillucien@126.com
  Description:后台首页
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.js"></script><!--引入jquery框架-->
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
</head>
<frameset rows="10%,80%,*">
	<frame name="top" src="title.html"></frame>
	<frameset cols="10%,*">
		<frame name="menu" src="menu.html"></frame>
		<frame name="main" src="welcome.html"></frame>
	</frameset>
	<frame name="footer" src="footer.html"></frame>
</frameset>
</html>
