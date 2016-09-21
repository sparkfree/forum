<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>我的主页</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/index.css">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.8.3.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/common.js"></script>
	<script type="text/javascript">
	var userid="";
	var username="";
	var account="";
	var phonenumber="";
	var email="";
	var address="";
	//页面加载时加载数据
	$(function(){
		userid="${sessionScope.user.userid}";
		username="${sessionScope.user.username}";
		account="${sessionScope.user.account}";
		phonenumber="${sessionScope.user.phonenumber}";
		email="${sessionScope.user.email}";
		address="${sessionScope.user.address}";
		$("#name").html(username);
		$("#phone").html(phonenumber);
		$("#mail").html(email);
		$("#add").html(address);
		
		$(".editcss").hide();
		$("#save").hide();
		$("#back").hide();
		var range = 50;             //距下边界长度/单位px  
        var elemt = 100;            //插入元素高度/单位px  
        var maxnum = 20;            //设置加载最多次数  
        var num = 1;  
        var totalheight = 0;   
        var main = $("#topic");                     //主体元素  
        $(window).scroll(function(){  
            var srollPos = $(window).scrollTop();    //滚动条距顶部距离(页面超出窗口的高度)  
            //console.log("滚动条到顶部的垂直高度: "+$(document).scrollTop());  
            //console.log("页面的文档高度 ："+$(document).height());  
            //console.log('浏览器的高度：'+$(window).height());  
              
            totalheight = parseFloat($(window).height()) + parseFloat(srollPos);  
            if(($(document).height()-range) <= totalheight  && num != maxnum) {  
                //main.append("<div style='border:1px solid tomato;margin-top:20px;color:#ac"+(num%20)+(num%20)+";height:"+elemt+"' >hello world"+srollPos+"---"+num+"</div>");  
                num++;  
            }  
        });  
        
			//ajax加载topic
			$.ajax({
                type: "POST",
                url: "topicaction/getmytopic.do",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function(data) {
                	if(data!=""){
                		$(data).each(function(n,value){
                    	//$("#topic").append("<div style='border:1px solid gray;margin-bottom:20px;height:100px;'><div style='float:left;'><a href='' style='font-size:16px;'>"+value.username+"</a>&nbsp;&nbsp;发布于"+value.publishdate+"</div><div style='font-size:18px;'>"+value.topic+"</div><div><a>点赞</a>:"+value.heart+"</div></div>");
                   	 	//$("#topic").append("<table style='border-bottom:1px solid gray;margin-bottom:20px;height:100px;width:100%;' id='content'><tr><td style='width:30%;'><a style='font-size:16px;'>"+value.username+"</a>&nbsp;&nbsp;发布于："+value.publishdate+"</td><td style='width:50%;'>"+value.topic+"</td><td style='width:20%;'><a>点赞</a>&nbsp;"+value.heart+"&nbsp;&nbsp;<a>评论</a>"+3+"</td></tr></table>");
                   	 	
                   	 	$("#topic").append("<table id='content"+n+"' style='border-bottom:1px solid gray;margin-bottom:20px;height:100px;width:100%;'><tr><td style='width:30%;'><a style='font-size:16px;'>"+value.username+"</a>&nbsp;&nbsp;发布于："+value.publishdate+"</td><td style='width:50%;'>"+value.topic+"</td><td style='width:20%;'><a>点赞</a>&nbsp;"+value.heart+"&nbsp;&nbsp;<a>评论</a>&nbsp;<span id='comnum"+n+"'></span></td></tr><tr><td></td></tr></table>");
						//查询评论
                   		var jsondata={id:value.id};
                   		var obj=_ajax.jsonajax("topicaction/getcomment.do",false,jsondata,"json");
                   		var comnum=0;
                   		$(obj).each(function(m,mvalue){
                   			comnum++;
                   			$("#content"+n).append("<tr><td></td><td><a style='font-size:16px;'>"+mvalue.username+"</a>&nbsp:&nbsp;"+mvalue.content+"</td><td></td></tr>");
                   		});
                   		$("#comnum"+n).html(comnum);//评论数
                   	 	});
                	}else{
                		$("#topic").append("<div style='border:1px solid gray;margin-bottom:20px;height:450px;'><div style=''><a href=''>您还没有任何动静!~~</a></div></div>");
                	}
                    
                }, error: function(error) {
                
                }
            });
		});
		
		//加载个人信息
		function loadinfo(userid){
			//url,aysnc,data,datatype,fun
			var data={userid:userid};
			var obj=_ajax.jsonajax("getmyinfo.do",false,data,"json");
			$("#userid").val(obj.userid);
			$("#username").val(obj.username);
			$("#phonenumber").val(obj.phonenumber);
			$("#email").val(obj.email);
			$("#address").val(obj.address);
		}
		
		//编辑个人信息
		function editmyinfo(){
			$(".showcss").hide();
			$("#edit").hide();
			$(".editcss").show();
			$("#save").show();
			$("#back").show();
			loadinfo(userid);
		}
		//退出编辑
		function backedit(){
			$(".showcss").show();
			$(".editcss").hide();
			$("#save").hide();
			$("#back").hide();
			$("#edit").show();
		}
		//保存个人信息
		function savemyinfo(){
			var id=$("#userid").val();
			var name=$("#username").val();
			var phone=$("#phonenumber").val();
			var email=$("#email").val();
			var address=$("#address").val();
			$.ajax({
                url: "updatemyinfo.do",
               	type: 'post',
				dataType: 'json',
                data:{userid:id,username:name,phonenumber:phone,email:email,address:address},
                success: function(data) {
                	if(data!=null){
                		alert("编辑个人信息成功");
                		$(".showcss").show();
						$(".editcss").hide();
						$("#save").hide();
						$("#back").hide();
						$("#edit").show();
					
					$("#name").html(username);
					$("#phone").html(phonenumber);
					$("#mail").html(email);
					$("#add").html(address);
                	}else{
                		alert("编辑个人信息失败");
                		$(".showcss").show();
						$(".editcss").hide();
						$("#save").hide();
						$("#back").hide();
						$("#edit").show();
                	}
                }
			});
		}
	</script>
  </head>
  
  <body>
    <jsp:include page="title.jsp"></jsp:include>
    <div style="">
    	<div id="topic" style="border: 1px solid #00A2CA;width: 75%;float:left;margin-left: 30px;">
