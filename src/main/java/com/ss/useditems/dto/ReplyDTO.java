package com.ss.useditems.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ReplyDTO {
	int repl_index;
	int repl_item;
	int repl_candidate;
	String repl_nickname; 
	String repl_content;
	Date repl_enrolldate;
	
	
	String repl_profile; //테이블 조인_정일 추가0813_프로필사진 필요
}
