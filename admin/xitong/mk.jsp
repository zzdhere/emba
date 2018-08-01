<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
Vector v_bs = new Vector();
Properties p = null;
ResultSet rs = null;
int i = 0;

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();

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
  (new Log()).log("error", "admin/xitong/mk.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
}
finally
{
  database.close();
}
%>

<html>
<head>
<title>模块管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript">
function work_add() //增加
{
  window.open("mk_add.jsp");
}

function work_query() //查询
{
  document.mk_form.target = "mk_frame";
  document.mk_form.action = "mk_list.jsp";
  document.mk_form.submit();
}

function work_key()
{
  if (event.keyCode == 13)
    work_query();
}
</script>
</head>
<body class="background" style="text-align:center;" onload="work_query();" onkeydown="work_key();">
<table width="95%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td height="60" class="text">
      <form name="mk_form" method="post">&nbsp;
        版式名称：<select name="bsid" class="select">
                    <option value=""></option>
                <%for (i = 0; i < v_bs.size(); i++)
                  {%>
                    <option value="<%=(((Properties) v_bs.get(i)).getProperty("bsid"))%>"><%=(((Properties) v_bs.get(i)).getProperty("mc"))%></option>
                <%}%>
                  </select>&nbsp;
        模块名称：<input type="text" name="mkmc" class="input" style="width:150px;">&nbsp;
        <input type="button" value="查询" class="button" onclick="work_query();">&nbsp;
        <input type="button" value="增加" class="button" onclick="work_add();">
      </form>
    </td>
  </tr>
  <tr>
    <td height="400" class="box_top">
      <iframe name="mk_frame" src="" frameborder="0" scrolling="no" width="100%" height="100%"></iframe>
    </td>
  </tr>
</table>
</body>
</html>