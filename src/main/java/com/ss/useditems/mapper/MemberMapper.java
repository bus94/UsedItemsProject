package com.ss.useditems.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.MemberDTO;

@Mapper
public interface MemberMapper {

	int selectByMember(MemberDTO loginMember);
	
}
