package com.ss.useditems.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ss.useditems.dto.ChatDTO;
import com.ss.useditems.dto.ChatRoomDTO;
import com.ss.useditems.service.ChatService;


@RequestMapping("/chat")
@Controller
public class ChatController {
	
	@Autowired
	private ChatService chatService;
	
	
	//마지막 챗 인덱스(chatDB) 수시 체크(헤더 열릴때마다, header.js)
	//미확인 메시지가 있는지 확인하기 위해
	@GetMapping("/checkLastChat.do")
	@ResponseBody
	public ChatDTO checkLastChat(@RequestParam String loginMember_accIndex) {

		ChatDTO result = null;
		try {
			result = chatService.checkLastChat(loginMember_accIndex);
		} catch(Exception e) {}

		return result;
	}
	
	
	//헤더 채팅아이콘 클릭 시 채팅리스트 넘겨주기(chatRoom)
	@GetMapping("/chatList.do")
	@ResponseBody
	public List<ChatRoomDTO> viewChatList(@RequestParam String loginMember_accIndex) {

		List<ChatRoomDTO> chatList = null;
		try {
			if(loginMember_accIndex != null) {
				chatList = chatService.getChatList(loginMember_accIndex);	
				//System.out.println("chatList: " + chatList);
				//System.out.println("chatListSize: " + chatList.size());
			}
		} catch(Exception e) {}

		return chatList;
	}
	
	
	//각 채팅방 클릭 시(chatRoom.js) 해당 채팅방 정보 넘겨주기
	@GetMapping("/chatRoom.do")
	@ResponseBody
	public ChatRoomDTO getChatRoom(@RequestParam String room_index) {

		ChatRoomDTO chatRoom = null;
		try {
			chatRoom = chatService.getChatRoom(room_index);
			//System.out.println("chatRoom: " + chatRoom);
		} catch(Exception e) {}

		return chatRoom;
	}
	
	//채팅방에서 전송 버튼 클릭 시(chatRoom.js) chatDB에 저장하고 chat_index 반환
	@PostMapping("/recordChat.do")
	@ResponseBody
	public int recordChat(@RequestParam String chat_room, @RequestParam String chat_writer, @RequestParam String chat_content) {
		
		int result = -1;
		try {
			ChatDTO chatDTO = new ChatDTO();
			chatDTO.setChat_room(Integer.parseInt(chat_room));
			chatDTO.setChat_writer(Integer.parseInt(chat_writer));
			chatDTO.setChat_content(chat_content);
			
			chatService.recordChat(chatDTO);	
			//chatService.reocordChat()의 반환값(0 or 1)은 DB 입력 성공 여부
			
			//동기화 통신
			//chatDTO를 mapper에 넘기고 selectKey 사용(DB에 입력 후 index 받아서 DTO에 저장)
			result = chatDTO.getChat_index();
			//DB에 저장된 INDEX값을 반환
			//System.out.println("recordChatIndex: " + result); 
		} catch (Exception e) {
			result = 0;
		}
		return result;
	}
	
	
	//사용자가 확인한 최종 메시지를 ACCOUNT DB에 저장
	//실행 시점 1. 헤더 채팅아이콘을 눌렀을 때(header.js)
	//실행 시점 2. 채팅방에서 실시간 확인 했을 때(chatRoom.js)
	@PostMapping("/recordLastChat.do")
	@ResponseBody
	public int recordLastChat(HttpSession session, @RequestParam String acc_index, @RequestParam String acc_lastMessage) {
			
		int result = -1;
		try {
			if(!acc_lastMessage.equals("00")) {	//서버 발신메시지(00)이 아니면 인덱스 저장
				result = chatService.recordLastChat(acc_index, acc_lastMessage);
				session.setAttribute("checkedLastMessage", acc_lastMessage);
			}
			result = 1;
		} catch (Exception e) {
			result = 0;
		}
		return result;
	}
	
	//댓글에서 채팅하기 버튼 클릭 시(itemView.js) 채팅방 개설(item_status: onsale -> ondeal)
	@PostMapping("/openChat.do")
	@ResponseBody
	public int openChat(@RequestParam String room_item, @RequestParam String room_reply) {
		
		int result = -1;
		try {
			result = chatService.openChat(room_item, room_reply);
			//System.out.println("openChatResult: " + result);
		} catch(Exception e) {
			result = 0;
		}
		return result;
	}
	
	//채팅방에서 '거래중단' 클릭 시 채팅방+채팅 삭제(item_status: ondeal -> onsale)
	@PostMapping("/dropDeal.do")
	@ResponseBody
	public int dropDeal(@RequestParam String room_index, @RequestParam String room_item) {
		
		int result = -1;
		try {
			result = chatService.dropDeal(room_index, room_item);
			//System.out.println("dropDealResult: " + result);
		} catch(Exception e) {
			result = 0;
			e.printStackTrace();
		}
		return result;
	}

	//채팅방에서 '거래완료' 클릭 시 채팅방+채팅 삭제(item_status: ondeal -> donedeal)
	@PostMapping("/signDeal.do")
	@ResponseBody
	public int signDeal(@RequestParam String room_index, @RequestParam String room_item) {
		
		int result = -1;
		try {
			result = chatService.signDeal(room_index, room_item);
			//System.out.println("signDealResult: " + result);
		} catch(Exception e) {
			result = 0;
		}
		return result;
	}
	
}
