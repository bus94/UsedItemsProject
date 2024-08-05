$().ready(function(){
	console.log('mainProto1.js 연결');
	
	
	
	
	
	
	
	
});

$('#nav_toTop').click(function() {
	console.log('TOP 클릭');
	
	$('html, body').animate({scrollTop : 0	}, 50);
		return false;
});
