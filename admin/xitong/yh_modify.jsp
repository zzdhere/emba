<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Encrypt" %>
<%@ page import="xcflow.Log" %>

<%
String yhid = request.getParameter("list");
String dm = "";
String mc = "";
String mm = "";
String jsid = "";
String zt = "";
ResultSet rs = null;
Vector v_js = new Vector();
Properties p = null;
int i = 0;

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();

  rs = database.query("select * from t_yh where yhid = '" + yhid + "'");
  if (rs.next())
  {
    dm = rs.getString("dm");
    mm = Encrypt.getInstance().getDesString(rs.getString("mm"));
    mc = rs.getString("mc");
    jsid = rs.getString("jsid");
    zt = rs.getString("zt");
  }

  rs = database.query("select * from t_js where zt = 'Y' order by xh");
  while (rs.next())
  {
    p = new Properties();
    
    p.setProperty("jsid", rs.getString("jsid"));
    p.setProperty("mc", rs.getString("mc"));
    
    v_js.add(p);
  }
}
catch (Exception e)
{
  (new Log()).log("error", "admin/yonghu/yh_modify.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
}
finally
{
  database.close();
}
%>

<html>
<head>
<title>用户管理_修改</title>
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../../style/tool.js"></script>
<script language="javascript" src="../../style/calendar.js"></script>
<script language="javascript">
function work_save()
{
  if (document.yh_modify_form.mc.value == "")
  {
    alert("名称不能为空");
    return;
  }

  if (document.yh_modify_form.mm.value == "")
  {
    alert("密码不能为空");
    return;
  }

  if (document.yh_modify_form.dm.value == "")
  {
    alert("代码不能为空");
    return;
  }
  
  if (document.yh_modify_form.jsid.value == "")
  {
    alert("角色不能为空");
    return;
  }

  document.yh_modify_form.target = "yh_modify_frame";
  document.yh_modify_form.action = "yh_do.jsp?operate=modify";
  document.yh_modify_form.submit();
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
    <td class="title">用户管理_修改</td>
  </tr>
</table>

<br><br>

<form name="yh_modify_form" method="post">
<table border="0" cellpadding="0" cellspacing="0" align="center">
  <tr><td height="40" align="right" class="text">名&nbsp;&nbsp;&nbsp;&nbsp;称：</td>
      <td><input type="text" name="mc" value="<%=mc%>"></td>
  </tr>
  <tr><td height="40" align="right" class="text">代&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
      <td><input type="text" name="dm" value="<%=dm%>"></td>
  </tr>
  <tr><td height="40" align="right" class="text">密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
      <td><input type="text" name="mm" value="<%=mm%>"></td>
  </tr>
  <tr><td height="40" align="right" class="text">角&nbsp;&nbsp;&nbsp;&nbsp;色：</td>
      <td><select name="jsid" class="select">
            <option value=""></option>
        <%for (i = 0; i < v_js.size(); i++)
          {%>
            <option value="<%=(((Properties) v_js.get(i)).getProperty("jsid"))%>"><%=(((Properties) v_js.get(i)).getProperty("mc"))%></option>
        <%}%>
          </select>
      </td>
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
<input type="hidden" name="yhid" value="<%=yhid%>">
</form>

<iframe name="yh_modify_frame" src="" frameborder="0" scrolling="no" width="0" height="0"></iframe>

<script language="javascript">
  work_select(document.yh_modify_form.jsid, '<%=jsid%>');
  work_select(document.yh_modify_form.zt, '<%=zt%>');
</script>
</body>
</html>