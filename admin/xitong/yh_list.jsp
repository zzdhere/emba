<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//用户管理_列表
String yhmc = request.getParameter("yhmc");
String zt = request.getParameter("zt");
ResultSet rs = null;
Vector v = new Vector();
Vector v_all = new Vector();
Properties p = null;

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();

  rs = database.query(" select t_yh.*, t_js.mc jsmc" +
                      " from t_yh, t_js" +
                      " where t_yh.jsid = t_js.jsid" +
                      "       and t_yh.mc like '%" + yhmc + "%'" +
                      "       and t_yh.zt like '%" + zt + "%'");
  while (rs.next())
  {
    p = new Properties();

    p.setProperty("yhid", rs.getString("yhid"));
    p.setProperty("yhmc", rs.getString("mc"));
    p.setProperty("dm", rs.getString("dm"));
    p.setProperty("jsmc", rs.getString("jsmc"));

    if (rs.getString("zt").equals("Y"))
      p.setProperty("zt", "使用");
    else
      p.setProperty("zt", "停用");

    v_all.add(p);
  }
}
catch (Exception e)
{
  (new Log()).log("error", "admin/yonghu/yh_list.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
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
<title>用户管理_列表</title>
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript">
function work_modify(obj)
{
  window.open("yh_modify.jsp?list=" + obj);
}

function work_delete(obj)
{
  if (window.confirm("确定删除数据"))
    document.yh_list_frame.location.href = "yh_do.jsp?operate=delete&list=" + obj;
}

function work_set(obj)
{
  window.open("yhgn.jsp?yhid=" + obj);
}

function work_go(obj)
{
  document.yh_list_form.action = "yh_list.jsp";
  document.yh_list_form.target = "_self";
  document.yh_list_form.cpage.value = obj;
  document.yh_list_form.submit();

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
    document.yh_list_form.action = "yh_list.jsp";
    document.yh_list_form.target = "_self";
    document.yh_list_form.cpage.value = obj;
    document.yh_list_form.submit();
  }

  return false;
}
</script>
</head>
<body>
<form name="yh_list_form" method="post">
<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr><td width="100%" valign="top">
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
        	<td height="30" align="center" class="th box_left" nowrap>名称</td>
        	<td align="center" class="th box_left" nowrap>代码</td>
        	<td align="center" class="th box_left" nowrap>角色</td>
        	<td align="center" class="th box_left" nowrap>状态</td>
        	<td align="center" class="th box_left box_right" nowrap>操作</td>
        </tr>
    <%for (i = 0; i < v.size(); i++)
      {%>
        <tr>
          <td height="30" align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("yhmc"))%></td>
          <td align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("dm"))%></td>
          <td align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("jsmc"))%></td>
          <td align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("zt"))%></td>
          <td align="center" class="td box_top box_left box_right" nowrap>
            <a href="javascript:work_modify('<%=(((Properties) v.get(i)).getProperty("yhid"))%>');"><img src="../../style/images/pencil.png" border="0" alt="修改"></a>&nbsp;
            <a href="javascript:work_delete('<%=(((Properties) v.get(i)).getProperty("yhid"))%>');"><img src="../../style/images/cross.png" border="0" alt="删除"></a>&nbsp;
            <a href="javascript:work_set('<%=(((Properties) v.get(i)).getProperty("yhid"))%>');"><img src="../../style/images/hammer.png" border="0" alt="用户功能"></a>
          </td>
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
<input type="hidden" name="yhmc" value="<%=yhmc%>">
<input type="hidden" name="zt" value="<%=zt%>">
</form>

<iframe name="yh_list_frame" src="" frameborder="0" scrolling="no" width="0" height="0"></iframe>

</body>
</html>