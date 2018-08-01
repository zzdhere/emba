<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
	request.setCharacterEncoding("UTF-8");
	String xm = request.getParameter("mc")==null?"":request.getParameter("mc").toString();
	String nc = request.getParameter("nc")==null?"":request.getParameter("nc").toString();
	String xb = request.getParameter("xb")==null?"":request.getParameter("xb").toString();
	String lxfs = request.getParameter("lxfs")==null?"":request.getParameter("lxfs").toString();
	String imgSrc = request.getParameter("imgSrc")==null?"":request.getParameter("imgSrc").toString();
	String openid = request.getParameter("openid")==null?"":request.getParameter("openid").toString();

	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.21.6:1521:orcl","hitemba","hitemba");
  	Statement stmt = conn.createStatement();

	String lj = request.getSession().getServletContext().getRealPath("//images")+"//";
	String imagelj = lj+openid+".jpg";

	FileOutputStream fos = null;  
	BufferedInputStream bis = null;  
	HttpURLConnection httpUrl = null; 
 	int BUFFER_SIZE = 1024;  
	byte[] buf = new byte[BUFFER_SIZE];  
	int size = 0;
	String qdzt = "N";

	try 
	{  
	   URL url = new URL(imgSrc);  
	   httpUrl = (HttpURLConnection) url.openConnection();  
	   httpUrl.connect(); 
	   bis = new BufferedInputStream(httpUrl.getInputStream());  
	   fos = new FileOutputStream(imagelj);  
	   while ((size = bis.read(buf)) != -1)
	   {  
	     fos.write(buf, 0, size);  
	   }  
	    fos.flush();  
	}
	catch (Exception e)
	{  

	} 
	finally 
	{
	 fos.close();  
	 bis.close();
	 httpUrl.disconnect();    
	}

	try
	  {
	    stmt.executeUpdate(" INSERT INTO t_qdyh(openid, xb, nc, zsxm, dh, tx)" +
	    			 " values('" + openid + "', '" + xb + "', '" + nc + "', '" + xm + "', '" + lxfs + "', '" + openid + ".jpg')");
	  }
	  catch (Exception e)
	  {
	   	qdzt = "Y";
	  }
	  finally
	  {
	    stmt.close();
	    conn.close();
	  }
%>
<html>
	<head>
		<meta charset="UTF-8">
		<title>视野天下</title>
		<link rel="stylesheet" type="text/css" href="style.css"/>
	</head>
	<body>
		<div class="container">
			<div class="header">
				<div class="logo"></div>
				<div class="title"></div>
			</div>
			<%
			if(qdzt=="N")
			{
			%>
			<div class="main">
				<div class="pic">
					<img src="<%=imgSrc%>" alt="" width="200" height="200" />
				</div>
				<div class="text">
				<p>姓名：<%=xm%></p>
				<p>联系方式：<%=lxfs%></p>
				<p class="hy">欢迎您参会</p>
				</div>
			</div>
			<%
			}else{
			%>
			<div class="main">
				<div class="text">
				<p class="hy">请勿再次签到！</p>
				</div>
				<div style="height: 200px;"></div>
			</div>
			<%
			}
			%>
			<div class="bg2"></div>
		</div>
	</body>
</html>
