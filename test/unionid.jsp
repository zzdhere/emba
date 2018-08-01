<%@ page import="java.net.URL" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.URLConnection" %>
<%@ page import="java.net.MalformedURLException" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxed86d8e52be984ec&redirect_uri=http://www.hrbwmxx.com/wx/oauth.jsp&response_type=code&scope=snsapi_base&state=1#wechat_redirect


    String _appid = "wxed86d8e52be984ec";
    String _appsecret = "eb9ec987c6f0523ebe70724ce3503af3";
    String _code = "code";
    String _authorization_code = "authorization_code";

    StringBuffer sb = new StringBuffer();
    sb.append("https://api.weixin.qq.com/sns/oauth2/access_token?");
    sb.append("&appid="+_appid+"");
    sb.append("&secret="+_appsecret+"");
    sb.append("&code="+_code+"");
    sb.append("&grant_type="+_authorization_code+"");
    String _url = sb.toString();

    StringBuffer retJson = new StringBuffer();
    try {
        URL urlObject = new URL(_url);
        URLConnection uc = urlObject.openConnection();
        BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream()));
        String inputLine = null;
        while ( (inputLine = in.readLine()) != null) {
            retJson.append(inputLine);
        }
        in.close();
    } catch (MalformedURLException e) {
        e.printStackTrace();
    } catch (IOException e) {
        e.printStackTrace();
    }


    //response.sendRedirect(_url);
%>

<%=retJson.toString()%>