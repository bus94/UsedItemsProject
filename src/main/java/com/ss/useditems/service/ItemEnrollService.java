package com.ss.useditems.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.dto.ItemInfoDTO;
import com.ss.useditems.mapper.ItemEnrollMapper;

@Service
public class ItemEnrollService {

	@Autowired
	private ItemEnrollMapper mapper;

	// 물품 등록
	public int enrollItem(ItemInfoDTO enrollItemInfo) {
		return mapper.enrollItem(enrollItemInfo);
	}

	// 물품 개수 조회
	public int selectItemIndex() {
		return mapper.selectItemIndex();
	}

	// 물품 수정
	public int updateItem(ItemInfoDTO existingItem, boolean thumb_check, boolean img_check) {
		// 썸네일이 변경되면 thumb_check: true, 변경되지 않으면 thumb_check: false
		if (thumb_check) {
			// 썸네일이 변경되었을 때 실행
			mapper.updateShowcaseThumbnail(existingItem);
		}
		
		// 이미지 파일이 변경되면 img_check: true, 변경되지 않으면 img_check: false
		if (img_check) {
			// 이미지 파일이 변경되었을 때 실행
			mapper.updateShowcaseImg(existingItem);
		}
		// 물품 제목, 내용, 카테고리, 가격, 장소 등의 수정
		return mapper.updateItem(existingItem);
	}

}
