/**
 * 
 */
$(document).ready(function() {

	console.log('header.js 연결');
	
});


console.log("Login: " + loginMember_accId);
console.log("로그인 시 마지막 확인 메시지(accDB): " + loginMember_accLatMsg);

// checkLastChat.do
//목적: 미확인 메시지가 있는지 확인
//방법: chatDB에 저장된 마지막 메시지와 accDB에 저장된 마지막 메시지의 index를 비교
//요청: chatDB에 저장된 최종 메시지 확인을 위해 acc_index를 서버에 전달
//결과: 미확인 메시지가 있을 경우 아이콘을 바꿈 
//확인: checkLastChat.do 결과로 얻어온 마지막 챗인덱스: chat_index(chatDB) (최종 도착 메시지)
//     recordLastChat.do 결과로 얻어온 마지막 챗인덱스: acc_lastMessage(accDB) = checkedLastMessage (최종 확인 메시지)
//ex) chat_index(chatDB) > acc_lastMessage(accDB) : 사용자가 미확인한 메시지가 들어옴
//    chat_index(chatDB) = acc_lastMessage(accDB) : 사용자가 확인한 메시지가 최종 메시지


const queryLastChat_check = { loginMember_accIndex : loginMember_accIndex };
		
$.ajax({	
	type : "GET",
	url : project + "/chat/checkLastChat.do", //project는 header.jsp 내부 script에서 선언해 둠
	data : queryLastChat_check,
	success : function(result) {
				//console.log("checkLastChat.do 통신 성공");
				console.log("최종 도착 메시지(chatDB): " + result.chat_index); //checkLastChat.do 결과
				console.log("최종 확인 메시지(accDB): " + checkedLastMessage); //recordLastChat.do 결과
				if(result.chat_index > checkedLastMessage) {
					$('#chat_icon_null').addClass('chat_icon_hidden');
					$('#chat_icon_fill').removeClass('chat_icon_hidden');
				}
			},
	error : function(error) {
				console.log("checkLastChat.do 통신 실패(AJAX)");
			}
}); //ajax		



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


$('#navbar-toggler').click(function() {
	
	$('section').toggleClass('section_toggleOn');	
	//모든페이지 섹션에 클래스(section_toggleOn) 토글, 상단 마진 생성용
	$('#nav_user').toggle();
	$('#nav_wish').toggle();
	$('.menu_text').toggle();
});


$('#logout').click(function() {

	if (confirm("정말 정말 로그아웃 하시겠습니까?ㅠ_ㅠ")) {
		window.location.href = project + "/account/logoutOK.do"; //project는 header.jsp 내부 script에서 선언해 둠
	}
	
});


$('#nav_toTop').click(function() {

	$('html, body').animate({
		scrollTop : 0
	}, 50);
	
	return false;
});


//헤더 채팅 아이콘 클릭 시 실행
$('#nav_chat').click(function() {

	const queryChatList = { loginMember_accIndex : loginMember_accIndex };
	
	$.ajax({
			type : "GET",
			url : project + "/chat/chatList.do", //project는 header.jsp 내부 script에서 선언해 둠
			data : queryChatList,
			success : function(result) {
						//열릴 때마다 modal container 초기화(누적 생성 방지)
						$('#chatList').empty(); //채팅룸리스트 모달 컨테이너 리셋
						$('#ChatRoom_Modal_reservoir').empty();	//채팅룸 모달 컨테이너 리셋
						
						if(result.length == 0){
							makingEmptyModal(); //빈 채팅리스트 모달 생성, 메서드 정의는 아래에
						}else {
							console.log("chatList_size: " + result.length);
							makingChatRooms(result); //채팅리스트 모달 생성, result=chatList를 그대로 매개변수로 넘겨줌
						}						
					},
			error : function(error) {
					alert("오류로 인하여 정상적으로 처리되지 않았습니다.(AJAX)");
					}
		}); //ajax
				
});


function makingEmptyModal() {	// 빈 채팅리스트 모달 생성

	var emptyList_template = '<h4 id="chat_emptyList" class="text-center">현재 거래 중인 물품이 없습니다!</h4>';
	$('#chatList').append(emptyList_template);
	
}


