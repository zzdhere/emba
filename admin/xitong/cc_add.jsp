<%@ page contentType="text/html;charset=gb2312" %>

<html>
<head>
<title>仓储管理_增加</title>
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../../style/tool.js"></script>
<script language="javascript">
function work_save()
{
  if (document.cc_add_form.hwmc.value == "")
  {
    alert("名称不能为空");
    return;
  }

  document.cc_add_form.target = "cc_add_frame";
  document.cc_add_form.action = "cc_do.jsp?operate=add";
  document.cc_add_form.submit();
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
    <td class="title">仓储管理_增加</td>
  </tr>
</table>

<br>

<form name="cc_add_form" method="post">
<table border="0" cellpadding="0" cellspacing="0" align="center">
  <tr><td height="40" align="right" class="text">名&nbsp;&nbsp;&nbsp;&nbsp;称：</td>
      <td><input type="text" name="hwmc"></td>
  </tr>
  <tr><td height="40" align="right" class="text">编&nbsp;&nbsp;&nbsp;&nbsp;号：</td>
      <td><input type="text" name="bh" style="width:50px;"></td>
  </tr>
  <tr><td height="40" align="right" class="text">数&nbsp;&nbsp;&nbsp;&nbsp;量：</td>
      <td><input type="text" name="sl" style="width:50px;"></td>
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
</form>

<iframe name="cc_add_frame" src="" frameborder="0" scrolling="no" width="0" height="0"></iframe>

</body>
</html>