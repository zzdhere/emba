<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//表单选择_维护
String pId = request.getParameter("id");
String bsid = request.getParameter("mkid");
StringBuffer sb = new StringBuffer();
String json = null;
int i = 0;
ResultSet rs = null;

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();

  rs = database.query("select * from t_mk where bsid = '" + bsid + "'");
  while (rs.next())
  {
    if (i > 0)
      sb.append(",");
      
    sb.append("{id:'" + pId + String.valueOf(i) + "',");
    sb.append("pId:'" + pId + "',");
    sb.append("name:'" + rs.getString("mc") + "',");
    sb.append("isParent:false,");
    sb.append("mkid:'" + rs.getString("mkid") + "'}");
    
    i = i + 1;
  }
    
  json = "[" +
           sb +
         "]";
}
catch (Exception e) 
{
  (new Log()).log("error", "admin/xitong/mkxz_do.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
}
finally
{
  database.close();
}

out.println(json);
%>