function makingChatRooms(chatList) {	// 채팅리스트 모달 생성
	
	$(chatList).each(function (index, obj){	//forEach 반복문 jQuery 형식
		
		//console.log(index);
		//console.log(obj.room_index);
		//console.log("UTC 날짜 형식: " + obj.room_openDate);
		//console.log(obj.room_itemTitle);
		//console.log("messages: " + obj.messages);
		
		
		var thisRoom = obj.room_index;
		//chatRoom_index를 고유번호로 활용하기 위해 변수 지정
		
		
		var formattedDate = formattingDate(new Date(obj.room_openDate));
		// formattedDate: (재사용 변수) 채팅방 개설 일시, 메시지 등록 일시 반복
		// formattingDate(): Date type formatter 메서드, 정의는 아래에
		//console.log("채팅방 개설 일시: " + formattedDate);
		
		
		var other_index = '';
		var other_id = '';
		var other_nickname = '';
		var other_profile = '';
		
		// 로그인한 사용자가 채팅방 호스트(판매자)인지 게스트(구매후보자)인지 구분:
		// 상대방의 사진 표시, 상대방과 채팅 css 구별
		if(loginMember_accIndex == obj.room_hostIndex) {
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
		
		// otherProfile(): 상대방 프로필 정보로 img태그 경로 생성, 메서드 정의는 아래에
		var profile_path = otherProfile(other_profile, other_index);
		
			
		///////////////////Modal Element/////////////////
	
		//채팅 목록(chatRoom list) template
		var chatList_template = 
		
		// selectChatRoom(): chatRoom.js에서 메서드 정의
		`<div id="chatRoom_box${obj.room_index}" class="chatRoom_box container" onclick="selectChatRoom(${obj.room_index})">`
		
		+ '<div class="chatRoom_profile d-flex flex-column">'
		+ profile_path
		+ `<p class="text-center">${other_id}</p>`
		+ '</div>'
		
		+ `<div id="chatRoom_content${obj.room_index}" class="chatRoom_content d-flex flex-column">`
		+ `<h4 class="chatRoom_title">${obj.room_itemTitle}</h4>`
		+ '</div>'
		
		+ `<div id="chatRoom_date${obj.room_index}" class="chatRoom_date d-flex flex-column">`
		+ `<p class="align-self-end">Open: ${formattedDate}</p>`	//formattedDate: 채팅방 개설 일시
		+ '</div>'
		
		// enterChatRoom(): chatRoom.js에서 메서드 정의
		+ `<button class="enterChatRoom" id="enterChatRoom${obj.room_index}" value="${obj.room_index}" onclick="enterChatRoom(this.value)" data-bs-target="#chatRoomModal${obj.room_index}" data-bs-toggle="modal"></button>`
		+ '</div>';

		
		$('#chatList').append(chatList_template);



		//채팅방 template
		var chatRoom_modal_template =
		
		`<div class="modal fade" id="chatRoomModal${obj.room_index}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">`
  		+ '<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">'
  		+ '<div class="modal-content">'
		+ '<div class="chat_header modal-header">'
		+ '<button class="unlink_chat returnToRoomList" onclick="returnToRoomList()"><i class="fa-solid fa-reply returnToRoomList"></i></button>'
		+ `<h4 class="chatRoom_modal_title modal-title">&nbsp;${obj.room_itemTitle}</h4>`
		+ `<a id="dropDeal" class="action_deal" onclick="dropDeal(${thisRoom}, ${obj.room_item})">거래중단</a>`
		+ `<a id="signDeal" class="action_deal" onclick="signDeal(${thisRoom}, ${obj.room_item})">거래완료</a>`
		//+ '<button class="unlink_chat btn btn-primary" data-bs-target="#chatRoomListModal" data-bs-toggle="modal">돌아가기</button>'
		+ '<button type="button" class="unlink_chat btn-close" data-bs-dismiss="modal"></button>'
		+ '</div>'
		+ `<div id="chat_viewer${obj.room_index}" class="chat_viewer modal-body">`
		+ '<!-- 채팅글 div가 추가되는 곳 -->';
		
		
		//아래 내부 반복문에서 밖으로 가지고 나갈 변수(최종 확인 메시지)
		var thisAccLatestMsgIdx = '0';
		var thisRoomLatestMsg ='';
		
		//현재 반복문 안의 반복문(각 채팅메시지가 이 방에 속하면 element 추가)
		$(obj.messages).each(function (index, item){	//forEach 반복문 jQuery 형식
		
			// 반복하며 가장 큰(최근) chat_index를 변수에 저장
			if(thisAccLatestMsgIdx < item.chat_index){
				thisAccLatestMsgIdx = item.chat_index;
			}
		
		
			if(item.chat_room == thisRoom) {
			
				//현재 반복 메시지 내용
				thisRoomLatestMsg = item.chat_content;
				//console.log(thisRoomLatestMsg);				
				
				//현재 반복 메시지 등록 일시
				formattedDate = formattingDate(new Date(item.chat_enrollDate));	//변수 선언은 위에 채팅방 개설일시에서
				//console.log("메시지 등록 일시: " + formattedDate);
			
			
				if(item.chat_writer == loginMember_accIndex){
					
					//console.log("내가 쓴 메시지");
					chatRoom_modal_template += 
					  '<div class="message message_mine">'
					+ `<div class="message_txt">${thisRoomLatestMsg}</div>`
					+ `<div class="message_time">${formattedDate}</div>`	//formattedDate: 메시지 등록 일시
					+ '</div>';
					
				} else {
					
					//console.log("상대방이 쓴 메시지");
										
					chatRoom_modal_template += 
					'<div class="profile_other">'
					+ `<a href="/useditems/account/acc_info.do?acc_id=${other_id}">`
					+ profile_path 
					+ '</a>'
					+ other_nickname + '</div>'
					+ '<div class="message message_other">'
					+ `<div class="message_txt">${thisRoomLatestMsg}</div>`
					+ `<div class="message_time">${formattedDate}</div>`	//formattedDate: 메시지 등록 일시
					+ '</div>';
				}
				
			
			}	//if(item.chat_room == thisRoom){} 끝
			
			
		}); //내부 반복문 종료
				
		
		//내부반복 종료 후 최종 메시지와 시간을 채팅 목록(chatRoom list)에 추가
		var chatRoom_latestMsg_template	= `<p class="latest_message">${thisRoomLatestMsg}</p>`;
		$('#chatRoom_content'+thisRoom).append(chatRoom_latestMsg_template);
		
		var chatRoom_latestDate_template = `<p class="align-self-end">Latest: ${formattedDate}</p>`;	//formattedDate: 메시지 등록 일시
		$('#chatRoom_date'+thisRoom).append(chatRoom_latestDate_template);
		
				
		
		//안끝난 채팅방 template 마무리
		chatRoom_modal_template +=
		
		 '</div>'
		+ '<div class="chat_footer modal-footer">'
		+ '<div class="input-area w-100">'
		+ `<input type="text" id="chat_input${obj.room_index}" class="chat_input w-75" onkeyup="keyCheck(event)" placeholder="메시지 입력">`
        + `<button id="chat_sendBtn${obj.room_index}" class="chat_sendBtn">전송</button>`
        + '</div>'
        + '</div>'
        + '</div>'
        + '</div>'
        + '</div>';


		$('#ChatRoom_Modal_reservoir').append(chatRoom_modal_template);
		
		
		//console.log("요소로 만들어진 메시지 인덱스의 최대값: " + thisAccLatestMsgIdx);
		// 채팅방 요소가 만들어졌다? 헤더 채팅 아이콘을 눌렀다는 것 == 각 채팅방 최종 메시지를 확인했다는 것!
		
		// recordLastChat.do: DB(ACCOUNT)에 확인한 메시지 입력(최종 확인한 메시지)
		//요청: accDB에 최종 확인 메시지를 저장하기 위해 acc_index와 chat_index를 서버에 전달
		
		const queryLastChat_record = { acc_index : loginMember_accIndex, acc_lastMessage : thisAccLatestMsgIdx };
		
		$.ajax({	
			type : "POST",
			url : project + "/chat/recordLastChat.do", //project는 jsp 내부 script에서 선언해 둠
			data : queryLastChat_record,
			success : function(result) {
			
						if(result > 0) {
							//console.log("recordLastChat.do 통신 성공");
							checkedLastMessage = thisAccLatestMsgIdx;	// HttpSession에 저장된 변수와 일치시킴
							//console.log("(accDB) checkedLastMessage: " + checkedLastMessage);
							$('#chat_icon_null').removeClass('chat_icon_hidden');
							$('#chat_icon_fill').addClass('chat_icon_hidden');
							
						} else if( result == 0 ) {
							//console.log("recordLastChat.do 저장 실패");
						} else {
							//console.log("recordLastChat.do 통신 실패");
						}
					},
			error : function(error) {
					//console.log("recordLastChat.do 통신 실패(AJAX)");
					}
		}); //ajax		
		
		
	}); //외부 반복문 종료
	
	
	//chatRoom.js 불러오기: 헤더 채팅 아이콘을 눌렀을 때만
	var chatRoom_js_template = '<script defer src="/useditems/resources/js/chat/chatRoom.js"></script>';
	$('#ChatRoom_Modal_reservoir').append(chatRoom_js_template);
	
}



//상대방 프로필 사진 값이 null(또는 '')이면 기본이미지 경로 반환
function otherProfile(param_profile, param_index) {

	var profile_path = '';
					
	if(param_profile == '' || param_profile == null) {
			profile_path = '<img src="/useditems/resources/img/login1.png">';
	} else {
			profile_path = '<img src="/useditems/resources/img/' + param_index + '/profile/' + param_profile + '">';
	}

	return profile_path;
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
