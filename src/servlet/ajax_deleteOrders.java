package servlet;

import Data.Database;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/*
 *		Created by IntelliJ IDEA.
 *		User:龙猫
 *		Date: 2018/12/5
 *		Time: 19:22
 *       email: foxmaillucien@126.com
 *       Description:接受order_manage.jsp发出的ajax请求，同步删除数据库中相同订单
 */
public class ajax_deleteOrders extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		Database database = new Database();
		//接收数据
		String orderID = request.getParameter("OrderID");

		database.del_orders(orderID);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
