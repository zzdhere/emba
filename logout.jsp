<%@ page contentType="text/html;charset=gb2312" %>

<%
//ÍË³öÏµÍ³
session.removeAttribute("global");
response.sendRedirect("index.jsp");
%>