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
                    	$("#topic").append("<div style='border:1px solid gray;margin-top:20px;height:100px;'><div style=''><a href=''>"+value.userid+"</a>发布于"+value.publishdate+"</div><div style=''>"+value.topic+"</div><div>点赞数："+value.heart+"</div></div>");
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
    	<div id="topic" style="border: 1px solid red;width: 75%;float:left;margin-left: 30px;">
    		<div id="follow">this is a scroll test;<br/>    页面下拉自动加载内容</div>  
<!--         <div style='border:1px solid tomato;margin-top:20px;color:#ac1;height:500' >hello world test DIV</div>   -->
    	</div>
    	<div id="" style="border: 1px solid green;width: 20%;float:left;">
    		最热话题榜
    	</div>
    </div>
    <jsp:include page="footer.jsp"></jsp:include>
  </body>
</html>
