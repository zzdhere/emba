<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
String mkid = request.getParameter("list");
String mc = null;
String bsid = null;
String xh = null;
String tb = null;
String zt = null;
ResultSet rs = null;
Vector v_bs = new Vector();
Properties p = null;
int i = 0;

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();

  rs = database.query("select * from t_mk where mkid = '" + mkid + "'");
  if (rs.next())
  {
    mc = rs.getString("mc");
    bsid = rs.getString("bsid");
    xh = rs.getString("xh");
    tb = rs.getString("tb");
    zt = rs.getString("zt");
  }
  
  rs = database.query("select * from t_bs where zt = 'Y' order by xh");
  while (rs.next())
  {
    p = new Properties();
    p.setProperty("bsid", rs.getString("bsid"));
    p.setProperty("mc", rs.getString("mc"));
    v_bs.add(p);
  }
}
catch (Exception e)
{
  (new Log()).log("error", "admin/xitong/mk_modify.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
}
finally
{
  database.close();
}
%>

<html>
<head>
<title>模块管理_修改</title>
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../../style/tool.js"></script>
<script language="javascript">
function work_save()
{
  if (document.mk_modify_form.mc.value == "")
  {
    alert("名称不能为空");
    return;
  }

  if (document.mk_modify_form.bsid.value == "")
  {
    alert("版式不能为空");
    return;
  }

  document.mk_modify_form.target = "mk_modify_frame";
  document.mk_modify_form.action = "mk_do.jsp?operate=modify";
  document.mk_modify_form.submit();
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
    <td class="title">模块管理_修改</td>
  </tr>
</table>

<br>

<form name="mk_modify_form" method="post">
<table border="0" cellpadding="0" cellspacing="0" align="center">
  <tr><td height="40" align="right" class="text">名&nbsp;&nbsp;&nbsp;&nbsp;称：</td>
      <td><input type="text" name="mc" value="<%=mc%>"></td>
  </tr>
  <tr><td height="40" align="right" class="text">版&nbsp;&nbsp;&nbsp;&nbsp;式：</td>
      <td><select name="bsid" class="select">
            <option value=""></option>
        <%for (i = 0; i < v_bs.size(); i++)
          {%>
            <option value="<%=(((Properties) v_bs.get(i)).getProperty("bsid"))%>"><%=(((Properties) v_bs.get(i)).getProperty("mc"))%></option>
        <%}%>
          </select>
      </td>
  </tr>
  <tr><td height="40" align="right" class="text">序&nbsp;&nbsp;&nbsp;&nbsp;号：</td>
      <td><input type="text" name="xh" value="<%=xh%>" style="width:50px;"></td>
  </tr>
  <tr><td height="40" align="right" class="text">图&nbsp;&nbsp;&nbsp;&nbsp;标：</td>
      <td><input type="text" name="tb" value="<%=tb%>"></td>
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
<input type="hidden" name="mkid" value="<%=mkid%>">
</form>

<iframe name="mk_modify_frame" src="" frameborder="0" scrolling="no" width="0" height="0"></iframe>

<script language="javascript">
  work_select(document.mk_modify_form.zt, '<%=zt%>');
  work_select(document.mk_modify_form.bsid, '<%=bsid%>');
</script>

</body>
</html>