package jspCourseDesign;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBC {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		Connection conn = getConn();
		if (conn!=null) System.out.println("succ");

	}

	public static Connection getConn() throws ClassNotFoundException, SQLException {
		String uri ="jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC&useSSL=true";

		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection(uri,"root","111111");

		return conn;
	}

}
