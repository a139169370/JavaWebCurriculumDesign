<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  UserMess: 龙猫
  Date: 2018/11/24
  Time: 16:35
  email: foxmaillucien@126.com
  Description:将注册表单信息插入数据库servlet
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>insert_user</title>
</head>
<body>
    <%
        try {
            request.setCharacterEncoding("utf-8");
//        获取表单信息
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String gender = request.getParameter("gender");
            String email = request.getParameter("email");
            String telephone = request.getParameter("telephone");
            String introduce = request.getParameter("introduce");
            String activeCode = request.getParameter("activeCode");

            int state = 0;
            if (activeCode == "123456" | "123456".equals(activeCode)){
                state = 1;
            }

            String role;        //用户类型，未定义
            String regist_time;
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            regist_time = simpleDateFormat.format(new Date());

            Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultSet = null;
            InitialContext initialContext = new InitialContext();
            DataSource dataSource = (DataSource) initialContext.lookup("java:comp/env/jdbc/javacoursedesign");
            connection = dataSource.getConnection();
            String sql = "insert into user(username,password,gender,email,telephone,introduce,activeCode,state,registtime) values(?,?,?,?,?,?,?,?,?)";
            preparedStatement = connection.prepareStatement(sql);
            //插入数据
            preparedStatement.setString(1,username);
            preparedStatement.setString(2,password);
            preparedStatement.setString(3,gender);
            preparedStatement.setString(4,email);
            preparedStatement.setString(5,telephone);
            preparedStatement.setString(6,introduce);
            preparedStatement.setString(7,activeCode);
            preparedStatement.setInt(8,state);
            preparedStatement.setString(9,regist_time);
            int row = preparedStatement.executeUpdate();
            response.sendRedirect("insert_finish.jsp");      //插入完成后重定向
        }catch (Exception e){
        	e.printStackTrace();
        }
    %>
</body>
</html>
