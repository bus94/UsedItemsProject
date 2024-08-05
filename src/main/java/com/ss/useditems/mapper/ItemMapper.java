package com.ss.useditems.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ss.useditems.dto.ItemDTO;

@Mapper
public interface ItemMapper {

	List<ItemDTO> searchItems(String searchValue);

	List<ItemDTO> interest(@Param("accIndex") int accIndex);

	int deleteInterestItem(Map<String,Integer> params);





}
