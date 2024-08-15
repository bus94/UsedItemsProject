package com.ss.useditems.dto;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ChatRoomDTO {

	private int room_index;	//테이블 값
	private int room_item;	//테이블 값
	private int room_reply;	//테이블 값
	private Date room_openDate;	//테이블 값
	
	private String room_itemTitle;
	private String room_itemStatus;
	
	private int room_hostIndex;
	private String room_hostId;
	private String room_hostNickname;
	private String room_hostProfile;
	
	private int room_guestIndex;
	private String room_guestId;
	private String room_guestNickname;
	private String room_guestProfile;	
	
	private List<ChatDTO> messages;

}
