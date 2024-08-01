package com.ss.useditems.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BlacklistDTO {

	private int black_index;
	private int black_subject;
	private int black_object;
	private String black_content;
	private Date black_enrollDate;
	
}
