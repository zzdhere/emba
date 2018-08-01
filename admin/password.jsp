<%@ page contentType="text/html;charset=gb2312" %>

<html>
<head>
<title>修改密码</title>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript">
function work_ok()
{
  if (document.password_form.password_old.value == "")
  {
    alert("旧的密码不能为空");
    return;
  }

  if (document.password_form.password_new.value == "")
  {
    alert("新的密码不能为空");
    return;
  }
  
  if (document.password_form.password_new1.value == "")
  {
    alert("确认密码不能为空");
    return;
  }
  
  if (document.password_form.password_new.value != document.password_form.password_new1.value)
  {
    alert("新的密码和确认密码不一致");
    return;
  }
  
  document.password_form.submit();
}
</script>
</head>
<body style="text-align:center;" class="background">
<br><br>

<table border="0" cellpadding="0" cellspacing="5">
  <tr>
    <td width="20" height="25"><img src="../style/images/title2.gif" border="0" width="25" height="25"></td>
    <td class="title">修改密码</td>
  </tr>
</table>

<br>
 
<form method="post" name="password_form" action="password_do.jsp">
<table border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="50" align="right" class="text">&nbsp;&nbsp;旧的密码：</td>
    <td><input class="input" type="password" style="width: 300px;" name="password_old"></td>
  </tr>
  <tr>
    <td height="50" align="right" class="text">&nbsp;&nbsp;新的密码：</td>
    <td><input class="input" type="password" style="width: 300px;" name="password_new"></td>
  </tr>
  <tr>
    <td height="50" align="right" class="text">&nbsp;&nbsp;确认密码：</td>
    <td><input class="input" type="password" style="width: 300px;" name="password_new1"></td>
  </tr>
  <tr>
    <td colspan="2" height="80" align="center">&nbsp;&nbsp;
      <input type="button" value="确定" class="button" onclick="work_ok();">&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" value="取消" class="button" onclick="window.close();">
    </td>
  </tr>
</table>
</form>
</body>
</html>