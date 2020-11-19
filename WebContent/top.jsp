<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="check.jsp"%>
<html>
<body background="stone.gif">
<font color="red" size="5"><strong><%=session.getAttribute("username")%>，欢迎您使用学生宿舍管理系统！</strong></font>
<div align="right">
	<a href="left.htm" target="left">查询用户</a>
<%
	String id=(String)session.getAttribute("loginId");
	int i=Integer.parseInt(id);
	if(i<10001)
	{
		out.println("<a href='insert.htm' target='left'>添加用户</a>");
		out.println("<a href='delete.jsp' target='right'>删除用户</a>");
	}
	else
		out.println("<a href='update.jsp?updateid="+id+"' target='left'>修改个人资料</a>");
%>
	<a href="logout.jsp" target="_top">退出</a>
</div>
</body>
</html>