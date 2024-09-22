package com.ss.useditems.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
// 신고내역 DTO
public class BlacklistDTO {
	
	private int black_index;			// DB. 신고 일련번호
	private int black_subject;			// DB. 신고자 acc_index
	private String subject_nickname;	// 신고자 닉네임
	private String subject_id;			// 신고자 id
	private int black_object;			// DB. 피신고자 acc_index
	private String object_nickname;		// 피신고자 닉네임
	private String object_id;			// 피신고자 id
	private String black_content;		// DB. 신고 내용
	private Date black_enrollDate;		// DB. 신고일자
	
}
