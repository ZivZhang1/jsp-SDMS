<%@ page contentType="text/html;charset=gb2312" import="java.sql.*"%>
<%@ page import="jspCourseDesign.*"%>
<jsp:useBean id="conn" class="dbBean.DBBean" scope="session"/>
<jsp:setProperty name="conn" property="connStr" value="jdbc:odbc:user"/>
<%
request.setCharacterEncoding("gb2312");
String name="";
String password="";
String sex="";
String age="0";
String phone="";
String email="";
String address="";
int id=10000;
if(request.getParameter("username")!=null)
	name=request.getParameter("username");
if(request.getParameter("password")!=null)
	password=request.getParameter("password");
if(request.getParameter("sex")!=null)
	sex=request.getParameter("sex");
if(request.getParameter("age")!=null && !(request.getParameter("age").equals("")))
	age=request.getParameter("age");
if(request.getParameter("phone")!=null)
	phone=request.getParameter("phone");
if(request.getParameter("email")!=null)
	email=request.getParameter("email");
if(request.getParameter("address")!=null)
	address=request.getParameter("address");
	ResultSet  rs=null;
	rs  =  conn.executeQuery("select max(id) from user");
	if(rs.next())
		id=rs.getInt(1);
	id++;
	rs.close();
	String sql="insert into user values("+id+",'"+name+"','"+password+"','"+sex+"',"+age+",'"+phone+"','"+email+"','"+address+"')";	
	JDBC.getConn().createStatement().executeUpdate(sql);
	out.println("��ϲ����ע��ɹ���<br>");
	out.println("<a href='login.htm'>���ص�¼ҳ��</a>");	

%>
