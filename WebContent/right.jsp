<%@ page contentType="text/html;charset=gb2312" import="java.sql.*"%>
<%@ page import="jspCourseDesign.*"%>
<%@ include file="check.jsp"%>
<jsp:useBean id="conn" class="dbBean.DBBean" scope="session"/>
<%!
//每页显示的记录个数
int size = 8;
//当前页号
int p = 1;
//全部的页数
int totalPage = 1;
String str = "";
//显示页号为p的一页
public String printPage(ResultSet rs, int p, int size,int logId) 
{
	  str = "";
	  //将访问游标定位到页号为p的页要显示的第一条记录的位置
	  try {
	  	for(int k=0;k<(p-1)*size;k++)	
			rs.next();
	  }
	  catch(SQLException e) {   }
	  for(int iPage=1; iPage<=size; iPage++) {
	     str += printRow(rs,iPage,p,logId);
	     try {
		 if(!rs.next()) break;
	     }
	     catch(Exception e) {   }
	  }
	  return str;
}	
//显示单行记录
public String printRow( ResultSet rs ,int i,int p,int logId) 
{
	String temp = "";
	try {
		if(i%2==1)
			temp+="<tr bgcolor='#e7e7e7'>";
		else
			temp+="<tr bgcolor='#f7f7f7'>";   
		String id=rs.getString("id");

		if(logId<10001)
			temp+="<td><a href='update.jsp?updateid="+id+"&p="+p+"' target='left'>"+id+"</a></td>";
		else
			temp+="<td>"+id+"</td>";
		temp+="<td>"+rs.getString("name")+"</td>";
		temp+="<td>"+rs.getString("sex")+"</td>";
		temp+="<td>"+rs.getString("age")+"</td>";
		temp+="<td>"+rs.getString("phone")+"</td>";
		temp+="<td>"+rs.getString("email")+"</td>";
		temp+="<td>"+rs.getString("address")+"</td>";
	        temp += "</tr>";
	}
	catch(SQLException e) {   }
		return temp;
}
%>

<%
	request.setCharacterEncoding("gb2312");
	String type="";
	String key="";
	if(request.getParameter("stype")!=null)
	{
		type=request.getParameter("stype");
		session.setAttribute("stype",type);
	}
	if(request.getParameter("skey")!=null)
	{
		key=request.getParameter("skey");
		session.setAttribute("skey",key);
	}
	ResultSet rs=null;
	String sql="select * from user";
	if(session.getAttribute("stype")!=null)
		type=(String)session.getAttribute("stype");
	if(session.getAttribute("skey")!=null)
		key=(String)session.getAttribute("skey");
	if(type!=null && key!=null && !type.equals("") && !key.equals(""))
	{
		if(type.equals("id")||type.equals("age"))
			sql += " where "+type+"="+key;
		else
			sql += " where "+type+"='"+key+"'";
	}
	sql+=" order by id asc";	
	rs = JDBC.getConn().createStatement().executeQuery(sql);
%>
<center>
<table border="1" borderColorDark="#ffffec" borderColorLight="#5e5e00" width="100%">
<tr bgcolor="#cccccc" align="center">
<th>宿舍号</th><th>姓名</th><th>性别</th><th>年龄</th><th>联系电话</th><th>电子邮件</th><th>地址</th>
<%
	ResultSet rsTmp=null;
	String sql2="select count(*) from user";
	if(type!=null && key!=null && !type.equals("") && !key.equals(""))
	{
		if(type.equals("id")||type.equals("age"))
			sql2 += " where "+type+"="+key;
		else
			sql2 += " where "+type+"='"+key+"'";
	}
	rsTmp = JDBC.getConn().createStatement().executeQuery(sql2);
	int totalrecord=0;
	if(rsTmp.next())
		totalrecord = rsTmp.getInt(1);
	// 如果是当前页码的整数倍	
	if(totalrecord % size ==0) totalPage = totalrecord / size;  
	// 如果最后还空余一页
	else  totalPage = (int) Math.floor( totalrecord / size ) + 1;   
	if(totalPage == 0) totalPage = 1;
	rsTmp.close();
	try {
		if(request.getParameter("p")==null|| request.getParameter("p").equals("")) 
		{
		   if(session.getAttribute("rightp")==null)
			p = 1;
		   else
			p = ((Integer)session.getAttribute("rightp")).intValue();
		}
		else
		{
		   p = Integer.parseInt(request.getParameter("p"));			   session.setAttribute("rightp",new Integer(p));
		}
	} 
	// 捕获用户从浏览器地址拦直接输入非数字信息而引起的异常
	catch(NumberFormatException e) {  
		   p = 1;
	}
	if(p < 1)  p = 1;
	if(p > totalPage) p = totalPage;
	if(rs.next())
	{
		int logId=Integer.parseInt((String)session.getAttribute("loginId"));
		out.println(printPage(rs,p,size,logId));
	}
%>
</table>
<form Action="right.jsp" Method="GET">
<%
  for(int i=1;i<=totalPage;i++) {
      out.println("<a href=right.jsp?p=" + i +">" + i + "</a>&nbsp;&nbsp;");
  }
%>
  <p>输入页数：<input type="text" name="p" size="3"> 
     页数：<font color="red"><%=p%>/<%=totalPage%></font> 
  </p>
</form>
</center>
<%
	rs.close();
%>
				



