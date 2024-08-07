package com.ss.useditems.mapper;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ss.useditems.dto.ItemDTO;

@Mapper
public interface ItemMapper {

	ArrayList<ItemDTO> interest(@Param("accIndex") int accIndex);

	int deleteInterestItem(Map<String,Integer> params);

	ArrayList<ItemDTO> selectByNearPlace(Map<String, Object> map);

	ArrayList<ItemDTO> selectByPopular(Map<String, Object> map);

	ArrayList<ItemDTO> selectByBestSeller(Map<String, Object> map);

	ArrayList<ItemDTO> selectByDefault(Map<String, Object> map);







}