<!--     		<div id="follow">this is a scroll test;<br/>    页面下拉自动加载内容</div>   -->
<!--         <div style='border:1px solid tomato;margin-top:20px;color:#ac1;height:500' >hello world test DIV</div>   -->
    	</div>
    	<div id="" style="border: 1px solid #00A2CA;width: 20%;float:left;">
    		<div>我的主页</div>
    		<input name="userid" id="userid" type="hidden">
    		<div>
    			昵称：<span class="showcss" id="name"></span><input class="editcss" name="username" id="username" type="text">
    			<br>
    			联系方式：<span class="showcss" id="phone"></span><input class="editcss" name="phonenumber" id="phonenumber" type="text">
    			<br>
    			邮箱：<span class="showcss" id="mail"></span><input class="editcss" name="email" id="email" type="text">
    			<br>
    			地址：<span class="showcss" id="add"></span><input class="editcss" name="address" id="address" type="text">
    		</div>
    		<div>
    			<input name="edit" id="edit" value="编辑" type="button" onclick="editmyinfo()">
    			<input name="save" id="save" value="保存" type="button" onclick="savemyinfo()">
    			<input name="back" id="back" value="返回" type="button" onclick="backedit()">
    		</div>
    	</div>
    </div>
    <jsp:include page="footer.jsp"></jsp:include>
  </body>
</html>
