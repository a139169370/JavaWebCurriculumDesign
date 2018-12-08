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
 *		Time: 9:16
 *       email: foxmaillucien@126.com
 *       Description:接受/ajax_query_commodity_management_module/directory.jsp页面的查询请求
 */
public class ajax_query_commodity_management_module extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		//获取参数
		String message_type = request.getParameter("type");
		String productID = request.getParameter("productID");
		String category = new String(request.getParameter("category").getBytes("iso8859-1"),"utf-8");			//ajax读取中文，需要转码

		Database database = new Database();
		String products_message[][] = database.query_product_messageForID_type(message_type,productID,category);
		out.print("<?xml version='1.0' encoding='utf-8'?>");
		out.print("<Info>");
		for (int i = 0;i < products_message.length;i++){
			out.print("<messageInfo>" +
					"<productID>" + products_message[i][0] + "</productID>" +
					"<productName>" + products_message[i][1] + "</productName>" +
					"<price>" + products_message[i][2] + "</price>" +
					"<category>" + products_message[i][3] + "</category>" +
					"<pnum>" + products_message[i][4] + "</pnum>" +
					"<imgurl>" + products_message[i][5] + "</imgurl>" +
					"<description>" + products_message[i][6] + "</description>" +
					"</messageInfo>");
		}
		out.print("</Info>");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req,resp);
	}
}
