<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="check.jsp"%>
<html>
<body background="stone.gif">
<font color="red" size="5"><strong><%=session.getAttribute("username")%>����ӭ��ʹ��ѧ���������ϵͳ��</strong></font>
<div align="right">
	<a href="left.htm" target="left">��ѯ�û�</a>
<%
	String id=(String)session.getAttribute("loginId");
	int i=Integer.parseInt(id);
	if(i<10001)
	{
		out.println("<a href='insert.htm' target='left'>����û�</a>");
		out.println("<a href='delete.jsp' target='right'>ɾ���û�</a>");
	}
	else
		out.println("<a href='update.jsp?updateid="+id+"' target='left'>�޸ĸ�������</a>");
%>
	<a href="logout.jsp" target="_top">�˳�</a>
</div>
</body>
</html>