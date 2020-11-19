<script language="javaScript">
	function check()
	{
		if(myform.username.value=="")
		{
			alert("请输入姓名！");
			return false;
		}
		if(myform.password.value=="")
		{
			alert("请输入口令！");
			return false;
		}
		var age=myform.age.value;
		for(i=0;i<age.length;i++)
		{
			if(age.charAt(i)<"0")
			{
				alert("请输入数字！");
				return false;
			}
			else if(age.charAt(i)>"9")
			{
				alert("请输入数字！");
				return false;
			}
		}
		var phone=myform.phone.value;
		for(i=0;i<phone.length;i++)
		{
			if(phone.charAt(i)<"0")
			{
				alert("请输入数字！");
				return false;
			}
			else if(phone.charAt(i)>"9")
			{
				alert("请输入数字！");
				return false;
			}
		}
		var em,index;
		em=myform.email.value;
		index=myform.email.value.indexOf('@');
		if(index<=0||index>=em.length-1)
		{
			alert("请输入合法的电子邮件地址！");
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
<h2>修改用户</h2>
<hr>
<form name="myform" method="POST" action="dealupdate.jsp" onSubmit="return check()" target="right">
<table border width="100%" borderColorDark="#ffffec" borderColorLight="#5e5e00"> 
  <tr bgcolor="#f7f7f7">
	<td>宿舍号：</td>
	<td><%=id%><input type="hidden" name="updateid" value="<%=id%>"></td>
  <tr bgcolor="#f7f7f7">
	<td>姓名：</td>
	<td><input type="text" name="username" size="12" value="<%=name%>"></td>
  <tr bgcolor="#f7f7f7">
	<td>口令：</td>
	<td><input type="password" name="password" size="12" value="<%=password%>"></td>
  <tr bgcolor="#f7f7f7">
	<td>性别：</td>
	<td><input type="radio" name="sex" value="男" 
		<%if(sex.equals("男")) out.println("checked");%>>男
	<input type="radio" name="sex" value="女"
		<%if(sex.equals("女")) out.println("checked");%>>女</td>
  <tr bgcolor="#f7f7f7">
	<td>年龄：</td>
	<td><input type="text" name="age" size="12" value="<%=age%>"></td>
  <tr bgcolor="#f7f7f7">
	<td>电话：</td>
	<td><input type="text" name="phone" size="12" value="<%=phone%>"></td>
  <tr bgcolor="#f7f7f7">
	<td>电子邮件：</td>
	<td><input type="text" name="email" size="12" value="<%=email%>"></td>
  <tr bgcolor="#f7f7f7">
	<td>地址：</td>
	<td><input type="text" name="address" size="12" value="<%=address%>"></td>
  <tr bgcolor="#f7f7f7">
     <td colspan="2" align="center">
	<input type="submit" value="修改">&nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="reset" value="清空">
     </td>
</table>
</form>
</center>