package com.ss.useditems.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.MemberDTO;

@Mapper
public interface MemberMapper {

	MemberDTO selectByMember(MemberDTO loginMember);
	
	MemberDTO selectInfoByAcc_id(String acc_id); //정일_계정 정보(테이블정보 + 피신고 + 아이템목록...)

	MemberDTO selectAccountByAcc_id(String acc_id); //정일_계정 정보(테이블정보만)
	
	int selectById(String id);

	int signup(MemberDTO signupMember);

	int selectIdIndex(String acc_id);

	int withdraw(String acc_id); //정일_회원탈퇴

}
