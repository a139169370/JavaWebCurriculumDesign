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
 *		Date: 2018/12/8
 *		Time: 13:50
 *       email: foxmaillucien@126.com
 *       Description:商品管理模块/更新商品信息
 */
public class updateProductMessages extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		Database database = new Database();
		//接收数据
		String productID = request.getParameter("productID");
		String productName = request.getParameter("productName");
		String money = request.getParameter("money");
		String pnum = request.getParameter("pnum");
		String category = request.getParameter("category");
		String img_url = request.getParameter("img_url");
		String description = request.getParameter("description");
		database.updateProductMessages(productID,productName,money,pnum,category,img_url,description);
		response.sendRedirect("/tomcat/commodity_management_module/updateProductMessageFinish.jsp");      //更新完成后重定向

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req,resp);
	}
}
