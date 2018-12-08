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
 *		Time: 14:11
 *       email: foxmaillucien@126.com
 *       Description:更新公告servlet
 */
public class updateAnnouncement extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		Database database = new Database();
		//接收数据
		String announcement = request.getParameter("announcement");
		database.updateAnnouncement(announcement);
		response.sendRedirect("/tomcat/backstage_supporter/updateAnnouncementFinish.jsp");      //更新完成后重定向
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req,resp);
	}
}
