package Data;

import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

/*
 *		Created by IntelliJ IDEA.
 *		UserMess:龙猫
 *		Date: 2018/11/25
 *		Time: 13:46
 *       email: foxmaillucien@126.com
 *       Description:数据库类
 */

public class Database {
	private Connection connection = null;
	public Database() {			//打开链接
		try {
			InitialContext initialContext = new InitialContext();
			DataSource dataSource = (DataSource) initialContext.lookup("java:comp/env/jdbc/javacoursedesign");
			connection = dataSource.getConnection();
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	public String[][] commodity_choose(String commodity_type){			//根据商品类型返回商品信息数组
		try {
			String sql = "select id,name,price,pnum,isDelete from products where category = ?";
			PreparedStatement preparedStatement = null;
			if (commodity_type.equals("all")){
				sql = "select id,name,price,pnum from products";
				preparedStatement = connection.prepareStatement(sql);
			}else {
				preparedStatement = connection.prepareStatement(sql);
				preparedStatement.setString(1,commodity_type);
			}
			ResultSet resultSet = preparedStatement.executeQuery();
			//获取获得记录的行数
			int count_row;
			resultSet.last();
			count_row = resultSet.getRow();
			resultSet.beforeFirst();		//将记录返回第一行

			String commodity_message[][] = new String[count_row][4];
			int row = 0;
			int col = 0;
			while (resultSet.next()){
				col = 0;
				commodity_message[row][col] = resultSet.getString(1);
				commodity_message[row][++col] = resultSet.getString(2);
				commodity_message[row][++col] = resultSet.getString(3);
				commodity_message[row][++col] = resultSet.getString(4);
				row++;
			}
			connection.close();
			return commodity_message;
		}catch (Exception e){
			e.printStackTrace();
		}
		return null;
	}

	public String[][] searchForBookName(String book_name){									//根据输入书名模糊查询商品信息
		try {
			String sql = "select id,name,price,pnum from products where name like ? and isDelete = 0";

			StringBuffer stringBuffer = new StringBuffer("%");
			stringBuffer.append(book_name);
			stringBuffer.append("%");
			book_name = new String(stringBuffer);

			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1,book_name);
			ResultSet resultSet = preparedStatement.executeQuery();
			//获取获得记录的行数
			int count_row;
			resultSet.last();
			count_row = resultSet.getRow();
			resultSet.beforeFirst();		//将记录返回第一行

			String commodity_message[][] = new String[count_row][4];
			int row = 0;
			int col = 0;
			while (resultSet.next()){
				col = 0;
				commodity_message[row][col] = resultSet.getString(1);
				commodity_message[row][++col] = resultSet.getString(2);
				commodity_message[row][++col] = resultSet.getString(3);
				commodity_message[row][++col] = resultSet.getString(4);
				row++;
			}
			connection.close();
			return commodity_message;
		}catch (Exception e){
			e.printStackTrace();
		}
		return null;
	}

	//表单信息插入数据库
	public void insert_order_message(String order_id,Double money,String receiverAddress,String receiverName,String receiverPhone,String user_id,String product_ids[],String product_nums[]){
		try {
			connection.setAutoCommit(false);
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");     //格式化
			StringBuffer date = new StringBuffer(simpleDateFormat.format(new Date()));      //取得当前时间戳
			String sql_orders = "INSERT orders(id,money,receiverAddress,receiverName,receiverPhone,ordertime,user_id) values(?,?,?,?,?,?,?)";

			PreparedStatement preparedStatement = connection.prepareStatement(sql_orders);
			preparedStatement.setString(1,order_id);
			preparedStatement.setDouble(2,money);
			preparedStatement.setString(3,receiverAddress);
			preparedStatement.setString(4,receiverName);
			preparedStatement.setString(5,receiverPhone);
			preparedStatement.setString(6,new String(date));
			preparedStatement.setString(7,user_id);
			preparedStatement.executeUpdate();

			String sql_orderitem = "INSERT orderitem values(?,?,?)";
			String sql_products = "UPDATE products SET pnum = pnum-? where id = ?";
			PreparedStatement preparedStatement1[] = new PreparedStatement[product_ids.length];
			PreparedStatement preparedStatement2[] = new PreparedStatement[product_ids.length];
			for (int i = 0;i < product_ids.length;i++){
				preparedStatement1[i] = connection.prepareStatement(sql_orderitem);
				preparedStatement1[i].setString(1,order_id);
				preparedStatement1[i].setString(2,product_ids[i]);
				preparedStatement1[i].setString(3,product_nums[i]);
				preparedStatement1[i].executeUpdate();

				preparedStatement2[i] = connection.prepareStatement(sql_products);
				preparedStatement2[i].setInt(1,Integer.valueOf(product_nums[i]));
				preparedStatement2[i].setString(2,product_ids[i]);
				preparedStatement2[i].executeUpdate();
			}
			connection.commit();
		}catch (Exception e){
			e.printStackTrace();
			try {
				connection.rollback();
			}catch (Exception el){
				el.printStackTrace();
			}
		}finally {
			try {
				connection.setAutoCommit(true);
				connection.close();
			}catch (Exception elw){
				elw.printStackTrace();
			}
		}
	}

	public String[][] query_order_message(String message_type,String orderID,String receiverName){				//根据条件返回订单信息二元数组
		try {
			String sql = null;
			if (message_type.equals("all")){			//查询所有商品
				sql = "select orders.id,receiverName,receiverAddress,receiverPhone,money,username,paystate from orders join user on user.id = orders.user_id";
			}else if (message_type.equals("condition_query")){			//按条件查询，修改SQL语句
				StringBuffer sqlBuffer = new StringBuffer("select orders.id,receiverName,receiverAddress,receiverPhone,money,username,paystate from orders join user on user.id = orders.user_id");
				//将订单号和收货人字符串头尾去空格
				orderID = orderID.trim();
				receiverName = receiverName.trim();
				Boolean orderIdAppend = false;		//布尔类型判断是否添加了订单编号这个查询条件，以判断SQL语句是否要添加and关键字
				//如果这两个条件不为空，则sql语句添加上相应的查询条件
				if (!orderID.equals("")){
					sqlBuffer.append(" where orders.id = " + orderID + " ");
					orderIdAppend = true;
				}
				if (!receiverName.equals("")){
					if (orderIdAppend){
						sqlBuffer.append("and receiverName = '" + receiverName + "'");
					}else {
						sqlBuffer.append(" where receiverName = '" + receiverName + "'");
					}
				}
				sql = new String(sqlBuffer);
			}else {
				return null;
			}
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			ResultSet resultSet = preparedStatement.executeQuery();
			//获取获得记录的行数
			int count_row;
			resultSet.last();
			count_row = resultSet.getRow();
			resultSet.beforeFirst();		//将记录返回第一行
			String order_message[][] = new String[count_row][7];
			int clo = 0,row = 0;
			while (resultSet.next()){
				clo = 0;
				order_message[row][clo] = resultSet.getString(1);
				order_message[row][++clo] = resultSet.getString(2);
				order_message[row][++clo] = resultSet.getString(3);
				order_message[row][++clo] = resultSet.getString(4);
				order_message[row][++clo] = resultSet.getString(5);
				order_message[row][++clo] = resultSet.getString(6);
				if (resultSet.getInt(7) == 0){			//判断支付状态
					order_message[row][++clo] = "未支付";
				}else {
					order_message[row][++clo] = "已支付";
				}
				row++;
			}
			connection.close();
			return order_message;
		}catch (Exception e){
			e.printStackTrace();
		}
		return null;
	}

	public void del_orders(String order_id){				//根据订单ID删除数据库订单信息
		try {
			order_id = order_id.trim();
			String sql_orders = "delete from orders where id = ?";
			String sql_orderitem = "delete from orderitem where order_id = ?";
			//因为必须先删除外键约束表orderitem中的内容，再删除orders，两个操作一起执行所以关闭自动提交
			connection.setAutoCommit(false);
			PreparedStatement preparedStatement_orderitem = connection.prepareStatement(sql_orderitem);
			preparedStatement_orderitem.setString(1,order_id);
			preparedStatement_orderitem.executeUpdate();

			PreparedStatement preparedStatement_orders = connection.prepareStatement(sql_orders);
			preparedStatement_orders.setString(1,order_id);
			preparedStatement_orders.executeUpdate();
			connection.commit();		//提交操作
		}catch (Exception e){
			e.printStackTrace();
			//捕捉异常回滚提交
			try {
				connection.rollback();
			}catch (Exception e1){
				e1.printStackTrace();
			}
		}finally {
			try {
				connection.setAutoCommit(true);			//恢复自动提交
				connection.close();
			}catch (Exception e2){
				e2.printStackTrace();
			}
		}
	}

	public String[][] query_product_messageForID_type(String message_type,String productID,String category){				//根据条件返回商品信息二元数组
		try {
			String sql = null;
			if (message_type.equals("all")){			//查询所有商品
				sql = "select * from products where isDelete = 0";
			}else if (message_type.equals("condition_query")){			//按条件查询，修改SQL语句
				StringBuffer sqlBuffer = new StringBuffer("select * from products where isDelete = 0");
				//将订单号和收货人字符串头尾去空格
				productID = productID.trim();
				category = category.trim();
				//如果这两个条件不为空，则sql语句添加上相应的查询条件
				if (!productID.equals("")){
					sqlBuffer.append(" and id = " + productID + " ");
				}
				if (!category.equals("")){
						sqlBuffer.append("and category = '" + category + "'");
				}
				sql = new String(sqlBuffer);
			}else {
				return null;
			}
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			ResultSet resultSet = preparedStatement.executeQuery();
			//获取获得记录的行数
			int count_row;
			resultSet.last();
			count_row = resultSet.getRow();
			resultSet.beforeFirst();		//将记录返回第一行

			String order_message[][] = new String[count_row][7];
			int clo = 0,row = 0;
			while (resultSet.next()){
				clo = 0;
				order_message[row][clo] = resultSet.getString(1);
				order_message[row][++clo] = resultSet.getString(2);
				order_message[row][++clo] = resultSet.getString(3);
				order_message[row][++clo] = resultSet.getString(4);
				order_message[row][++clo] = resultSet.getString(5);
				order_message[row][++clo] = "无";						//数据库无该项数值，故以‘无’填充
				order_message[row][++clo] = "无";
				row++;
			}
			connection.close();
			return order_message;
		}catch (Exception e){
			e.printStackTrace();
		}
		return null;
	}

	public void del_product(String productID){				//根据订单ID删除数据库商品信息
		try {
			productID = productID.trim();
			String sql = "update products set isDelete = 1 where id = ?";
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1,productID);
			preparedStatement.executeUpdate();
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public String[] queryAllCategory(){					//查询并返回所有商品类型
		try {
			String sql = "select distinct category from products";				//查询products中不重复的商品类型
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			ResultSet resultSet = preparedStatement.executeQuery();
			//获取获得记录的行数
			int count_row;
			resultSet.last();
			count_row = resultSet.getRow();
			resultSet.beforeFirst();		//将记录返回第一行

			String category[] = new String[count_row];
			int i = 0;
			while (resultSet.next()){
				category[i] = resultSet.getString(1);
				i++;
			}
			return category;
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public void insertNewProductMessages(String productID,String productName,String money,String pnum,String category,String img_url,String description){			//插入新商品信息
		try {
			String sql = "insert products values(?,?,?,?,?,?,?,0)";
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1,productID);
			preparedStatement.setString(2,productName);
			preparedStatement.setString(3,money);
			preparedStatement.setString(4,category);
			preparedStatement.setString(5,pnum);
			preparedStatement.setString(6,img_url);
			preparedStatement.setString(7,description);
			preparedStatement.executeUpdate();
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public String[] queryProductForProductID(String productID){					//根据商品ID返回商品信息数组
		try {
			productID = productID.trim();
			String sql = "select * from products where id = ?";
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1,productID);
			ResultSet resultSet = preparedStatement.executeQuery();
			String productMessage[] = new String[7];
			while (resultSet.next()){
				for (int i = 0;i < productMessage.length-1;i++){				//length-1:不将isDelete字段插入
					productMessage[i] = resultSet.getString(i+1);			//将数据逐一插入
				}
			}
			resultSet.close();
			return productMessage;
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public void updateProductMessages(String productID,String productName,String money,String pnum,String category,String img_url,String description){			//更新商品信息
		try {
			String sql = "update products set id = ?,name = ?,price = ?,category = ?,pnum = ?,imgurl = ?,description = ? where id = ?";
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1,productID);
			preparedStatement.setString(2,productName);
			preparedStatement.setString(3,money);
			preparedStatement.setString(4,category);
			preparedStatement.setString(5,pnum);
			preparedStatement.setString(6,img_url);
			preparedStatement.setString(7,description);
			preparedStatement.setString(8,productID);
			preparedStatement.executeUpdate();
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public String queryAnnouncement(){					//查询公告
		try {
			String sql = "select * from announcement";
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			ResultSet resultSet = preparedStatement.executeQuery();
			String announcement = null;
			while (resultSet.next()){
				announcement = resultSet.getString(1);
			}
			return announcement;
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public void updateAnnouncement(String announcement){				//更新公告
		try {
			String sql = "update announcement set announcement = ?";
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1,announcement);
			preparedStatement.executeUpdate();
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public Connection getConnection() {
		return connection;
	}

	public void setConnection(Connection connection) {
		this.connection = connection;
	}

	public void setConnection() {				//每个方法使用后都会关闭连接，此方法重新打开连接
		try {
			InitialContext initialContext = new InitialContext();
			DataSource dataSource = (DataSource) initialContext.lookup("java:comp/env/jdbc/javacoursedesign");
			connection = dataSource.getConnection();
		}catch (Exception e){
			e.printStackTrace();
		}
	}
}
