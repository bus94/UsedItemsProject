$(document).ready(function(){
	console.log('itemView.js 연결');

	$('.itemView_carousel').slick({
    	dots: false,
    	arrows: true,
    	infinite: true,
    	speed: 300,
    	slidesToShow: 5,
    	slidesToScroll: 1,
    	responsive: [
        	{
            	breakpoint: 1024,
            	settings: {
                	slidesToShow: 3,
                	slidesToScroll: 3,
                	infinite: true,
                	dots: true
            	}
        	},
        	{
            	breakpoint: 600,
            	settings: {
                	slidesToShow: 2,
                	slidesToScroll: 2
            	}
        	},
        	{
            	breakpoint: 480,
            	settings: {
                	slidesToShow: 1,
                	slidesToScroll: 1
            	}
        	}

	    ]
	});

});



function openChat(item_index, repl_index) {	//'채팅하기' 버튼 클릭

	//console.log("OpenChat item_index: " + item_index + " repl_index: " + repl_index);
	
	//DB에 새 채팅방 생성
	const queryOpenChat = { room_item : item_index, room_reply : repl_index };
	
	$.ajax({	
			type : "POST",
			url : project + "/chat/openChat.do", //project는 header.jsp 내부 script에서 선언해 둠
			data : queryOpenChat,
			success : function(result) {
						console.log("openChat.do 통신 성공");
						if(result > 0) {
						
						location.href = project + `/item/itemView?item_index=${item_index}`;
						
						} else if( result == 0 ) {
							alert("오류로 인하여 정상적으로 처리되지 않았습니다.");
						} else {
							alert("서버가 정상적으로 작동하지 않습니다.");
						}
					},
			error : function(error) {
					alert("오류로 인하여 정상적으로 처리되지 않았습니다.(AJAX)");
					}
		}); //ajax

}

