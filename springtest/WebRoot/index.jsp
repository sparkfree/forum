<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
  <title>简言，分享你的故事</title>
  <!--响应式布局，自适应物理配置，initial-scale设置为1：完全不缩放-->
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- 引入bootstrap样式 -->
     <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-responsive.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/docs.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/js/google-code-prettify/prettify.css" rel="stylesheet">
     <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/assets/ico/yan.ico">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${pageContext.request.contextPath}/resources/assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="${pageContext.request.contextPath}/resources/assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/resources/assets/ico/apple-touch-icon-57-precomposed.png">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
  	
  	<style type="text/css">
  		.tfont:HOVER {
			color: green;
		}
  	</style>
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
          		<a class="brand" href="index.html">简言</a>
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
		                <a href="useraction/myprofile.do">我的</a>
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
<div class="container-fluid">
	<div id="myCarousel" class="carousel slide">
    <!-- 轮播（Carousel）指标 -->
    <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>   
    <!-- 轮播（Carousel）项目 -->
    <div class="carousel-inner">
        <div class="item active">
            <img style="height: 280px;width: 100%;" src="${pageContext.request.contextPath}/resources/images/night.jpg" alt="First slide">
        </div>
        <div class="item">
            <img style="height: 280px;width: 100%;" src="${pageContext.request.contextPath}/resources/images/night.jpg" alt="Second slide">
        </div>
        <div class="item">
            <img style="height: 280px;width: 100%;" src="${pageContext.request.contextPath}/resources/images/night.jpg" alt="Third slide">
        </div>
    </div>
    <!-- 轮播（Carousel）导航 -->
    <a class="carousel-control left" href="#myCarousel" 
        data-slide="prev">&lsaquo;
    </a>
    <a class="carousel-control right" href="#myCarousel" 
        data-slide="next">&rsaquo;
    </a>
</div>

  <div class="row-fluid">
  	<div class="span8">
    	<div class="row-fluid">
    		<div id="topichtml">
    		</div>
    	</div>
    </div>
  	<div class="span3">
  		<div class="sidebar-nav">
            <ul class="nav nav-list">
              <li class="nav-header">汪洋在任时</li>
              <li class="active"><a href="fluid.html#">汪书记最英明</a></li>
              <li><a href="fluid.html#">汪书记最英明</a></li>
              <li><a href="fluid.html#">汪书记最英明</a></li>
              <li><a href="fluid.html#">汪书记最英明</a></li>
              <li class="nav-header">薄熙来在任时</li>
              <li><a href="fluid.html#">薄书记最英明</a></li>
              <li><a href="fluid.html#">薄书记最英明</a></li>
              <li><a href="fluid.html#">薄书记最英明</a></li>
              <li><a href="fluid.html#">薄书记最英明</a></li>
              <li><a href="fluid.html#">薄书记最英明</a></li>
              <li><a href="fluid.html#">薄书记最英明</a></li>
              <li class="nav-header">薄熙来下台了</li>
              <li><a href="fluid.html#">中央最英明</a></li>
              <li><a href="fluid.html#">中央最英明</a></li>
              <li><a href="fluid.html#">中央最英明</a></li>
            </ul>
          </div>
    </div>
  </div>
