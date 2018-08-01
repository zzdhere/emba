<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
String dm = request.getParameter("list");
String mc = "";
String nr = "";
ResultSet rs = null;

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();

  rs = database.query("select * from t_cs where dm = '" + dm + "'");
  if (rs.next())
  {
    mc = rs.getString("mc");
    nr = rs.getString("nr");
  }
}
catch (Exception e)
{
  (new Log()).log("error", "admin/xitong/cs_modify.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
}
finally
{
  database.close();
}
%>

<html>
<head>
<title>系统参数_修改</title>
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../../style/tool.js"></script>
<script language="javascript">
function work_save()
{
  if (document.cs_modify_form.mc.value == "")
  {
    alert("名称不能为空");
    return;
  }
  
  if (document.cs_modify_form.nr.value == "")
  {
    alert("内容不能为空");
    return;
  }

  document.cs_modify_form.target = "cs_modify_frame";
  document.cs_modify_form.action = "cs_do.jsp?operate=modify";
  document.cs_modify_form.submit();
}

function work_back()
{
  window.opener.parent.work_query();
  window.close();
}
</script>
</head>
<body style="text-align:center;" class="background">

<br><br>

<table border="0" cellpadding="0" cellspacing="5" align="center">
  <tr>
    <td width="20" height="25"><img src="../../style/images/title2.gif" border="0" width="25" height="25"></td>
    <td class="title">系统参数_修改</td>
  </tr>
</table>

<br>

<form name="cs_modify_form" method="post">
<table border="0" cellpadding="0" cellspacing="0" align="center">
  <tr><td height="40" align="right" class="text">代&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
      <td><input type="text" name="dm" value="<%=dm%>" readonly></td>
  </tr>
  <tr><td height="40" align="right" class="text">名&nbsp;&nbsp;&nbsp;&nbsp;称：</td>
      <td><input type="text" name="mc" value="<%=mc%>"></td>
  </tr>
  <tr><td height="40" align="right" class="text">内&nbsp;&nbsp;&nbsp;&nbsp;容：</td>
      <td><input type="text" name="nr" value="<%=nr%>"></td>
  </tr>
  <tr>
    <td colspan="2" height="80" align="center" class="text">
      <input type="button" class="button" onclick="work_save();" value="保存">&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" class="button" onclick="window.close();" value="关闭">
    </td>
  </tr>
</table>
</form>

<iframe name="cs_modify_frame" src="" frameborder="0" scrolling="no" width="0" height="0"></iframe>

</body>
</html>