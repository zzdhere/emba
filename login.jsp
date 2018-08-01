<%@ page contentType="text/html;charset=utf-8" %>

<%
String message = "";
if (request.getAttribute("message") != null)
  message = (String) request.getAttribute("message");
%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>物理管理系统</title>
    <link href="style/login/css/style.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/JavaScript">
function work_login()
{
  if (document.login_form.user.value == "")
  {
    alert("账号不能为空");
    return;
  }

  if (document.login_form.password.value == "")
  {
    alert("密码不能为空");
    return;
  }

  document.login_form.submit();
}

function work_key()
{
  if (event.keyCode == 13)
    work_login();
}
</script>
<body onkeydown="work_key();">

<div class="top">
	<div><!--<div class="logo"><img src="style/login/images/logo.png" width="385" height="73" /></div>--></div>
</div>
<div class="banner">
	<div class="cunt">
		<div class="wbk">
			<div class="nr">
				<div class="bt"><img src="style/login/images/title.jpg" width="326" height="63" /></div>
				<form name="login_form" method="post" action="verify.jsp" target="_self">
				<div class="yhm">
					<span>账号：</span><input name="user" type="text" value="admin" />
				</div>
				<div class="yhm">
					<span>密码：</span><input name="password" type="password"  value="admin" />
				</div>
				<input name="" type="button" class="button" onclick="work_login();"/>
				</form>
			</div>
		</div>
	</div>
</div>
<div class="foot">
	<p>版权所有：张振东</p>
</div>
<script type="text/javascript" src="style/login/style/jquery-1.11.1.js"></script> 
<script type="text/javascript">
$(function () {
	/*获取body高度，将值赋予div元素*/
	var clientHeight = ($(window).height() - 124 - 63)
	if (clientHeight >= 400) {
		$(".banner").height(clientHeight)

		$(".wbk").css("margin-top", (clientHeight - 284 ) / 2)
	}
	else {
		$(".banner").height(400)
		$(".wbk").css("margin-top", 60)
	}
})
</script>

<script language="javascript">
if ("<%=message%>" != "")
  alert("<%=message%>");
</script>
</body>
</html>
