package com.ss.useditems.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.ItemDTO;

@Mapper
public interface ItemEnrollMapper {

	int itemEnroll(ItemDTO enrollItem);
	
}
