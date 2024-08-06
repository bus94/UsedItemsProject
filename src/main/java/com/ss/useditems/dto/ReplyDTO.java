package com.ss.useditems.dto;

import java.sql.Date;

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
	String repl_content;
	Date repl_enrolldate;
}
