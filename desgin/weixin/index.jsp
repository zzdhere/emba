<%@ page import="java.net.URL" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.MalformedURLException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.net.URLConnection" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
	Date date = new Date();
	SimpleDateFormat nowDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String myDate = nowDate.format(date);
	Date d1 = nowDate.parse(myDate);
	String beginDate = "2016-08-14 16:30:00";
	Date d2 = nowDate.parse(beginDate);
	if(d1.getTime() < d2.getTime()){
	%>
	活动尚未开始，2016年8月20日16：30 开放签到。
	<%
	}else{
%>



<!--基础参数-->
<%
    String _appId = "wxed86d8e52be984ec";
    String _appSecret = "eb9ec987c6f0523ebe70724ce3503af3";
    String _code = request.getParameter("code")==null?"":request.getParameter("code").toString();
%>
<!--结束参数-->

<!--获取openid链接-->
<%
    StringBuffer openid_sb = new StringBuffer();
    openid_sb.append("https://api.weixin.qq.com/sns/oauth2/access_token?");
    openid_sb.append("appid="+_appId+"");
    openid_sb.append("&secret="+_appSecret+"");
    openid_sb.append("&code="+_code+"");
    openid_sb.append("&grant_type=authorization_code");
    String openid_url = openid_sb.toString();
%>
<!--结束openid链接-->

<!--获取openid-->
<%
    StringBuffer openid_retJson = new StringBuffer();
    try {
        URL urlObject = new URL(openid_url);
        URLConnection uc = urlObject.openConnection();
        BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream(),"UTF-8"));
        String inputLine = null;
        while ( (inputLine = in.readLine()) != null) {
            openid_retJson.append(inputLine);
        }
        in.close();
    } catch (MalformedURLException e) {
        e.printStackTrace();
    } catch (IOException e) {
        e.printStackTrace();
    }
%>
<!--获取公共号access_token-->
<%
    StringBuffer ggh_sb = new StringBuffer();
    ggh_sb.append("https://api.weixin.qq.com/cgi-bin/token?");
    ggh_sb.append("grant_type=client_credential");
    ggh_sb.append("&appid="+_appId+"");
    ggh_sb.append("&secret="+_appSecret+"");
    String ggh_url = ggh_sb.toString();

    StringBuffer ggh_retJson = new StringBuffer();
    try {
        URL urlObject = new URL(ggh_url);
        URLConnection uc = urlObject.openConnection();
        BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream(),"UTF-8"));
        String inputLine = null;
        while ( (inputLine = in.readLine()) != null) {
            ggh_retJson.append(inputLine);
        }
        in.close();
    } catch (MalformedURLException e) {
        e.printStackTrace();
    } catch (IOException e) {
        e.printStackTrace();
    }

%>
<!--结束公共号access_token-->
<!--转换JSON开始-->
<%
    /*openid 返回值
    * access_token 用户端
    * expires_in
    * refresh_token
    * openid
    * scope
    */
    JSONObject openid_json = JSONObject.fromObject(openid_retJson.toString());
    /*公共号 返回值
    * access_token 平台端
    * expires_in
    */
    JSONObject ggh_json = JSONObject.fromObject(ggh_retJson.toString());
%>
<!--转换JSON结束-->

<!--获取人员信息-->
<%
    StringBuffer userinfo_sb = new StringBuffer();
    userinfo_sb.append("https://api.weixin.qq.com/cgi-bin/user/info?");
    userinfo_sb.append("access_token=" + ggh_json.get("access_token") + "");
    //userinfo_sb.append("&openid="+openid_json.get("openid")+"");
    //本机测试
    userinfo_sb.append("&openid=obslSuNahbWQ73EyMNJwHQhhpsbg");
    userinfo_sb.append("&lang=zh_CN");
    String userinfo_url = userinfo_sb.toString();

    StringBuffer userinfo_retJson = new StringBuffer();
    try {
        URL urlObject = new URL(userinfo_url);
        URLConnection uc = urlObject.openConnection();
        BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream(),"UTF-8"));
        String inputLine = null;
        while ( (inputLine = in.readLine()) != null) {
            userinfo_retJson.append(inputLine);
        }
        in.close();
    } catch (MalformedURLException e) {
        e.printStackTrace();
    } catch (IOException e) {
        e.printStackTrace();
    }
