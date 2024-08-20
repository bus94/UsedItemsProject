package com.ss.useditems.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.ChatDTO;
import com.ss.useditems.dto.ChatRoomDTO;

@Mapper
public interface ChatMapper {

	ChatDTO selectLastChat(String acc_index);
	
	ArrayList<ChatRoomDTO> selectChatList(String loginMember_accIndex);

	ChatRoomDTO selectChatRoom(String room_index);

	int insertChat(ChatDTO chatDTO);

	int insertChatRoom(String room_item, String room_reply);

	int updateItemOndeal(String room_item);

	int deleteChatRoom(String room_index);

	int updateItemOnsale(String room_item);

	int updateLastMessage(String acc_index, String acc_lastMessage);

	int updateItemDonedeal(int item_index, int item_buyer);

	int updateAccountCount(int acc_index);



	

	
	
}
