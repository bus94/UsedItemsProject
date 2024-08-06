package com.ss.useditems.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.ItemDTO;

@Mapper
public interface ItemViewMapper {

	ItemDTO selectByItemIndex(int item_index);
	
}
