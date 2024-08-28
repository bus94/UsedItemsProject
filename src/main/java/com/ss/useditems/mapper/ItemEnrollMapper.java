package com.ss.useditems.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.ItemInfoDTO;

@Mapper
public interface ItemEnrollMapper {

	int enrollItem(ItemInfoDTO enrollItemInfo);

	int selectItemIndex();

	int updateItem(ItemInfoDTO existingItem);
	
	int updateShowcaseThumbnail(ItemInfoDTO existingItem);
	
	int updateShowcaseImg(ItemInfoDTO existingItem);
	
}
