package com.ss.useditems.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EventDTO {

	private int event_index;			// DB. 이벤트 일련번호
	private int event_party;			// DB. 이벤트 대상(계정) 일련번호
	private String event_code;		// DB. 이벤트 코드
	private String event_message;	// DB. 이벤트 내용(타임라인 출력 문구)
	private Date event_time;	// DB. 이벤트 발생 시간
	
}
