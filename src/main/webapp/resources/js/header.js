/**
 * 
 */
$(document).ready(function() {

	console.log('header.js 연결');
	
});



const path = "/useditems";	//contextPath(project) 변수 선언



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
	//console.log('Nav토글버튼 클릭');
	
	$('section').toggleClass('section_toggleOn');	
	//모든페이지 섹션에 클래스(section_toggleOn) 토글 //상단 마진 생성용
	$('#nav_user').toggle();
	$('#nav_wish').toggle();
	$('.menu_text').toggle();
});


$('#logout').click(function() {

	if (confirm("정말 정말 로그아웃 하시겠습니까?ㅠ_ㅠ")) {
		window.location.href = path + "/account/logoutOK.do";
	}
	
});


$('#nav_toTop').click(function() {
	//console.log('TOP 클릭');

	$('html, body').animate({
		scrollTop : 0
	}, 50);
	
	return false;
});


$('#nav_chat').click(function() {

	console.log("loginMember.accIndex: "+ loginMember_accIndex);
	
	const queryChatList = { loginMember_accIndex : loginMember_accIndex };
	
	$.ajax({
			type : "POST",
			url : path + "/chat/chatList.do", //path는 전역변수
			data : queryChatList,
			success : function(result) {
			
						$('#chatList').empty(); //채팅룸리스트 모달 컨테이너 리셋
						$('#ChatRoom_Modal_reservoir').empty();	//채팅룸 모달 컨테이너 리셋
						
						if(result.length == 0){
							makingEmptyModal();
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

function makingEmptyModal() {

	var emptyList_template = '<h4 id="chat_emptyList" class="text-center">현재 거래 중인 물품이 없습니다!</h4>';
		
	$('#chatList').append(emptyList_template);
	
}



function makingChatRooms(chatList) {	//채팅리스트 모달 생성
	
	
	$(chatList).each(function (index, obj){	//forEach 반복문 jQuery 형식
		
		//console.log(index);
		//console.log(obj.room_index);
		console.log("UTC날짜라고 합니다: " + obj.room_openDate);
		//console.log(obj.room_itemTitle);
		//console.log("messages: " + obj.messages);
		
		//console.log("loginMember.accIndex: "+ loginMember_accIndex);
		
		
		var thisRoom = obj.room_index;
		
		
		//채팅방 개설일시
		var thisRoomOpenDate = new Date(obj.room_openDate);
		var formattedDate = formatingDate(thisRoomOpenDate);
		console.log("채팅방 오픈: " + formattedDate);
		
		
		var other_index = '';
		var other_id = '';
		var other_nickname = '';
		var other_profile = '';
		
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
		
	
		///////////////////Modal Element/////////////////
	
		//상대방 프로필 값으로 img태그 생성, 함수 정의는 아래에
		var profile_path = otherProfile(other_profile, other_index);
	
	
	
		//채팅 목록(chatRoom list) template
		var chatList_template = 
		
		`<div id="chatRoom_box${obj.room_index}" class="chatRoom_box container" onclick="selectChatRoom(${obj.room_index})">`
		+ '<div class="chatRoom_profile d-flex flex-column">'
		+ profile_path
		+ `<p class="text-center">${other_id}</p>`
		+ '</div>'
		
		+ `<div id="chatRoom_content${obj.room_index}" class="chatRoom_content d-flex flex-column">`
		+ `<h4 class="chatRoom_title">${obj.room_itemTitle}</h4>`
		+ '</div>'
		
		+ `<div id="chatRoom_date${obj.room_index}" class="chatRoom_date d-flex flex-column">`
		+ `<p class="align-self-end">Open: ${formattedDate}</p>`	//최근날짜는 밑에 내부반복문에서 처리
		+ '</div>'
		
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
		+ `<a class="dropDeal" onclick="dropDeal(${obj.room_index})">거래중단</a>`
		//+ '<button class="unlink_chat btn btn-primary" data-bs-target="#chatRoomListModal" data-bs-toggle="modal">돌아가기</button>'
		+ '<button type="button" class="unlink_chat btn-close" data-bs-dismiss="modal"></button>'
		+ '</div>'
		+ `<div id="chat_viewer${obj.room_index}" class="chat_viewer modal-body">`
		+ '<!-- 채팅글 div가 추가되는 곳 -->';
		
		
		//아래 내부 반복문에서 밖으로 가지고 나갈 변수(최근메시지)
		var thisRoomLatestMsg ='';
		
		//현재 반복문 안의 반복문(각 채팅메시지가 이 방에 속하면 element 추가)
		$(obj.messages).each(function (index, item){	//forEach 반복문 jQuery 형식
		
			if(item.chat_room == thisRoom) {
			
				//현재 반복 메시지 내용
				thisRoomLatestMsg = item.chat_content;
				console.log(thisRoomLatestMsg);				
				
				//현재 반복 메시지 시간
				var thisRoomLatestDate = new Date(item.chat_enrollDate);
				formattedDate = formatingDate(thisRoomLatestDate);	//변수 선언은 위에 채팅방 개설일시에서
				console.log("시간: " + formattedDate);
			
			
				if(item.chat_writer == loginMember_accIndex){
					
					//console.log("내가 쓴 메시지");
					chatRoom_modal_template += `<div title="${formattedDate}" class="message mine">${thisRoomLatestMsg}</div>`;
					
				} else {
					
					//console.log("상대방이 쓴 메시지");
										
					chatRoom_modal_template += 
					'<div class="profile other">'
					+ `<a href="/useditems/account/acc_info.do?acc_id=${other_id}">`
					+ profile_path 
					+ '</a>'
					+ other_nickname + '</div>'
					+ `<div title="${formattedDate}" class="message other">${thisRoomLatestMsg}</div>`;
					
				}
				
				

				
				
			}	//if(item.chat_room == thisRoom){} 끝
		}); //내부 반복문 종료
				
		
		//내부반복 종료 후 최종 메시지와 시간을 채팅 목록(chatRoom list)에 추가
		var chatRoom_latestMsg_template	= `<p>${thisRoomLatestMsg}</p>`;
		$('#chatRoom_content'+thisRoom).append(chatRoom_latestMsg_template);
		
		var chatRoom_latestDate_template = `<p class="align-self-end">Latest: ${formattedDate}</p>`;
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
		
	}); //외부 반복문 종료
	
	
	//chatRoom.js 불러오기
	var chatRoom_js_template = '<script defer src="/useditems/resources/js/chat/chatRoom.js"></script>';
	
	$('#ChatRoom_Modal_reservoir').append(chatRoom_js_template);
	
}



//상대방 프로필 사진 값이 null(또는 '')이면 기본이미지 경로 반환
function otherProfile(param_profile, param_index) {

	var profile_path = '';
					
	if(param_profile == '' || param_profile == null) {
			profile_path = '<img src="/useditems/resources/img/login.png">';
	} else {
			profile_path = '<img src="/useditems/resources/img/' + param_index + '/profile/' + param_profile + '">';
	}

	return profile_path;
}


//Date -> yy/MM/dd hh:mm
function formatingDate(param) {
	
	//Date type parameter를 받아서 yy/MM/dd hh:mm 으로 반환

	var result = param.getFullYear().toString().slice(-2) + "/" 
			+ (param.getMonth()+1).toString().padStart(2, '0') + "/" 
			+ param.getDate().toString().padStart(2, '0') + " " 
			+ param.getHours().toString().padStart(2, '0') + ":"
			+ param.getMinutes().toString().padStart(2, '0');

	return result;
	
	
}



