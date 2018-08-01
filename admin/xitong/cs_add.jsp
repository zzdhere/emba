<%@ page contentType="text/html;charset=gb2312" %>

<html>
<head>
<title>系统参数_增加</title>
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../../style/tool.js"></script>
<script language="javascript">
function work_save()
{
  if (document.cs_add_form.dm.value == "")
  {
    alert("代码不能为空");
    return;
  }
  
  if (document.cs_add_form.mc.value == "")
  {
    alert("名称不能为空");
    return;
  }
  
  if (document.cs_add_form.nr.value == "")
  {
    alert("内容不能为空");
    return;
  }

  document.cs_add_form.target = "cs_add_frame";
  document.cs_add_form.action = "cs_do.jsp?operate=add";
  document.cs_add_form.submit();
}

function work_back()
{
  window.opener.work_query();
  window.close();
}
</script>
</head>
<body style="text-align:center;" class="background">

<br><br>

<table border="0" cellpadding="0" cellspacing="5" align="center">
  <tr>
    <td width="20" height="25"><img src="../../style/images/title2.gif" border="0" width="25" height="25"></td>
    <td class="title">系统参数_增加</td>
  </tr>
</table>

<br>

<form name="cs_add_form" method="post">
<table border="0" cellpadding="0" cellspacing="0" align="center">
  <tr><td height="40" align="right" class="text">代&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
      <td><input type="text" name="dm"></td>
  </tr>
  <tr><td height="40" align="right" class="text">名&nbsp;&nbsp;&nbsp;&nbsp;称：</td>
      <td><input type="text" name="mc"></td>
  </tr>
  <tr><td height="40" align="right" class="text">内&nbsp;&nbsp;&nbsp;&nbsp;容：</td>
      <td><input type="text" name="nr"></td>
  </tr>
  <tr>
    <td colspan="2" height="80" align="center" class="text">
      <input type="button" class="button" onclick="work_save();" value="保存">&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" class="button" onclick="window.close();" value="关闭">
    </td>
  </tr>
</table>
</form>

<iframe name="cs_add_frame" src="" frameborder="0" scrolling="no" width="0" height="0"></iframe>

</body>
</html>