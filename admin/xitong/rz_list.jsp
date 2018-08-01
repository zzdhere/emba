<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
	//日志管理_列表
	ResultSet rs = null;
	Vector v = new Vector();
	Vector v_all = new Vector();
	Properties p = null;
	String qsrq = request.getParameter("qsrq");
	String jzrq = request.getParameter("jzrq");

	Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

	try
	{
	database.open();

	rs = database.query("select * from t_rz where rq >= '" + qsrq + "' and rq <= '" + jzrq + "' order by rq desc, sj desc");
	while (rs.next())
	{
	p = new Properties();

		p.setProperty("rq", rs.getString("rq"));
	p.setProperty("sj", rs.getString("sj"));
	p.setProperty("yhdm", rs.getString("yhdm"));
	p.setProperty("nr", rs.getString("nr"));
	p.setProperty("ip", rs.getString("ip"));

	v_all.add(p);
	}
	}
	catch (Exception e)
	{
	(new Log()).log("error", "admin/xitong/rz_list.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
	}
	finally
	{
	database.close();
	}

	//以下处理分页列表显示
	int rpage = 10; //每页记录数
	int npage = 0; //总页数
	int nrow = 0; //总记录数
	int i = 0;

	int cpage = 1; //当前页数
	if (request.getParameter("cpage") != null)
	cpage = Integer.parseInt(request.getParameter("cpage"));

	nrow = v_all.size();
	if (nrow < rpage)
	npage = 1;
	else
	{
	if ((nrow % rpage) == 0)
	npage = nrow / rpage;
	else
	npage = nrow / rpage + 1;
	}

	i = 0;
	while (i < v_all.size())
	{
	if (((cpage == 1) && (i < rpage)) || ((cpage != 1) && (i >= (cpage - 1) * rpage) && (i < cpage * rpage)))
	v.add(v_all.get(i));

	if (i >= cpage * rpage)
	break;
	i = i + 1;
	}
%>

<html>
<head>
<title>日志管理_列表</title>
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript">
function work_go(obj) 
{
  document.rz_list_form.action = "rz_list.jsp";
  document.rz_list_form.target = "_self";
  document.rz_list_form.cpage.value = obj;
  document.rz_list_form.submit();
  
  return false;
}

function work_jump(obj) 
{
  if ((obj < 1) && (event.keyCode == 13))
    alert("页数不能小于1");
  
  if ((obj > <%=npage%>) && (event.keyCode == 13)) 
    alert("页数不能大于" + <%=npage%>);
  
  if ((obj >= 1) && (obj <= <%=npage%>) && (event.keyCode == 13)) 
  {
    document.rz_list_form.action = "rz_list.jsp";
    document.rz_list_form.target = "_self";
    document.rz_list_form.cpage.value = obj;
    document.rz_list_form.submit();
  }  
  
  return false;
}
</script>
</head>
<body>
<form name="rz_list_form" method="post">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr><td width="100%" valign="top">
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
        	<td height="30" align="center" class="th box_left" nowrap>日期</td>
        	<td align="center" class="th box_left" nowrap>时间</td>
        	<td align="center" class="th box_left" nowrap>用户</td>
        	<td align="center" class="th box_left" nowrap>IP</td>
        	<td align="center" class="th box_left box_right" nowrap>内容</td>
        </tr>
    <%for (i = 0; i < v.size(); i++)
      {%>
        <tr>
          <td height="30" align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("rq"))%></td>
          <td align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("sj"))%></td>
          <td align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("yhdm"))%></td>
          <td align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("ip"))%></td>
          <td class="td box_top box_left box_right" nowrap><%=(((Properties) v.get(i)).getProperty("nr"))%></td>
        </tr>
    <%}%>
      </table>
  </td></tr>
  <tr><td align="right" class="box_top">
      <table border="0" cellpadding="0" cellspacing="0">
        <tr><td class="text">共<%=nrow%>条 共<%=cpage%>/<%=npage%>页</td>
            <td class="text">
          <%if (cpage > 1)
            {%>
              &nbsp;<a href="" onclick="return work_go(<%=(cpage - 1)%>);">上一页</a>
          <%}
            else
            {%>
              &nbsp;上一页
          <%}
   
            if (cpage < npage)
            {%>
              <a href="" onclick="return work_go(<%=(cpage + 1)%>);">下一页</a>
          <%}
            else
            {%>
              下一页
          <%}%>
            </td>
            <td valign="top" class="text">&nbsp;到<input type="text" style="height:16px; width:20px;" value="<%=cpage%>" class="input" onkeydown="work_jump(this.value);">页</td>
        </tr>
      </table>
  </td></tr>
</table>
<input type="hidden" name="cpage" value="<%=cpage%>">
<input type="hidden" name="qsrq" value="<%=qsrq%>">
<input type="hidden" name="jzrq" value="<%=jzrq%>">
</form>
</body>
</html>