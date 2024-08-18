package com.ss.useditems.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.dto.ChatRoomDTO;
import com.ss.useditems.mapper.ChatMapper;

@Service
public class ChatService {

	@Autowired
	private ChatMapper chatMapper;

	
	public List<ChatRoomDTO> getChatList(String loginMember_accIndex) {

		return chatMapper.selectChatList(loginMember_accIndex);
	}

	public ChatRoomDTO getChatRoom(String room_index) {

		return chatMapper.selectChatRoom(room_index);
	}

	public int recordChat(String chat_room, String chat_writer, String chat_content) {
	
		return chatMapper.insertChat(chat_room, chat_writer, chat_content);
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

	
}
