<%@ page contentType="text/html;charset=gb2312" %>

<html>
<head>
<title>系统参数</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript">
function work_add() //增加
{
  window.open("cs_add.jsp");
}

function work_query() //查询
{
  document.cs_form.target = "cs_frame";
  document.cs_form.action = "cs_list.jsp";
  document.cs_form.submit();
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
      <form name="cs_form" method="post">&nbsp;
        参数名称：<input type="text" name="csmc" class="input" style="width:150px;">&nbsp;
        <input type="button" value="查询" class="button" onclick="work_query();">&nbsp;
        <input type="button" value="增加" class="button" onclick="work_add();">
      </form>
    </td>
  </tr>
  <tr>
    <td height="400" class="box_top">
      <iframe name="cs_frame" src="" frameborder="0" scrolling="no" width="100%" height="100%"></iframe>
    </td>
  </tr>
</table>
</body>
</html>