<%--
  Created by IntelliJ IDEA.
  UserMess: 龙猫
  Date: 2018/11/25
  Time: 13:32
  email: foxmaillucien@126.com
  Description:书本商品选购页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Data.Database" %>
<%
    request.setCharacterEncoding("utf-8");
    response.setContentType("text/html;charset=utf-8");
    Database database = new Database();
    String commodity_message[][] = database.commodity_choose("all");
    database.setConnection();       //重新打开连接
%>
<html>
<head>
    <title>书本商品选购</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.js"></script><!--引入jquery框架-->
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css" media="screen">
        input[type="text"]{
            border: 0px;
        }
        input[type="number"]{
            border: 0px;
            width: 100px;
        }
        body{
            text-align: center;
        }
        table{
            padding-top: 20px;
        }
    </style>
    <script type="text/javascript">
        jQuery(document).ready(function($) {
            row = <%= commodity_message.length%>;                //数据库中的商品数目
            index = 0;             //商品在页面的下标
            <%
                for (int i = 0;i < commodity_message.length;i++){
                	out.print(
"                $(\"table\").append('<tr><td><input type=\"hidden\" name=\"ids\" value=\"" + commodity_message[i][0] + "\"></td>' +\n" +
"                    '<td><input type=\"text\" name=\"names\" value=\"" + commodity_message[i][1] + "\" readonly=\"readonly\"></td>' +\n" +
"                    '<td><input type=\"text\" name=\"prices\" value=\"" + commodity_message[i][2] + "\" readonly=\"readonly\"></td>' +\n" +
"                    '<td><input type=\"text\" name=\"pnums\" value=\"" + commodity_message[i][3] + "\" readonly=\"readonly\"></td>' +\n" +
"                    '<td><input type=\"number\" min=\"0\" max=\"" + commodity_message[i][3] + "\" name=\"buy_nums\" value=\"0\" placeholder=\"0\" class=\"buy_num\"></td>' +\n" +
"                    '<td><input type=\"checkbox\" name=\"is_buy\" class=\"hidden\" value=\"" + i + "\"></td></tr>');    //商品在页面的下标\n");
                }
            %>
            $("form").submit(function (e){              //提交时将数目为0的商品删除
                for (i = 0;i < $("input[type=number]").length;i++){
                    if ($("input[type=number]").eq(i).val() == "0"){
                        $("input[type=number]").eq(i).parent().next().children().eq(0).prop("checked",false);
                    }else {
                        $("input[type=number]").eq(i).parent().next().children().eq(0).prop("checked",true);
                    }
                }
            });
        });


    </script>
</head>
<body>
    <form method="post" action="shopping_cart.jsp">
        <h3>选购商品</h3>
        <h4>
            <%=database.queryAnnouncement()%>
        </h4>
        <table id="table" align="center">
            <tr>
                <th></th>
                <th>商品名称</th>
                <th>价格</th>
                <th>库存</th>
                <th>购买数目</th>
                <th></th>
            </tr>
        </table>
        <input type="button" name="" value="返回" class="btn btn-primary" onclick="window.location.href='directory.jsp'">
        <input type="submit" name="submit" class="btn btn-primary" value="放入购物车">
    </form>
</body>
