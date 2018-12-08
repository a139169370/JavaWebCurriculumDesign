package order_message;

import java.text.SimpleDateFormat;
import java.util.Date;

/*
 *		Created by IntelliJ IDEA.
 *		User:龙猫
 *		Date: 2018/11/28
 *		Time: 19:09
 *       email: foxmaillucien@126.com
 *       Description:订单号生成类
 */
public class OrderNumberCreate {
	private String OrderNumber;

	public OrderNumberCreate(String user_id) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");     //格式化
		StringBuffer date = new StringBuffer(simpleDateFormat.format(new Date()));      //取得当前时间戳
		date.append(user_id);
		OrderNumber = new String(date);
	}

	public String getOrderNumber() {
		return OrderNumber;
	}

	public void setOrderNumber(String orderNumber) {
		OrderNumber = orderNumber;
	}
}
