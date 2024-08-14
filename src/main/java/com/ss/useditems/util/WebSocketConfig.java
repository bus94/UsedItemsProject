package com.ss.useditems.util;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;



@Configuration	//  bean을 설정하는 클래스라는 annot
@EnableWebSocket	// 웹소켓을 관리하는 annot
public class WebSocketConfig implements WebSocketConfigurer{

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		System.out.println("===웹소켓 bean 등록//실행 중===");
		
		// "/safeChat" url 요청에 대해
		//setAllowedOrigins("*"): 어떤 클라이언트(어디서 접속하든지)든 접속 허용
		registry.addHandler(new SafeWebSocketHandler(), "/safeChat").setAllowedOrigins("*");
		
	}

}
