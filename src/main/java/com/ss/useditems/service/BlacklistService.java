package com.ss.useditems.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.dto.BlacklistDTO;
import com.ss.useditems.mapper.BlacklistMapper;
import com.ss.useditems.mapper.MemberMapper;
import com.ss.useditems.util.PageInfo;

@Service
public class BlacklistService {

	@Autowired
	private BlacklistMapper blacklistMapper;

	@Autowired
	private MemberMapper memberMapper;
	
	public PageInfo getBlacklist(int currentPage, Map<String, String> queryMap) {
		
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

	public int enroll(BlacklistDTO complain) {
		System.out.println("BlacklistService의 enroll()");
		
		memberMapper.selectIdIndex(complain.getSubject_id());
		memberMapper.selectIdIndex(complain.getObject_id());

		
		
		BlacklistDTO dto = new BlacklistDTO();

		return blacklistMapper.enroll(complain);
	}
	
	
	
	
	
	
}
