package com.ss.useditems.dto;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
// 채팅방 DTO
public class ChatRoomDTO {
	
	private int room_index;				// DB. 채팅방 일련번호
	private int room_item;				// DB. 해당 채팅방 물품 일련번호
	private int room_reply;				// DB. 채팅방 
	private Date room_openDate;			// DB. 채팅방 생성 날짜 
	
	private String room_itemTitle;		// 물품 제목
	private String room_itemStatus;		// 물품 상태 (onsale: 판매 중 (채팅방 x), ondeal: 거래 중 (채팅방 o), donedeal: 판매 완료, drop: 거래 중지)
	
	private int room_hostIndex;			// 판매자 일련번호
	private String room_hostId;			// 판매자 id
	private String room_hostNickname;	// 판매자 닉네임
	private String room_hostProfile;	// 판매자 프로필 사진
	
	private int room_guestIndex;		// 구매자 일련번호 
	private String room_guestId;		// 구매자 id
	private String room_guestNickname;	// 구매자 닉네임
	private String room_guestProfile;	// 구매자 프로필 사진
	
	private List<ChatDTO> messages;		// 채팅 메세지 
	
}
