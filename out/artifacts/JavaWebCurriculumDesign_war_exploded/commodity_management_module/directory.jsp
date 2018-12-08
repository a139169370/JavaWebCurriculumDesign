<%--
  Created by IntelliJ IDEA.
  User: 龙猫
  Date: 2018/12/6
  Time: 9:07
  email: foxmaillucien@126.com
  Description:商品管理模块根目录
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>订单管理</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <style type="text/css" media="screen">
        h3,tr th{
            background-image: linear-gradient(to right , #7A88FF, #4fceff);
        }
        th,td{
            text-align: center;
            padding-left: 3px;
            padding-right: 3px;
        }
        .row{
            padding-top: 10px;
        }
    </style>
    <script>
        window.message_type = "all";            //定义全局变量
        jQuery(document).ready(function($) {
            choose();           //页面加载完成执行一次

            $("#all").click(function(event) {       //‘显示全部’按钮点击时执行
                window.message_type = "all";        //修改全局变量，查询全体
                choose();
                //清空两个输入框
                $("#productID").val("");
                $("#category").val("");
            });

            $("#condition_query").click(function (event) {          //‘查询’按钮点击时执行
                window.message_type = "condition_query";            //修改全局变量，以条件查询
                choose();
            });

            //‘删除’按钮点击执行,动态添加的组件用这个方法捕捉点击事件
            $("#table").delegate(".delete-button", "click", function() {
                window.deleteProductID = $(this).parent().prev().prev().prev().prev().prev().prev().prev().prev().html();
                delete_product();                                     //ajax提交请求，删除数据库数据
                $(this).parent().parent().remove();					//删除这行tr标签
            });

            //‘查看’按钮点击执行，跳转到详细信息页面，并附带商品ID
            $("#table").delegate(".view","click",function () {
                productID = $(this).parent().prev().prev().prev().prev().prev().prev().prev().html();
                window.location.href='/tomcat/commodity_management_module/viewProductDetails.jsp?productID=' + productID;
            })
        });

        function choose(){			//查询方法
            $.ajax({
                url: '/tomcat/ajax_query_commodity_management_module',
                type: 'get',
                dataType: 'xml',
                data:
                    {
                        type: window.message_type,        //查询所有，type为all
                        productID: $("#productID").val(),
                        category: $("#category").val()
                    },
            })
                .done(function(data) {
                    $("table").find("td").html("");
                    $(data).find("Info").find("messageInfo").each(function(){
                        $("table").append('<tr><td>' + $(this).find("productID").text() + '</td>' +
                            '<td>' + $(this).find('productName').text() + '</td>' +
                            '<td>' + $(this).find('price').text() + '</td>' +
                            '<td>' + $(this).find('category').text() + '</td>' +
                            '<td>' + $(this).find('pnum').text() + '</td>' +
                            '<td>' + $(this).find('imgurl').text() + '</td>' +
                            '<td>' + $(this).find('description').text() + '</td>' +
                            '<td><input type="button" class="btn btn-default view" value="查看"</td>' +
                            '<td><input type="button" class="btn btn-danger delete-button" value="删除"</td></tr>')
                    })
                })
                .fail(function(error) {         //捕捉到错误时执行
                    console.log(error);
                })
                .always(function() {            //总是执行
                    // console.log("complete");
                });
        }

        function delete_product(){			//删除表单方法
            $.ajax({
                url: '/tomcat/ajax_deleteProducts',
                type: 'get',
                dataType: 'xml',
                data:
                    {
                        productID: window.deleteProductID
                    },
            })
                .done(function() {
                    console.log("success");
                })
                .fail(function(error) {         //捕捉到错误时执行
                    console.log(error);
                });

        }

    </script>
</head>
<body>
<div class="container">
    <form method="post" action="">
        <div class="row text-center">
            <h3>查询条件</h3>
        </div>
        <div class="row text-center">
            商品ID： <input type="number" name="productID" value="" placeholder="" id="productID">
            商品类型： <input type="text" name="category" value="" placeholder="" id="category">
        </div>
        <div class="row text-center">
            <input type="button" name="" value="添加商品" class="btn btn-primary" id="add" onclick="window.location.href='addCommodity.jsp'">
            <input type="button" name="" value="查询" class="btn btn-primary" id="condition_query">
            <input type="button" name="" value="显示全部" class="btn btn-primary" id="all">
        </div>
    </form>
    <div class="row text-center">
        <h3>商品信息列表</h3>
    </div>
    <div class="row">
        <table align="center" id="table">
            <tr>
                <th>商品ID</th>
                <th>商品名称</th>
                <th>价格</th>
                <th>商品类型</th>
                <th>库存</th>
                <th>所属路径</th>
                <th>商品描述</th>
                <th>查看</th>
                <th>删除</th>
            </tr>
        </table>
    </div>
</div>
</body>
</html>