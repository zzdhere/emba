<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//订单管理_维护
String operate = request.getParameter("operate");

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));
  
if (operate.equals("add")) //增加
{
  String ddid = Global.getInstance().getYear() + Global.getInstance().getMonth() + Global.getInstance().getDay() + Global.getInstance().getHour() + Global.getInstance().getMinute() + Global.getInstance().getSecond();
  String dd = request.getParameter("dd");
  String ddrq = request.getParameter("ddrq");  
  ResultSet rs = null;
  
  String dddz = request.getParameter("dddz");
  
  
  try
  {
	  
    database.open();
		
  		
    //判断是否已经存在
    rs = database.query("select * from t_dd where dd = '" + dd + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('数据已经存在');");
      out.println("</script>");
      
      return;
	 	}

    database.update("insert into t_dd(ddid, dd, dddz, ddrq) values('" + ddid + "', '" + dd + "', '" + dddz + "', '" + ddrq + "')");
	
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/dd_do.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
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
  String ddid = request.getParameter("ddid");
  String dd = request.getParameter("dd");
  String ddrq = request.getParameter("ddrq");
  ResultSet rs = null;
  
  String dddz = request.getParameter("dddz");
  
  try
  {
    database.open();
 
    //判断是否已经存在
    rs = database.query("select * from t_dd where dd = '" + dd + "' and ddid != '" + ddid + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('数据已经存在');");
      out.println("</script>");
      
      return;
	 	}
 
    database.update("update t_dd set dd = '" + dd + "', dddz = '" + dddz + "', ddrq = '" + ddrq + "' where ddid = '" + ddid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/dd_do.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
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
  String ddid = request.getParameter("list");
  ResultSet rs = null;
  
  try
  {
    database.open();
  
    //判断是否还有模块
    rs = database.query("select * from t_mk where ddid = '" + ddid + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('该版式还有模块，不能删除');");
      out.println("</script>");
      
      return;
	 	}
	 	
    database.update("delete from t_dd where ddid = '" + ddid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/dd_do.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
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