package com.ss.useditems.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.mapper.MemberMapper;

@Service
public class MemberService {
	@Autowired
	private MemberMapper mapper;
	
	public int selectByMember(MemberDTO loginMember) {
		return mapper.selectByMember(loginMember);
	}
}
