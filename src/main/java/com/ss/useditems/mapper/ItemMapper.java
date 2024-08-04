package com.ss.useditems.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ss.useditems.dto.ItemDTO;

@Mapper
public interface ItemMapper {

	List<ItemDTO> searchItems(String searchValue);

	List<ItemDTO> interest(@Param("accIndex") int accIndex);

	void deleteInterestItem(@Param("accIndex") int accIndex, @Param("itemId") int itemId);





}
