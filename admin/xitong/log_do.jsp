<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.io.*" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//ÈÕÖ¾Î¬»¤
File f = null;

try
{
  f = new File(Global.getInstance().getPath() + "//log//" + request.getParameter("name"));
  if (f.exists())
    f.delete();
  
  response.sendRedirect("log.jsp");  
}
catch (Exception e)
{
  (new Log()).log("error", "admin/xitong/log_do.jsp£º" + Global.getInstance().getTime() + "£º" + e.getMessage());
}
%>