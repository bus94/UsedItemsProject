package com.ss.useditems.mapper;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ss.useditems.dto.ItemInfoDTO;

@Mapper
public interface ItemMapper {
	// 관심 물품 (찜 목록)
	ArrayList<ItemInfoDTO> interest(@Param("accIndex") int accIndex);

	// 관심 물품 (찜 목록) 삭제
	int deleteInterestItem(Map<String,Integer> params);

	// 조회순 검색
	ArrayList<ItemInfoDTO> selectByPopular(Map<String, Object> map);

	// 매너등급순 검색
	ArrayList<ItemInfoDTO> selectByBestSeller(Map<String, Object> map);

	// 기본 검색
	ArrayList<ItemInfoDTO> selectByDefault(Map<String, Object> map);

	// 반경 700m 지역
	ArrayList<String> nearDistrict(Map<String,String> params);
}
