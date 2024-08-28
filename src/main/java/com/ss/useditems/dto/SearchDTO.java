package com.ss.useditems.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
// 검색어 정보 DTO
public class SearchDTO {

	private int sear_index;
	private int sear_subject;
	private String sear_word;
	private Date sear_date;
	
}
