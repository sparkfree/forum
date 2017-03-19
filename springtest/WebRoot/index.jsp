<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

  <head>
    <title>听说</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css"  media="all">
	<script src="${pageContext.request.contextPath}/resources/layui/layui.js" charset="utf-8"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
	<style type="text/css">
		.date_class{
			font-size: 12px;
			color: green;
		}
		.heart_png{
			cursor: pointer;
		}
		.topic:HOVER{
			color: green;
		}
		.signin{
			cursor: pointer;
		}
	</style>
	<script>
	var user="";
	$(function(){
		user = "${sessionScope.user}";//user
		if(user!=""){//用户已经登录
			$(".sign").hide();
			var nickname="${sessionScope.user.nickname}";
			$("#usernick").html(nickname);	
			$(".signin").show();
		}
	});
		function hitheart(ele,id){
			ele.src="${pageContext.request.contextPath}/resources/images/hot_heart.png";//点赞后更换hot_heart图标
			var heart_num=$("#heart_num"+id).val();
			if(heart_num==undefined){
				heart_num=0;
			}
			var heart_new=parseInt(heart_num)+1;
			$("#heart_total"+id).html(heart_new);
			//更新该主题点赞数
			var jsondata={id:id,heart:heart_new};
			_ajax.jsonajax("topicaction/updatehearts.do",false,jsondata,"text");
		}
		
		//话题详情
		function topic_show(tid){
			location.href="topicaction/topiccomment.do?tid="+tid;//通过controller跳转至web-inf中的页面
		}
		
		layui.use('element', function(){
		  var element = layui.element(); //导航的hover效果、二级菜单等功能，需要依赖element模块
		  //监听导航点击
		  element.on('nav(demo)', function(elem){
		    layer.msg(elem.text());
		  });
		});
		
		layui.use(['laypage', 'layer'], function(){
		var laypage = layui.laypage,layer = layui.layer;
 		var nums = 12; //每页出现的数据量
	  //模拟渲染
	  var render = function(curr){
	    //此处只是演示，实际场景通常是返回已经当前页已经分组好的数据
	    //var str = '', last = curr*nums - 1;
	    //last = last >= data.length ? (data.length-1) : last;
	    //for(var i = (curr*nums - nums); i <= last; i++){
	    //  str += '<li>'+ data[i] +'</li>';
	    //}
	    //return str;
	    var page=curr;
	    var rows=nums;//alert(page+","+rows)
	    var jsondata={page:page,rows:rows};
        var result=_ajax.jsonajax("topicaction/gettopics.do",false,jsondata,"json");
        var str='';
        $(result).each(function(index,value){
        	str+='<li onclick=\'topic_show(\"'+value.id+'\");\' class=\'topic\'>'+value.topic+'<li><br><div style=\'float:right;margin-right:10px;\'><span onMouseOver="javascript:show(this,\'mydiv1\');" onMouseOut="hide(this,\'mydiv1\')" id=\'nickname\'>'+value.nickname+'</span>&nbsp;&nbsp;<span class=\'date_class\'>'+value.publishdate+'</span>&nbsp;&nbsp;<img onclick=\'hitheart(this,\"'+value.id+'\");\' class=\'heart_png\' src=\'${pageContext.request.contextPath}/resources/images/gray_heart.png\'/><span id=\'heart_total'+value.id+'\'>'+value.heart+'</span><input id=\'heart_num'+value.id+'\' type=\'hidden\' value=\''+value.heart+'\'>&nbsp;&nbsp;<img onclick=\'topic_show(\"'+value.id+'\");\' id=\'talk\' src=\'${pageContext.request.contextPath}/resources/images/talk.png\'/><span id=\'talk_num\'>'+value.comment+'</span></div><hr>';
        });
        return str;
	  };
  		
  	var datasum=_ajax.jsonajax("topicaction/gettopicsum.do",false,null,"text");//查询数据总数
  	
  	var hotdata=_ajax.jsonajax("topicaction/getHotTopic.do",false,null,"json");
  	var renderhot=function(){
  		var str='<li style=\'color:red;\'>hot</li><br>';
  		$(hotdata).each(function(index,value){
        	str+='<li onclick=\'topic_show(\"'+value.id+'\");\' class=\'topic\'>'+value.topic+'<li><br><div style=\'float:right;margin-right:10px;\'><span class=\'date_class\'>'+value.publishdate+'</span>&nbsp;&nbsp;<img onclick=\'hitheart(this,\"'+value.id+'\");\' class=\'heart_png\' src=\'${pageContext.request.contextPath}/resources/images/gray_heart.png\'/><span id=\'heart_total'+value.id+'\'>'+value.heart+'</span><input id=\'heart_num'+value.id+'\' type=\'hidden\' value=\''+value.heart+'\'>&nbsp;&nbsp;<img onclick=\'topic_show(\"'+value.id+'\");\' id=\'talk\' src=\'${pageContext.request.contextPath}/resources/images/talk.png\'/><span id=\'talk_num\'>'+value.comment+'</span></div><hr>';
        });
        return str;
  	};
  	
  	/*var recentdata=_ajax.jsonajax("topicaction/getRecentTopic.do",false,null,"json");
  	var rendertopic=function(){
  		var str='<li style=\'color:red;\'>recent</li><br>';
  		$(recentdata).each(function(index,value){
        	str+='<li onclick=\'topic_show(\"'+value.id+'\");\' class=\'topic\'>'+value.topic+'<li><br><div style=\'float:right;margin-right:10px;\'><span class=\'date_class\'>'+value.publishdate+'</span>&nbsp;&nbsp;<img onclick=\'hitheart(this,'+value.id+');\' class=\'heart_png\' src=\'${pageContext.request.contextPath}/resources/images/gray_heart.png\'/><span id=\'heart_total'+value.id+'\'>'+value.heart+'</span><input id=\'heart_num'+value.id+'\' type=\'hidden\' value=\''+value.heart+'\'>&nbsp;&nbsp;<img onclick=\'topic_show(\"'+value.id+'\");\' id=\'talk\' src=\'${pageContext.request.contextPath}/resources/images/talk.png\'/><span id=\'talk_num\'>'+value.comment+'</span></div><hr>';
        });
        return str;
  	};*/
  	
  	document.getElementById('hot_list').innerHTML=renderhot();
  	//document.getElementById('recent_list').innerHTML=rendertopic();
	  //调用分页
	  laypage({
	    cont: 'blog_content'
	    ,pages: Math.ceil(datasum/nums) //得到总页数
	    ,jump: function(obj){
	      document.getElementById('biuuu_city_list').innerHTML = render(obj.curr);
	    }
	  });
  
});

	function show(obj,id) {
		var objDiv = $("#"+id+"");
		$(objDiv).css("display","block");
		$(objDiv).css("left", obj.clientX);
		$(objDiv).css("top", obj.clientY + 10); 
	}
	
	function hide(obj,id) {
		var objDiv = $("#"+id+"");
		$(objDiv).css("display", "none");
	} 
	
	//my profile
	/*function mytopic(){
		if(user==""){//用户未登录
			layer.msg('小伙伴，要先登录哦！');
			setTimeout(function (){
				location.href="login.jsp";
	   		}, 1000); 
			return;
		}
	}*/
	
	</script>
  </head>
  
