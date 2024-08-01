package com.ss.useditems.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.dto.BlacklistDTO;
import com.ss.useditems.mapper.BlacklistMapper;

@Service
public class BlacklistService {

	@Autowired
	private BlacklistMapper mapper;

	public List<BlacklistDTO> getBlacklist(int currentPage, Map<String, String> queryMap) {
		// currentPage정보로 pagination해서 paged_list돌려주기
		
		
		List<BlacklistDTO> paged_list = mapper.getBlacklist(queryMap);
		
		
		return paged_list;
	}
	
	
	
	
	
	
}
