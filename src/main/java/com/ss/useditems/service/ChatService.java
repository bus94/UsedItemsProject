package com.ss.useditems.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.dto.ChatDTO;
import com.ss.useditems.dto.ChatRoomDTO;
import com.ss.useditems.dto.EventDTO;
import com.ss.useditems.mapper.ChatMapper;

@Service
public class ChatService {

	@Autowired
	private ChatMapper chatMapper;

	
	
	public ChatDTO checkLastChat(String acc_index) {

		return chatMapper.selectLastChat(acc_index);
	}
	
	public List<ChatRoomDTO> getChatList(String acc_index) {

		return chatMapper.selectChatList(acc_index);
	}

	public ChatRoomDTO getChatRoom(String room_index) {

		return chatMapper.selectChatRoom(room_index);
	}

	public int recordChat(ChatDTO chatDTO) {
	
		return chatMapper.insertChat(chatDTO);
	}

	public int recordLastChat(String acc_index, String acc_lastMessage) {
		
		return chatMapper.updateLastMessage(acc_index, acc_lastMessage);
	}
	
	public int openChat(String room_item, String room_reply) {
		int result = 0;
		result = chatMapper.insertChatRoom(room_item, room_reply);
		result += chatMapper.updateItemOndeal(room_item);
		return result;
	}

	public int dropDeal(String room_index, String room_item) {
		int result = 0;
		result = chatMapper.deleteChatRoom(room_index);
		result += chatMapper.updateItemOnsale(room_item);
		return result;
	}


	public int signDeal(String room_index) {
			
		ChatRoomDTO dto = chatMapper.selectChatRoom(room_index);

		String item_index = Integer.toString(dto.getRoom_item());
		String item_seller = Integer.toString(dto.getRoom_hostIndex());
		String item_buyer = Integer.toString(dto.getRoom_guestIndex());//repl_candidate: 구매 후보자
		
		String event_code = "item";
		String event_message = "물품 <" +  dto.getRoom_itemTitle() 
								+ ">의 거래가 완료되었습니다."
								+ " 관련 채팅방과 채팅글이 모두 삭제되었습니다.";
		
		int result = 0;
		result = chatMapper.updateItemDonedeal(item_index, item_buyer);
		result += chatMapper.updateAccountCount(item_seller);
		result += chatMapper.updateAccountCount(item_buyer);
		result += chatMapper.insertTimeLine(item_seller, event_code, event_message);
		result += chatMapper.insertTimeLine(item_buyer, event_code, event_message);
		result += chatMapper.deleteChatRoom(room_index);
		
		return result;
	}

	public List<EventDTO> getTimeline(String acc_index) {

		return chatMapper.selectAllEvent(acc_index);
	}



	
}
