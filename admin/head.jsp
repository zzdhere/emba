<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
String jsid = ((Properties) session.getAttribute("global")).getProperty("jsid");
String yhid = ((Properties) session.getAttribute("global")).getProperty("yhid");
Vector v_bs = new Vector();
Properties p = null;
ResultSet rs = null;
ResultSet rs1 = null;
int i = 0;
String personal = "N";
String ymid = "";
String bsid = "";
String bsmc = "";
  
Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();
  
  //个性版式
  rs = database.query("select * from t_cs where dm = 'personal'");
  if (rs.next())
    personal = rs.getString("nr");
    
  //页面
  rs = database.query("select * from t_js where jsid = '" + jsid + "'");
  if (rs.next())
    ymid = rs.getString("ymid");
  
  //版式
  rs = database.query("select * from t_bs where zt = 'Y' order by xh");
  while (rs.next())
  {
    rs1 = database.query(" select t_bs.*" +
                         " from t_bs, t_mk, t_gn, t_js_gn" +
                         " where t_bs.bsid = t_mk.bsid" +
                         "       and t_mk.mkid = t_gn.mkid" +
                         "       and t_gn.gnid = t_js_gn.gnid" +
                         "       and t_bs.bsid = '" + rs.getString("bsid") + "'" +
                         "       and t_js_gn.jsid = '" + jsid + "'");
    if (rs1.next())
    {
      p = new Properties();
      p.setProperty("bsid", rs1.getString("bsid"));
      p.setProperty("mc", rs1.getString("mc"));
      
      if (v_bs.size() == 0)
        p.setProperty("class", "system_select");
      else
        p.setProperty("class", "system_unselect");
      
      v_bs.add(p);
      
      continue;
    }
    
    rs1 = database.query(" select t_bs.*" +
                         " from t_bs, t_mk, t_gn, t_yh_gn" +
                         " where t_bs.bsid = t_mk.bsid" +
                         "       and t_mk.mkid = t_gn.mkid" +
                         "       and t_gn.gnid = t_yh_gn.gnid" +
                         "       and t_bs.bsid = '" + rs.getString("bsid") + "'" +
                         "       and t_yh_gn.yhid = '" + yhid + "'");
    if (rs1.next())
    {
      p = new Properties();
      p.setProperty("bsid", rs1.getString("bsid"));
      p.setProperty("mc", rs1.getString("mc"));
      
      if (v_bs.size() == 0)
        p.setProperty("class", "system_select");
      else
        p.setProperty("class", "system_unselect");
      
      v_bs.add(p);
    }
  }
  
  //第一个版式为默认版式
  if (v_bs.size() > 0)
  {
    bsid = ((Properties) v_bs.get(0)).getProperty("bsid");
    bsmc = ((Properties) v_bs.get(0)).getProperty("mc");
  }
}
catch (Exception e)
{
  (new Log()).log("error", "admin/head.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
}
finally
{
  database.close();
}
%>
        
<html>
<head>
<title>页头</title>
<link rel="stylesheet" type="text/css" href="../style/style.css">
<style type=text/css> 
.system_select
{
  font-size:15px;
  color:#014dc7;
  background-image:url("../style/images/list_sel.png");
}

.system_unselect
{
  font-size:15px;
  color:white;
}
</style>
<script language="javascript">
function work_password()
{
  window.open("password.jsp");
}

function work_ymsz()
{
  window.open("shouye/ymsz.jsp?szlx=yh&ymid=<%=ymid%>");
}

function work_clear()
{
<%for (i = 0; i < v_bs.size(); i++)
  {%>
    document.getElementById("td_<%=(((Properties) v_bs.get(i)).getProperty("bsid"))%>").className = "system_unselect";
<%}%>
}

function work_bs(bsmc, bsid) //切换到管理版式
{
  work_clear();
  
  document.getElementById("td_" + bsid).className = "system_select";
  
  window.parent.work_manage(bsmc, bsid);
}
</script>
</head>
<body style="background-image:url('../style/images/wlbg.jpg');" onload="work_bs('<%=bsmc%>', '<%=bsid%>');">
<table width='100%' height='100%' border='0' cellpadding='0' cellspacing='0'>
  <tr><td width="10" height="100%">
      <td height="100%">
        <table border='0' cellpadding='0' cellspacing='0'>
          <tr><td height="5"></td></tr>
         
        </table>
      </td>
      <td align="right" valign="top">
        <table height="100%" border='0' cellpadding='0' cellspacing='0'>
          <tr><td height="47" align='right'>
              <table border='0' cellpadding='0' cellspacing='0'>
                <tr><td><img src='../style/images/toplist_left.png' border='0'></td>
                    <td class='text' style="color:white; background-image:url('../style/images/toplist_bg.png');">欢迎您：<%=(((Properties) session.getAttribute("global")).getProperty("yhmc"))%>&nbsp;&nbsp;&nbsp;</td>
                    <td align="center" style="background-image:url('../style/images/toplist_bg.png');"><img src='../style/images/coin_1.png' border='0'></td>
                    <td style="background-image:url('../style/images/toplist_bg.png');"><a href='help.htm' target='_blank'><span class='text' style="color:white;">&nbsp;帮助手册</span></a>&nbsp;&nbsp;</td>
                    <td style="background-image:url('../style/images/toplist_bg.png');"><img src='../style/images/coin_2.png' border='0'></td>
                    <td align="center" style="background-image:url('../style/images/toplist_bg.png');">&nbsp;<a href='javascript:work_password();'><span class='text' style="color:white;">修改密码</span>&nbsp;&nbsp;</a></td>
                    <td align="center" style="background-image:url('../style/images/toplist_bg.png');"><img src='../style/images/coin_3.png' border='0'></td>
                    <td align="center" style="background-image:url('../style/images/toplist_bg.png');">&nbsp;<a href='../logout.jsp' target="_parent"><span class='text' style="color:white;">退出系统</span></a></td>
                    <td><img src='../style/images/toplist_right.png' border='0'></td>
                </tr>
              </table>
          </td></tr>
        
          <tr><td align='right' valign="bottom">
              <table height="36" border='0' cellpadding='0' cellspacing='0' style="background-image:url('../style/images/list<%=(v_bs.size())%>.png'); background-repeat:no-repeat;">
                <tr>
                <%for (i = 0; i < v_bs.size(); i++)
                  {%>
                  <td width="104" id="td_<%=(((Properties) v_bs.get(i)).getProperty("bsid"))%>" align="center" class="<%=(((Properties) v_bs.get(i)).getProperty("class"))%>"><b><span style="cursor:hand;" onclick="work_bs('<%=(((Properties) v_bs.get(i)).getProperty("mc"))%>', '<%=(((Properties) v_bs.get(i)).getProperty("bsid"))%>');"><b><%=(((Properties) v_bs.get(i)).getProperty("mc"))%></b></span></td>
                <%}%>
                </tr>
              </table>
          </td></tr>
        </table>
      </td>
      <td width="20">&nbsp;</td>
  </tr>
</table>
</body>
</html>