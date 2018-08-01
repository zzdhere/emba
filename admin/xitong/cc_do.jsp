<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//仓储管理_维护
String operate = request.getParameter("operate");

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));
  
if (operate.equals("add")) //增加
{
  String hwid = Global.getInstance().getYear() + Global.getInstance().getMonth() + Global.getInstance().getDay() + Global.getInstance().getHour() + Global.getInstance().getMinute() + Global.getInstance().getSecond();
  String hwmc = request.getParameter("hwmc");
  String sl = request.getParameter("sl");  
  ResultSet rs = null;
  
  String bh = request.getParameter("bh");
  if (bh.equals(""))
    bh = "0";
  
  try
  {
	  
    database.open();
		
    
    //判断是否已经存在
    rs = database.query("select * from t_cc where hwmc = '" + hwmc + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('数据已经存在');");
      out.println("</script>");
      
      return;
	 	}

    database.update("insert into t_cc(hwid, hwmc, bh, sl) values('" + hwid + "', '" + hwmc + "', '" + bh + "', '" + sl + "')");
	
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/cc_do.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
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
  String hwid = request.getParameter("hwid");
  String hwmc = request.getParameter("hwmc");
  String sl = request.getParameter("sl");
  ResultSet rs = null;
  
  String bh = request.getParameter("bh");
  if (bh.equals(""))
    bh = "0";
  
  try
  {
    database.open();
 
    //判断是否已经存在
    rs = database.query("select * from t_cc where hwmc = '" + hwmc + "' and hwid != '" + hwid + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('数据已经存在');");
      out.println("</script>");
      
      return;
	 	}
 
    database.update("update t_cc set hwmc = '" + hwmc + "', bh = '" + bh + "', sl = '" + sl + "' where hwid = '" + hwid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/cc_do.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
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
  String hwid = request.getParameter("list");
  ResultSet rs = null;
  
  try
  {
    database.open();
  
    //判断是否还有模块
    rs = database.query("select * from t_mk where hwid = '" + hwid + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('该版式还有模块，不能删除');");
      out.println("</script>");
      
      return;
	 	}
	 	
    database.update("delete from t_cc where hwid = '" + hwid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/cc_do.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
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