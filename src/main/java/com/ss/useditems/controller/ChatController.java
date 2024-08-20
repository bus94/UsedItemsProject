package com.ss.useditems.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	
	
	
	@PostMapping("checkLastChat.do")	//정일_마지막 챗 수시 체크(헤더 열릴때마다)
	@ResponseBody
	public ChatDTO checkLastChat(@RequestParam String acc_index) {
		System.out.println("==chat.checkLastChat==");
		System.out.println("acc_index: " + acc_index);

		ChatDTO result = null;
		try {
			
			result = chatService.checkLastChat(acc_index);
			
			System.out.println("checkLastChat: " + result);
				
		} catch(Exception e) {
				
		}

		return result;
	}
	
	
	
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
		//System.out.println("==chat.recordChat==");
		//System.out.println("chat_room: " + chat_room + " chat_writer: " + chat_writer + " chat_content: " + chat_content);
		
		int result = -1;
		try {
			ChatDTO chatDTO = new ChatDTO();
			chatDTO.setChat_room(Integer.parseInt(chat_room));
			chatDTO.setChat_writer(Integer.parseInt(chat_writer));
			chatDTO.setChat_content(chat_content);
			
			chatService.recordChat(chatDTO);	
			//chatService.reocordChat()의 반환값(0 or 1)은 DB 입력 성공 여부
			//chatDTO를 mapper에 넘기고 selectKey 사용(DB에 입력 후 index 받아서 DTO에 자동 저장)
			result = chatDTO.getChat_index();
			//DB에 저장된 INDEX값을 반환
			
			//System.out.println("recordChatIndex: " + result); 
			
		} catch (Exception e) {
			result = 0;
		}
		return result;
	}
	
	
	@PostMapping("recordLastChat.do")	//정일_최종 확인 메시지 DB에 저장(ACCOUNT)
	@ResponseBody
	public int recordLastChat(HttpSession session, @RequestParam String acc_index, @RequestParam String acc_lastMessage) {
		System.out.println("==chat.recordLastChat==");
		System.out.println("acc_index: " + acc_index + " acc_lastMessage: " + acc_lastMessage);
			
		int result = -1;
		try {
			result = 1;
			if(!acc_lastMessage.equals("00")) {	//서버 발신메시지(00)이 아니면 인덱스 저장
				result = chatService.recordLastChat(acc_index, acc_lastMessage);
				session.setAttribute("checkedLastMessage", acc_lastMessage);
			}
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
	
	
	@PostMapping("dropDeal.do")		//정일_거래 중단(item_status: ondeal -> onsale)
	@ResponseBody
	public int dropDeal(@RequestParam String room_index, @RequestParam String room_item) {
		System.out.println("==chat.dropDeal==");
		System.out.println("Drop chat_room: " + room_index + " sale room_item: " + room_item);
		
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

	@PostMapping("signDeal.do")		//정일_거래 완료(item_status: ondeal -> donedeal)
	@ResponseBody
	public int signDeal(@RequestParam String room_index, @RequestParam String room_item) {
		System.out.println("==chat.signDeal==");
		System.out.println("Drop chat_room: " + room_index + " sign room_item: " + room_item);
		
		int result = -1;
		try {
			//result = 
			System.out.println("signDealResult: " + result);

		} catch(Exception e) {
			result = 0;
			e.printStackTrace();
		}
		return result;
	}
	
	
	
	
	
	
}
