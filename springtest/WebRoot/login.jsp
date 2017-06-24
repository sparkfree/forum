<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <title>用户登录</title>
	 <!--响应式布局，自适应物理配置，initial-scale设置为1：完全不缩放-->
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- 引入bootstrap样式 -->
     <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-responsive.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/docs.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/js/google-code-prettify/prettify.css" rel="stylesheet">
     <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/assets/ico/listen.ico">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${pageContext.request.contextPath}/resources/assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="${pageContext.request.contextPath}/resources/assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/resources/assets/ico/apple-touch-icon-57-precomposed.png">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
    
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#nickname").focus();
			document.onkeydown = function(e){ 
			    var ev = document.all ? window.event : e;
			    if(ev.keyCode==13) {
					login();//登录
	     		}
			};
		});
  		
		//登录
		function login(){
			var nickname=$("#nickname").val();
			if(nickname==""){
				alert('昵称不可以为空哦！');
				return false;
			}
			var password=$("#password").val();
			if(password==""){
				alert('密码不能为空哦！');
				return false;
			}
			var jsondata={nickname:nickname,password:password};
			var data=_ajax.jsonajax("useraction/userlogin.do",false,jsondata,"text");
			if(data=="login_success"){
				//注册成功
				alert('Hello,登录成功！');
				location.href="index.jsp";//跳转至index.jsp
			}else if(data=="login_fail"){
				//注册失败
				alert('Wow,登录失败！');
			}
		}
		
		//validate
		function b_nickname(){
			var nickname=$("#nickname").val();
			if(nickname==undefined||nickname==""){
				//$('#nickstr').popover("show");
				//layer.msg('昵称不能为空！');
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
  <body data-spy="scroll" data-target=".subnav" data-offset="50">
  	<div class="navbar navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<!-- 面包层 -->
				<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
		            <span class="icon-bar"></span>
		            <span class="icon-bar"></span>
		            <span class="icon-bar"></span>
          		</a>
          		<a class="brand" href="index.html">听说</a>
  		        <div class="nav-collapse">
  		        	<ul class="nav">
		              <li class="active">
		                <a href="index.html">首页</a>
		              </li>
		              <li class="active">
		                <a href="index.html">话题</a>
		              </li>
		              <li class="active">
		                <a href="index.html">一起</a>
		              </li>
		              <li class="active">
		                <a href="index.html">听说</a>
		              </li>
		              <li class="active">
		                <a href="index.html">我的</a>
		              </li>
		              <li class="active">
		                <a href="login.jsp">登录</a>
		              </li>
		              <li class="active">
		                <a href="register.jsp">注册</a>
		              </li>
		            </ul>  
  		        </div>
			</div>
		</div>
	</div>   
  	
 <div class="container">
	<header class="jumbotron masthead">
  <div class="inner">
    <h1>登录&nbsp;&nbsp;<span style="font-size: 16px;"><a href="register.jsp">注册</a></span></h1>
    <form class="well">
  		<label><img src="${pageContext.request.contextPath}/resources/images/nickname.png"/>昵称</label>
  		<input id="nickname" name="nickname" type="text" class="span3" placeholder="请输入昵称">
 		<label><img src="${pageContext.request.contextPath}/resources/images/password.png"/>密码</label>
 		<input id="password" name="password" type="password" class="span3" placeholder="请输入昵称">
  		<br><a onclick="login();" class="btn btn-primary btn-large">登录</a>
	</form>
<%--      <a href="" class="btn btn-large">下载 Bootstrap <small>(v2.0.2)</small></a>--%>
  </div>

  <div class="bs-links">
    <ul class="quick-links">
      <li><a href="">关于我们</a></li>
    </ul>
    <ul class="quick-links">
      <li class="follow-btn">
        <a href="" class="twitter-follow-button" data-link-color="#0069D6" data-show-count="true">©2017 李帅康 All rights reserved.<br>
    	浙ICP备17009657号</a>
      </li>
      <li class="tweet-btn">
<%--        <a href="" class="twitter-share-button" data-url="" data-count="horizontal" data-via="twbootstrap" data-related="mdo:Creator of Twitter Bootstrap">Tweet</a>--%>
      </li>
    </ul>
  </div>
</header>
</div>
    
    <%-- <script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>--%>
    <script src="${pageContext.request.contextPath}/resources/assets/js/google-code-prettify/prettify.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-transition.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-alert.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-modal.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-dropdown.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-scrollspy.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-tab.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-tooltip.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-popover.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-button.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-collapse.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-carousel.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-typeahead.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/application.js"></script>

	<script type="text/javascript">
		
	</script>
    
  </body>
</html>
