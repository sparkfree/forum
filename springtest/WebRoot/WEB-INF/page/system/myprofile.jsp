<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
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
		.signin{
			cursor: pointer;
		}
		.image{
			width:43px;
			height:43px;
			border-radius:50px;
		} 
	</style>
	<script>
	var user="";
	var userid="${sessionScope.user.userid}";
	var nickname="${sessionScope.user.nickname}";
	var username="${sessionScope.user.username}";
	var phonenumber="${sessionScope.user.phonenumber}";
	var email="${sessionScope.user.email}";
	var hobby="${sessionScope.user.hobby}";
	$(function(){
		user = "${sessionScope.user}";//user
		if(user!=""){//用户已经登录
			$(".sign").hide();
			$("#usernick").html(nickname);	
			$(".signin").show();
			$("#userid").val(userid);
			$("#nickname").html(nickname);
			$("#username").html(username);
			$("#phone").html(phonenumber);
			$("#email").html(email);
			$("#hobby").html(hobby);
		}
	});
	
	var str="<li>昵称&nbsp;&nbsp;<input class=\"layui-input\" id=\"enickname\" name=\"enickname\" type=\"text\"></li><br>"
		+"<li>大名&nbsp;&nbsp;<input class=\"layui-input\" id=\"eusername\" name=\"eusername\" type=\"text\"></li><br>"
		+"<li>联系电话&nbsp;&nbsp;<input class=\"layui-input\" id=\"ephone\" name=\"ephone\" type=\"text\"></li><br>"
		+"<li>邮箱&nbsp;&nbsp;<input class=\"layui-input\" id=\"eemail\" name=\"eemail\" type=\"text\"></li><br>"
		+"<li>爱好&nbsp;&nbsp;<input class=\"layui-input\" id=\"ehobby\" name=\"ehobby\" type=\"text\"></li><br>"
		+"<li><button style=\"text-align:center;\" class=\"layui-btn\" onclick=\"saveedit();\">保存</button></li>";
	
	//编辑个人信息
	function edit(){
		$("#enickname").val(nickname);
		$("#eusername").val(username);
		$("#ephone").val(phonenumber);
		$("#eemail").val(email);
		$("#ehobby").val(hobby);
		if($("#editme").is(":hidden")){
			$("#aboutme").hide();
			$("#editme").show();
		}else{
			$("#aboutme").show();
			$("#editme").hide();
		}
	}
	
	//保存修改
	function saveedit(){
		var userid=$("#userid").val();
		var nickname=$("#enickname").val();
		var username=$("#eusername").val();
		var phone=$("#ephone").val();
		var email=$("#eemail").val();
		var hobby=$("#ehobby").val();
		var jsondata={userid:userid,nickname:nickname,username:username,phone:phone,email:email,hobby:hobby};
		var result=_ajax.jsonajax("../useraction/updateuser.do",false,jsondata,"text");
		if(result=="success"){
			layer.msg("个人信息修改成功！");
			//刷新当前页面
		 	window.location.reload();
		}else{
			layer.msg("呦，服务器开小差了，待会再试吧！");
		}
	}
	
	//点赞事件
		function hitheart(ele,id){
			ele.src="${pageContext.request.contextPath}/resources/images/hot_heart.png";//点赞后更换hot_heart图标
			var heart_num=$("#heart_num"+id).val();
			var heart_new=parseInt(heart_num)+1;
			$("#heart_total"+id).html(heart_new);
			//更新该主题点赞数
			var jsondata={id:id,heart:heart_new};
			_ajax.jsonajax("../topicaction/updatehearts.do",false,jsondata,"text");
		}
		
		//话题详情
		function topic_show(tid){
			location.href="../topicaction/topiccomment.do?tid="+tid;//通过controller跳转至web-inf中的页面
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
 	var nums = 8; //每页出现的数据量
	  //模拟渲染
	  var render = function(curr){
	    var page=curr;
	    var rows=nums;
	    var jsondata={page:page,rows:rows};
        var result=_ajax.jsonajax("../topicaction/getmytopic.do",false,jsondata,"json");
        var str='';
        $(result).each(function(index,value){
        	str+='<li onclick=\'topic_show(\"'+value.id+'\");\' class=\'topic\'>'+value.topic+'<li><br><div style=\'float:right;margin-right:10px;\'><span class=\'date_class\'>'+value.publishdate+'</span>&nbsp;&nbsp;<img onclick=\'hitheart(this,'+value.id+');\' class=\'heart_png\' src=\'${pageContext.request.contextPath}/resources/images/gray_heart.png\'/><span id=\'heart_total'+value.id+'\'>'+value.heart+'</span><input id=\'heart_num'+value.id+'\' type=\'hidden\' value=\''+value.heart+'\'>&nbsp;&nbsp;<img onclick=\'topic_show(\"'+value.id+'\");\' id=\'talk\' src=\'${pageContext.request.contextPath}/resources/images/talk.png\'/><span id=\'talk_num\'>'+value.comment+'</span>&nbsp;&nbsp;<img onclick=\'deltopic(\"'+value.id+'\");\' src=\'${pageContext.request.contextPath}/resources/images/deltopic.png\'/></div><hr>';
        });
        return str;
	  };
  		
  	var datasum=_ajax.jsonajax("../topicaction/getmytopicsum.do",false,null,"text");//查询数据总数
	  //调用分页
	  laypage({
	    cont: 'myblog_content'
	    ,pages: Math.ceil(datasum/nums) //得到总页数
	    ,jump: function(obj){
	      document.getElementById('my_topic_list').innerHTML = render(obj.curr);
	    }
	  });
	});
	
	layui.use('layedit', function(){
		var layedit = layui.layedit
 		,$ = layui.jquery;
 		
 		 //构建一个默认的编辑器
  		var index = layedit.build('topicarea', {
		    tool: ['face', 'link', 'unlink', '|', 'left', 'center', 'right']
		    ,height: 100
		  });
  	  //编辑器外部操作
	  var active = {
	    content: function(){
	      //alert(layedit.getContent(index)); //获取编辑器内容
	      var comment=layedit.getContent(index);
	      if(comment==""){
	      	layer.msg('亲，发布内容不能为空哦！');
	      }else{
	      	addtopic(comment);//发布
	      }
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
	});
	
		//发布
		function addtopic(comment){
			//判断用户是否登录
			var user = "${sessionScope.user}";//user
			if(user!=""){
				var jsondata={comment:comment};
				var result=_ajax.jsonajax("../topicaction/addtopic.do",false,jsondata,"text");
				if(result=="success"){
					layer.msg('发布成功！');
					//刷新当前页面
					 window.location.reload();
				}else{
					layer.msg('发布失败，服务器好像开小差了！');
				}
			}else{
				layer.msg('小伙伴，评论要先登录哦！');
				setTimeout(function (){
					location.href="login.jsp";
		   		}, 1000); 
			return;
			}
		}
		
		function deltopic(tid){
			layer.msg('亲，确定要删除吗？<br>评论也会一起删掉哦', {
        		time: 20000, //20s后自动关闭
        		btn: ['我确定', '不了'],
        		yes: function(){
        			var jsondata={tid:tid};
        			var result=_ajax.jsonajax("../topicaction/deletetopic.do",false,jsondata,"text");
        			if(result=="success"){
        				layer.msg("残忍地删除成功！");
        				//刷新当前页面
					 	window.location.reload();
        			}else{
        				layer.msg("服务器开小差了，待会再试吧！");
        			}
		        }
		        ,btn2: function(){
		          	layer.closeAll();
		        }
      		});
		}
		
		layui.use('upload', function(){
		  layui.upload({
		    url: '../topicaction/uploaduserlogo.do' //上传接口
		    ,before: function(input){
      			layer.msg('文件上传中');
    			},            
    		success: function(res){ //上传成功后的回调
		      alert(res)
		    }
		  });
  		});
</script>
</head>
<!--菜单栏  -->  
<ul class="layui-nav">
  <li class="layui-nav-item"><a href="../index.jsp">首页</a></li>
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
  <li class="layui-nav-item layui-this" style="cursor: pointer;"><a href="useraction/myprofile.do">我的</a></li>
  <li class="layui-nav-item sign" style="float: right;"><a href="login.jsp">登录</a></li>
  <li class="layui-nav-item sign" style="float: right;"><a href="register.jsp">注册</a></li>
  <li class="layui-nav-item signin" style="float: right;display: none;">Hello,<span id="usernick"></span></li>
</ul>

<input id="userid" name="userid" type="hidden"/>
<!--发表区  -->
	<div style="margin: 25px;width: 60%;float: left;">
			<fieldset class="layui-elem-field layui-field-title">
  				<legend>说点什么</legend>
			</fieldset>
		<textarea class="layui-textarea" id="topicarea" style="display: none"></textarea>
			<div class="site-demo-button" style="margin-top: 20px;">
  				<button class="layui-btn site-demo-layedit" data-type="content">发布</button>
			</div> 
		</div>
	<ul id="aboutme" style="margin: 25px;width: 20%;;float:left;">
		<fieldset class="layui-elem-field layui-field-title">
		<legend>关于我&nbsp;&nbsp;<img onclick="edit();" style="cursor: pointer;" src="${pageContext.request.contextPath}/resources/images/edit.png"/></legend>
		<li>头像&nbsp;&nbsp;<img class="image" id="" src="../resources/images/tong.jpg"></li><br>
		<li>昵称&nbsp;&nbsp;<span id="nickname"></span></li><br>
		<li>大名&nbsp;&nbsp;<span id="username"></span></li><br>
		<li>联系电话&nbsp;&nbsp;<span id="phone"></span></li><br>
		<li>邮箱&nbsp;&nbsp;<span id="email"></span></li><br>
		<li>爱好&nbsp;&nbsp;<span id="hobby"></span></li><br>
		</fieldset>
	</ul>
	<ul id="editme" style="margin: 25px;width: 20%;height:100px;float:left;display: none;">
		<fieldset class="layui-elem-field layui-field-title">
		<legend>关于我&nbsp;&nbsp;<img onclick="edit();" style="cursor: pointer;" id="editbtn" src="${pageContext.request.contextPath}/resources/images/edit.png"/></legend>
		<li>头像&nbsp;&nbsp;
			  <img class="image" id="myfacepng" src="../resources/images/tong.jpg">
			  <form target="layui-upload-iframe" method="post" key="set-mine" enctype="multipart/form-data" action=""> 
			    <input name="file" class="layui-upload-file" type="file">
			  </form>
		</li><br>
		<li>昵称&nbsp;&nbsp;<input class="layui-input" id="enickname" name="enickname" type="text"></li><br>
		<li>大名&nbsp;&nbsp;<input class="layui-input" id="eusername" name="eusername" type="text"></li><br>
		<li>联系电话&nbsp;&nbsp;<input class="layui-input" id="ephone" name="ephone" type="text"></li><br>
		<li>邮箱&nbsp;&nbsp;<input class="layui-input" id="eemail" name="eemail" type="text"></li><br>
		<li>爱好&nbsp;&nbsp;<input class="layui-input" id="ehobby" name="ehobby" type="text"></li><br>
		<li><button class="layui-btn" onclick="saveedit();">保存</button></li>
		</fieldset>
	</ul>
 	<!-- 内容区 -->
<ul id="my_topic_list" style="margin: 25px;width: 60%;float: left;cursor: pointer;"></ul>
<!-- 分页 -->	
<div id="myblog_content" style="margin: 25px;float: left;clear: both;"></div>
 