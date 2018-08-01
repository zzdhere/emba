<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Log" %>

<%
String jsid = ((Properties) session.getAttribute("global")).getProperty("jsid");
String yhid = ((Properties) session.getAttribute("global")).getProperty("yhid");
ResultSet rs = null;
ResultSet rs1 = null;
String menu = null;
String menu_data = "['', '系统首页', 'hyjm.jsp']";
Vector v = new Vector();
Properties p = null;
int i = 1;

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();

  //模块功能菜单
  rs = database.query("select * from t_mk order by xh");
  while (rs.next())
  {
    menu = "";
    
    //角色功能处理
    rs1 = database.query(" select t_gn.*" +
                         " from t_js_gn, t_gn" +
                         " where t_gn.gnid = t_js_gn.gnid" +
                         "       and t_js_gn.jsid = '" + jsid + "'" +
                         "       and t_gn.mkid = '" + rs.getString("mkid") + "'" +
                         " order by t_gn.xh");
	  while (rs1.next())
	  {
      //显示功能
	    menu = menu + "<tr onclick=work_menu('" + rs1.getString("gnid") + "'); onmouseover='work_over(this);' onmouseout='work_out(this);'><td width='60' align='right' class='menu'><img src='../style/images/menu3.gif' border='0'></td><td class='menu'>&nbsp;&nbsp;" + rs1.getString("mc") + "</td></tr>";

	    menu_data = menu_data + ",['" + rs1.getString("gnid") + "', '" + rs1.getString("mc") + "', '" + rs1.getString("wj") + "']";
	  }

    //用户功能处理
    rs1 = database.query(" select t_gn.*" +
                         " from t_yh_gn, t_gn" +
                         " where t_yh_gn.gnid = t_gn.gnid" +
                         "       and t_yh_gn.yhid = '" + yhid + "'" +
                         "       and t_gn.mkid = '" + rs.getString("mkid") + "'" +
                         " order by t_gn.xh");
    while (rs1.next())
    {
      if ((menu.indexOf("'" + rs1.getString("gnid") + "'")) == -1) //只有在角色功能权限中没有的，才显示
      {
        //显示功能
  	    menu = menu + "<tr onclick=work_menu('" + rs1.getString("gnid") + "'); onmouseover='work_over(this);' onmouseout='work_out(this);'><td width='60' align='right' class='menu'><img src='../style/images/menu3.gif' border='0'></td><td class='menu'>&nbsp;&nbsp;" + rs1.getString("mc") + "</td></tr>";
  
  	    menu_data = menu_data + ",['" + rs1.getString("gnid") + "', '" + rs1.getString("mc") + "', '" + rs1.getString("wj") + "']";
      }
    }
   
    if (! (menu.equals("")))
    {
      p = new Properties();

      p.setProperty("mkmc", rs.getString("mc"));
      p.setProperty("hidden", "true"); //显示
      p.setProperty("collapsed", "true"); //收缩
		  p.setProperty("bsid", rs.getString("bsid"));
	    p.setProperty("html", "<table width='100%' class='background' border='0' cellpadding='0' cellspacing='0'>" + menu + "</table>");

	    v.add(p);
    }
  }
}
catch (Exception e)
{
  (new Log()).log("error", "admin/admin.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
}
finally
{
  database.close();
}
%>

<html>
<head>
<title><%=(((Properties) session.getAttribute("global")).getProperty("system"))%></title>
<link rel="stylesheet" type="text/css" href="../style/style.css">
<link rel="stylesheet" type="text/css" href="../style/extjs/resources/css/ext-all.css">
<style type=text/css>
.x-panel-header
{
  text-align:center;
}
</style>

<script type="text/javascript" src="../style/extjs/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="../style/extjs/ext-all.js"></script>
<script type="text/javascript">
var head;
var foot;
var nav;
var tabs;

var menu_data = [<%=menu_data%>];

var tools = [
    {
        id:'close',
        handler: function(e, target, panel){
            panel.ownerCt.remove(panel, true);
        }
    }];

function work_gui()
{
  head = new Ext.Panel(
  {
    region:'north',
    height:96,
    margins:'5 5 5 5',
    html:'<iframe src="head.jsp" frameborder="no" scrolling="no" height="100%" width="100%"></iframe>'
  });

  foot = new Ext.Panel(
  {
    region:'south',
    height:25,
    margins:'5 5 5 5',
    html:'<iframe src="foot.jsp" frameborder="no" scrolling="no" height="100%" width="100%"></iframe>'
  });

  nav = new Ext.Panel(
  {
    title:'',
    region:'west',
    width:200,
    margins:'0 5 0 5',
    collapsible:true,
    collapsed:false,
    autoScroll:true,
    layout:'accordion',
    items:[
<%for (i = 0; i < v.size(); i++)
  {%>
    {
      title:'&nbsp;&nbsp;<%=(((Properties) v.get(i)).getProperty("mkmc"))%>&nbsp;&nbsp;&nbsp;&nbsp;',
      iconCls:'menu_bar',
      autoScroll:true,
      border:false,
      layout:'fit',
      collapsed:<%=(((Properties) v.get(i)).getProperty("collapsed"))%>,
      hidden:<%=(((Properties) v.get(i)).getProperty("hidden"))%>,
      bsid:"<%=(((Properties) v.get(i)).getProperty("bsid"))%>",
      html:"<%=(((Properties) v.get(i)).getProperty("html"))%>"
    }
  <%if (i < v.size() - 1)
    {%>,<%}
  }%>
    ]
   });
   
  tabs = new Ext.TabPanel(
  {
    region:'center',
    margins:'0 5 0 0',
    activeTab:0,
    items:[
    {
      title:'系统首页',
      gnid:'',
      html:'<iframe src="hyjm.jsp" name="ymxs_frame" scrolling="auto" frameborder="no" height="100%" width="100%"></iframe>'
    }]
  });

  new Ext.Viewport(
  {
    enableTabScroll:true,
    layout:'border',
    items:[head, foot, nav, tabs]
  });
}

function work_menu(obj)
{
  var s = "false";
  var i = 0;

  for (i = 0; i < tabs.items.length; i++)
    if (tabs.items.items[i].gnid == obj)
    {
      tabs.activate(i);

      s = "true";
      break;
    }

  if (s == "true")
    return;

  for (i = 0; i < menu_data.length; i++)
    if (menu_data[i][0] == obj)
    {
      tabs.add(
      {
        title:menu_data[i][1],
        gnid:menu_data[i][0],
        html:'<iframe src="' + menu_data[i][2] + '" frameborder="no" height="100%" width="100%"></iframe>',
        closable:true
      }).show();

      break;
    }

  if (i == menu_data.length)
    alert("没有授权，不能访问");
}

function work_over(obj)
{
  obj.style.backgroundColor = 'fff7f3';
}

function work_out(obj)
{
  obj.style.backgroundColor = '';
}

function work_manage(bsmc, bsid) //版式切换
{
  //菜单标题
  var s = bsmc.split("");
  var bsmcs = "";
  for (i = 0; i < s.length; i++)
  {
    if (bsmcs == "")
      bsmcs = s[i];
    else
      bsmcs = bsmcs + "&nbsp;&nbsp;&nbsp;&nbsp;" + s[i];
  }
  
  nav.setTitle(bsmcs);

  //菜单内容
  for (i = 0; i < nav.items.length; i++)
  {
    if (nav.items.items[i].bsid == bsid)
      nav.items.items[i].setVisible(true);
    else
      nav.items.items[i].setVisible(false);
      
    nav.items.items[i].expand();
  }
}

Ext.onReady(work_gui);
</script>
</head>
<body>
</body>
</html>