package com.ss.useditems.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BlacklistDTO {

	private int black_index;	//테이블 값, 신고 일련번호
	private int black_subject;	//테이블 값, 신고자 acc_index 
	private String subject_nickname;
	private String subject_id;
	private int black_object;	//테이블 값, 피신고자 acc_index 
	private String object_nickname;
	private String object_id;
	private String black_content;	//테이블 값, 신고 내용
	private Date black_enrollDate;	//테이블 값, 신고일자
	
	private int black_count;	//피신고횟수
}
