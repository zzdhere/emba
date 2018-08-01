<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
File[] list = null;
int i = 0;

Global.getInstance().setPath(request.getSession(false).getServletContext().getRealPath(""));

try
{
  list = (new File(Global.getInstance().getPath() + "//log")).listFiles();
}
catch (Exception e)
{
  (new Log()).log("error", "admin/xitong/log.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
}
%>

<html>
<head>
<title>运行日志</title>
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<body class="background" style="text-align:center;">

<br>

<table border="0" cellpadding="0" cellspacing="5" align="center">
  <tr>
    <td width="20" height="25"><img src="../../style/images/title2.gif" border="0" width="25" height="25"></td>
    <td class="title">运行日志</td>
  </tr>
</table>

<br>

<table width="800" border="1" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30" width="60%" align="center" class="th">文件</td>
    <td height="30" width="40%" align="center" class="th">操作</td>
  </tr>
<%for (i = 0; i < list.length; i++)
  {
    if (list[i].isFile())
    {%>
    <tr>
      <td height="30" align="center" class="td"><a href="../../log/<%=(list[i].getName())%>" title="查看" target="_blank"><%=(list[i].getName())%></a></td>
      <td height="30" align="center" class="td"><a href="log_do.jsp?name=<%=(list[i].getName())%>"><img src="../../style/images/cross.png" border="0" alt="删除"></a></td>
    </tr>
<%  }    
  }%>
</table>
</body>
</html>