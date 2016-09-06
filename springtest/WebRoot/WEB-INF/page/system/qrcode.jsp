<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>js生成二维码</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="${contextPath }/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${contextPath }/js/utf.js"></script>
<script type="text/javascript" src="${contextPath }/js/jquery.qrcode.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#qrcodeCanvas").qrcode({
			render : "canvas",    //设置渲染方式，有table和canvas，使用canvas方式渲染性能相对来说比较好
			text : "这是修改了官文的js文件，此时生成的二维码支持中文和LOGO",    //扫描了二维码后的内容显示,在这里也可以直接填一个网址，扫描二维码后
			width : "200",               //二维码的宽度
			height : "200",              //二维码的高度
			background : "#ffffff",       //二维码的后景色
			foreground : "#000000",        //二维码的前景色
			src: '${contextPath}/js/photo.jpg'             //二维码中间的图片
		});
	});
</script>

  </head>
  
  <body>
    <center>
      <h2>该二维码支持中文和LOGO</h2>
      <div id="qrcodeCanvas"></div>
    </center>
  </body>
</html>
