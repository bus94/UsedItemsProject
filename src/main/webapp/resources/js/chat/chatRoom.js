/**
 * 
 */
 $(function() {

	console.log('chatRoom.js 연결');
		
});
 


 window.onload = function() {
 
 	const acc_index = chat_accIndex;
	const acc_id = chat_accId;
	const acc_nickname = chat_accNickname;
	const acc_profile = chat_accProfile; 	 	 	



 console.log(acc_index);
 console.log(acc_id);
 console.log(acc_nickname);
 console.log(acc_profile);
};
 

 
 	//var path =  "/useditems";
	//var serverName = "localhost";
	//var serverPort = "8282";
	
	var chatURL = "ws://localhost:8282/useditems/chat/safeChat"

	




	//클라이언트의 jsp에서 웹소켓 객체 생성
	//protocol: ws
	//요청 경로는 서버의 웹소켓 핸들러 제공 url(WebSocketConfig에서 설정)
	var ws = new WebSocket(chatURL);

	ws.onopen = function() {	//클라이언트에서 웹소켓 연결되면 실행
		console.log("서버 웹소켓에 연결 성공");
		ws.send(clientNickname + "님 입장하였습니다.");
		
	};
	
	ws.onclose = function() {
		console.log("서버 웹소켓에서 연결 해제");
		ws.send("${loginMember.acc_nickname} 님 퇴장하였습니다.");
	};

	ws.onerror = function(error) {
		console.log("웹소켓 에러 발생");
		console.log("Error: " + error);
	};
	
	ws.onmessage = function(event) {	//서버로부터 메시지가 오면 실행
		
		displayMessage(event.data, 'server');
	}

	
	const sendButton = document.getElementById('sendButton');
	const chatInput = document.getElementById('chatInput');
	const chatArea = document.getElementById('chatArea');
	
	sendButton.addEventListener('click', sendMessage);
	
	
	function sendMessage() {
		
		const textInput = chatInput.value.trim();

		if(textInput != ''){
			
			//displayMessage(text, 'user');
			
			ws.send(textInput);
			
			chatInput.value='';
		}
		
		
	};
	
	
	
	function displayMessage(msg, type) {
		
		const msgDiv = document.createElement('div');
		msgDiv.className = 'message ' + type;
		msgDiv.textContent = msg;
		chatArea.appendChild(msgDiv);

	}
	
	
 
	