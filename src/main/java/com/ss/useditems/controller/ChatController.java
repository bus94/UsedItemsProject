package com.ss.useditems.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChatController {
	@RequestMapping("/chat/chat.do")
	public String signup(Model model) {
		return "chat/chat";
	}
}
