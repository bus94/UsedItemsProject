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
	
	
	public MemberDTO selectByAcc_id(String acc_id) {//정일
		System.out.println("MemberService의 selectByAcc_id()");
		
		MemberDTO account_info = new MemberDTO();
		account_info = mapper.selectByAcc_id(acc_id);
		account_info.setAcc_birthDate(null);
		account_info.setAcc_enrollDate(null);
		account_info.setAcc_password(null);
		account_info.setAcc_status(null);
		
		return account_info;
	}
	
}