<ul class="layui-nav">
  <li class="layui-nav-item layui-this"><a href="">首页</a></li>
  <li class="layui-nav-item">
    <a href="javascript:;">话题</a>
    <dl class="layui-nav-child">
      <dd><a href="">选项1</a></dd>
      <dd><a href="">选项2</a></dd>
      <dd><a href="">选项3</a></dd>
    </dl>
  </li>
  <li class="layui-nav-item"><a href="">发现</a></li>
  <li class="layui-nav-item">
    <a href="javascript:;">消息</a>
    <dl class="layui-nav-child">
      <dd><a href="">移动模块</a></dd>
      <dd><a href="">后台模版</a></dd>
      <dd class="layui-this"><a href="">选中项</a></dd>
      <dd><a href="">电商平台</a></dd>
    </dl>
  </li>
  <li class="layui-nav-item"><a href="">社区</a></li>
  <li class="layui-nav-item" style="cursor: pointer;"><a href="useraction/myprofile.do">我的</a></li>
  
  <li class="layui-nav-item sign" style="float: right;"><a href="login.jsp">登录</a></li>
  <li class="layui-nav-item sign" style="float: right;"><a href="register.jsp">注册</a></li>
  <li class="layui-nav-item signin" style="float: right;display: none;">Hello,<span id="usernick"></span></li>
</ul>

<ul id="biuuu_city_list" style="margin: 25px;width: 60%;float: left;cursor: pointer;"></ul>
<ul id="hot_list" style="margin: 25px;width: 20%;;float:left;">

</ul> 
<ul id="recent_list" style="margin: 25px;width: 20%;float: left;">
	
</ul>
<div id="blog_content" style="margin: 25px;float: left;clear: both;"></div>
 
<div id="mydiv1" style="position:absolute;display:none;border:1px solid silver;background:silver;">
提示1效果
</div>  