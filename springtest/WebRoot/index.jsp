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
	<script>
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
  
  		var nums = 20; //每页出现的数据量
  
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
        	str+='<li>'+value.topic+'<li>';
        });
        return str;
	  };
  
	  //调用分页
	  laypage({
	    cont: 'blog_content'
	    ,pages: Math.ceil(data.length/nums) //得到总页数
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
</ul>

<ul id="biuuu_city_list"></ul> 
<div id="blog_content"></div>
 
 