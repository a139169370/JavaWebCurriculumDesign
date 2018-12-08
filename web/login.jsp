<%--
  Created by IntelliJ IDEA.
  UserMess: 龙猫
  Date: 2018/11/24
  Time: 15:02
  email: foxmaillucien@126.com
  Description:登录表单页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登陆界面</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.js"></script><!--引入jquery框架-->
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css" media="screen">
        .row{
            padding: 5px;
        }
    </style>
    <script type="text/javascript">
        function isEmpty_checked(){
            if ($("#username").val() != "" & $("#password").val() != "") {
                return true;
            }else{
                alert("用户名或密码不能为空！")
                return false;
            }
        }
    </script>
</head>
<body>
<div class="container">
    <div class="row">
        <h3 style="text-align: center">
            欢迎，请登录！
        </h3>
    </div>
    <form action="login_checking.jsp" method="post" onsubmit="return isEmpty_checked();">
        <div class="row">
            <div class="col-md-1 text-right col-md-offset-4">
                用户名：
            </div>
            <div class="col-md-6">
                <input type="text" name="username" id="username">
            </div>
        </div>
        <div class="row">
            <div class="col-md-1 text-right col-md-offset-4">
                密码：
            </div>
            <div class="col-md-6">
                <input type="password" name="password" id="password">
            </div>
        </div>
        <div class="row text-center">
            <input type="button" name="register" value="注册" class="btn btn-primary" onclick="window.location.href='register.jsp'">
            <input type="submit" name="submit" value="登录" class="btn btn-primary" onclick="">
        </div>
    </form>
</div>
</body>
</html>
