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
	private String subject_nickname;
	private String subject_id;
	private int black_object;
	private String object_nickname;
	private String object_id;
	private String black_content;
	private Date black_enrollDate;
	
}
