package com.ss.useditems.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.ChatRoomDTO;

@Mapper
public interface ChatMapper {

	ArrayList<ChatRoomDTO> selectChatList(String loginMember_accIndex);

	ChatRoomDTO selectChatRoom(String room_index);

	int insertChat(String chat_room, String chat_writer, String chat_content);

	int insertChatRoom(String room_item, String room_reply);

	int updateItemOndeal(String room_item);

	int deleteChatRoom(String room_index);

	int updateItemOnsale(String room_item);

	
	
}
