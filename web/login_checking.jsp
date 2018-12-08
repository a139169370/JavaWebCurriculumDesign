<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>

<%--
  Created by IntelliJ IDEA.
  UserMess: 龙猫
  Date: 2018/11/24
  Time: 17:32
  email: foxmaillucien@126.com
  Description:登录表单提交验证账户名密码页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="UserMess.UserMessage" %>
<html>
<head>
    <title></title>
</head>
<body>
    <%
        String username = new String(request.getParameter("username").getBytes("iso8859-1"),"utf-8");			//中文转码
        String password = request.getParameter("password");
        try {
        	Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultSet = null;
            InitialContext initialContext = new InitialContext();
            DataSource dataSource = (DataSource) initialContext.lookup("java:comp/env/jdbc/javacoursedesign");
            connection = dataSource.getConnection();
            String sql = "select * from user where username = ? and password = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1,username);
            preparedStatement.setString(2,password);
            resultSet = preparedStatement.executeQuery();
            String role = "";           //用户权限
            String user_id = "",state = "";
            Boolean isExist = false;
            while (resultSet.next()){       //验证用户激活状况
            	if (resultSet.getInt("state") == 1){
            		user_id = resultSet.getString("id");
            		state = resultSet.getString("state");
                    role = resultSet.getString("role");
            		isExist = true;
                }
            }

            if (isExist){
            	UserMessage userMessage = new UserMessage();
            	userMessage.setName(username);
            	userMessage.setUser_id(user_id);
            	userMessage.setState(state);
            	session.setAttribute("username",username);      //将用户名存入session
                session.setAttribute("UserMessage",userMessage);        //将javabean存入session
                if (role.equals("普通用户")){
                    response.sendRedirect("directory.jsp");      //通过验证，重定向到主页
                }else {
                    response.sendRedirect("/tomcat/backstage_supporter/directory.jsp");      //通过验证，重定向到主页
                }
            }else {
                response.sendRedirect("login_checked_fail.jsp");      //未通过验证，重定向到失败页
            }
        }catch (Exception e){
        	e.printStackTrace();
        }
    %>
</body>
</html>
