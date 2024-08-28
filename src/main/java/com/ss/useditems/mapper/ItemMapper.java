package com.ss.useditems.mapper;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ss.useditems.dto.ItemInfoDTO;

@Mapper
public interface ItemMapper {

	ArrayList<ItemInfoDTO> interest(@Param("accIndex") int accIndex);

	int deleteInterestItem(Map<String,Integer> params);

	ArrayList<ItemInfoDTO> selectByNearPlace(Map<String, Object> map);

	ArrayList<ItemInfoDTO> selectByPopular(Map<String, Object> map);

	ArrayList<ItemInfoDTO> selectByBestSeller(Map<String, Object> map);

	ArrayList<ItemInfoDTO> selectByDefault(Map<String, Object> map);

	ArrayList<String> nearDistrict(Map<String,String> params);

}
