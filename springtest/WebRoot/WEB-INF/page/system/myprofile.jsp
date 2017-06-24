<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
  <title>简言，分享你的故事</title>
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
	
	<script>
	var user="";
	var userid="${sessionScope.user.userid}";
	var nickname="${sessionScope.user.nickname}";
	var username="${sessionScope.user.username}";
	var phonenumber="${sessionScope.user.phonenumber}";
	var email="${sessionScope.user.email}";
	var hobby="${sessionScope.user.hobby}";
	var userface="${sessionScope.user.userface}";
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
			if(userface==""){//如果用户还没有上传头像
				$('#userface').attr("src","${pageContext.request.contextPath}/resources/images/tong.jpg");
			}else{
				$('#userface').attr("src","${pageContext.request.contextPath}/upload/userface/"+userface);			
			}
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
		if(userface==""){//如果用户还没有上传头像
				$('#myfacepng').attr("src","${pageContext.request.contextPath}/resources/images/tong.jpg");
			}else{
				$('#myfacepng').attr("src","${pageContext.request.contextPath}/upload/userface/"+userface);			
			}
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
		
		//上传图片
		layedit.set({
			  uploadImage: {
			    url: '../topicaction/uploadimage.do' //接口url
			    ,type: 'post' //默认post
			    ,success:function(res){
			    	alert(res)
			    }
			  }
			});
 		
 		 //构建一个默认的编辑器
  		var index = layedit.build('topicarea', {
		    tool: ['face', 'image','link', 'unlink', '|', 'left', 'center', 'right']
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
    			layer.msg(res);
		    }
		  });
  		});
  		
  		//ajax上传用户头像
  		function ajaxFileUploadss(){
  			$.ajaxFileUpload({
	        url:'../useraction/uploaduserface.do?userid='+userid,//用于文件上传的服务器端请求地址
	        secureuri:false,//一般设置为false
	        fileElementId:'facefile',//文件上传控件的id属性  <input type="file" id="file" name="file" />
	        dataType: 'json',//返回值类型 一般设置为json
	        success: function (data, status){  //服务器成功响应处理函数
	           	if(data.flag=='success'){ //从服务器返回的json中取出message中的数据
	        	  	layer.msg("上传成功！");
	        	  	$('#faceimagepath').val(data.faceimagepath);
					$('#myfacepng').attr("src","${pageContext.request.contextPath}/upload/userface/"+data.faceimagepath);
	           	}else if(data.flag=='typeerror'){
	        	   	layer.msg("图片类型错误，上传失败。");
	           	}else{
	           		layer.msg("未知错误，上传失败！");
	           	}
	        },
	        error: function (data, status, e){//服务器响应失败处理函数
	           layer.msg("服务器无法连接！");
	        }
	    });
  		}
  		
  		function hobbytip(){
  			layer.msg("爱好填写越准确，为你匹配相似爱好的小伙伴越准确哦！-_^");
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
  <div class="row-fluid">
  	<div class="span8">
    	<div class="row-fluid">
    		<div id="topichtml">
    			<textarea rows="" cols="" style="width: 80%;height: 48px;"></textarea>
    			<br><a onclick="login();" class="btn btn-primary btn-large">发布</a>
    		</div>
    	</div>
    </div>
  	<div class="span3">
  		<div class="sidebar-nav">
            <ul class="nav nav-list">
              <li class="nav-header">关于我</li>
              <li><span class="label label-default">头像：</span></li><br>
              <li><span class="label label-default">昵称：</span></li><br>
              <li><span class="label label-default">大名：</span></li><br>
              <li><span class="label label-default">联系电话：</span></li>
              <li class="nav-header">汪洋在任时</li>
              <li class="active"><a href="fluid.html#">汪书记最英明</a></li>
              
              <li class="nav-header">薄熙来在任时</li>
             
              <li class="nav-header">薄熙来下台了</li>
             
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

</body>
 