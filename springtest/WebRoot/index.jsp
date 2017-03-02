<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
  <head>
    <title>多米论坛</title>
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
	</style>
	<script>
		function hitheart(ele,id){
			ele.src="${pageContext.request.contextPath}/resources/images/hot_heart.png";//点赞后更换hot_heart图标
			var heart_num=$("#heart_num"+id).val();
			var heart_new=parseInt(heart_num)+1;
			$("#heart_total"+id).html(heart_new);
			//更新该主题点赞数
			var jsondata={id:id,heart:heart_new};
			_ajax.jsonajax("topicaction/updatehearts.do",false,jsondata,"text");
		}
		
		//话题详情
		function topic_show(){
			alert();
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
		  //测试数据
		  var data = [
		    '北京',
		    '上海',
		    '广州',
		    '深圳',
		    '杭州',
		    '长沙',
		    '合肥',
		    '宁夏',
		    '成都',
		    '西安',
		    '南昌',
		    '上饶',
		    '沈阳',
		    '济南',
		    '厦门',
		    '福州',
		    '九江',
		    '宜春',
		    '赣州',
		    '宁波',
		    '绍兴',
		    '无锡',
		    '苏州',
		    '徐州',
		    '东莞',
		    '佛山',
		    '中山',
		    '成都',
		    '武汉',
		    '青岛',
		    '天津',
		    '重庆',
		    '南京',
		    '九江',
		    '香港',
		    '澳门',
		    '台北'
		  ];
  
  		var nums = 7; //每页出现的数据量
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
        	str+='<li onclick=\'topic_show();\' class=\'topic\'>'+value.topic+'<li><br><div style=\'float:right;margin-right:10px;\'><span class=\'date_class\'>'+value.publishdate+'</span>&nbsp;&nbsp;<img onclick=\'hitheart(this,'+value.id+');\' class=\'heart_png\' src=\'${pageContext.request.contextPath}/resources/images/gray_heart.png\'/><span id=\'heart_total'+value.id+'\'>'+value.heart+'</span><input id=\'heart_num'+value.id+'\' type=\'hidden\' value=\''+value.heart+'\'>&nbsp;&nbsp;<img id=\'talk\' src=\'${pageContext.request.contextPath}/resources/images/talk.png\'/><span id=\'talk_num\'></span></div><hr>';
        });
        return str;
	  };
  		
  	var datasum=_ajax.jsonajax("topicaction/gettopicsum.do",false,null,"text");//查询数据总数
  	
  	var hotdata=_ajax.jsonajax("topicaction/getHotTopic.do",false,null,"json");
  	var renderhot=function(){
  		var str='';
  		$(hotdata).each(function(index,value){
        	str+='<li onclick=\'topic_show();\' class=\'topic\'>'+value.topic+'<li><br><div style=\'float:right;margin-right:10px;\'><span class=\'date_class\'>'+value.publishdate+'</span>&nbsp;&nbsp;<img onclick=\'hitheart(this,'+value.id+');\' class=\'heart_png\' src=\'${pageContext.request.contextPath}/resources/images/gray_heart.png\'/><span id=\'heart_total'+value.id+'\'>'+value.heart+'</span><input id=\'heart_num'+value.id+'\' type=\'hidden\' value=\''+value.heart+'\'>&nbsp;&nbsp;<img id=\'talk\' src=\'${pageContext.request.contextPath}/resources/images/talk.png\'/><span id=\'talk_num\'></span></div><hr>';
        });
        return str;
  	};
  	
  	var rendertopic=function(){
  		var str='';
  		$(hotdata).each(function(index,value){
        	str+='<li onclick=\'topic_show();\' class=\'topic\'>'+value.topic+'<li><br><div style=\'float:right;margin-right:10px;\'><span class=\'date_class\'>'+value.publishdate+'</span>&nbsp;&nbsp;<img onclick=\'hitheart(this,'+value.id+');\' class=\'heart_png\' src=\'${pageContext.request.contextPath}/resources/images/gray_heart.png\'/><span id=\'heart_total'+value.id+'\'>'+value.heart+'</span><input id=\'heart_num'+value.id+'\' type=\'hidden\' value=\''+value.heart+'\'>&nbsp;&nbsp;<img id=\'talk\' src=\'${pageContext.request.contextPath}/resources/images/talk.png\'/><span id=\'talk_num\'></span></div><hr>';
        });
        return str;
  	};
  	
  	document.getElementById('hot_list').innerHTML=renderhot();
  	document.getElementById('recent_list').innerHTML=rendertopic();
	  //调用分页
	  laypage({
	    cont: 'blog_content'
	    ,pages: Math.ceil(datasum/nums) //得到总页数
	    ,jump: function(obj){
	      document.getElementById('biuuu_city_list').innerHTML = render(obj.curr);
	    }
	  });
  
});
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
  
  <li class="layui-nav-item" style="float: right;"><a href="login.jsp">登录</a></li>
  <li class="layui-nav-item" style="float: right;"><a href="register.jsp">注册</a></li>
</ul>

<ul id="biuuu_city_list" style="margin: 25px;width: 60%;float: left;cursor: pointer;"></ul>
<ul id="hot_list" style="margin: 25px;width: 20%;;float:left;">
	<li>今日头条</li>
	<li>今日头条</li>
	<li>今日头条</li>
	<li>今日头条</li>
	<li>今日头条</li>
	<li>今日头条</li>
</ul> 
<ul id="recent_list" style="margin: 25px;width: 20%;float: left;">
	<li>今日头条</li>
	<li>今日头条</li>
	<li>今日头条</li>
	<li>今日头条</li>
	<li>今日头条</li>
	<li>今日头条</li>
</ul>
<div id="blog_content" style="margin: 25px;float: left;clear: both;"></div>
 
 