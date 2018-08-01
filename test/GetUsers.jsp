<%@ page import="java.net.URL" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.URLConnection" %>
<%@ page import="java.net.MalformedURLException" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String _access_token = "jFxl_wKakkADO_CMTFYTcZl6l2wke0BEGvcwSg3g47D-mQClv9Ubrl_PfZdr5VMrpzcL6afXHimBZSOAsmmDBk-csZ58fDfZ9ClnneRk1IuUWeO45S2ODvBP9N8-k3HBWEShACARZN";
    String _next_openid = "";

    StringBuffer sb = new StringBuffer();
    sb.append("https://api.weixin.qq.com/cgi-bin/user/get?");
    sb.append("access_token="+_access_token+"");
    sb.append("&next_openid="+_next_openid+"");
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