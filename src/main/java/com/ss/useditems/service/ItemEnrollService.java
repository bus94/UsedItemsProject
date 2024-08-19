package com.ss.useditems.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.dto.ItemDTO;
import com.ss.useditems.dto.ItemInfoDTO;
import com.ss.useditems.mapper.ItemEnrollMapper;

@Service
public class ItemEnrollService {
	
	@Autowired
	private ItemEnrollMapper mapper;

	public int enrollItem(ItemInfoDTO enrollItemInfo) {
		System.out.println("ItemEnrollService의 enrollItem() 실행");
		return mapper.enrollItem(enrollItemInfo);
	}

	public int selectItemIndex() {
		System.out.println("ItemEnrollService의 selectItemIndex() 실행");
		return mapper.selectItemIndex();
	}

	public int updateItem(ItemInfoDTO existingItem,boolean check,int listsize) {
		System.out.println("ItemEnrollService의 updateItem() 실행");
		System.out.println(check);
		int i=1;
		if(!check) {
			 i=mapper.updateShowcaseThumbnail(existingItem);
		}
		if(i<=0) {
			return i;
		}
		if(listsize >0) {
			mapper.updateShowcaseImg(existingItem);
		}
		return mapper.updateItem(existingItem);
	}
	
}
