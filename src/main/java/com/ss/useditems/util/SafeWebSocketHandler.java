package com.ss.useditems.util;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;


//스프링에서 제공하는 텍스트메시지 송수신 처리 메서드를 가진 핸들러
public class SafeWebSocketHandler extends TextWebSocketHandler{

	
	// 채팅창에 여러 클라이언트가 들어왔을 때 처리할 수 있는 변수
	// Set 컬렉션 프레임워크: 순서가 없고, 중복을 허용하지 않음
	// 여러 스레드(접속한 클라이언트)에서 공용의 자원(SocketHandler)을 사용할 때 충돌 방지
	private static Set<WebSocketSession> sessionSet
		= Collections.synchronizedSet(new HashSet<WebSocketSession>());

	
	
	
	
	@Override	// 웹소켓에 특정 세션(클라이언트)이 연결되면
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		//	접속한 세션을 세션집합에 추가
		sessionSet.add(session);
		//System.out.println("입장한 클라이언트 session: " + session);
	}
	
	
	
	@Override	//메시지 송 수신 처리 메서드
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

		//클라이언트 요청에 의해 서버로 전달되는 값(브라우저 콘솔에 페이로드가 있다?)
		String payload = message.getPayload(); 
		System.out.println("payload: " + payload);
		
		//들어온거 그대로 메시지로 돌려줌
		TextMessage messageToClients = new TextMessage(payload);
		
		//접속한 모든 세션에 보내는 메시지
		for(WebSocketSession eachSession : sessionSet) {
			//eachSession.sendMessage(messageToClients);
			//모든 세션에 모든 메시지를 다 뿌려주는건 비효율적인듯..
			
			if(eachSession.isOpen()) {	//소켓이 열려있는(?) 세션에게 메시지 발송
				
				try {
					eachSession.sendMessage(messageToClients);
					//System.out.println("열린소켓: " + eachSession.getId());
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
			
			
		}//for()반복
		
		
		//메시지를 보내온 클라이언트에게 확인 메시지
		//TextMessage confirmToClient = new TextMessage("너한테만 보낸다");
		
		//메시지를 보내온 클라이언트에게 확인 메시지
		//session.sendMessage(confirmToClient);
	}
	
	
	
	@Override	// 웹소켓에서 특정 세션(클라이언트)이 연결 해제되면
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		sessionSet.remove(session);
		//System.out.println("퇴장한 클라이언트 session: " + session.getId());
		
	}
	
	
	
}
