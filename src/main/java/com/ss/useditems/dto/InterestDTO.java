package com.ss.useditems.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
// 찜 목록 DTO
public class InterestDTO {
	
	private int int_index;		// DB. 찜 목록 일련번호
	private int int_item;		// DB. 찜한 물품 일련번호
	private int int_subject;	// DB. 찜한 사용자 일련번호
	
}
