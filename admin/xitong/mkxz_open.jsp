<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//模块选择_外置
Vector v = new Vector();
Properties p = null;
int i = 1;
ResultSet rs = null;

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();
  
  rs = database.query("select * from t_bs where zt = 'Y' order by xh");
  while (rs.next())
  {
    p = new Properties();
    
    p.setProperty("id", String.valueOf(i));
    p.setProperty("pId", "0");
    p.setProperty("mkid", rs.getString("bsid"));
    p.setProperty("mc", rs.getString("mc"));
    
    v.add(p);

    i = i + 1;
  }
}
catch (Exception e)
{
  (new Log()).log("error", "admin/xitong/mkxz_open.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
}
finally
{
  database.close();
}
%>

<html>
<head>
<title>模块选择</title>
<link rel="stylesheet" href="../../style/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="../../style/ztree/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="../../style/ztree/js/jquery.ztree.core-3.5.js"></script>

<script language="javascript" type="text/javascript">
var operate = "";
var mkmc = "";
var mkid = "";

var setting = {
	view:
	{
		showIcon:false
	},
	data:
	{
		simpleData:
		{
			enable:true
		}
	},
  async:
  {
    autoParam:['id', 'mkid'],
    dataType:'text',
    enable:true,
    type:'post',
    url:'mkxz_do.jsp'
  },
  callback:
  {
    onClick:nodeClick
  }
};

var zNodes =[
<%for (i = 0; i < v.size(); i++)
  {%>
    {
      id:'<%=(((Properties) v.get(i)).getProperty("id"))%>',
      pId:'<%=(((Properties) v.get(i)).getProperty("pId"))%>',
      name:'<%=(((Properties) v.get(i)).getProperty("mc"))%>',
      isParent:true,
      mkid:'<%=(((Properties) v.get(i)).getProperty("mkid"))%>'
    }
  <%if (i < v.size() - 1)
    {%>,<%}
  }%>
    ];

function showIconForTree(treeId, treeNode)
{
	return !treeNode.isParent;
}

function nodeClick(event, treeId, treeNode)
{
  if (treeNode.isParent)
    operate = "bs";
  else
    operate = "mk";
    
  mkid = treeNode.mkid;
  mkmc = treeNode.name;
}

$(document).ready(function(){
	$.fn.zTree.init($("#tree"), setting, zNodes);
});

function work_save() //确定
{
  window.opener.work_mk_back(operate, mkid, mkmc);
  window.close();
}
</script>
</head>
<body style="margin:0px; padding:0px; text-align:center; background-color:white; background-image:url('../../style/images/bg01.jpg'); background-repeat:repeat-x;">
<br><br>

<table border="0" cellpadding="0" cellspacing="5" align="center">
  <tr>
    <td width="20" height="25"><img src="../../style/images/title2.gif" border="0" width="25" height="25"></td>
    <td style="FONT-SIZE:18px;COLOR: #363737;LINE-HEIGHT:22px;FONT-FAMILY:'宋体';FONT-WEIGHT:bold;">模块选择</td>
  </tr>
</table>

<br><br>

<table border="0" cellpadding="0" cellspacing="0">
  <tr><td><div style="width:250px; height:300px; overflow:auto; border-style:solid; border-color:silver; border-width:1px;"><ul id="tree" class="ztree" style="text-align:center;"></ul></div></td></tr>
  <tr>
    <td height="80" align="center" style="font-family: "宋体";font-size:13px;LINE-HEIGHT:20px;">
      <input type="button" class="button" onclick="work_save();" value="确定">&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" class="button" onclick="window.close();" value="关闭">
    </td>
  </tr>
</table>
</body>
</html>