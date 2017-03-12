<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String id=(String)request.getAttribute("tid");//topic id
%>
  <head>
    <base href="<%=basePath%>">
    
    <title>评论</title>
    <style type="text/css">
    	#contents:HOVER {
		color: green;
}
	#comments li{
		height: 30px;
	}
    </style>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css"  media="all">
	<script src="${pageContext.request.contextPath}/resources/layui/layui.js" charset="utf-8"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
	<script type="text/javascript">
		layui.use('element', function(){
		  var element = layui.element(); //导航的hover效果、二级菜单等功能，需要依赖element模块
		  //监听导航点击
		  element.on('nav(demo)', function(elem){
		    layer.msg(elem.text());
		  });
		});
		
		layui.use(['laypage', 'layer'], function(){
		  var laypage = layui.laypage,layer = layui.layer;
		  var id="<%=id%>";
		 var jsond={fkid:id};
		 var datasum=_ajax.jsonajax("topicaction/getcommentsum.do",false,jsond,"text");//查询评论总数
		 var nums = 5; //每页出现的数据量
		 //模拟渲染
	  var render = function(curr){
	    var page=curr;
	    var rows=nums;
	    var jsondata={id:id,page:page,rows:rows};
        var result=_ajax.jsonajax("topicaction/getcommentbyid.do",false,jsondata,"json");
        var str='';
        $(result).each(function(index,value){
        	str+='<li style=\'color:green;\'>'+value.username+'<li><span style=\'margin:10px;\'>'+value.content+'</span><hr>';
        });
        return str;
	  };
		  //调用分页
	  laypage({
	    cont: 'blog_comment'
	    ,pages: Math.ceil(datasum/nums) //得到总页数
	    ,jump: function(obj){
	      document.getElementById('biuuu_comment_list').innerHTML = render(obj.curr);
	    }
	  });
	});
		
	layui.use('layedit', function(){
		var layedit = layui.layedit
 		,$ = layui.jquery;
 		
 		 //构建一个默认的编辑器
  	var index = layedit.build('LAY_demo1', {
		    tool: ['face', 'link', 'unlink', '|', 'left', 'center', 'right']
		    ,height: 100
		  });
  
  //编辑器外部操作
	  var active = {
	    content: function(){
	      //alert(layedit.getContent(index)); //获取编辑器内容
	      var comment=layedit.getContent(index);
	      addcomment(comment);//添加评论
	    }
	    ,text: function(){
	      alert(layedit.getText(index)); //获取编辑器纯文本内容
	    }
	    ,selection: function(){
	      alert(layedit.getSelection(index));
	    }
	  };
	  
	  $('.site-demo-layedit').on('click', function(){
	    var type = $(this).data('type');
	    active[type] ? active[type].call(this) : '';
	  });
	  
	   //自定义工具栏
		  //layedit.build('LAY_demo2', {
		  //  tool: ['face', 'link', 'unlink', '|', 'left', 'center', 'right']
		 //   ,height: 100
		 // });
	});

		$(function(){
			user = "${sessionScope.user}";//user
			if(user!=""){//用户已经登录
				$(".sign").hide();
				var nickname="${sessionScope.user.nickname}";
				$("#usernick").html(nickname);	
				$(".signin").show();
			}
			var id="<%=id%>";
			var jsondata={id:id};
			var data=_ajax.jsonajax("topicaction/gettopicbyid.do",false,jsondata,"json");
			$("#fkid").val(id);
			$("#topic").html(data.topic);
			$("#publishdate").html(data.publishdate);
			$("#heart").html(data.heart);
			$("#comment").html(data.comment);
			//根据topic id加载评论
			var result="";//_ajax.jsonajax("topicaction/getcommentbyid.do",false,jsondata,"json");
			if(result==""){
				//$("#comments").html("<li style=\"color:green;\">还没有评论哦，快来占个沙发吧！</li>");
			}else{
				var str="";
				$(result).each(function(index,value){
        			str+='<li style=\'color:green;\'>'+value.username+'<li><span style=\'margin:10px;\'>'+value.content+'</span><hr>';
        		});
        		//$("#comments").html(str);
			}
		});
		
		//添加评论
		function addcomment(comment){
			//判断用户是否登录
			var user = "${sessionScope.user}";//user
			if(user!=""){
				var fkid=$("#fkid").val();
				var jsondata={comment:comment,fkid:fkid};
				var result=_ajax.jsonajax("topicaction/addcomment.do",false,jsondata,"text");
				if(result=="success"){
					layer.msg('评论成功，抢到沙发了哦！');
					//评论成功后更新topic表中的comment字段
					var json={id:fkid};
					_ajax.jsonajax("topicaction/updatecomment.do",false,json,"text");
					//刷新当前页面
					 window.location.reload();
				}else{
					layer.msg('评论失败，服务器好像开小差了！');
				}
			}else{
				layer.msg('小伙伴，评论要先登录哦！');
				setTimeout(function (){
					location.href="login.jsp";
		   		}, 1000); 
			return;
			}
		}
		
	</script>
  </head>
<ul class="layui-nav">
  <li class="layui-nav-item layui-this"><a href="index.jsp">首页</a></li>
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

<div style="margin: 25px;width: 60%;height: 20%;">
	<div id="contents" style="cursor: pointer;">
		<span id="topic"></span><br>
		<div style="float: right;">
			<span id="publishdate"></span>&nbsp;&nbsp;
			<img src="${pageContext.request.contextPath}/resources/images/hot_heart.png" alt=""/><span id="heart"></span>&nbsp;&nbsp;
			<img alt="" src="${pageContext.request.contextPath}/resources/images/talk.png"/><span id="comment"></span>	
		</div>
	</div>
	<input name="fkid" id="fkid" value="" type="hidden">
	<div style="padding-top: 50px;">
<!-- 		<ul id="comments"> -->
			
<!-- 		</ul> -->
<!-- 		<br> -->
		<ul id="biuuu_comment_list" style="margin: 25px;width: 60%;cursor: pointer;"></ul>
		<div id="blog_comment"></div>
		<br>
		<div>
			<fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
  				<legend>评论区</legend>
			</fieldset>
		<textarea class="layui-textarea" id="LAY_demo1" style="display: none">  
		</textarea>
			<div class="site-demo-button" style="margin-top: 20px;">
  				<button class="layui-btn site-demo-layedit" data-type="content">评论</button>
			</div> 
		</div>
	</div>
</div>

