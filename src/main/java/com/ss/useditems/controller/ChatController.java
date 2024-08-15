package com.ss.useditems.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ss.useditems.dto.ChatRoomDTO;
import com.ss.useditems.service.ChatService;


@RequestMapping("/chat")
@Controller
public class ChatController {
	
	@Autowired
	private ChatService chatService;
	
	
	
	
	@PostMapping("chatList.do")
	@ResponseBody
	public List<ChatRoomDTO> viewChatList(Model model, @RequestParam String loginMember_accIndex) {
		System.out.println("==chat.chatList==");

		List<ChatRoomDTO> chatList = null;
		try {
			

			if(loginMember_accIndex != null) {
				chatList = chatService.getChatList(loginMember_accIndex);
					
				System.out.println("chatList: " + chatList);
				System.out.println("chatListSize: " + chatList.size());
			

			}else {
			}

		} catch(Exception e) {
			
		}

		return chatList;
	}
	
	
	@PostMapping("chatRoom.do")
	@ResponseBody
	public ChatRoomDTO getChatRoom(Model model, @RequestParam String room_index) {
		System.out.println("==chat.chatRoom==");
		System.out.println("room_index: " + room_index);

		ChatRoomDTO chatRoom = null;
		try {
				
				chatRoom = chatService.getChatRoom(room_index);
				System.out.println("chatRoom: " + chatRoom);
			
		} catch(Exception e) {
			
		}

		return chatRoom;
	}
	
	
	

	
	
	
	
	
	
}
