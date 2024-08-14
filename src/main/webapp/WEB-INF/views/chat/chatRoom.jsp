<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="serverName" value="${pageContext.request.serverName}" />
<c:set var="serverPort" value="${pageContext.request.serverPort}" />



<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>


<section id="content" class="container chatRoom_page" style="padding-top: 100px;">
	<h1>채팅방</h1>
	<a href="${path}/chat/chat.do">나가기</a>
	
	<p>서버명: ${serverName}</p>
	<p>서버포트: ${serverPort}</p>
	
	
	<div class="chat-container">
    	<div class="header">세이프챗</div>

    	<div class="chat-area" id="chatArea">
   
    	</div>

    	<div class="input-area">
        	<input type="text" id="chatInput" placeholder="메시지입력">
        	<button id="sendButton">전송</button>
    	</div>
	</div>
	

</section>

<script>
	
	//클라이언트의 jsp에서 웹소켓 객체 생성
	//protocol: ws
	//요청 경로는 서버의 웹소켓 핸들러 제공 url(WebSocketConfig에서 설정)
	var ws = new WebSocket("ws://${serverName}:${serverPort}${path}/chat/safeChat");

	ws.onopen = function() {	//클라이언트에서 웹소켓 연결되면 실행
		console.log("서버 웹소켓에 연결 성공");
		ws.send("${loginMember.acc_nickname} 님 입장하였습니다.");
		
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
	
	
	



</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>