package com.ss.useditems.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
// 채팅 메세지 DTO
public class ChatDTO {

	private int chat_index;			// DB. 채팅메세지 일련번호
	private int chat_room;			// DB. 채팅방 일련번호
	private int chat_writer;		// DB. 채팅메세지 작성자
	private String chat_content;	// DB. 채팅메세지 내용
	private Date chat_enrollDate;	// DB. 채팅메세지 보낸 시간
	
}
