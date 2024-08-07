package com.ss.useditems.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.dto.BlacklistDTO;
import com.ss.useditems.dto.ItemDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.mapper.BlacklistMapper;
import com.ss.useditems.mapper.ItemMapper2;
import com.ss.useditems.mapper.MemberMapper;
import com.ss.useditems.util.PageInfo;

@Service
public class BlacklistService {

	@Autowired
	private BlacklistMapper blacklistMapper;

	@Autowired
	private MemberMapper memberMapper;//이거는 실제로 사용 중!!

	
	
	////////////////////////////////////////////////////임시
	@Autowired
	private ItemMapper2 itemMapper; //임시로 ItemMapper2 생성, 안겹치려고
	
	
	public ArrayList<ItemDTO> getNew5() {	//정일_home.jsp-HomeController
		System.out.println("BlacklistService.getNew5()");


		ArrayList<ItemDTO> result = itemMapper.getNew5();
		System.out.println("bService.getNew5 result: " + result);
		
		return result;
	}
	
	public MemberDTO getPowerSeller() {		//정일_home.jsp-HomeController
		System.out.println("BlacklistService.getPowerSeller()");
		
		MemberDTO powerSeller = memberMapper.getPowerSeller();

		return powerSeller;
	}
	
	
	
	
	
	public ArrayList<BlacklistDTO> getBlack5() {	//정일_home.jsp-HomeController
		System.out.println("BlacklistService.getBlack5()");


		ArrayList<BlacklistDTO> result = blacklistMapper.getBlack5();
		System.out.println("bService.getBlack5 result: " + result);
		
		return result;
	
	}
	
	////////////////////////////////////////////////////////////////////임시
	
	
	
	
	
	
	
	
	public PageInfo getBlacklist(int currentPage, Map<String, String> queryMap) {	//정일_신고등록
		System.out.println("BlacklistService.getBlacklist()");
		//일단 쿼리맵 검색으로 전체리스트 받아옴
		ArrayList<BlacklistDTO> unpaged_list = blacklistMapper.getBlacklist(queryMap);
		
		//생성자: pageInfo(currentPage, pagePerViewer, dtoTotal, dtoPerPage)
		PageInfo pageinfo = new PageInfo(currentPage, 5, unpaged_list.size(), 5);
		
		//페이지인포로 서브리스트 만들어서
		List<BlacklistDTO> paged_list = unpaged_list.subList(pageinfo.getFromIndex(), pageinfo.getTillIndex());
		
		//페이지인포 dto컨테이너에 가공된 리스트 넣어줌
		pageinfo.setDtoContainer(paged_list);
		
		return pageinfo;
	}

	public int enroll(BlacklistDTO complain) {	//정일_신고등록
		System.out.println("BlacklistService.enroll()");
		
		//신고자 id로 계정정보 조회(index)
		MemberDTO subject = memberMapper.selectAccountByAcc_id(complain.getSubject_id());
		MemberDTO object = memberMapper.selectAccountByAcc_id(complain.getObject_id());
		//개인 비공개정보 제거??
		
//		System.out.println(subject);
//		System.out.println(object);
		complain.setBlack_subject(subject.getAcc_index());
		complain.setBlack_object(object.getAcc_index());
		System.out.println(complain);

		return blacklistMapper.enroll(complain);
	}













	
}
