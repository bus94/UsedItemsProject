package com.ss.useditems.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.mapper.MemberMapper;

@Service
public class MemberService {
	@Autowired
	private MemberMapper mapper;
	
	public MemberDTO selectByMember(MemberDTO loginMember) {
		System.out.println("MemberService의 selectByMember()");
		return mapper.selectByMember(loginMember);
	}
}
