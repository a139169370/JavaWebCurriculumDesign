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
 *		Date: 2018/12/6
 *		Time: 9:43
 *       email: foxmaillucien@126.com
 *       Description:接受/ajax_query_commodity_management_module/directory.jsp页面的删除请求
 */
public class ajax_deleteProducts extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		Database database = new Database();
		//接收数据
		String productID = request.getParameter("productID");

		database.del_product(productID);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req,resp);
	}
}
