<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>首页</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/index.css">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.8.3.js"></script>
	<script type="text/javascript">
		$(function(){
			//ajax加载topic
			$.ajax({
                type: "POST",
                url: "",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function(data) {
                    $("#LatestNews").html(data);
                }, error: function(error) {
                $("#LatestNews").html("尚未发布任何信息！");
                }
            });
		});
	</script>
  </head>
  
  <body>
  	<jsp:include page="title.jsp"></jsp:include>
    <div>
    	<div id="topic" style="border: 1px solid red;">
    		
    	</div>
    </div>
  </body>
</html>
