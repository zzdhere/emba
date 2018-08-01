<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//用户功能_未选列表
String wxgnmc = request.getParameter("wxgnmc");
String yhid = request.getParameter("yhid");
ResultSet rs = null;
Vector v = new Vector();
Vector v_all = new Vector();
Properties p = null;

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();

  rs = database.query(" select t_gn.*, t_mk.mc mkmc" +
                      " from t_gn, t_mk" +
                      " where t_gn.mkid = t_mk.mkid" +
                      "       and t_gn.mc like '%" + wxgnmc + "%'" +
                      "       and not exists (select t_yh_gn.*" +
                      "                       from t_yh_gn" +
                      "                       where t_yh_gn.gnid = t_gn.gnid" +
                      "                             and t_yh_gn.yhid = '" + yhid + "')");
  while (rs.next())
  {
    p = new Properties();

    p.setProperty("gnid", rs.getString("gnid"));
    p.setProperty("gnmc", rs.getString("mc"));
    p.setProperty("mkmc", rs.getString("mkmc"));
      
    v_all.add(p);
  }
}
catch (Exception e)
{
  (new Log()).log("error", "admin/yonghu/yhgn_unselect.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
}
finally
{
  database.close();
}

//以下处理分页列表显示
int rpage = 8; //每页记录数
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
<title>用户功能_未选列表</title>
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript">
function work_add(obj)
{
  document.yhgn_unselect_frame.location.href = "yhgn_do.jsp?operate=add&yhid=<%=yhid%>&gnid=" + obj;
}

function work_go(obj) 
{
  document.yhgn_unselect_form.action = "yhgn_unselect.jsp";
  document.yhgn_unselect_form.target = "_self";
  document.yhgn_unselect_form.cpage.value = obj;
  document.yhgn_unselect_form.submit();
  
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
    document.yhgn_unselect_form.action = "yhgn_unselect.jsp";
    document.yhgn_unselect_form.target = "_self";
    document.yhgn_unselect_form.cpage.value = obj;
    document.yhgn_unselect_form.submit();
  }  
  
  return false;
}
</script>
</head>
<body>
<form name="yhgn_unselect_form" method="post">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr><td width="100%" valign="top">
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
        	<td height="30" align="center" class="th box_left box_top" nowrap>模块</td>
        	<td align="center" class="th box_left box_top" nowrap>功能</td>
        	<td align="center" class="th box_left box_top box_right" nowrap>操作</td>
        </tr>
    <%for (i = 0; i < v.size(); i++)
      {%>
        <tr>
          <td height="30" align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("mkmc"))%></td>
          <td align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("gnmc"))%></td>
          <td align="center" class="td box_top box_left box_right" nowrap><a href="javascript:work_add('<%=(((Properties) v.get(i)).getProperty("gnid"))%>');"><img src="../../style/images/add.png" border="0" alt="增加"></a></td>
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
<input type="hidden" name="wxgmnc" value="<%=wxgnmc%>">
<input type="hidden" name="yhid" value="<%=yhid%>">
</form>

<iframe name="yhgn_unselect_frame" src="" frameborder="0" scrolling="no" width="0" height="0"></iframe>

</body>
</html>