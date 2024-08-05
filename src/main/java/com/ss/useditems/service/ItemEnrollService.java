package com.ss.useditems.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.dto.ItemDTO;
import com.ss.useditems.mapper.ItemEnrollMapper;

@Service
public class ItemEnrollService {
	
	@Autowired
	private ItemEnrollMapper mapper;

	public int itemEnroll(ItemDTO enrollItem) {
		System.out.println("ItemEnrollService의 itemEnroll() 실행");
		return mapper.itemEnroll(enrollItem);
	}
	
}
