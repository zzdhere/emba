<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Encrypt" %>
<%@ page import="xcflow.Log" %>

<%
//修改密码维护
String password_old = request.getParameter("password_old");
String password_new = request.getParameter("password_new");
String dm = ((Properties) session.getAttribute("global")).getProperty("yhdm");
ResultSet rs = null;
String message = "";

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();

  //判断旧密码是否正确
  rs = database.query("select * from t_yh where dm = '" + dm + "' and mm = '" + Encrypt.getInstance().getEncString(password_old) + "'");
  if (! rs.next())
  {
    request.setAttribute("message", "旧的密码不正确");
    request.getRequestDispatcher("message.jsp").forward(request, response);
    return;
 	}

  database.update("update t_yh set mm = '" + Encrypt.getInstance().getEncString(password_new) + "' where dm = '" + dm + "'");

  message = "修改密码成功";
}
catch (Exception e)
{
  (new Log()).log("error", "admin/password_do.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
}
finally
{
  database.close();
}

request.setAttribute("message", message);
request.getRequestDispatcher("message.jsp").forward(request, response);
%>