<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
String operate = request.getParameter("operate");

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));
  
if (operate.equals("add")) //增加
{
  String dm = request.getParameter("dm");
  String mc = request.getParameter("mc");
  String nr = request.getParameter("nr");
  
  try
  {
    database.open();
    
    database.update("insert into t_cs(dm, mc, nr) values('" + dm + "', '" + mc + "', '" + nr + "')");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/cs_do.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
  }
  finally
  {
    database.close();
  }
  
  out.println("<script language='javascript'>");
  out.println("alert('增加数据成功');");
  out.println("window.parent.work_back();");
  out.println("</script>");
}

if (operate.equals("modify")) //修改
{
  String dm = request.getParameter("dm");
  String mc = request.getParameter("mc");
  String nr = request.getParameter("nr");
  
  try
  {
    database.open();
 
    database.update("update t_cs set mc = '" + mc + "', nr = '" + nr + "' where dm = '" + dm + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/cs_do.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
  }
  finally
  {
    database.close();
  }
  
  out.println("<script language='javascript'>");
  out.println("alert('修改数据成功');");
  out.println("window.parent.work_back();");
  out.println("</script>");
}

if (operate.equals("delete")) //删除
{
  String dm = request.getParameter("list");
  
  try
  {
    database.open();
  
 	 	database.update("delete from t_cs where dm = '" + dm + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/cs_do.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
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