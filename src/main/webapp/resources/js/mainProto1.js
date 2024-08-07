$().ready(function(){
	console.log('mainProto1.js 연결');
	
	
	
	
	
	
	
	
});

$('#nav_toTop').click(function() {
	console.log('TOP 클릭');
	
	$('html, body').animate({scrollTop:0	}, 50);
		return false;
});


window.addEventListener('scroll', function(){

	//console.log(window.scrollY);

	if(window.scrollY >= '300') {
		console.log('scrollY >= 300');
		

		
		//console.log('before: ' + $('#before').attr('id')); //id 속성 값을 가져옴
		//console.log('after: ' + $('#after').attr('id')); //id 속성 값을 가져옴
		
		//.addClass('ab cd') : 클래스 값에 'ab cd' 추가
		
		
		$('#before').removeClass('fixed-top');
		console.log('before: ' + $('#before').attr('class'));
		
		// attr('attribute', 'value')
		$('#before').attr('id','after'); //id 속성 값 변경 ('#before' -> '#after')
	}
	
	if(window.scrollY < '300') {
		
		$('#after').attr('id','before');
		$('#before').addClass('fixed-top');
	}
	
	
	
	
	
		// prop() 프로퍼티를 가져오거나 수정
		// removeAttr(): attribute 제거
		// removeProp(): property 제거
});