package com.ss.useditems.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	public int updateItem(ItemInfoDTO existingItem, boolean thumb_check, boolean img_check) {
		System.out.println("ItemEnrollService의 updateItem() 실행");
	
		int i = 1;
		if (thumb_check) {
			mapper.updateShowcaseThumbnail(existingItem);
		}
		
		if (img_check) {
			mapper.updateShowcaseImg(existingItem);
		}
		return mapper.updateItem(existingItem);
	}

}
