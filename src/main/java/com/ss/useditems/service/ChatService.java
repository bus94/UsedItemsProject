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
	
	
}
