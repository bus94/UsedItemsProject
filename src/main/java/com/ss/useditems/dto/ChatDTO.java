package com.ss.useditems.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ChatDTO {

	private int chat_index;	//테이블 값
	private int chat_room;	//테이블 값
	private int chat_writer;	//테이블 값
	private String chat_content;	//테이블 값
	private Date chat_enrollDate;	//테이블 값
	
	
	
}
