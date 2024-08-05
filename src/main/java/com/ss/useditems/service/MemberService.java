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
	
	public int selectById(String id) {
		System.out.println("MemberService의 selectById()");
		return mapper.selectById(id);
	}

	public int signup(MemberDTO signupMember) {
		System.out.println("MemberService의 signup()");
		return mapper.signup(signupMember);
	}
	
	
	public MemberDTO selectByAcc_id(String acc_id) {     //정일
		System.out.println("MemberService의 selectByAcc_id()");
		
		MemberDTO account_info = new MemberDTO();
		account_info = mapper.selectByAcc_id(acc_id);
		
		//개인 비공개정보는 메모리에서 삭제
		account_info.setAcc_password(null);
		account_info.setAcc_birthDate(null);
		account_info.setAcc_status(null);
		account_info.setAcc_enrollDate(null);
		
		return account_info;
	}

	public int selectIdIndex(String acc_id) {
		return mapper.selectIdIndex(acc_id);
	}

	public int withdraw(String acc_id) {	//정일_회원탈퇴
		System.out.println("service.withdraw: " + acc_id);
		return mapper.withdraw(acc_id);
	}
	
}
