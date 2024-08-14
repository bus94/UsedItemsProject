package com.ss.useditems.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@RequestMapping("/chat")
@Controller
public class ChatController {
	
	
	@GetMapping("chat.do")
	public String viewChatList(Model model) {
		return "chat/chat";
	}
	
	
	@GetMapping("chatRoom.do")
	public String enterChatRoom(Model model) {
		return "chat/chatRoom";
	}
	
	
	
	
	
	
}
