<script language="javaScript">
	function check()
	{
		if(myform.username.value=="")
		{
			alert("������������");
			return false;
		}
		if(myform.password.value=="")
		{
			alert("��������");
			return false;
		}
		var age=myform.age.value;
		for(i=0;i<age.length;i++)
		{
			if(age.charAt(i)<"0")
			{
				alert("���������֣�");
				return false;
			}
			else if(age.charAt(i)>"9")
			{
				alert("���������֣�");
				return false;
			}
		}
		var phone=myform.phone.value;
		for(i=0;i<phone.length;i++)
		{
			if(phone.charAt(i)<"0")
			{
				alert("���������֣�");
				return false;
			}
			else if(phone.charAt(i)>"9")
			{
				alert("���������֣�");
				return false;
			}
		}
		var em,index;
		em=myform.email.value;
		index=myform.email.value.indexOf('@');
		if(index<=0||index>=em.length-1)
		{
			alert("������Ϸ��ĵ����ʼ���ַ��");
			return false;
		}
	}
</script>
<%@ page contentType="text/html;charset=gb2312" import="java.sql.*"%>
<%@ page import="jspCourseDesign.*"%>
<jsp:useBean id="conn" class="dbBean.DBBean" scope="session"/>
<%	
request.setCharacterEncoding("gb2312");
String updateid=request.getParameter("updateid");
String p=request.getParameter("p");

String logid=(String)session.getAttribute("loginId");
int i=Integer.parseInt(logid);
if(i>=10001&&!logid.equals(updateid))
	response.sendRedirect("login.htm");

ResultSet rs=null;

String id="";
String name="";
String password="";
String sex="";
String age="";
String phone="";
String email="";
String address="";

	String sql="select * from user where id="+updateid;
	rs=JDBC.getConn().createStatement().executeQuery(sql);
	if(rs.next())
	{
		id=rs.getString("id");
		name=rs.getString("name");
		password=rs.getString("password");
		sex=rs.getString("sex");
		age=rs.getString("age");
		phone=rs.getString("phone");
		email=rs.getString("email");
		address=rs.getString("address");
	} 
	rs.close();
%>
<center>
<h2>�޸��û�</h2>
<hr>
<form name="myform" method="POST" action="dealupdate.jsp" onSubmit="return check()" target="right">
<table border width="100%" borderColorDark="#ffffec" borderColorLight="#5e5e00"> 
  <tr bgcolor="#f7f7f7">
	<td>����ţ�</td>
	<td><%=id%><input type="hidden" name="updateid" value="<%=id%>"></td>
  <tr bgcolor="#f7f7f7">
	<td>������</td>
	<td><input type="text" name="username" size="12" value="<%=name%>"></td>
  <tr bgcolor="#f7f7f7">
	<td>���</td>
	<td><input type="password" name="password" size="12" value="<%=password%>"></td>
  <tr bgcolor="#f7f7f7">
	<td>�Ա�</td>
	<td><input type="radio" name="sex" value="��" 
		<%if(sex.equals("��")) out.println("checked");%>>��
	<input type="radio" name="sex" value="Ů"
		<%if(sex.equals("Ů")) out.println("checked");%>>Ů</td>
  <tr bgcolor="#f7f7f7">
	<td>���䣺</td>
	<td><input type="text" name="age" size="12" value="<%=age%>"></td>
  <tr bgcolor="#f7f7f7">
	<td>�绰��</td>
	<td><input type="text" name="phone" size="12" value="<%=phone%>"></td>
  <tr bgcolor="#f7f7f7">
	<td>�����ʼ���</td>
	<td><input type="text" name="email" size="12" value="<%=email%>"></td>
  <tr bgcolor="#f7f7f7">
	<td>��ַ��</td>
	<td><input type="text" name="address" size="12" value="<%=address%>"></td>
  <tr bgcolor="#f7f7f7">
     <td colspan="2" align="center">
	<input type="submit" value="�޸�">&nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="reset" value="���">
     </td>
</table>
</form>
</center>