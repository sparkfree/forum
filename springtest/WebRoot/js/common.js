//ajax��װȫ�ַ���
var _ajax={
		jsonajax:function(url,aysnc,data,datatype,fun){
			  var ajaxobj;
			  $.ajax({
				 url:url,
				 type: 'post',
				 async: aysnc,
				 dataType:datatype,
				 data:data,
				 success: function(backstr,strStatus){
					 ajaxobj=backstr;
					 if(aysnc){
						eval(""+fun+"('"+ajaxobj+"')"); 	
					 }
				 }
			  });
			  if(!aysnc){ return ajaxobj;}
			  }
};