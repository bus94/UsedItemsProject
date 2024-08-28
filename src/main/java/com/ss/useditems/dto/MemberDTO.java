package com.ss.useditems.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
// 계정 DTO
public class MemberDTO {
	
	private int acc_index;				// DB. 계정 일련번호
	private String acc_id;				// DB. id
	private String acc_password;		// DB. password
	private Date acc_birthDate;			// DB. 생년월일
	private String acc_phone;			// DB. 핸드폰 번호
	private String acc_name;			// DB. 이름
	private String acc_address;			// DB. 주소
	private String acc_nickname;		// DB. 닉네임
	private String acc_profile;			// DB. 프로필 사진
	private String acc_addressDetail;	// DB. 상세 주소
	private String acc_addressX;		// DB. 주소 경도
	private String acc_addressY;		// DB. 주소 위도
	private int acc_count; 				// DB. 거래횟수
	private int acc_lastMessage;		// DB. 마지막 수신 메세지
	private String acc_status;			// DB. 계정 상태 (admin: 관리자, active: 활성화, inactive: 탈퇴 회원)
	private Date acc_enrollDate;		// DB. 회원가입 날짜
	
	
	private int acc_blackCount; 		// 피신고횟수
	private int acc_score;				// 매너등급 점수
	private int acc_level; 				// 매너등급 (총 5개의 등급: ~19(lev.1) / 20~39(lev.2) / 40~59(lev.3) / 60~79(lev.4) / 80~(lev.5))
	
	// 매너등급 점수 계산 : 기본(50) + 거래횟수 * 2 - 신고횟수 * 6
	public int acc_score(int acc_count, int acc_blackCount) {
		return 50 + (acc_count * 2) - (acc_blackCount * 6);
	}
	
}
