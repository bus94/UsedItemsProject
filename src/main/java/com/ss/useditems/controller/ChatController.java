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
	
	
	
	
	@PostMapping("chatList.do")	//정일_채팅 리스트 불러오기
	@ResponseBody
	public List<ChatRoomDTO> viewChatList(@RequestParam String loginMember_accIndex) {
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
	
	
	@PostMapping("chatRoom.do")	//정일_채팅방 정보 불러오기
	@ResponseBody
	public ChatRoomDTO getChatRoom(@RequestParam String room_index) {
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
	
	@PostMapping("recordChat.do")	//정일_채팅 메시지 DB에 저장
	@ResponseBody
	public int recordChat(@RequestParam String chat_room, @RequestParam String chat_writer, @RequestParam String chat_content) {
		System.out.println("==chat.recordChat==");
		System.out.println("chat_room: " + chat_room + " chat_writer: " + chat_writer + " chat_content: " + chat_content);
		
		int result = -1;
		try {
			
			result = chatService.recordChat(chat_room, chat_writer, chat_content);
			System.out.println("recordChatResult: " + result);
			
		} catch (Exception e) {
			result = 0;
		}
		return result;
	}
	
	
	
	@PostMapping("openChat.do")		//정일_채팅방 개설(item_status: onsale -> ondeal)
	@ResponseBody
	public int openChat(@RequestParam String room_item, @RequestParam String room_reply) {
		System.out.println("==chat.openChat==");
		System.out.println("OpenChat room_item: " + room_item + " room_reply: " + room_reply);
		
		int result = -1;
		try {
			
			result = chatService.openChat(room_item, room_reply);
			System.out.println("openChatResult: " + result);
			
		} catch(Exception e) {
			result = 0;
		}
		return result;
	}
	
	
	@PostMapping("dropDeal.do")		//정일_채팅방 삭제(item_status: ondeal -> onsale)
	@ResponseBody
	public int dropDeal(@RequestParam String room_index, @RequestParam String room_item) {
		System.out.println("==chat.dropDeal==");
		System.out.println("Drop chat_room: " + room_index + " room_item: " + room_item);
		
		int result = -1;
		try {
			result = chatService.dropDeal(room_index, room_item);
			System.out.println("dropDealResult: " + result);

		} catch(Exception e) {
			result = 0;
			e.printStackTrace();
		}
		return result;
	}


	
	
	
	
	
	
}
