<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//模块选择_内嵌
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
  (new Log()).log("error", "admin/xitong/mkxz.jsp：" + Global.getInstance().getTime() + "：" + e.getMessage());
}
finally
{
  database.close();
}
%>

<html>
<head>
<title>模块选择_内嵌</title> 
<link rel="stylesheet" href="../../style/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="../../style/ztree/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="../../style/ztree/js/jquery.ztree.core-3.5.js"></script>

<script language="javascript" type="text/javascript">
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
    return;
    
  window.parent.work_mk_back(treeNode.mkid, treeNode.name);
}

$(document).ready(function(){
  $.fn.zTree.init($("#tree"), setting, zNodes);
});
</script>
</head>
<body style="background-color:white; background-image:url('../../style/images/bg01.jpg'); background-repeat:repeat-x;">
  <div>模块选择</div>
  <div><ul id="tree" class="ztree"></ul></div>
</body>
</html>