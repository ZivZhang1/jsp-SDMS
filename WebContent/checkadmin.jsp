<%
	if(session.getAttribute("loginId")!=null) 
	{
		int id=Integer.parseInt((String)session.getAttribute("loginId"));
		if(id>=10001)
			response.sendRedirect("login.htm");
	}
	else
		response.sendRedirect("login.htm");	
%>
