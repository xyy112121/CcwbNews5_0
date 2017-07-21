
$(function(){

});

/**
 * 加载新闻详情
 *
 */
function load_news_detail(news_id){
    
	$.ajax({
   	    type: 'post',
   	    url:'http://172.16.5.12:82/app/public/api/WebApi/getNewsDetail.html',
   	    data:{'cw_id':news_id},
   	    success: function(data) {
           
   	        if(data.success=="true"){
   	        	data=data.data;
   	        	$("#news_info").html(data.info);
   	        	$("#news_title").html(data.title);
   	        	$("#news_add_time").html(data.add_time);
   	        	$("#news_add_source").html(data.source);
   	        	$("#news_click_num").html(data.click_num);
   	        	var appInfo=data.appInfo;

//   	        	$("#nav_img").attr("src",appInfo.logo_pic_path);
//   	        	$("#nav_title").html(appInfo.name);

//   	        	//设置懒加载
//   	        	$("#news_info img").each(function(index,element){
//   	        		$(this).attr('data-echo',$(this).attr("src"));
//   	        		$(this).attr('src',WXPAGE+'/images/ccwb_common_default_normal.png');
//   	        	});
//   	        	//懒加载生效
//   	        	load_image_lazey();
//
//   	        	//初始化图片查看器
//   	        	initSwipe('#news_info img');
   	        }else{
           
   	        	alert(data.msg);
   	        }
   	    },
   	    error:function(XMLHttpRequest, textStatus, errorThrown){
   	    	 //alert(textStatus);
           alert(XMLHttpRequest.status);
   	    }
   	});
}

