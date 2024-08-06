package com.ss.useditems.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ss.useditems.dto.ItemDTO;

@Mapper
public interface ItemMapper {

	ArrayList<ItemDTO> searchItems(String searchValue);
	ArrayList<ItemDTO> searchItems2(String categoryList);

	ArrayList<ItemDTO> interest(@Param("accIndex") int accIndex);

	int deleteInterestItem(Map<String,Integer> params);

	ArrayList<ItemDTO> selectByNearPlace(Map<String, Object> map);

	ArrayList<ItemDTO> selectByPopular(Map<String, Object> map);

	ArrayList<ItemDTO> selectByBestSeller(Map<String, Object> map);

	ArrayList<ItemDTO> selectByDefault(Map<String, Object> map);






}
