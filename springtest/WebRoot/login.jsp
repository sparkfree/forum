<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>登录页面</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
		body{
			background-color: #f0ffff;
			text-align: center;
		}
	</style>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#register").hide();
		});
		function register(){
			$("#login").hide();
			$("#register").show();
		}
		function login(){
			$("#register").hide();
			$("#login").show();
		}
		
		function checkForm(){
			var account = $("#account").val();
		   	var msg = "";
		   	if(account.length==0){
		       msg="[ 提示：用户名不能为空! ]";
		       $("#account").focus();
		       alert(msg);
			   return false;
		   	}
		  	var password = $("#password").val();
		   	if(password.length==0){
		       msg="[ 提示：密码不能为空! ]";
		       $("#password").focus();
		       alert(msg);
			   return false;
		   	}
		   	return true;
		}
	</script>
	
  </head>
  
  <body>
  	<div style="margin-top: 150px;margin-left: 300px;">
  		<span id="btnlogin" onclick="login()">登录</span>&nbsp;&nbsp;
  		<span id="btnregister" onclick="register()">注册</span>
  		<br/><br/>
  		<div id="login">
  			<form action="userlogin.do" method="post" onsubmit="return checkForm()">
    		<span>账户</span>&nbsp;&nbsp;<input name="account" id="account" type="text"><br/><br/>
    		<span>密码</span>&nbsp;&nbsp;<input name="password" id="password" type="password"><br/><br/>
    		<input type="submit" value="登录">
    		</form>
  		</div>
  		
  		<div id="register">
  			<form action="userregister.do" method="post">
    		<span>账号</span>&nbsp;&nbsp;<input name="account" id="account" type="text"/><br/><br/>
    		<span>密码</span>&nbsp;&nbsp;<input name="password" id="password" type="password"><br/><br/>
    		<span>手机号</span>&nbsp;<input name="phonenumber" id="phonenumber" type="text"><br/><br/>
    		<input type="submit" value="注册">
    		</form>
  		</div>
  	</div>
    
    
  </body>
</html>
