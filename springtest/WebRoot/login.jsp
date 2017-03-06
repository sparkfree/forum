<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>用户注册</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		#logo{
			font-size: 32px;
			margin: 100px;
		}
		#register_box{
			 box-shadow:10px 10px 5px 10px #EE9A49 ;
		}
	</style>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css"  media="all">
	<script src="${pageContext.request.contextPath}/resources/layui/layui.js" charset="utf-8"></script>
	<script src="${pageContext.request.contextPath}/resources/layui/lay/modules/laypage.js" charset="utf-8"></script>
	<script type="text/javascript">
		$(function(){
			$("#nickname").focus();
			document.onkeydown = function(e){ 
			    var ev = document.all ? window.event : e;
			    if(ev.keyCode==13) {
					login();//登录
	     		}
			}
		});
		
		//加载layui模块
		layui.use(['layer', 'laypage', 'element'], function(){
  			var layer = layui.layer
  			,laypage = layui.laypage
  			,element = layui.element();
  		});
  		
  		//注册
		function register(){
			var nickname=$("#nickname").val();
			var phone=$("#phone").val();
			var password=$("#password").val();
			var jsondata={nickname:nickname,phone:phone,password:password};
			var data=_ajax.jsonajax("useraction/userregister.do",false,jsondata,"text");
			if(data=="register_success"){
				//注册成功
				layer.msg('Hello,注册成功！');
			}else if(data=="register_fail"){
				//注册失败
				layer.msg('Wow,注册失败！');
			}
		}
		
		//登录
		function login(){
			var nickname=$("#nickname").val();
			var password=$("#password").val();
			var jsondata={nickname:nickname,password:password};
			var data=_ajax.jsonajax("useraction/userlogin.do",false,jsondata,"text");
			if(data=="login_success"){
				//注册成功
				layer.msg('Hello,登录成功！');
				location.href="index.jsp";//跳转至index.jsp
			}else if(data=="login_fail"){
				//注册失败
				layer.msg('Wow,登录失败！');
			}
		}
		
		//validate
		function b_nickname(){
			var nickname=$("#nickname").val();
			if(nickname==undefined||nickname==""){
				layer.msg('昵称不能为空！');
				return false;
			}
			var jsondata={nickname:nickname};
			var data=_ajax.jsonajax("useraction/checknickname.do",false,jsondata,"text");
			if(data=="isexist"){
				layer.msg('昵称已经存在！');
			}else if(data=="notexist"){
				layer.msg('昵称不存在！');
			}
		}
		//validate phone
		function b_phone(){
		
		}
		
		//validate password
		function b_password(){
			
		}
	</script>
  </head>
  
  <body>
    <div style="background-color: #F5F5F5;width: 100%;height: 100%;">
    	<span id="logo">多米论坛</span>
    	<div id="register_box" style="width: 30%;height: 65%;margin: 50px auto;">
    		<div style="">
    		<div style="">
    			<span style="font-size: 18px;"><a href="login.jsp" style="color: red;">登录</a></span>&nbsp;&nbsp;
    			<span><a href="register.jsp">注册</a></span>
    		</div>
    		<br>
   				<div style="margin-left: 50px;"><img src="${pageContext.request.contextPath}/resources/images/nickname.png"/>&nbsp;&nbsp;<input style="width: 200px;height: 32px;" name="nickname" id="nickname" type="text" placeholder="你的昵称"/></div><br>
   				<div style="margin-left: 50px;"><img src="${pageContext.request.contextPath}/resources/images/password.png"/>&nbsp;&nbsp;<input style="width: 200px;height: 32px;" name="password" id="password" type="password" placeholder="输入密码"/></div><br>
   				<div style="margin-left: 50px;"><button style="width: 230px;height:38px;background: #32CD32;border: none;" onclick="login();"><span style="color: white;font-size: 18px;">登录</span></button></div>
    		</div>
    	</div>
    </div>
  </body>
</html>
