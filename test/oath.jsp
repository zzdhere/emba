<%@ page import="java.net.URL" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.URLConnection" %>
<%@ page import="java.net.MalformedURLException" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String _appId = "wxed86d8e52be984ec";
    String _appSecret = "eb9ec987c6f0523ebe70724ce3503af3";
    String _redirectUri = "http://localhost:8080/wxEmba/oath.jsp";
    String _response_type = "code";
    String _scope = "snsapi_userinfo";
    String _state = "state";
    String _connect_redirect = "1";

    StringBuffer sb = new StringBuffer();
    sb.append("https://api.weixin.qq.com/cgi-bin/token?");
    sb.append("grant_type=client_credential");
    sb.append("&appid="+_appId+"");
    sb.append("&secret="+_appSecret+"");
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