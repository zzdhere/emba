<%@ page contentType="text/html;charset=gb2312" %>

<html>
<head>
<title>功能管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript">
function work_add() //增加
{
  window.open("gn_add.jsp");
}

function work_mk() //模块选择
{
  window.open("mkxz_open.jsp","mkxz_open","toolbar=no,menubar=no,resizable=no,scrollbars=no,top=100,left=200,width=550,height=500");
}

function work_mk_back(operate, mkid, mkmc) //模块选择返回
{
  document.gn_form.operate.value = operate;
  document.gn_form.mkid.value = mkid;
  document.gn_form.mkmc.value = mkmc;
}

function work_query() //查询
{
  document.gn_form.target = "gn_frame";
  document.gn_form.action = "gn_list.jsp";
  document.gn_form.submit();
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
      <form name="gn_form" method="post">&nbsp;
        模块名称：<input type="text" name="mkmc" class="input" style="width:150px;" readonly onclick="work_mk();">&nbsp;
        功能名称：<input type="text" name="gnmc" class="input" style="width:150px;">&nbsp;
        <input type="button" value="查询" class="button" onclick="work_query();">&nbsp;
        <input type="button" value="增加" class="button" onclick="work_add();">
        <input type="hidden" name="operate" value="mk">
        <input type="hidden" name="mkid" value="">
      </form>
    </td>
  </tr>
  <tr>
    <td height="400" class="box_top">
      <iframe name="gn_frame" src="" frameborder="0" scrolling="no" width="100%" height="100%"></iframe>
    </td>
  </tr>
</table>
</body>
</html>