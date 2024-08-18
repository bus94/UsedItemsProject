/**
 * 
 */
$(function() {

 	console.log('chatRoom.js 연결');

});


var chatURI = "ws://" + serverName + ":" + serverPort + project + "/chat/safeChat";
//console.log(chatURI);

  	
	//console.log(serverName);	//각 변수들은 header.jsp 내부 script에서 선언해 둠
  	//console.log(serverPort);
  	//console.log(project);
 
 	//console.log(loginMember_accIndex);
 	//console.log(loginMember_accId);
 	//console.log(loginMember_accNickname);
 	//console.log(loginMember_accProfile);
 
	
function selectChatRoom(param) {	//채팅방 선택 -> 채팅방 보기 버튼 실행

	//console.log("내가고른채팅방번호: " + param); //왜 두번씩 실행되나?
	
	var enterBtn = document.getElementById('enterChatRoom'+param);
	enterBtn.click();
	
}


function enterChatRoom(param) { //'채팅방 보기' 버튼(room_index를 매개변수로 가져옴)

	var room_index = param;
	
	//$('#chat_viewer'+room_index).scrollTop($('#chat_viewer'+room_index).prop('scrollHeight'));	
	
	
	const queryChatRoom = { room_index : room_index };
	
	//상대방의 프사를 불러오고 싶다
	var other_index = '';
	var other_id = '';
	var other_nickname = '';
	var other_profile ='';
	
	$.ajax({	//queryChatRoom 객체를 보내서 채팅방의 정보를 불러옴
			type : "POST",
			url : project + "/chat/chatRoom.do", //project는 jsp 내부 script에서 선언해 둠
			data : queryChatRoom,
			success : function(result) {
						console.log("chatRoom.do 통신 성공");
						
						if(loginMember_accIndex == result.room_hostIndex) {
							console.log("나는 호스트")
							other_index = result.room_guestIndex;
							other_id = result.room_guestId;
							other_nickname = result.room_guestNickname;
							other_profile = result.room_guestProfile;
						} else {
							console.log("나는 게스트")
							other_index = result.room_hostIndex;
							other_id = result.room_hostId;
							other_nickname = result.room_hostNickname;
							other_profile = result.room_hostProfile;		
						}
					
						console.log("other_id: " + other_id);
						console.log("other_profile: " + other_profile);
						
					},
			error : function(error) {
					alert("오류로 인하여 정상적으로 처리되지 않았습니다.(AJAX)");
					}
		}); //ajax
		

		
	//클라이언트의 jsp에서 웹소켓 객체 생성
	//protocol: ws
	//요청 경로는 서버의 웹소켓 핸들러 제공 uri(WebSocketConfig에서 설정)
	var ws = new WebSocket(chatURI);//웹소켓 연결;
		
	var chat_viewer = document.getElementById('chat_viewer'+room_index);
	//var chat_viewer = $('#chat_viewer'+room_index);
	

		
	ws.onopen = function() {	//클라이언트에서 웹소켓 연결되면 실행
		console.log("서버 웹소켓에 연결 성공");
		ws.send(loginMember_accNickname + "님 입장하였습니다." + "^#" + room_index +  "^@" + serverName); 
		// ^#: 채팅방 인덱스, ^@: 발신자 id
	};
	
	ws.onclose = function () {
		console.log("서버 웹소켓에서 연결 해제");
		ws.send(loginMember_accNickname +  "님 퇴장하였습니다." + "^#" + room_index + "^@" + serverName); 
		// ^#: 채팅방 인덱스, ^@: 발신자 id
	};

	ws.onerror = function(error) {
		console.log("웹소켓 Error: " + error);
	};
	
	ws.onmessage = function(event) {	//서버로부터 메시지가 오면 실행
		//console.log(event.data);
		displayMessage(event.data);	//들어온 메시지 가공 및 출력 함수 호출
	};



	//채팅룸에서 새 메시지를 띄우는 함수
	function displayMessage(payload) { //payload = event.data
		
		var message = payload.substring(0, payload.lastIndexOf('^#'));
		//console.log(message);
		
		var fromWhere = payload.substring(payload.lastIndexOf('^#')+2, payload.lastIndexOf('^@'));
		//console.log("where: " + fromWhere);
		
		var fromWhose = payload.substring(payload.lastIndexOf('^@')+2);
		//console.log("whose: " + fromWhose);
		
		
		if(fromWhere == room_index) {	//해당 채팅방의 메시지만
		
		var type = 'none';
		
		if(fromWhose == serverName) {
			//console.log("서버의 알림메시지");
			type = 'server';
		} else if(fromWhose == loginMember_accId) { 
			//console.log("내가 쓴 거넹");
			type = 'mine';
		} else {
			//console.log("서버도 아니고, 내가 쓴 거도 아니고");
			type = 'other';
		}
		

		if(type == 'other') {
			var profileDiv = document.createElement('div');
			profileDiv.className = 'profile ' + type;
			profileDiv.textContent = other_nickname;
			chat_viewer.appendChild(profileDiv);
		
		
			var profile_path = '';
			//맨 위에서 찾은 상대방 프로필
			if(other_profile == '' || other_profile == null) {
				console.log("상대방프로필 기본이미지 적용");
				profile_path = project + "/resources/img/login.png";
			} else {
				profile_path = project + "/resources/img/" + other_index + "/profile/" + other_profile;
			}


			var profileImg = document.createElement('img');
			profileImg.src = profile_path;
			profileDiv.prepend(profileImg);	//appendChild는 그림이 text 뒤에 붙음!!
			
			//$('div').prepend('<img src="../../img/img01.jpg">');
		}

		var messageDiv = document.createElement('div');
		messageDiv.className = 'message ' + type;
		messageDiv.textContent = message;
		chat_viewer.appendChild(messageDiv);


		//메시지 요소를 추가하고 스크롤 내리기
		//.scrollTop(#) : scroll 상단 끝을 # 위치로 이동
		//.prop('scrollHeight') : 'scrollHeight' property 값을 불러옴
		console.log("scrollTop: " + chat_viewer.scrollTop);
		//console.log("scrollHeight: " + chat_viewer.scrollHeight);
		console.log("modal scrollHeight: " + $('#chat_viewer'+room_index).prop('scrollHeight'));			
		$('#chat_viewer'+room_index).scrollTop($('#chat_viewer'+room_index).prop('scrollHeight'));	
	
	
		}//해당 채팅방의 메시지만
	}
	
	
	
	//웹소켓으로 서버에 새 메시지를 보내는 함수
	$('#chat_sendBtn'+room_index).click(function(){
		
		var chat_input = $('#chat_input'+room_index);
		
		var message_input = $.trim(chat_input.val());

		console.log(message_input);

		if(message_input != ''){
						
			ws.send(message_input + "^#" + room_index + "^@" + loginMember_accId); 
			// ^#: 채팅방 인덱스, ^@: 발신자 id
	
			chat_input.val('');
			//chat_input.focus();//포커스 주기
			
		}
		
		
		//DB에 새 메시지 넣기
		const queryChat = { chat_room : room_index, chat_writer : loginMember_accIndex, chat_content : message_input };
		
		$.ajax({	
			type : "POST",
			url : project + "/chat/recordChat.do", //project는 jsp 내부 script에서 선언해 둠
			data : queryChat,
			success : function(result) {
						//console.log("recordChat.do 통신 성공");
						if(result > 0) {
						
						
						
						
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


	});
	


	
	//chat_sendBtn.addEventListener('click', sendMessage);
	function sendMessages() {
		
	}//웹소켓으로 서버에 새 메시지 보내는 함수 //오류나서 jQuery로 새로 정의
	


	//채팅방에서 '돌아가기' 또는 '닫기' 누를 경우
	$('.unlink_chat').click(function(){
		ws.onclose();	//웹소켓 해제
	});









}//'채팅방 보기' 버튼
	
	
function returnToRoomList() {	//'돌아가기' 버튼 클릭

	$('#nav_chat').trigger("click");
	//단순히 채팅룸리스트 모달으로 돌아가면 에러가 남(웹소켓 중복으로 생성??)
	//다시 채팅룸리스트를 열어서(DB에서 불러와서) 웹소켓 리셋
	
}



function dropDeal(room_index, room_item) {		//'거래중단' 버튼 클릭
		
	if (confirm("정말 거래를 중단하시겠습니까?\n이 채팅방과 대화 내용이 모두 삭제되며 복구할 수 없습니다.")) {
		
		console.log("삭제할 채팅방번호: " + room_index);
				
		const queryDropDeal = { room_index : room_index, room_item : room_item };
		
		$.ajax({	
			type : "POST",
			url : project + "/chat/dropDeal.do", //project는 jsp 내부 script에서 선언해 둠
			data : queryDropDeal,
			success : function(result) {
						console.log("dropDeal.do 통신 성공");
						if(result > 0) {
						
							$('#nav_chat').trigger("click");
						
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
}
	
	
	
//채팅방에서 키보드 엔터키 누르면 '전송' 버튼 클릭하도록 하는 함수 
function keyCheck(param) {//input태그에 onkeyup=keyCheck() 지정
	//html에서 넘겨주는 변수가 this일 때와 event일 때의  결과가 서로 다르다!!
		
	//console.log(param);
	//console.log(param.keyCode);
		
		
	if(param.keyCode === 13) {
		//console.log("엔터를 눌렀따");
			
		$('.chat_sendBtn').trigger("click");
	}
	
}	