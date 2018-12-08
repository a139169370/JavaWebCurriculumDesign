<%--
  Created by IntelliJ IDEA.
  User: 龙猫
  Date: 2018/11/28
  Time: 20:31
  email: foxmaillucien@126.com
  Description:图书查询首页
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>图书查询</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.js"></script><!--引入jquery框架-->
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript">
        jQuery(document).ready(function($) {
            $.ajax({                //页面加载完成执行一次ajax请求，填充table
                type:'get',
                url:'/tomcat/ajax',
                data:
                    {
                        message_type:"book_type",
                        book_type:"all"
                    },
                cache:true,
                dataType:'text',
                success:function(data){
                    $("table").html("");
                    $("table").append("            <tr>\n" +
                        "                <th colspan=\"\" rowspan=\"\" headers=\"\" scope=\"\">书名</th>\n" +
                        "                <th colspan=\"\" rowspan=\"\" headers=\"\" scope=\"\">单价</th>\n" +
                        "                <th colspan=\"\" rowspan=\"\" headers=\"\" scope=\"\">库存</th>\n" +
                        "            </tr>");
                    $("table").append(data);
                },
                error :function(e){
                    console.log("error!" + e);
                }
            });

            $(".search_book").click(function(event) {           //button点击执行ajax请求，更改table
                $.ajax({
                    type:'get',
                    url:'/tomcat/ajax',
                    data:
                    {
                        message_type:"book_type",
                        book_type:$(this).attr('id')
                     },
                    cache:true,
                    dataType:'text',
                    success:function(data){
                        $("#book_name").val("");                //点击按钮的时候清空输入框
                        $("table").html("");
                        $("table").append("            <tr>\n" +
                            "                <th colspan=\"\" rowspan=\"\" headers=\"\" scope=\"\">书名</th>\n" +
                            "                <th colspan=\"\" rowspan=\"\" headers=\"\" scope=\"\">单价</th>\n" +
                            "                <th colspan=\"\" rowspan=\"\" headers=\"\" scope=\"\">库存</th>\n" +
                            "            </tr>");
                        $("table").append(data);
                    },
                    error :function(e){
                        console.log("error!" + e);
                    }
                });
            });

            $("#book_name").keyup(function () {                         //搜索框变更，根据书名提交ajax模糊查询
                $.ajax({
                    type:'get',
                    url:'/tomcat/ajax',
                    data:
                        {
                            message_type:"book_name",
                            book_type:$(this).val()
                        },
                    cache:true,
                    dataType:'text',
                    success:function(data){
                        $("table").html("");
                        $("table").append("            <tr>\n" +
                            "                <th colspan=\"\" rowspan=\"\" headers=\"\" scope=\"\">书名</th>\n" +
                            "                <th colspan=\"\" rowspan=\"\" headers=\"\" scope=\"\">单价</th>\n" +
                            "                <th colspan=\"\" rowspan=\"\" headers=\"\" scope=\"\">库存</th>\n" +
                            "            </tr>");
                        $("table").append(data);
                    },
                    error :function(e){
                        console.log("error!" + e);
                    }
                });
            })

        });
    </script>
    <style>
        .row{
            padding: 10px;
        }
    </style>
</head>
<body>
<div class="container text-center">
    <div class="row text-center">
        <input type="button" class="btn btn-primary search_book" value="所有类" id="all">
        <input type="button" class="btn btn-primary search_book" value="编程类" id="programme">
        <input type="button" class="btn btn-primary search_book" value="文学类" id="literature">
        <input type="button" class="btn btn-primary search_book" value="数学类" id="math">
        <input type="button" class="btn btn-primary search_book" value="语言类" id="language">
    </div>
    <div class="row">
        <input type="text" id="book_name" placeholder="请输入书名">
    </div>
    <div class="row">
        <table align="center" style="width: 280px;">
            <tr>
                <th colspan="" rowspan="" headers="" scope="">书名</th>
                <th colspan="" rowspan="" headers="" scope="">单价</th>
                <th colspan="" rowspan="" headers="" scope="">库存</th>
            </tr>
        </table>
    </div>
</div>
</body>
</html>
