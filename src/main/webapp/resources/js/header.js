/**
 * 
 */
 
 $(document).ready(function() {

	console.log('header.js 연결');
	
});

console.log("loginMember.accIndex: "+ loginMember_accIndex);

const my_index = loginMember_accIndex;
const path = "/useditems";	//contextPath(project) 변수 선언



	
$('#logout').click(function() {

	if (confirm("정말 정말 로그아웃 하시겠습니까?ㅠ_ㅠ")) {
		//console.log("logout");
		window.location.href = path + "/account/logoutOK.do";
	}
	
});



$('#nav_chat').click(function() {

	//console.log('CHAT 클릭');
	//console.log('acc_index: " + loginMember_accIndex);
	
	const queryChatList = { loginMember_accIndex : loginMember_accIndex };
	
	$.ajax({
			type : "POST",
			url : path + "/chat/chatList.do", //path는 전역변수
			data : queryChatList,
			success : function(result) {
						if(result.length == 0){
							alert("개설된 채팅방이 없습니다.");
						}else {
							console.log("chatList_size: " + result.length);
							makingChatRooms(result);	//함수 정의는 아래에, result=chatList를 그대로 매개변수로 넘겨줌
						}
						
					},
			error : function(error) {
					alert("오류로 인하여 정상적으로 처리되지 않았습니다.(AJAX)");
					}
		}); //ajax
				
				
				
});


$('#nav_toTop').click(function() {
	//console.log('TOP 클릭');

	$('html, body').animate({
		scrollTop : 0
	}, 50);
	
	return false;
});


$('.navbar-toggler').click(function() {
	//console.log('Nav토글버튼 클릭');
	$('section').toggleClass('section_toggleOn');
	$('#nav_user').toggle();
	$('#nav_wish').toggle();
	$('.menu_text').toggle();
});


window.addEventListener('scroll', function() {
	//console.log(window.scrollY);

	// 스크롤 Y축 300 초과 시 실행
	if (window.scrollY > '300') {
		$('#nav_toTop').show();
	}

	// 스크롤 Y축 300 미만 시 실행
	if (window.scrollY < '300') {
		$('#nav_toTop').hide();
	}

});







		



function makingChatRooms(chatList) {	//채팅리스트 모달 생성
	
	$('#chatList').empty(); //컨테이너 리셋
	$('#ChatRoom_Modal_reservoir').empty();	//컨테이너 리셋
	
	
	$(chatList).each(function (index, obj){	//forEach 반복문 jQuery 형식
			
		
		//console.log(index);
		//console.log(obj.room_index);
		console.log("날짜가 왜 이래: " + obj.room_openDate);
		//console.log(obj.room_itemTitle);
		console.log("messages: " + obj.messages);
		
		
		var thisRoom = obj.room_index;
		
		var other_index = '';
		var other_id = '';
		var other_profile = '';
		
		if(my_index == obj.room_hostIndex) {
			other_index = obj.room_guestIndex;
			other_id = obj.room_guestId;
			other_nickname = obj.room_guestNickname;
			other_profile = obj.room_guestProfile;
		} else {
			other_index = obj.room_hostIndex;
			other_id = obj.room_hostId;
			other_nickname = obj.room_hostNickname;
			other_profile = obj.room_hostProfile;
		}
		
	
		///////////////////Modal Element/////////////////
	
		//채팅 목록 template
		var chatList_template = 
		
		`<div id="chatRoom_box" class="chatRoom_box container>`
		+ `<p>${obj.room_itemTitle}</p>`
		+ `<p>${obj.room_openDate}</p>`
		+ `<button class="enterChatRoom" id="enterChatRoom${obj.room_index}" value="${obj.room_index}" onclick="enterChatRoom(this.value)" data-bs-target="#chatRoomModal${obj.room_index}" data-bs-toggle="modal"></button>`
		+ '</div>';

		
		$('#chatList').append(chatList_template);



		//채팅방 template
		var chatRoom_modal_template =
		
		`<div class="modal fade" id="chatRoomModal${obj.room_index}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">`
  		+ '<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">'
  		+ '<div class="modal-content">'
		+ '<div class="chat-header modal-header">'
		+ '<button class="unlink-chat returnToRoomList" onclick="returnToRoomList()">_&lt;&lt;_</button>'
		+ `<h5 class="modal-title">&nbsp;${obj.room_itemTitle}</h5>`
		+ `<a class="dropDeal" onclick="dropDeal(${obj.room_index})">거래중단</a>`
		//+ '<button class="unlink-chat btn btn-primary" data-bs-target="#chatRoomListModal" data-bs-toggle="modal">돌아가기</button>'
		+ '<button type="button" class="unlink-chat btn-close" data-bs-dismiss="modal"></button>'
		+ '</div>'
		+ `<div id="chat-viewer${obj.room_index}" class="chat-viewer modal-body">`
		+ '<!-- 채팅글 div가 추가되는 곳 -->';
		
		
		$(obj.messages).each(function (index, item){
		
			if(item.chat_room == thisRoom) {
				//console.log("저요저요");
				//console.log(item.chat_content);
				if(item.chat_writer == loginMember_accIndex){
					//console.log("내가 쓴 메시지");
					
					chatRoom_modal_template += '<div class="message mine">' + item.chat_content + '</div>';
				} else {
					//console.log("상대방이 쓴 메시지");
					
					var profile_path = '';
					
					if(other_profile == ''|| other_profile == null) {
						profile_path = '<img src="/useditems/resources/img/login.png">';
					} else {
						profile_path = '<img src="/useditems/resources/img/' + other_index + '/profile/' + other_profile + '">';
					}
					
					
					chatRoom_modal_template += 
					'<div class="profile other">'
					+ profile_path 
					//+ '<img src="/useditems/resources/img/' + other_index + '/profile/' + other_profile + '">'
					+ other_nickname + '</div>'
					+ '<div class="message other">' + item.chat_content + '</div>';
					
				}
			}
		});
		
		
		
		chatRoom_modal_template +=
		
		 '</div>'
		+ '<div id="chat-footer" class="chat-footer modal-footer">'
		+ '<div class="input-area w-100">'
		+ '<input type="text" id="chat-input" class="w-75" onkeyup="keyCheck(event)" placeholder="메시지 입력">'
        + '<button id="chat-sendBtn">전송</button>'
        + '</div>'
        + '</div>'
        + '</div>'
        + '</div>'
        + '</div>'
        + '<script defer src="/useditems/resources/js/chat/chatRoom.js">'
        + '</script>';


		$('#ChatRoom_Modal_reservoir').append(chatRoom_modal_template);
		

	});

}

















