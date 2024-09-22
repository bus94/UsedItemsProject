package com.ss.useditems.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
// 물품 게시글에 대한 댓글
public class ReplyDTO {
	
	int repl_index;			// DB. 댓글 일련번호
	int repl_item;			// DB. 물품 일련번호
	int repl_candidate;		// DB. 댓글자 일련번호
	String repl_nickname; 	// DB. 댓글자 닉네임
	String repl_content;	// DB. 댓글 내용
	Date repl_enrolldate;	// DB. 댓글 등록 날짜
	
	String repl_profile; // 0813_프로필사진 필요
	
}
