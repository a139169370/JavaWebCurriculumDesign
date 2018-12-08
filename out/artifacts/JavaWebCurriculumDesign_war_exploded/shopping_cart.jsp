<%--
  Created by IntelliJ IDEA.
  UserMess: 龙猫
  Date: 2018/11/25
  Time: 15:39
  email: foxmaillucien@126.com
  Description:购物车页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>购物车</title>
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
            x = "x";
            row = 5;
            <%
                try{
                    request.setCharacterEncoding("utf-8");
                    response.setContentType("text/html;charset=utf-8");
                	String ids[] = request.getParameterValues("ids");
                    String names[] = request.getParameterValues("names");
                    String prices[] = request.getParameterValues("prices");
                    String pnums[] = request.getParameterValues("pnums");
                    String buy_nums[] = request.getParameterValues("buy_nums");
                    String is_buy[] = request.getParameterValues("is_buy");
                    for (int i = 0;i < is_buy.length;i++){
                        int index = Integer.parseInt(is_buy[i]);
                        double price = Double.parseDouble(prices[index]);
                        int buy_num = Integer.parseInt(buy_nums[index]);
                        out.print("$(\"table\").append('<tr><td><input type=\"hidden\" name=\"ids\" value=\"" + ids[index] + "\"></td>' +\n" +
    "                    '<td><input type=\"text\" name=\"names\" value=\"" + names[index] + "\" readonly=\"readonly\"></td>' +\n" +
    "                    '<td><input type=\"text\" name=\"prices\" value=\"" + price + "\" readonly=\"readonly\"></td>' +\n" +
    "                    '<td><input type=\"text\" name=\"pnums\" value=\"" + pnums[index] + "\" readonly=\"readonly\"></td>' +\n" +
    "                    '<td><input type=\"number\" min=\"0\"  name=\"buy_nums\" value=\"" + buy_num + "\" placeholder=\"0\" class=\"buy_num\"></td>' +\n" +
    "                    '<td>" + String.format("%.2f",price * buy_num) + "</td>' +\n" +
    "                    '<td><input type=\"button\" name=\"\" value=\"删除\" class=\"' + x +' btn btn-primary\"></td></tr>');    //商品在页面的下标\n" +
     "                   x = x + \"x\"; \n");
                    }
                }catch (NullPointerException e){
                	response.sendRedirect("book_purchasing_page.jsp");
                }
            %>
            $("input[type=button]").on('click', function(event) {
                var array = $(this).attr('class').split(' ');
                if (array[0] == "btn") {
                    return;
                }
                $("body").find('.' + array[0] + '').attr('name',' ');
                $("body").find('.' + array[0] + '').parent().parent().remove();     //删除按钮点击触发事件
                // $("body").find('.' + array[0] + '').remove();
            });

            $(".buy_num").on('click', function(event) {             //商品数目被更改价格随动
                $(this).parent().next().html((($(this).parent().prev().prev().children().eq(0).val()) * ($(this).val())).toFixed(2));
            });

            $("form").submit(function (e){              //提交时将数目为0的商品删除
                for (i = 0;i < $("input[type=number]").length;i++){
                    if ($("input[type=number]").eq(i).val() == "0"){
                        var arr = $("input[type=number]").eq(i).parent().next().next().children().eq(0).attr('class').split(' ');
                        if (arr[0] == "btn") {
                            return;
                        }
                        $("body").find('.' + arr[0] + '').attr('name',' ');
                        $("body").find('.' + arr[0] + '').parent().parent().remove();
                    }
                }
            });
        });
    </script>
</head>
<body>
<h3>购物车</h3>
<form method="post" action="order_message_fillout.jsp">
    <table align="center">
        <tr>
            <th></th>
            <th>商品名称</th>
            <th>单价</th>
            <th>库存</th>
            <th>购买数目</th>
            <th>总价</th>
            <th></th>
        </tr>
    </table>
    <input type="button" name="" value="返回" class="btn btn-primary" onclick="window.location.href='book_purchasing_page.jsp'">
    <input type="submit" name="submit" class="btn btn-primary" value="结算">
</form>

</body>
</html>