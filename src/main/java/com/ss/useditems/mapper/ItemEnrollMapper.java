package com.ss.useditems.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.ItemInfoDTO;

@Mapper
public interface ItemEnrollMapper {

	// 물품 등록
	int enrollItem(ItemInfoDTO enrollItemInfo);

	// 물품 개수 조회
	int selectItemIndex();

	// 물품 수정
	int updateItem(ItemInfoDTO existingItem);
	
	// 물품 썸네일 파일명 수정
	int updateShowcaseThumbnail(ItemInfoDTO existingItem);
	
	// 물품 이미지 파일명 수정
	int updateShowcaseImg(ItemInfoDTO existingItem);
	
}
