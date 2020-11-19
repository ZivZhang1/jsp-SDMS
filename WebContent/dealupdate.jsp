<%@ page contentType="text/html;charset=gb2312" import="java.sql.*"%>
<%@ page import="jspCourseDesign.*"%>
<jsp:useBean id="conn" class="dbBean.DBBean" scope="session"/>
<%
request.setCharacterEncoding("gb2312");

String id="0";
String name="";
String password="";
String sex="";
String age="0";
String phone="";
String email="";
String address="";

if(request.getParameter("updateid")!=null)
	id=request.getParameter("updateid");
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

	String sql="update user set name='"+name+"',password='"+password+"',sex='"+sex+"',age="+age+",phone='"+phone+"',email='"+email+"',address='"+address+"' where id="+id;
	JDBC.getConn().createStatement().executeUpdate(sql);

	response.sendRedirect("right.jsp");
%>

