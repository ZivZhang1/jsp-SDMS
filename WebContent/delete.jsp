<%@ page contentType="text/html;charset=gb2312" import="java.sql.*"%>
<%@ page import="jspCourseDesign.*"%>
<%@ include file="checkadmin.jsp"%>
<jsp:useBean id="conn" class="dbBean.DBBean" scope="session"/>
<%!
//ÿҳ��ʾ�ļ�¼����
int size = 8;
//��ǰҳ��
int p = 1;
//ȫ����ҳ��
int totalPage = 1;
String str = "";
//��ʾҳ��Ϊp��һҳ
public String printPage(ResultSet rs, int p, int size) 
{
	  str = "";
	  //�������α궨λ��ҳ��Ϊp��ҳҪ��ʾ�ĵ�һ����¼��λ��
	  try {
	  	for(int k=0;k<(p-1)*size;k++)	
			rs.next();
	  }
	  catch(SQLException e) {   }
	  for(int iPage=1; iPage<=size; iPage++) {
	     str += printRow(rs,iPage);
	     try {
		 if(!rs.next()) break;
	     }
	     catch(Exception e) {   }
	  }
	  return str;
}	
//��ʾ���м�¼
public String printRow( ResultSet rs ,int i) 
{
		String temp = "";
		try {
		if(i%2==1)
			temp+="<tr bgcolor='#e7e7e7'>";
		else
			temp+="<tr bgcolor='#f7f7f7'>";   
		String id=rs.getString("id");
		temp+="<td><a href='update.jsp?updateid="+id+"' target='left'>"+id+"</a></td>";
		temp+="<td>"+rs.getString("name")+"</td>";
		temp+="<td>"+rs.getString("sex")+"</td>";
		temp+="<td>"+rs.getString("age")+"</td>";
		temp+="<td>"+rs.getString("email")+"</td>";
		temp+="<td align='center'><input type='checkbox' name='isdel' value='"+id+"'></td>";
	        temp += "</TR>";
		}
		catch(SQLException e) {   }
		return temp;
}
%>

<%
	ResultSet  rs=null;
	rs  =  JDBC.getConn().createStatement().executeQuery("select * from user order by id");
%>
<center>
<form method="post" action="dealdelete.jsp">
<table border="1" borderColorDark="#ffffec" borderColorLight="#5e5e00" width="100%">
<tr bgcolor="#cccccc" align="center">
<th>�����</th><th>����</th><th>�Ա�</th><th>����</th><th>�����ʼ�</th><th>�Ƿ�ɾ��</th>
<%
	ResultSet rsTmp=null;
	rsTmp = JDBC.getConn().createStatement().executeQuery("select count(*) as mycount from user");
	int totalrecord=0;
	if(rsTmp.next())
		totalrecord = rsTmp.getInt("mycount");
	// �����¼����ҳ����������
	if(totalrecord % size ==0) totalPage = totalrecord / size; 
	// �����󻹿���һҳ 
	else  totalPage = (int) Math.floor( totalrecord / size ) + 1;   
	if(totalPage == 0) totalPage = 1;
	rsTmp.close();
	try {
		if(request.getParameter("p")==null|| request.getParameter("p").equals("")) 
		{
		   if(session.getAttribute("deletep")==null)
			p = 1;
		   else
			p = ((Integer)session.getAttribute("deletep")).intValue();
		}
		else
		{
		   p = Integer.parseInt(request.getParameter("p"));			   session.setAttribute("deletep",new Integer(p));
		}
	} 
	// �����û����������ַ��ֱ�������������Ϣ���������쳣
	catch(NumberFormatException e) {  p = 1;}
	if(p < 1)  p = 1;
	if(p > totalPage) p = totalPage;

	if(rs.next())
		out.println(printPage(rs,p,size));
%>
</table>
<p>
<input type="submit" value="ɾ��">
<input type="reset" value="����">
</form>
<form Action="delete.jsp" Method="GET">
<%
  for(int i=1;i<=totalPage;i++) {
      out.println("<a href=delete.jsp?p=" + i + ">" + i + "</a>&nbsp;&nbsp;");
  }
%>
  <p>����ҳ����<input type="text" name="p" size="3"> 
     ҳ����<font color="red"><%=p%>/<%=totalPage%></font> 
  </p>
</form>
</center>
<%
	rs.close();

%>