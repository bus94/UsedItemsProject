package com.ss.useditems.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.dto.ItemInfoDTO;
import com.ss.useditems.mapper.ItemMapper2;

@Service
public class HomeService {

	@Autowired
	private ItemMapper2 itemMapper; // 임시로 ItemMapper2 생성, 안겹치려고
	
	//@Autowired
	//private MemberMapper memberMapper;
	
	//@Autowired
	//private BlacklistMapper blacklistMapper;

	
	public ArrayList<ItemInfoDTO> getNew5() { // 정일_home.jsp-HomeController

		ArrayList<ItemInfoDTO> result = itemMapper.getNew5();

		return result;
	}

	public ArrayList<ItemInfoDTO> getHot5() { // 정일_home.jsp-HomeController

		return itemMapper.getHot5();
	}

//	public MemberDTO getPowerSeller() { // 정일_home.jsp-HomeController
//
//		MemberDTO powerSeller = memberMapper.getPowerSeller();
//
//		return powerSeller;
//	}

//	public ArrayList<MemberDTO> getBlack5() { // 정일_home.jsp-HomeController
//		System.out.println("BlacklistService.getBlack5()");
//
//		ArrayList<MemberDTO> result = blacklistMapper.getBlack5();
//		System.out.println("bService.getBlack5 result: " + result);
//
//		return result;
//
//	}
}
