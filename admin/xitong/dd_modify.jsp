<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
String ddid = request.getParameter("list");
String dd = null;
String ddrq = null;
String dddz= null;
String zt = null;
ResultSet rs = null;
Vector v_js = new Vector();
Properties p = null;
int i = 0;

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();

  rs = database.query("select * from t_dd where ddid = '" + ddid + "'");
  if (rs.next())
  {
    dd = rs.getString("dd");
    ddrq = rs.getString("ddrq");
	dddz = rs.getString("dddz");
    zt = rs.getString("zt");
  }
}
catch (Exception e)
{
  (new Log()).log("error", "admin/xitong/dd_modify.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
}
finally
{
  database.close();
}
%>

<html>
<head>
<title>订单管理_修改</title>
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../../style/tool.js"></script>
<script language="javascript">
function work_save()
{
  if (document.dd_modify_form.dd.value == "")
  {
    alert("名称不能为空");
    return;
  }

  document.dd_modify_form.target = "dd_modify_frame";
  document.dd_modify_form.action = "dd_do.jsp?operate=modify";
  document.dd_modify_form.submit();
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
    <td class="title">订单管理_修改</td>
  </tr>
</table>

<br>

<form name="dd_modify_form" method="post">
<table border="0" cellpadding="0" cellspacing="0" align="center">
  <tr><td height="40" align="right" class="text">名&nbsp;&nbsp;&nbsp;&nbsp;称：</td>
      <td><input type="text" name="dd" value="<%=dd%>"></td>
  </tr>
  <tr><td height="40" align="right" class="text">日&nbsp;&nbsp;&nbsp;&nbsp;期：</td>
      <td><input type="text" name="ddrq" value="<%=ddrq%>" style="width:50px;"></td>
  </tr>
  <tr><td height="40" align="right" class="text">地&nbsp;&nbsp;&nbsp;&nbsp;址：</td>
      <td><input type="text" name="dddz" value="<%=dddz%>" style="width:50px;"></td>
  </tr>
  <tr><td height="40" align="right" class="text">状&nbsp;&nbsp;&nbsp;&nbsp;态：</td>
      <td><select name="zt" class="select">
            <option value="Y">使用</option>
            <option value="N">停用</option>
          </select>
      </td>
  </tr>
  <tr>
    <td colspan="2" height="80" align="center" class="text">
      <input type="button" class="button" onclick="work_save();" value="保存">&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" class="button" onclick="window.close();" value="关闭">
    </td>
  </tr>
</table>
<input type="hidden" name="ddid" value="<%=ddid%>">
</form>

<iframe name="dd_modify_frame" src="" frameborder="0" scrolling="no" width="0" height="0"></iframe>

<script language="javascript">
  work_select(document.dd_modify_form.zt, '<%=zt%>');
</script>

</body>
</html>