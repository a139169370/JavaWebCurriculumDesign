$(function(){  
	
	
	
jQuery(".slideTxtBox3 .picScroll-left2").slide({titCell:".cd ul",mainCell:".dd ul",autoPage:true,effect:"leftLoop",autoPlay:true,vis:4,trigger:"click",prevCell:".sPrev",nextCell:".sNext"});//我们的产品
	$('.foot_weixin').hover(function(){
			$('.foot_weixin img').stop().fadeIn();
		},function(){
			$('.foot_weixin img').stop().fadeOut();
		});
	

});
//回到顶部
function goTop(){
	$('html,body').animate({'scrollTop':0},600);
}