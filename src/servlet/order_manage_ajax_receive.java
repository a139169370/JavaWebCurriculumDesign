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
 *		Time: 11:07
 *       email: foxmaillucien@126.com
 *       Description:
 */
public class order_manage_ajax_receive extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		Database database = new Database();
		//接收数据
		String message_type = request.getParameter("type");
		String orderID = request.getParameter("orderID");
		String receiverName = new String(request.getParameter("receiverName").getBytes("iso8859-1"),"utf-8");			//ajax读取中文，需要转码
		String order_message[][] = database.query_order_message(message_type,orderID,receiverName);
		out.print("<?xml version='1.0' encoding='utf-8'?>");
		out.print("<Info>");
		for (int i = 0;i < order_message.length;i++){
			out.print("<messageInfo>" +
							"<orderID>" + order_message[i][0] + "</orderID>" +
							"<receiverName>" + order_message[i][1] + "</receiverName>" +
							"<receiverAddress>" + order_message[i][2] + "</receiverAddress>" +
							"<receiverPhone>" + order_message[i][3] + "</receiverPhone>" +
							"<money>" + order_message[i][4] + "</money>" +
							"<username>" + order_message[i][5] + "</username>" +
							"<paystate>" + order_message[i][6] + "</paystate>" +
					  "</messageInfo>");
		}
		out.print("</Info>");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
