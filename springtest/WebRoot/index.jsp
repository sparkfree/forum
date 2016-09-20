<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>多米论坛</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/index.css">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.8.3.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/common.js"></script>
	<script type="text/javascript">
	$(function(){
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
                url: "topicaction/gettopic.do",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function(data) {
                    $(data).each(function(n,value){
                    	//$("#topic").append("<div id='con"+n+"' style='border-bottom:1px solid gray;margin-bottom:20px;height:100px;'><div style='float:left;'><a href='' style='font-size:16px;'>"+value.username+"</a>&nbsp;&nbsp;发布于"+value.publishdate+"</div><div style='font-size:18px;'>"+value.topic+"<div style='float:right;margin-right:5px;'><a>点赞</a>："+value.heart+"&nbsp;&nbsp;<a>评论</a>："+3+"</div></div></div>");
                    	//$("#con"+n).append("<div style='border:1px solid red;float:left;'><a style='font-size:16px;'>sum</a>:最喜欢的运动是跑步...</div>");
                    	//$("#con"+n).append("<div style='border:1px solid red;float:left;'>我要说：</div>");
                    	
                    	$("#topic").append("<table id='content"+n+"' style='border-bottom:1px solid gray;margin-bottom:20px;height:100px;width:100%;'><tr><td style='width:30%;'><a style='font-size:16px;'>"+value.username+"</a>&nbsp;&nbsp;发布于："+value.publishdate+"</td><td style='width:50%;'>"+value.topic+"</td><td style='width:20%;'><a>点赞</a>&nbsp;"+value.heart+"&nbsp;&nbsp;<a>评论</a>"+3+"</td></tr></table>");
						//查询评论
                   		var jsondata={id:value.id};
                   		var obj=_ajax.jsonajax("topicaction/getcomment.do",false,jsondata,"json");
                   		$(obj).each(function(m,mvalue){
                   			$("#content"+n).append("<tr><td></td><td><a style='font-size:16px;'>"+mvalue.username+"</a>&nbsp:&nbsp;"+mvalue.content+"</td><td></td></tr>");
                   		});
                   		
                    });
                }, error: function(error) {
                
                }
            });
		});
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
    		<span style='font-size:16px;'>最热话题榜</span>
    		
    	</div>
    	
    </div>
    <jsp:include page="footer.jsp"></jsp:include>
  </body>
</html>
