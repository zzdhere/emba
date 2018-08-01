<%@ page contentType="text/html;charset=gb2312" %>

<html>
<head>
<title>提示信息</title>
<link href="../style/style.css" rel="stylesheet" type="text/css">
</head>
<body class="background">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr><td style="text-align:center;">
      <table width="348" height="221" border="0" cellpadding="0" cellspacing="0" background="../style/images/message.jpg" style="background-repeat:no-repeat;">
        <tr>
          <td width="90" height="160"></td>
          <td class="message" align="center"><br><br><%=((String) request.getAttribute("message"))%></td>
        </tr>
        <tr>
          <td colspan="2" align="center" class="box_top"><input type="button" value="关闭" class="button" onclick="window.close();"></td>
        </tr>
      </table>
  </td></tr>
</table>
</body>
</html>