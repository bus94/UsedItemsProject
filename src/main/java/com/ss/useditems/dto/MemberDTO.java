package com.ss.useditems.dto;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberDTO {
	private int acc_index;
	private String acc_id;
	private String acc_password;
	private Date acc_birthDate;
	private String acc_phone;
	private String acc_name;
	private String acc_addressDetail;
	private String acc_address;
	private String acc_addressX;
	private String acc_addressY;
	private String acc_nickname;
	private String acc_profile;
	private int acc_score;
	private int acc_count; //거래횟수
	private int acc_lastMessage;//0818추가, 확인한 최종 메시지 인덱스
	private String acc_status;
	private Date acc_enrollDate;
	
	//위까지 테이블 컬럼 정보
	
	private int acc_blackCount; //피신고회수
	
}
