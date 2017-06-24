<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>底部公共页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		#footer {position: relative;
			    margin-top: -60px; 
			    height: 60px;
			    clear:both;
			    background:#00A2CA;
			    color:#FFF; 
			    font-family:"\5FAE\8F6F\96C5\9ED1"; 
			    font-size:16px;
			    text-align: center;
			    } 
	</style>
  </head>
  
  <body>
  
    <div id="footer">
    	©2017 李帅康 All rights reserved.<br>
    	浙ICP备17009657号
    </div>
  </body>
</html>
