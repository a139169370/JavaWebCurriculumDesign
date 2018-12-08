<%@ page import="order_message.OrderNumberCreate" %>
<%@ page import="UserMess.UserMessage" %>
<%@ page import="Data.Database" %><%--
  Created by IntelliJ IDEA.
  User: 龙猫
  Date: 2018/11/28
  Time: 18:49
  email: foxmaillucien@126.com
  Description:确认订单信息
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>填写订单信息</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.js"></script><!--引入jquery框架-->
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css" media="screen">
        table input[type="text"]{
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
        input[type=submit]{
            margin-top: 20px;
        }
    </style>
    <script type="text/javascript">
        jQuery(document).ready(function($) {
            <%
                try{
                	//读取提交的订单信息
                    request.setCharacterEncoding("utf-8");
		            response.setContentType("text/html;charset=utf-8");
                	String ids[] = request.getParameterValues("ids");
                    String names[] = request.getParameterValues("names");
                    String prices[] = request.getParameterValues("prices");
                    String pnums[] = request.getParameterValues("pnums");
                    String buy_nums[] = request.getParameterValues("buy_nums");
                    String consignee = request.getParameter("consignee");
                    String address = request.getParameter("address");
                    String consignee_telephone = request.getParameter("consignee_telephone");
                    //订单号生成
                    UserMessage userMessage = (UserMessage)session.getAttribute("UserMessage");
                    String user_id = userMessage.getUser_id();
                    OrderNumberCreate orderNumberCreate = new OrderNumberCreate(user_id);
                    String orderNumber = orderNumberCreate.getOrderNumber();
                    double money = 0;
                    for (int i = 0;i < ids.length;i++){
                        double price = Double.parseDouble(prices[i]);
                        int buy_num = Integer.parseInt(buy_nums[i]);
                        money += price * buy_num;
                        out.print("$(\"table\").append('<tr><td><input type=\"hidden\" name=\"ids\" value=\"" + ids[i] + "\"></td>' +\n" +
    "                    '<td><input type=\"text\" name=\"names\" value=\"" + names[i] + "\" readonly=\"readonly\"></td>' +\n" +
    "                    '<td><input type=\"text\" name=\"prices\" value=\"" + price + "\" readonly=\"readonly\"></td>' +\n" +
    "                    '<td><input type=\"text\" name=\"pnums\" value=\"" + pnums[i] + "\" readonly=\"readonly\"></td>' +\n" +
    "                    '<td><input type=\"number\" min=\"0\"  name=\"buy_nums\" value=\"" + buy_num + "\" readonly=\"readonly\" class=\"buy_num\"></td>' +\n" +
    "                    '<td>" + String.format("%.2f",money) + "</td></tr>') \n");
                    }
                    out.print("$(\"table\").append('<tr><td colspan=\"6\" rowspan=\"\" headers=\"\">全部商品总价：" + money + " 元</td></tr>');");
                    out.print("$(\"table\").append('<tr><td colspan=\"6\">订单号：<input type=\"text\" name=\"orderNumber\" value=\"" + orderNumber + "\" readonly=\"readonly\"></td></tr>');");
                    out.print("$(\"table\").append('<tr><td colspan=\"6\">收货人姓名：<input type=\"text\" name=\"consignee\" value=\"" + consignee + "\" readonly=\"readonly\"></td></tr>');");
                    out.print("$(\"table\").append('<tr><td colspan=\"6\">收货人电话：<input type=\"text\" name=\"consignee_telephone\" value=\"" + consignee_telephone + "\" readonly=\"readonly\"></td></tr>');");
                    out.print("$(\"table\").append('<tr><td colspan=\"6\">收货人地址：<input type=\"text\" name=\"address\" value=\"" + address + "\" readonly=\"readonly\"></td></tr>');");

                    //订单信息插入数据库
                    Database database = new Database();
                    database.insert_order_message(orderNumber,money,address,consignee,consignee_telephone,user_id,ids,buy_nums);

                }catch (NullPointerException e){
                	response.sendRedirect("shopping_cart.jsp");
                }
            %>
        });
    </script>
</head>
<body>
<h3 class="text-center">请核对订单信息</h3>
<form method="post" action="settlement_success.jsp">
    <table align="center">
        <tr>
            <th></th>
            <th>商品名称</th>
            <th>单价</th>
            <th>库存</th>
            <th>购买数目</th>
            <th>总价</th>
        </tr>
    </table>

    <input class="btn btn-primary" type="submit" value="去付款">
</form>
</body>
</html>
