<%@ page contentType="text/html;charset=gb2312" import="java.sql.*"%>
<%@ page import="jspCourseDesign.*"%>
<%@ include file="checkadmin.jsp"%>
<jsp:useBean id="conn" class="dbBean.DBBean" scope="session"/>
<%
	request.setCharacterEncoding("gb2312");
	String[] delid=request.getParameterValues("isdel");
	if(delid!=null)
	{
		for(int i=0;i<delid.length;i++)
			JDBC.getConn().createStatement().executeUpdate("delete from user where id="+delid[i]);
	}
	
	response.sendRedirect("delete.jsp"); 
%>