%>
<!--结束人员信息-->

<!--用户信息转换-->
<%
    /*用户信息
    * subscribe 是否订阅(关注)
    * openid 用户的标识
    * nickname 用户的昵称
    * sex 性别
    * language 简体中文为zh_CN
    * headimgurl
    * remark
    *
    */
    //JSONObject retJson = JSONObject.fromObject(userinfo_retJson.toString());
%>
<!--用户信息转换-->

<html>
	<head>
		<meta charset="UTF-8">
		<title>视野天下</title>
		<link rel="stylesheet" type="text/css" href="style.css"/>
		<script src="../../style/js/jquery-1.9.0.min.js" type="text/javascript"></script>
    	<script type="text/javascript">
        var _userinfo = jQuery.parseJSON('<%=userinfo_retJson%>');
        $(document).ready(function(){
            // console.log('nikename:'+_userinfo.nickname);
            if (_userinfo.subscribe==0)
            {
              $('#UserImage').attr('src',"");
              $('#nickname').val("");
              $('#sex').val("");
              alert("请先关注!");
              return;
            }
            $('#UserImage').attr('src',_userinfo.headimgurl);
            $('#imgSrc').val(_userinfo.headimgurl);
            $('#xb').val(_userinfo.sex);
            $('#nickname').val(_userinfo.nickname);
            $('#openid').val(_userinfo.openid);
            $('#nicknameShow').html(_userinfo.nickname);
            if (_userinfo.sex==1)
            {
              $('#sex').html("男");
            }
        });
    </script>
    <script language="javascript">
    function work_check()
	{
	  if ($('#nickname').val().length==0)
	  {
		alert("请先关注！");
		$('#subBut').attr('disabled',true);
	  }
	  else
	  {
	  	if($('#inp_mc').val().length==0){
      		  $('#inp_mc').attr('style','border:1px solid #f00');
      		  return false;
      	        }else{
      		  $('#inp_mc').attr('style','');
      	        }

      	        if($('#inp_lxfs').val().length==0){
      		  $('#inp_lxfs').attr('style','border:1px solid #f00');
      		  return false;
      	        }else{
      		  $('#inp_lxfs').attr('style','');
      	        }
	  }
	}
    </script>
	</head>
	<body>
		<div class="container">
			<div class="header">
				<div class="logo"></div>
				<div class="title"></div>
			</div>
			<div class="main">
				<div class="pic">
					<img id="UserImage" name="image" src="" alt="" width="200" height="200" />
				</div>
				<form name="index_form" method="post" action="qr.jsp">
				<!--	<input id="nickname" name="nc" type="text" class="input01" readonly />
					<input id="sex" type="text" class="input01" readonly />-->
					<div class="text" style="text-align: center;width: 431px;height: 30px;margin-top: 0px;">
					<p id="nicknameShow"></p>
					<p id="sex"></p>
					</div>	
					<input type="text" name="mc" class="input01" id="inp_mc" />
					<input type="text" name="lxfs" class="input02" id="inp_lxfs" />
					<button id="subBut" name="but" type="sumbit" class="qd" onclick="return work_check();" ></button>
					<input type="hidden" name="imgSrc" id="imgSrc" value="" />
					<input type="hidden" name="openid" id="openid" value="" />
					<input type="hidden" name="xb" id="xb" value="" />
					<input type="hidden" name="nc" id="nickname" value="" />
				</form>
				
			</div>
			<div class="bg2"></div>
		</div>
	</body>
</html>
<%
}
%>