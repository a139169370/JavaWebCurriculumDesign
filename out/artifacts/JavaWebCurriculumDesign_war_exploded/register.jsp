<%--
  Created by IntelliJ IDEA.
  UserMess: 龙猫
  Date: 2018/11/24
  Time: 16:05
  email: foxmaillucien@126.com
  Description:注册表单页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>会员注册</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.js"></script><!--引入jquery框架-->
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css" media="screen">
        .row{
            padding: 5px;
        }
    </style>
    <script type="text/javascript">
        function checkedPasswordTheSame() {
            if ($("#username").val() == ""){
                alert("用户名不能为空！");
                return false;
            }
            if ($("#password").val() == ""){
                alert("密码不能为空！");
                return false;
            }
            if ($("#repeat_password").val() == ""){
                alert("重复密码不能为空！");
                return false;
            }
            if ($("#telephone").val() == ""){
                alert("联系电话不能为空！");
                return false;
            }
            if ($("#email").val() == ""){
                alert("电子邮箱不能为空！");
                return false;
            }
            if ($("#introduce").val() == ""){
                alert("个人介绍不能为空！");
                return false;
            }
            if ($("#activeCode").val() == ""){
                alert("注册激活码不能为空！");
                return false;
            }
            if ($("#password").val() == $("#repeat_password").val()){
                if ($("#activeCode").val() == "" | $("#activeCode").val() == null){
                    $("#activeCode").val("123456");
                }
                return true;
            }else{
                alert("两次输入的密码不一致！");
                return false;
            }
        }
    </script>
</head>
<body>
<div class="container">
    <div class="row">
        <h3 style="text-align: center">
            会员注册
        </h3>
    </div>
    <form action="insert_user.jsp" method="post" onsubmit="return checkedPasswordTheSame();">
        <div class="row">
            <div class="col-md-2 text-right col-md-offset-3">
                用户名：
            </div>
            <div class="col-md-6">
                <input type="text" name="username" id="username">
            </div>
        </div>
        <div class="row">
            <div class="col-md-2 text-right col-md-offset-3">
                密码：
            </div>
            <div class="col-md-6">
                <input type="password" name="password" id="password">
            </div>
        </div>
        <div class="row">
            <div class="col-md-2 text-right col-md-offset-3">
                重复密码：
            </div>
            <div class="col-md-6">
                <input type="password" name="repeat_password" id="repeat_password">
            </div>
        </div>
        <div class="row">
            <div class="col-md-2 text-right col-md-offset-3">
                性别：
            </div>
            <div class="col-md-6">
                <input type="radio" name="gender" value="男" placeholder="" checked="">男
                <input type="radio" name="gender" value="女" placeholder="">女
            </div>
        </div>
        <div class="row">
            <div class="col-md-2 text-right col-md-offset-3">
                联系电话：
            </div>
            <div class="col-md-6">
                <input type="number" name="telephone" id="telephone">
            </div>
        </div>
        <div class="row">
            <div class="col-md-2 text-right col-md-offset-3">
                电子邮箱：
            </div>
            <div class="col-md-6">
                <input type="email" name="email" value="" placeholder="" id="email">
            </div>
        </div>
        <div class="row">
            <div class="col-md-2 text-right col-md-offset-3">
                个人简介：
            </div>
            <div class="col-md-6">
                <input type="text" name="introduce" value="" placeholder="" id="introduce">
            </div>
        </div>
        <div class="row">
            <div class="col-md-2 text-right col-md-offset-3">
                注册激活码：
            </div>
            <div class="col-md-6">
                <input type="number" name="activeCode" id="activeCode" value="123456" placeholder="如果没有激活码则保留默认">
            </div>
        </div>

        <div class="row text-center">
            <input type="button" name="return" value="返回" class="btn btn-primary" onclick="window.location.href='/tomcat/login.jsp' ">
            <input type="submit" name="submit" value="注册会员" class="btn btn-primary" onclick="">
        </div>
    </form>
</div>
</body>
</html>
