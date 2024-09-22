package com.ss.useditems.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.dto.ItemInfoDTO;
import com.ss.useditems.mapper.ItemMapper;
import com.ss.useditems.util.PageInfo;

@Service
public class ItemService {

	@Autowired
	private ItemMapper mapper;

	// 관심 물품 (찜 목록) 페이지 페이지네이션 처리
	public PageInfo interestItem(int currentPage, int accIndex) {
		ArrayList<ItemInfoDTO> unpaged_list = mapper.interest(accIndex);
		PageInfo pageinfo = new PageInfo(currentPage, 5, unpaged_list.size(), 10);
		List<ItemInfoDTO> paged_list = unpaged_list.subList(pageinfo.getFromIndex(), pageinfo.getTillIndex());
		pageinfo.setDtoContainerInfo(paged_list);
		return pageinfo;
	}

	// 관심 물품 (찜 목록) 리스트 불러오기
	public ArrayList<ItemInfoDTO> interestItem(int accIndex) {
		return mapper.interest(accIndex);
	}

	// 관심 물품 (찜 목록) 삭제
	public boolean deleteInterestItem(Map<String, Integer> params) {
		return mapper.deleteInterestItem(params) > 0;
	}

	// 조회순 검색 페이지네이션 처리
	public PageInfo selectByPopular(int currentPage_, Map<String, Object> map) {
		ArrayList<ItemInfoDTO> unpaged_list = mapper.selectByPopular(map);
		PageInfo pageinfo = new PageInfo(currentPage_, 5, unpaged_list.size(), 20);
		List<ItemInfoDTO> paged_list = unpaged_list.subList(pageinfo.getFromIndex(), pageinfo.getTillIndex());
		pageinfo.setDtoContainerInfo(paged_list);
		return pageinfo;
	}

	// 매너등급순 검색 페이지네이션 처리
	public PageInfo selectByBestSeller(int currentPage_, Map<String, Object> map) {
		ArrayList<ItemInfoDTO> unpaged_list = mapper.selectByBestSeller(map);
		PageInfo pageinfo = new PageInfo(currentPage_, 5, unpaged_list.size(), 20);
		List<ItemInfoDTO> paged_list = unpaged_list.subList(pageinfo.getFromIndex(), pageinfo.getTillIndex());
		pageinfo.setDtoContainerInfo(paged_list);
		return pageinfo;
	}

	// 기본 페이지네이션 처리 (필터링 없는 검색)
	public PageInfo selectByDefault(int currentPage_, Map<String, Object> map) {
		ArrayList<ItemInfoDTO> unpaged_list = mapper.selectByDefault(map);
		PageInfo pageinfo = new PageInfo(currentPage_, 5, unpaged_list.size(), 20);
		List<ItemInfoDTO> paged_list = unpaged_list.subList(pageinfo.getFromIndex(), pageinfo.getTillIndex());
		pageinfo.setDtoContainerInfo(paged_list);
		return pageinfo;
	}
	
	// haversine 공식을 이용하여 반경 700m 지역 저장 리스트 불러오기
	public ArrayList<String> nearDistrict(Map<String,String> params){
		return mapper.nearDistrict(params);
	}
}
