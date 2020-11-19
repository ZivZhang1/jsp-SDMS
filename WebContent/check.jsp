<%
	if(session.getAttribute("loginId")==null)  
		response.sendRedirect("login.htm");
%>
