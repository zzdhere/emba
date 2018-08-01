<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//模块管理_维护
String operate = request.getParameter("operate");

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));
  
if (operate.equals("add")) //增加
{
  String mkid = Global.getInstance().getYear() + Global.getInstance().getMonth() + Global.getInstance().getDay() + Global.getInstance().getHour() + Global.getInstance().getMinute() + Global.getInstance().getSecond();
  String mc = request.getParameter("mc");
  String bsid = request.getParameter("bsid");
  String zt = request.getParameter("zt");  
  ResultSet rs = null;
  
  String xh = request.getParameter("xh");
  if (xh.equals(""))
    xh = "0";
    
  String tb = request.getParameter("tb");
  if (tb.equals(""))
    tb = "coin_14.png";
  
  try
  {
    database.open();
    
    //判断是否已经存在
    rs = database.query("select * from t_mk where mc = '" + mc + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('数据已经存在');");
      out.println("</script>");
      
      return;
	 	}
    
    database.update("insert into t_mk(mkid, mc, bsid, xh, tb, zt) values('" + mkid + "', '" + mc + "', '" + bsid + "', '" + xh + "', '" + tb + "', '" + zt + "')");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/mk_do.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
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
  String mkid = request.getParameter("mkid");
  String mc = request.getParameter("mc");
  String bsid = request.getParameter("bsid");
  String zt = request.getParameter("zt");
  ResultSet rs = null;
  
  String xh = request.getParameter("xh");
  if (xh.equals(""))
    xh = "0";
    
  String tb = request.getParameter("tb");
  if (tb.equals(""))
    tb = "coin_14.png";
  
  try
  {
    database.open();
 
    //判断是否已经存在
    rs = database.query("select * from t_mk where mc = '" + mc + "' and mkid != '" + mkid + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('数据已经存在');");
      out.println("</script>");
      
      return;
	 	}
 
    database.update("update t_mk set mc = '" + mc + "', bsid = '" + bsid + "', xh = '" + xh + "', tb = '" + tb + "', zt = '" + zt + "' where mkid = '" + mkid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/mk_do.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
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
  String mkid = request.getParameter("list");
  ResultSet rs = null;
  
  try
  {
    database.open();
    
    //判断是否还有功能
    rs = database.query("select * from t_gn where mkid = '" + mkid + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('该模块还有功能，不能删除');");
      out.println("</script>");
      
      return;
	 	}
  
    database.update("delete from t_mk where mkid = '" + mkid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/mk_do.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
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