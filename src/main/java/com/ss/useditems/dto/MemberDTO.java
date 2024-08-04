package com.ss.useditems.dto;

import java.util.Date;

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
//	private String acc_email;	0804 DB에서 열 삭제
	private String acc_name;
	private String acc_address;
	private String acc_nickname;
	private String acc_profile;
	private String acc_level;
	private int acc_count;
	private String acc_status;
	private Date acc_enrollDate;
}
