<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="xcflow.Global" %>

<html>
<head>
<title>日志管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../../style/calendar.js"></script>
<script language="javascript">
function work_query() //查询
{
  document.rz_form.target = "rz_frame";
  document.rz_form.action = "rz_list.jsp";
  document.rz_form.submit();
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
      <form name="rz_form" method="post">&nbsp;
        起始日期：<input name="qsrq" type="text" class="input" style="width:150px;" onfocus="showCalendar(this);" value="<%=(Global.getInstance().getDate())%>" readonly>&nbsp;
        截止日期：<input name="jzrq" type="text" class="input" style="width:150px;" onfocus="showCalendar(this);" value="<%=(Global.getInstance().getDate())%>" readonly>&nbsp;&nbsp;
            &nbsp;
        <input type="button" value="查询" class="button" onclick="work_query();">
      </form>
    </td>
  </tr>
  <tr>
    <td height="400" class="box_top">
      <iframe name="rz_frame" src="" frameborder="0" scrolling="no" width="100%" height="100%"></iframe>
    </td>
  </tr>
</table>
</body>
</html>