</div>
<div class="container">
	<div class="bs-links">
	    <ul class="quick-links">
	      <li><a href="">关于我们</a></li>
	      <li><a href="">©2017 李帅康 All rights reserved.</a></li>
    	 <li><a href="">浙ICP备17009657号</a></li>
	    </ul>
	  </div>
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
	$(function(){
		user = "${sessionScope.user}";
		if(user!=""){//用户已经登录
			var nickname="${sessionScope.user.nickname}";
		}
		
		var jsondata={page:1,rows:12};
        var result=_ajax.jsonajax("topicaction/gettopics.do",false,jsondata,"json");
        var str='<ul style=\'width:100%\' class="thumbnails">';
        $(result).each(function(index,value){
        	//str+='<li onclick=\'topic_show(\"'+value.id+'\");\'><img class="image" src=\"${pageContext.request.contextPath}/upload/userface/'+value.userface+'\"><span onMouseOver="javascript:show(this,\'mydiv1\');" onMouseOut="hide(this,\'mydiv1\')" id=\'nickname\'>'+value.nickname+'</span><br><span class=\'topic\'>'+value.topic+'</span><li><br><div style=\'float:right;margin-right:10px;\'><span class=\'date_class\'>'+value.publishdate+'</span>&nbsp;&nbsp;<img onclick=\'hitheart(this,\"'+value.id+'\");\' class=\'heart_png\' src=\'${pageContext.request.contextPath}/resources/images/gray_heart.png\'/><span id=\'heart_total'+value.id+'\'>'+value.heart+'</span><input id=\'heart_num'+value.id+'\' type=\'hidden\' value=\''+value.heart+'\'>&nbsp;&nbsp;<img onclick=\'topic_show(\"'+value.id+'\");\' id=\'talk\' src=\'${pageContext.request.contextPath}/resources/images/talk.png\'/><span id=\'talk_num\'>'+value.comment+'</span></div><hr>';
        	if(value.image==null||value.image==""){
        		str+="<li style=\"width:100%;\" class=\"\"><div class=\"thumbnail\"><p><img class=\"image\" src=\"${pageContext.request.contextPath}/upload/userface/"+value.userface+"\">&nbsp;&nbsp;<span>"+value.nickname+"</span></p><p class=\"tfont\">"+value.topic+"</p><p><img src=\'${pageContext.request.contextPath}/resources/images/gray_heart.png\'/>&nbsp;<span>"+value.heart+"</span>&nbsp;&nbsp;<img src=\'${pageContext.request.contextPath}/resources/images/talk.png\'/>&nbsp<span>"+value.comment+"</span></p></div></li>";
        	}else{
        		str+="<li class=\"\"><div class=\"thumbnail\">"+
        		+"<img src=\""+value.image+"\" alt=\"\">"+
        	      +"<h5>"+value.topic+"</h5><p></p></div></li>";
        	}
        });
        str+='</ul>';
        $('#topichtml').html(str);
        $('#hothtml').html(str);
        var page=1;//定义一个页数变量，页面滚动时+1
        $(window).scroll(function() {  
            var scrollTop = $(this).scrollTop(),scrollHeight = $(document).height(),windowHeight = $(this).height();  
                var positionValue = (scrollTop + windowHeight) - scrollHeight;  
             if (positionValue == 0) {  
                   page=page+1;
                   var jsondata={page:page,rows:12};
                   var result=_ajax.jsonajax("topicaction/gettopics.do",false,jsondata,"json");
                   if(result.length==0){
                	   alert("没有更多数据了");
                	   page=page-1;
                	   return;
                   }
                   var strmore="";
                   $(result).each(function(index,value){
                   	if(value.image==null||value.image==""){
                   		strmore+="<li style=\"width:100%;\" class=\"\"><div class=\"thumbnail\"><p><img class=\"image\" src=\"${pageContext.request.contextPath}/upload/userface/"+value.userface+"\">&nbsp;&nbsp;<span>"+value.nickname+"</span></p><p class=\"tfont\">"+value.topic+"</p><p><img src=\'${pageContext.request.contextPath}/resources/images/gray_heart.png\'/>&nbsp;<span>"+value.heart+"</span>&nbsp;&nbsp;<img src=\'${pageContext.request.contextPath}/resources/images/talk.png\'/>&nbsp<span>"+value.comment+"</span></p></div></li>";
                   	}else{
                   		strmore+="<li class=\"\"><div class=\"thumbnail\">"+
                   		+"<img src=\""+value.image+"\" alt=\"\">"+
                   	      +"<h5>"+value.topic+"</h5><p></p></div></li>";
                   	}
                   });
                   $('#topichtml').append(strmore);
              }  
        });  
	});
	</script>
</body>
</html>