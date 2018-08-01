<%@ page import="java.net.URL" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.MalformedURLException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.net.URLConnection" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    String access_token = request.getParameter("access_token")==null?"":request.getParameter("access_token");
    String openid = request.getParameter("openid")==null?"":request.getParameter("openid");

    StringBuffer sb = new StringBuffer();
    sb.append("https://api.weixin.qq.com/cgi-bin/user/info?");
    sb.append("access_token="+access_token+"");
    sb.append("&openid="+openid+"");
    sb.append("&lang=zh_CN");
    String _url = sb.toString();
%>
<%

    StringBuffer retJson = new StringBuffer();
    try {
        URL urlObject = new URL(_url);
        URLConnection uc = urlObject.openConnection();
        BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream(),"UTF-8"));
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
%>
<%=retJson.toString()%>