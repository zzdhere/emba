<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Encrypt" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Xml" %>
<%@ page import="xcflow.Log" %>

<%
//登录验证
String user = request.getParameter("user");
String password = request.getParameter("password");
String success = "false";
String system_name = "";
String system_right = "";
String system_service = "";
String system_year = "";
String system_version = "";
String system_database = "";
ResultSet rs = null;
Properties p = new Properties();
String message = null;

Global.getInstance().setPath(session.getServletContext().getRealPath(""));

try
{

  Xml xml = new Xml(Global.getInstance().getPath() + "/WEB-INF/config.xml");
  system_name = xml.select("/config/system/name");
  system_right = xml.select("/config/system/right");
  system_service = xml.select("/config/system/service");
  system_year = xml.select("/config/system/year");
  system_version = xml.select("/config/system/version");
  system_database = xml.select("/config/system/database");
}
catch (Exception e)
{
  (new Log()).log("error", "verify.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
}

Database database = new Database(system_database);

try
{
	
  database.open();
	
  rs = database.query("select * from t_yh where dm = '" + user + "'");
 
  if (rs.next())
  {
    if (rs.getString("mm").equals(Encrypt.getInstance().getEncString(password)))
    {
      success = "true";
	
      p.setProperty("yhid", rs.getString("yhid")); //用户ID
      p.setProperty("yhdm", user); //用户代码
      p.setProperty("yhmc", rs.getString("mc")); //用户名称
      p.setProperty("jsid", rs.getString("jsid")); //角色ID
      p.setProperty("system", system_name); //系统名称
      p.setProperty("right", system_right); //版权所有
      p.setProperty("service", system_service); //技术支持
      p.setProperty("year", system_year); //使用年份
      p.setProperty("version", system_version); //系统版本
      p.setProperty("database", system_database); //默认数据库
      database.update("insert into t_rz(yhdm, rq, sj, nr, lx, ip) values('" + user + "', '" + Global.getInstance().getDate() + "', '" + Global.getInstance().getTime() + "', '登录系统成功', '1', '" + request.getRemoteAddr() + "')");
    }
    else
    {
      message = "账号与密码不匹配";
      
      database.update("insert into t_rz(yhdm, rq, sj, nr, lx, ip) values('" + user + "', '" + Global.getInstance().getDate() + "', '" + Global.getInstance().getTime() + "', '登录密码错误', '1', '" + request.getRemoteAddr() + "')");
    }
  }
  else
  {
    message = "登录用户不存在";
  
    database.update("insert into t_rz(yhdm, rq, sj, nr, lx, ip) values('" + user + "', '" + Global.getInstance().getDate() + "', '" + Global.getInstance().getTime() + "', '登录用户不存在', '1', '" + request.getRemoteAddr() + "')");
  }
}
catch (Exception e)
{
  (new Log()).log("error", "verify.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
}
finally
{
  database.close();
}

if (success.equals("false"))
{
  request.setAttribute("message", message);
  request.getRequestDispatcher("login.jsp").forward(request, response);
}

if (success.equals("true"))
{
  session.setAttribute("global", p);
  //session.setMaxInactiveInterval(60 * 30); //会话超时30分钟
  session.setMaxInactiveInterval(60 * 60 * 24); //会话超时24小时
  
  response.sendRedirect("admin/admin.jsp");
}
%>