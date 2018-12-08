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
 *		Date: 2018/11/28
 *		Time: 20:52
 *       email: foxmaillucien@126.com
 *       Description:
 */
public class ajax_request_receive extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String message_type = request.getParameter("message_type");
		String book_typeOrName = request.getParameter("book_type");
		Database database = new Database();
		String commodity_message[][];
		if (message_type.equals("book_type")){
			commodity_message = database.commodity_choose(book_typeOrName);
		}else {
			commodity_message = database.searchForBookName(book_typeOrName);
		}
		StringBuffer out_string = new StringBuffer("");
		for (int i = 0;i < commodity_message.length;i++){
			out_string.append("<tr><td>" + commodity_message[i][1] + "</td><td>" + commodity_message[i][2] + "</td><td>" + commodity_message[i][3] + "</td></tr>");
		}
		out.print(new String(out_string));
		out.close();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
