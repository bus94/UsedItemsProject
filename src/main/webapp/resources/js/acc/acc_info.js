/**
 * 
 */
 
// $().ready(function(){
//    console.log('acc_info.js 연결');
//	});

$(function() {

	console.log('acc_info.js 연결');

});


// 회원정보_매물 목록

// [ (거래중)[carousel],[carousel에 속한 item],
//   (판매중)[carousel],[carousel에 속한 item],
//  (판매내역)[carousel],[carousel에 속한 item],
//  (구매내역)[carousel],[carousel에 속한 item],
//  (관심물품)[carousel],[carousel에 속한 item] ]

var arr_carousel_slide = [ 	[$('#slick_carousel_1'), $('.carousel_1_item')],
						[$('#slick_carousel_2'), $('.carousel_2_item')],
						[$('#slick_carousel_3'), $('.carousel_3_item')],
						[$('#slick_carousel_4'), $('.carousel_4_item')],
						[$('#slick_carousel_5'), $('.carousel_5_item')]  ]


for (i=0; i<5; i++) {
	 
	if(arr_carousel_slide[i][1].length>5) {
		//item 수 > 5이면 carousel 돌리기
		//console.log("5 초과 itemCount: " + arr_carousel_slide[i][1].length);
		arr_carousel_slide[i][0].slick({
	        dots: false,
	        infinite: true,
	        arrows: true,
	        speed: 500,
	        slidesToShow: 5,
	        slidesToScroll: 1,
	        autoplay: false
	    });
	} else {
		//item 수 <= 5이면 단순 나열
		//console.log("5 이하 itemCount: " + arr_carousel_slide[i][1].length);
		arr_carousel_slide[i][0].css({
	        'overflow': 'hidden',
	        'width': 'auto',
	        'justify-content': 'flex-start'
	    });
	    arr_carousel_slide[i][0].children(':first').css({
	        'margin-left': '8px'
	    });
	    arr_carousel_slide[i][1].css({
	    	'border' : '1px solid lightgray',
	    	'width' : '190px'
	    });
	}
	
} 



// 타임라인 토글
$('#btn_timeline').click(function(){

	// account/info.jsp 컨테이너 padding css
	$('#acc_summary').toggleClass('acc_summary_withTimeline');
	$('.carousel-wrapper').toggleClass('carousel-wrapper_withTimeline');

	
	const queryTimeline = { loginMember_accIndex : loginMember_accIndex };
	
	$.ajax({
			type : "GET",
			url : project + "/chat/timeline.do", //project는 header.jsp 내부 script에서 선언해 둠
			data : queryTimeline,
			success : function(result) {
			
						//열릴 때마다 container 초기화(누적 생성 방지)
						$('#offcanvas_timeline_body').empty();	//타임라인 바디(컨테이너) 리셋
						
						console.log("timeline_size: " + result.length);
						
						writingTimeline(result); 
						//타임라인 이벤트 요소 생성, result=eventList를 그대로 매개변수로 넘겨줌
											
					},
			error : function(error) {
					alert("오류로 인하여 정상적으로 처리되지 않았습니다.(AJAX)");
					}
		}); //ajax
				
});


$('#btn_close_timeline').click(function(){
	$('#acc_summary').removeClass('acc_summary_withTimeline');
	$('.carousel-wrapper').removeClass('carousel-wrapper_withTimeline');
});



function writingTimeline(eventList) {

	console.log(eventList);
	$(eventList).each(function (index, obj){	//forEach 반복문 jQuery 형식
	
		
		var event_code = 'event_' + obj.event_code;
		
		//날짜 형식 변환, 메서드 정의는 하단
		var formattedDate = formattingDate(new Date(obj.event_time));
	
		var event_template = 
		  `<div class="event_box ${event_code}">`
		+ `<p class="event_message">&middot; ${obj.event_message}</p>`
		+ `<p class="event_time">${formattedDate}</p>`
		+ '</div>';
	
	
		$('#offcanvas_timeline_body').append(event_template);
	
	}); //반복문 종료
	
}




//Date -> yy/MM/dd hh:mm
function formattingDate(param) {
	
	//Date type parameter를 받아서 yy/MM/dd hh:mm 형식으로 반환
	var result = param.getFullYear().toString().slice(-2) + "/" 
			+ (param.getMonth()+1).toString().padStart(2, '0') + "/" 
			+ param.getDate().toString().padStart(2, '0') + " " 
			+ param.getHours().toString().padStart(2, '0') + ":"
			+ param.getMinutes().toString().padStart(2, '0');

	return result;	
}

