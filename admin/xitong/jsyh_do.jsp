<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//角色用户_维护
String operate = request.getParameter("operate");
String jsid = request.getParameter("jsid");
String yhid = request.getParameter("yhid");

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

if (operate.equals("add")) //增加
{
  try
  {
    database.open();
  
    database.update("update t_yh set jsid = '" + jsid + "' where yhid = '" + yhid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/jsyh_do.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
  }
  finally
  {
    database.close();
  }
  
  out.println("<script language='javascript'>");
  out.println("alert('增加数据成功');");
  out.println("window.parent.parent.work_query();");
  out.println("</script>");
}

if (operate.equals("delete")) //删除
{
  try
  {
    database.open();
  
  	database.update("update t_yh set jsid = '-1' where yhid = '" + yhid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/jsyh_do.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
  }
  finally
  {
    database.close();
  }
  
  out.println("<script language='javascript'>");
  out.println("alert('删除数据成功');");
  out.println("window.parent.parent.work_query();");
  out.println("</script>");
}
%>