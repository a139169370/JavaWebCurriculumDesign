<%-- by 龙猫 --%>
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
                $("#orderID").val("");
                $("#receiverName").val("");
			});

            $("#condition_query").click(function (event) {          //‘查询’按钮点击时执行
                window.message_type = "condition_query";            //修改全局变量，以条件查询
                choose();
            });
            
			//‘删除’按钮点击执行,动态添加的组件用这个方法捕捉点击事件
            $("#table").delegate(".delete-button", "click", function() {
            	window.deleteOrderID = $(this).parent().prev().prev().prev().prev().prev().prev().prev().prev().html();
                delete_order();                                     //ajax提交请求，删除数据库数据
			    $(this).parent().parent().remove();					//删除这行tr标签
			});
		});

		function choose(){			//查询方法
			$.ajax({
				url: '/tomcat/order_manage_ajax_receive',
				type: 'get',
				dataType: 'xml',
				data: 
				{
					type: window.message_type,        //查询所有，type为all
					orderID: $("#orderID").val(),
					receiverName: $("#receiverName").val()
				},
			})
            .done(function(data) {
                $("table").find("td").html("");
                $(data).find("Info").find("messageInfo").each(function(){
                    $("table").append('<tr><td>' + $(this).find("orderID").text() + '</td>' +
                        '<td>' + $(this).find('receiverName').text() + '</td>' +
                        '<td>' + $(this).find('receiverAddress').text() + '</td>' +
                        '<td>' + $(this).find('receiverPhone').text() + '</td>' +
                        '<td>' + $(this).find('money').text() + '</td>' +
                        '<td>' + $(this).find('username').text() + '</td>' +
                        '<td>' + $(this).find('paystate').text() + '</td>' +
                        '<td><input type="button" class="btn btn-default" value="查看"</td>' +
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

		function delete_order(){			//删除表单方法
			$.ajax({
				url: '/tomcat/ajax_deleteOrders',
				type: 'get',
				dataType: 'xml',
				data: 
				{
					OrderID: window.deleteOrderID
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
					订单编号： <input type="number" name="orderID" value="" placeholder="" id="orderID">
					收件人： <input type="text" name="receiverName" value="" placeholder="" id="receiverName">
			</div>
			<div class="row text-center">
				<input type="button" name="" value="查询" class="btn btn-primary" id="condition_query">
				<input type="button" name="" value="显示全部" class="btn btn-primary" id="all">
			</div>
		</form>
		<div class="row text-center">
			<h3>订单列表</h3>
		</div>
		<div class="row">
			<table align="center" id="table">
				<tr>
					<th>订单编号</th>
					<th>收件人</th>
					<th>地址</th>
					<th>联系电话</th>
					<th>总价</th>
					<th>所属用户</th>
					<th>订单状态</th>
					<th>查看</th>
					<th>删除</th>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>