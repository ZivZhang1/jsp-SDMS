<%@ page contentType="text/html;charset=gb2312" import="java.sql.*"%>
<%@ page import="jspCourseDesign.*"%>


<jsp:useBean id="conn" class="dbBean.DBBean" scope="session"/>
<jsp:setProperty name="conn" property="connStr" value="jdbc:odbc:user"/>
<%
	session.setMaxInactiveInterval(-1);
	//获取姓名
	String username=request.getParameter("username");
	//将获得的姓名进行内码转换，防止中文乱码问题
	username=new String(username.getBytes("8859_1"));
	//获取口令
	String password=request.getParameter("password");
	//对口令进行编码转换
	password=new String(password.getBytes("8859_1"));
	ResultSet  rs=null;
	String sql="select * from user where name='"+username+"' and password='"+password+"'";
	rs = JDBC.getConn().createStatement().executeQuery(sql);
	if(rs.next())
	{
		session.setAttribute("loginId",rs.getString("id"));
		session.setAttribute("username",rs.getString("name"));
		rs.close();
		
		response.sendRedirect("home.jsp");
	}
	else   	
	{
		rs.close();
		conn.close();
		response.sendRedirect("login.htm");
	}
%>