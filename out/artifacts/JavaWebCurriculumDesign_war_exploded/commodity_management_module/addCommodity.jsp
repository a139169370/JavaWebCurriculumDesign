<%@ page import="Data.Database" %><%--
  Created by IntelliJ IDEA.
  User: 龙猫
  Date: 2018/12/6
  Time: 23:14
  email: foxmaillucien@126.com
  Description:添加商品页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>添加商品</title>
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
    <script type="text/javascript">
        jQuery(document).ready(function($) {
            <%
                Database database = new Database();
                String catagory[] = database.queryAllCategory();
                for (int i = 0;i < catagory.length;i++){
                	out.println("$(\"select\").append('<option value=\"" + catagory[i] + "\">" + catagory[i] + "</option>');");
                }
            %>
            $("#reset").on('click', function(event) {               //重置按钮点击清空输入框
                console.log("1");
                $(".input").val("");
            });
        });
    </script>
</head>
<body>
    <h3 class="text-center">添加商品</h3>
    <div class="container text-center">
        <form method="post" action="/tomcat/insertNewProductsMessages">
            <div class="row">
                <span class="col-md-2 col-md-offset-2">商品ID：</span><input type="number" name="productID" value="" class="col-md-2 input">
                <span class="col-md-2">商品名称：</span><input type="text" name="productName" value="" placeholder="" class="col-md-2 input">
            </div>
            <div class="row">
                <span class="col-md-2 col-md-offset-2">商品价格：</span><input type="text" name="money" value="" placeholder="" class="col-md-2 input">
                <span class="col-md-2">商品库存：</span><input type="number" name="pnum" value="" class="col-md-2 input">
            </div>
            <div class="row">
                <span class="col-md-2 col-md-offset-2">商品类型：</span><select name="category" class="col-md-2"></select>
                <span class="col-md-2">商品图片：</span><input type="file" name="img_url" value="" class="col-md-2 input">
            </div>
            <div class="row">
                <span class="col-md-2 col-md-offset-2">商品描述：</span><textarea cols="30" rows="5" name="description" class="col-md-6 input"></textarea>
            </div>
            <div class="row button">
                <input type="submit" name="submit" value="确定" class="btn btn-primary">
                <input type="button" name="reset" value="重置" class="btn btn-primary" id="reset">
                <input type="button" name="return" value="返回" class="btn btn-primary" onclick="window.location.href='/tomcat/commodity_management_module/directory.jsp'">
            </div>
        </form>
    </div>
</body>
</html>
