<%@ page contentType="text/html;charset=gb2312" import="java.sql.*"%>
<%@ page import="jspCourseDesign.*"%>


<jsp:useBean id="conn" class="dbBean.DBBean" scope="session"/>
<jsp:setProperty name="conn" property="connStr" value="jdbc:odbc:user"/>
<%
	session.setMaxInactiveInterval(-1);
	//��ȡ����
	String username=request.getParameter("username");
	//����õ�������������ת������ֹ������������
	username=new String(username.getBytes("8859_1"));
	//��ȡ����
	String password=request.getParameter("password");
	//�Կ�����б���ת��
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