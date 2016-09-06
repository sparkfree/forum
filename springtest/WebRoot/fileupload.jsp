<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>文件上传</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.8.3.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	function upload(){
		$.ajaxFileUpload({
	        url:'uploadfile.do',
	        secureuri:false,	//是否启用安全提交，一般设置为false
	        fileElementId:'uploadfile',		//文件上传空间的id属性  <input type="file" id="uploadfile" name="uploadfile" />
	        dataType: 'json',	//返回值类型 一般设置为json
	        success:function(data,status){  //服务器成功响应处理函数
	        	alert(data);
	        	data = data.replace("<pre>","").replace("</pre>","");
	        	data = eval('('+data+')');
	           	if(data.flag=='success'){ //从服务器返回的json中取出message中的数据
	        	  	alert("上传成功。");
	        	  	
	        	  	$('#filepath').val(data.faceimagepath);
					$('#fileimage').attr("src","${pageContext.request.contextPath}/upload/userface/"+data.faceimagepath);
	           	}else if(data.flag=='typeerror'){
	        	   	alert("图片类型错误，上传失败。");
	           	}else{
	           		alert("未知错误，上传失败！");
	           	}
	        },
	        error: function (data, status, e){	//服务器响应失败处理函数
	            alert("服务器无法连接");
	        }
	    })
	}
	</script>
  </head>
  
  <body>
    <input id="uploadfile" name="uploadfile" type="file">
    <input type="button" value="上传" onclick="upload()">
    <input id="filepath" name="filepath" type="text">
    <div style="background:#fff;border:2px solid #99BBE8;padding: 0px;overflow:hidden;width: 220px;height: 220px;">
    	<img id="fileimage" alt="" src="">
    </div>
  </body>
</html>
