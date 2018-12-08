配置Tomcat的jndi数据源：
将以下配置填写完成后复制进Tomcat中tomcat/conf/context.xml的Context标签下即可

<Resource
name="jdbc/javacoursedesign"
type="javax.sql.DataSource"
maxActive="最大连接数"
maxIdle="空闲连接数"
maxWait="最大等待时间"
username="MySQL数据库账号"
password="MySQL数据库密码"
driverClassName="com.mysql.jdbc.Driver"
url="jdbc:mysql://你的数据库IP地址:3306/你的数据库名称?characterEncoding=UTF-8" />

使用MySQL新建数据库，名字与上面数据源名字相同
文件名字为“181208144708.psc”为数据库备份，将备份还原至你的数据库即可

项目源码为IDEA编写，请用IEAD打开