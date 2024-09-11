/**
 * 
 */
 
// $().ready(function(){
//    console.log('acc_info.js 연결');
//	});

$(function() {

	console.log('acc_info.js 연결');

});



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