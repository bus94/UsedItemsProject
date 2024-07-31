package com.ss.useditems.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.MemberDTO;

@Mapper
public interface MemberMapper {

	MemberDTO selectByMember(MemberDTO loginMember);
	
	MemberDTO selectByAcc_id(String acc_id);
}
