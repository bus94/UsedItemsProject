/**
 * 
 */
 $(function() {

 	console.log('chatRoom.js 연결');

		
});


	//상대방의 프사를 불러오고 싶다
	var other_index = '';
	var other_profile ='';



	function getIndex(param) { //'채팅방 보기' 누르면 정보를 가져옴
		var room_index = param;
		
	const queryChatRoom = { room_index : room_index };
	
	$.ajax({
			type : "POST",
			url : project + "/chat/chatRoom.do", //project는 jsp 내부 script에서 선언해 둠
			data : queryChatRoom,
			success : function(result) {
						console.log("chatRoom.do 통신 성공");
						
					$(result).each(function (index, obj){	//forEach 반복문 jQuery 형식
						
						if(loginMember_accIndex == obj.room_hostIndex) {
							console.log("나는 호스트")
							other_index = obj.room_guestIndex;
							other_profile = obj.room_guestProfile;
						} else {
							console.log("나는 게스트")
							other_index = obj.room_hostIndex;
							other_profile = obj.room_hostProfile;		
						}
					
						console.log("other_index: " + other_index);
						console.log("other_profile: " + other_profile);

					});
						
					},
			error : function(error) {
					alert("오류로 인하여 정상적으로 처리되지 않았습니다.(AJAX)");
					}
		}); //ajax
		
		
	}

  	
	//console.log(serverName);	//
  	//console.log(serverPort);
  	//console.log(project);
 
 	//console.log(loginMember_accIndex);
 	//console.log(loginMember_accId);
 	//console.log(loginMember_accNickname);
 	//console.log(loginMember_accProfile);
 
	
	var chatURI = "ws://" + serverName + ":" + serverPort + project + "/chat/safeChat";
	//console.log(chatURI);

	var chat_viewer = document.getElementById('chat-viewer');
	var chat_input = document.getElementById('chat-input');
	var chat_sendBtn = document.getElementById('chat-sendBtn');
	
	chat_sendBtn.addEventListener('click', sendMessage);	//sendMessage 함수는 아래에 정의



	//클라이언트의 jsp에서 웹소켓 객체 생성
	//protocol: ws
	//요청 경로는 서버의 웹소켓 핸들러 제공 uri(WebSocketConfig에서 설정)
	var ws = new WebSocket(chatURI);

	ws.onopen = function() {	//클라이언트에서 웹소켓 연결되면 실행
		console.log("서버 웹소켓에 연결 성공");
		//ws.send(loginMember_accNickname + "님 입장하였습니다." + "^@"+serverName); // ^@ 뒤는 발신자 표시
	};
	
	ws.onclose = function () {
		console.log("서버 웹소켓에서 연결 해제");
		//ws.send(loginMember_accNickname +  "님 퇴장하였습니다." + "^@"+serverName); // ^@ 뒤는 발신자 표시
	
	};

	ws.onerror = function(error) {
		console.log("웹소켓 Error: " + error);
	};
	
	ws.onmessage = function(event) {	//서버로부터 메시지가 오면 실행
		
		//console.log(event.data);
		displayMessage(event.data);	//들어온 메시지 가공 함수 호출
	};

	
	function displayMessage(payload) { //payload = event.data
		
		var message = payload.substring(0, payload.lastIndexOf('^@'));
		//console.log(message);
		
		var whose = payload.substring(payload.lastIndexOf('^@')+2);
		//console.log(whose);
		
		
		var type = 'none';
		
		if(whose == serverName) {
			//console.log("서버의 알림메시지");
			type = 'server';
		} else if(whose == loginMember_accId) { 
			//console.log("내가 쓴 거넹");
			type = 'mine';
		} else {
			//console.log("서버도 아니고, 내가 쓴 거도 아니고");
			type = 'other';
		}
		

		if(type == 'other') {
			var profileDiv = document.createElement('div');
			profileDiv.className = 'profile ' + type;
			//profileDiv.textContent = whose;
			chat_viewer.appendChild(profileDiv);
		
		
			var profilePath = '';
			//맨 위에서 찾은 상대방 프로필
			if(other_profile == '' || other_profile == null) {
				console.log("상대방프로필 기본이미지 적용");
				profilePath = project + "/resources/img/login.png";
			} else {
				profilePath = project + "/resources/img/" + other_index + "/profile/" + other_profile;
			}


			var profileImg = document.createElement('img');
			profileImg.src = profilePath;
			profileDiv.appendChild(profileImg);
			
			//$('div').prepend('<img src="../../img/img01.jpg">');
		}

		var messageDiv = document.createElement('div');
		messageDiv.className = 'message ' + type;
		messageDiv.textContent = message;
		chat_viewer.appendChild(messageDiv);

	}
	
	
	
	
	function sendMessage() {
		
		var textInput = chat_input.value.trim();

		if(textInput != ''){
						
			ws.send(textInput + "^@"+loginMember_accId); // ^@ 뒤는 발신자 표시
			
			chat_input.value='';
			chat_input.focus();//포커스 주기
		}
		
		
	}
	
	

	function keyCheck(param) {//input태그에 onkeyup=keyCheck() 지정
		//html에서 넘겨주는 변수가 this일 때와 event일 때의  결과가 서로 다르다!!
		
		//console.log(param);
		//console.log(param.keyCode);
		
		
		if(param.keyCode === 13) {
			//console.log("엔터를 눌렀따");
			
			chat_sendBtn.click();
			//$('#chat-sendBtn').trigger("click");
		}
		
	}
	
	
	

	
	
	
	$('.unlink-chat').click(function(){
		//ws.onclose();
	
	});
	
	