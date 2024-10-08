/**
 * 
 */
$(function() {

 	console.log('chatRoom.js 연결');

});


var chatURI = "ws://" + serverName + ":" + serverPort + project + "/chat/safeChat";
// 웹소켓 통신 uri, protocol: ws, util/WebSocketConfig.java에서 설정
//console.log(chatURI);

  	
	//console.log(serverName);	//각 변수들은 header.jsp 내부 script에서 선언해 둠
  	//console.log(serverPort);
  	//console.log(project);
 
 	//console.log(loginMember_accIndex);
 	//console.log(loginMember_accId);
 	//console.log(loginMember_accNickname);
 	//console.log(loginMember_accProfile);
 

//각 채팅방은 고유의 room_index로 modal element가 구분됨
//채팅리스트(모달)에서 채팅방 선택 -> 채팅방 보기 버튼 실행
function selectChatRoom(param) {	
	//console.log("내가고른채팅방번호: " + param); //왜 두번씩 실행되나?
	var enterBtn = document.getElementById('enterChatRoom'+param);
	enterBtn.click();
}


//'채팅방 보기' 버튼(room_index를 매개변수로 가져옴)
function enterChatRoom(param) { 

	var room_index = param;
		
	//상대방의 프사를 불러오고 싶다
	var other_index = '';
	var other_id = '';
	var other_nickname = '';
	var other_profile ='';
	
	const queryChatRoom = { room_index : room_index };
	
	$.ajax({	//queryChatRoom 객체를 보내서 채팅방의 정보를 불러옴, 내가 호스트인가 게스트인가
			type : "GET",
			url : project + "/chat/chatRoom.do", //project는 header.jsp 내부 script에서 선언해 둠
			data : queryChatRoom,
			success : function(result) {
						//console.log("chatRoom.do 통신 성공");
						
						if(loginMember_accIndex == result.room_hostIndex) {
							//console.log("나는 호스트")
							other_index = result.room_guestIndex;
							other_id = result.room_guestId;
							other_nickname = result.room_guestNickname;
							other_profile = result.room_guestProfile;
						} else {
							//console.log("나는 게스트")
							other_index = result.room_hostIndex;
							other_id = result.room_hostId;
							other_nickname = result.room_hostNickname;
							other_profile = result.room_hostProfile;		
						}
					
						//console.log("other_id: " + other_id);
						//console.log("other_profile: " + other_profile);
						
					},
			error : function(error) {
					alert("오류로 인하여 정상적으로 처리되지 않았습니다.(AJAX)");
					}
		}); //ajax
		

	//클라이언트의 jsp에서 웹소켓 객체 생성
	//요청 경로는 서버의 웹소켓 핸들러 제공 uri(WebSocketConfig에서 설정)
	var ws = new WebSocket(chatURI);//웹소켓 연결;
		
	var chat_viewer = document.getElementById('chat_viewer'+room_index);
	//var chat_viewer = $('#chat_viewer'+room_index);
	
		
	ws.onopen = function() {	//클라이언트에서 웹소켓 연결되면 실행
		//console.log("서버 웹소켓에 연결 성공 room_index: " + room_index);
		ws.send(loginMember_accNickname + "님 입장하였습니다" + "^$00^#" + room_index +  "^@" + serverName + "^!" + thisTime()); 
		// ^$: 챗 인덱스(서버메시지는 00), ^#: 채팅방 인덱스, ^@: 발신자 id, ^!: 발송시간
		//thisTime(): 현재 시간 Date formatter, 정의는 하단에
	};
	
	ws.onclose = function () {
		//console.log("서버 웹소켓에서 연결 해제");
		ws.send(loginMember_accNickname +  "님 퇴장하였습니다" + "^$00^#" + room_index + "^@" + serverName + "^!" + thisTime()); 
		// ^$: 챗 인덱스(서버메시지는 00), ^#: 채팅방 인덱스, ^@: 발신자 id, ^!: 발송시간
		//thisTime(): 현재 시간 Date formatter, 정의는 하단에
	};

	ws.onerror = function(error) {
		console.log("웹소켓 Error: " + error);
	};
	
	ws.onmessage = function(event) {	//서버로부터 메시지가 오면 실행
		//console.log("paylod: " + event.data);
		displayMessage(event.data);	//들어온 메시지 가공 및 출력 메서드 호출
		
		//메시지 요소를 추가하고 스크롤 내리기: 채팅방 들어올 때, 나갈 때 모두 서버에서 알림 메시지가 날아옴
		//.scrollTop(#) : scroll 상단 끝을 # 위치로 이동
		//.prop('scrollHeight') : 'scrollHeight' property 값을 불러옴
				
		//크롬은 안되는데 엣지는 된다 => 크롬이 엣지보다 빠르다... 
		//처음 채팅방을 열 때 요소를 만들어내는 시간차때문에 scrollHeight 값을 못불러와서(?)
		setTimeout(function(){
			//console.log('timeout150');
			//console.log("scrollHeight: " + $('#chat_viewer'+room_index).prop('scrollHeight'));
			//console.log("scrollTop: " + $('#chat_viewer'+room_index).prop('scrollTop'));
			$('#chat_viewer'+room_index).scrollTop($('#chat_viewer'+room_index).prop('scrollHeight'));
		}, 150);
	};


	// 서버는 웹소켓이 열린 모든 클라이언트에 메시지를 뿌린다.(broadcast)
	// 클라이언트는 보낼 메시지에 꼬리표를 달아보내고
	// 클라이언트는 또한 들어오는 모든 메시지에서 꼬리표를 보고 선별함


	//채팅방에서 새 메시지를 띄우는 메서드
	function displayMessage(payload) { //payload = event.data
		
		var message_txt = payload.substring(0, payload.lastIndexOf('^$'));
		//console.log(message_txt);
				
		var message_index = payload.substring(payload.lastIndexOf('^$')+2, payload.lastIndexOf('^#'));
		//console.log("index: " + message_index);
		
		var fromWhere = payload.substring(payload.lastIndexOf('^#')+2, payload.lastIndexOf('^@'));
		//console.log("where: " + fromWhere);
		
		var fromWhose = payload.substring(payload.lastIndexOf('^@')+2, payload.lastIndexOf('^!'));
		//console.log("whose: " + fromWhose);
		
		var message_time = payload.substring(payload.lastIndexOf('^!')+2);
		
		
		// 해당 채팅방에만 요소가 생성되도록
		if(fromWhere == room_index) {
		
			var type = 'none'; //메시지의 발신자 타입: 미정
			if(fromWhose == serverName) {
				//console.log("서버의 알림메시지");
				type = 'server';
			} else if(fromWhose == loginMember_accId) { 
				//console.log("내가 쓴 거넹");
				type = 'mine';
			} else {
				//console.log("서버 알림도 아니고, 내가 쓴 거도 아니고");
				type = 'other';
			}
		
			//상대방이 쓴 채팅글의 경우만 프로필 정보를 보여줌
			if(type == 'other') {
				var profileDiv = document.createElement('div');
				profileDiv.className = 'profile_' + type;
				profileDiv.textContent = other_nickname;
				chat_viewer.appendChild(profileDiv);
		
				var profile_path = '';
				//맨 위에서 찾은 상대방 프로필
				if(other_profile == '' || other_profile == null) {
					//console.log("상대방프로필 기본이미지 적용");
					profile_path = project + "/resources/img/login1.png";
				} else {
					profile_path = project + "/resources/img/" + other_index + "/profile/" + other_profile;
				}

				var profileImg = document.createElement('img');
				profileImg.src = profile_path;
				profileDiv.prepend(profileImg);	//appendChild는 그림이 text 뒤에 붙음!!
			
				//$('div').prepend('<img src="../../img/img01.jpg">');
			}

			var messageDiv = document.createElement('div');	//컨테이너(message_txt + message_time)
			messageDiv.className = 'message message_' + type;
			chat_viewer.appendChild(messageDiv);
		
			var messageTxtDiv = document.createElement('div');
			messageTxtDiv.className = 'message_txt';
			messageTxtDiv.textContent = message_txt;
			messageDiv.appendChild(messageTxtDiv);
		
			var messageTimeDiv = document.createElement('div');
			messageTimeDiv.className = 'message_time';
			messageTimeDiv.textContent = message_time;
			messageDiv.appendChild(messageTimeDiv);
			///메시지 요소 추가 끝
			//console.log("scrollTop: " + chat_viewer.scrollTop);
			//console.log("scrollHeight: " + chat_viewer.scrollHeight);		
	
	
	
			// recordLastChat.do: DB(ACCOUNT)에 확인한 메시지 입력(최종 확인한 메시지)
			//요청: accDB에 최종 확인 메시지를 저장하기 위해 acc_index와 chat_index를 서버에 전달
			const queryLastChat_record = { acc_index : loginMember_accIndex, acc_lastMessage : message_index };
		
			$.ajax({	
				type : "POST",
				url : project + "/chat/recordLastChat.do", //project는 header.jsp 내부 script에서 선언해 둠
				data : queryLastChat_record,
				success : function(result) {
			
							if(result > 0) {
								checkedLastMessage = message_index;	// HttpSession에 저장된 변수와 일치시킴
								//console.log("recordLastChat.do 통신 성공");
								//console.log("(WS) checkedLastMessage: " + checkedLastMessage);
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
	
		}// 해당 채팅방에만 요소가 생성되도록
	}
	
	

	//웹소켓으로 서버에 새 메시지를 보내는 메서드
	$('#chat_sendBtn'+room_index).click(function(){
		
		var chat_input = $('#chat_input'+room_index);
		var message_input = $.trim(chat_input.val());
		//console.log(message_input);

		if(message_input != ''){
					
			//DB에 새 메시지 넣고 Index값 얻어오기
			const queryChat = { chat_room : room_index, chat_writer : loginMember_accIndex, chat_content : message_input };
			var chat_index = '';
			
			//console.log("지금 곧 AJAX 실행");
			$.ajax({	
				type : "POST",
				url : project + "/chat/recordChat.do", //project는 header.jsp 내부 script에서 선언해 둠
				data : queryChat,
				async: false,		//기본적으로 비동기식인 AJAX를 동기식으로 전환
				success : function(result) {
								//console.log("recordChat.do 통신 성공");
								if(result > 0) {
									chat_index = result;	//컨트롤러에서 반환해준 값(chat_index)
									//console.log("AJAX로 받아온 챗 인덱스: " + chat_index);
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
					
			//console.log("지금 곧 메시지 전송됨!! " + message_input);
			ws.send(message_input + "^$" + chat_index + "^#" + room_index + "^@" + loginMember_accId + "^!" + thisTime()); 
			// ^$: 챗 인덱스, ^#: 채팅방 인덱스, ^@: 발신자 id, ^!: 발송시간
			//thisTime(): 현재 시간 Date formatter, 정의는 하단에
	
			chat_input.val('');//입력창 리셋
			//chat_input.focus();//포커스 주기
			
		}	//if(message_input != ''): 빈 값이 아닐 때만 실행
		
	});//웹소켓으로 서버에 새 메시지를 보내는 메서드
	


	//chat_sendBtn.addEventListener('click', sendMessage);
	function sendMessages() {
	}//웹소켓으로 서버에 새 메시지 보내는 메서드 //오류나서 미사용, jQuery 방식으로 바로 위에 새로 정의
	


	//채팅방에서 '돌아가기' 또는 '닫기' 누를 경우
	$('.unlink_chat').click(function(){
		ws.onclose();	//작별인사(퇴장알림)
		ws.close();		//웹소켓 강제 종료, 종료하지 않으면 채팅방을 닫아도 메시지를 수신함
		//현재 웹소켓 closing 에러 남,, 강제 종료했는데 ws.onclose()를 실행하라고 해서,,,
		
		//ws=null;
		console.log(ws);
	});

}//'채팅방 보기' 버튼

	
	
function returnToRoomList() {	//'돌아가기' 버튼 클릭

	$('#nav_chat').trigger("click");
	//단순히 채팅룸리스트 모달으로 돌아가면 에러가 남(웹소켓 중복으로 생성??)
	//다시 채팅룸리스트를 열어서(DB에서 불러와서) 웹소켓 리셋
	
}



function dropDeal(room_index, room_item) {		//'거래중단' 버튼 클릭
		
	if (confirm("정말 거래를 중단하시겠습니까?\n이 채팅방과 대화 내용이 모두 삭제되며 복구할 수 없습니다.")) {
		
		//console.log("삭제할 채팅방번호: " + room_index);
		const queryDropDeal = { room_index : room_index, room_item : room_item };
		
		$.ajax({	
			type : "POST",
			url : project + "/chat/dropDeal.do", //project는 jsp 내부 script에서 선언해 둠
			data : queryDropDeal,
			success : function(result) {
						//console.log("dropDeal.do 통신 성공");
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



function signDeal(room_index, room_item) {		//'거래완료' 버튼 클릭
		
	if (confirm("이 거래를 성사시키겠습니까?\n이 채팅방과 대화 내용이 모두 삭제되며 복구할 수 없습니다.")) {
		
		//console.log("삭제할 채팅방번호: " + room_index);
		const querySignDeal = { room_index : room_index };
		
		$.ajax({	
			type : "POST",
			url : project + "/chat/signDeal.do", //project는 jsp 내부 script에서 선언해 둠
			data : querySignDeal,
			success : function(result) {
						//console.log("signDeal.do 통신 성공");
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

	
	
	
//채팅방에서 키보드 '엔터'키 누르면 '전송' 버튼 클릭하도록 하는 메서드 
function keyCheck(param) {//input태그에 onkeyup=keyCheck() 지정
	//html에서 넘겨주는 변수가 this일 때와 event일 때의  결과가 서로 다르다!!
		
	//console.log(param);
	//console.log(param.keyCode);
		
	if(param.keyCode === 13) {
		//console.log("엔터를 눌렀따");
		$('.chat_sendBtn').trigger("click");
	}
}	



//Date -> yy/MM/dd hh:mm
function thisTime() {
	
	var thisTime = new Date();
	var result = thisTime.getHours().toString().padStart(2, '0') + ":"
			+ thisTime.getMinutes().toString().padStart(2, '0');

	return result;
}

