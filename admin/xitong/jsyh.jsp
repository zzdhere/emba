<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
String jsid = request.getParameter("jsid");
String jsmc = "";
ResultSet rs = null;

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();

	rs = database.query("select * from t_js where jsid = '" + jsid + "'");
	if (rs.next())
    jsmc = rs.getString("mc");
}
catch (Exception e)
{
  (new Log()).log("error", "admin/xitong/jsyh.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
}
finally
{
  database.close();
}
%>

<html>
<head>
<title>角色用户</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"> 
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript">
function work_query()
{
  work_query_yx();
  work_query_wx();
}

function work_query_yx()
{
  document.jsyh_yx_form.action = "jsyh_select.jsp?jsid=<%=jsid%>";
  document.jsyh_yx_form.submit();
}

function work_query_wx()
{
  document.jsyh_wx_form.action = "jsyh_unselect.jsp?jsid=<%=jsid%>";
  document.jsyh_wx_form.submit();
}

function work_key()
{
  if (event.keyCode == 13)
    work_query();
}
</script>
</head>
<body class="background" style="text-align:center;" onload="work_query();" onkeydown="work_key();">

<br><br>

<table border="0" cellpadding="0" cellspacing="5" align="center">
  <tr>
    <td width="20" height="25"><img src="../../style/images/title2.gif" border="0" width="25" height="25"></td>
    <td class="title">角色用户</td>
  </tr>
</table>

<table width="95%" border="0" cellpadding="0" cellspacing="0" class="box_bottom">
  <tr>
    <td height="60" class="text">
        角色名称：<%=jsmc%>&nbsp;
        <input type="button" value="查询" class="button" onclick="work_query();">
    </td>
  </tr>
</table>

<br>

<table width="95%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="48%" height="340" class="text">
      <form name="jsyh_yx_form" method="post" target="jsyh_yx_frame">
      &nbsp;已选用户：<input type="text" name="yxyhmc" class="input">&nbsp;&nbsp;<input type="button" class="button" value="查询" onclick="work_query_yx();">
      </form>
      
      <br>
      
      <iframe name="jsyh_yx_frame" src="jsyh_select.jsp" frameborder="0" scrolling="no" width="100%" height="100%"></iframe>
    </td>
    <td width="4%">&nbsp;</td>
    <td width="48%" class="text">
      <form name="jsyh_wx_form" method="post" target="jsyh_wx_frame">
      &nbsp;未选用户：<input type="text" name="wxyhmc" class="input">&nbsp;&nbsp;<input type="button" class="button" value="查询" onclick="work_query_wx();">
      </form>
      
      <br>
      
      <iframe name="jsyh_wx_frame" src="jsyh_unselect.jsp" frameborder="0" scrolling="no" width="100%" height="100%"></iframe>
    </td>
  </tr>
</table>
</body>
</html>