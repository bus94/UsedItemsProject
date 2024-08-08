package com.ss.useditems.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.dto.ItemDTO;
import com.ss.useditems.mapper.ItemMapper;
import com.ss.useditems.util.PageInfo;


@Service
public class ItemService2 {

	
	
	//기존 매퍼 사용!!!!!!!!!!!!!!!!!!!!!!!!!!
	@Autowired
	private ItemMapper mapper;

	
	
	
//	public PageInfo interestItem(int currentPage, int accIndex) {
//		System.out.println(mapper.interest(accIndex));
//
//		ArrayList<ItemDTO> unpaged_list = mapper.interest(accIndex);
//
//		PageInfo pageinfo = new PageInfo(currentPage, 5, unpaged_list.size(), 10);
//
//		List<ItemDTO> paged_list = unpaged_list.subList(pageinfo.getFromIndex(), pageinfo.getTillIndex());
//
//		pageinfo.setDtoContainer2(paged_list);
//
//		return pageinfo;
//	}

//	public List<ItemDTO> interestItem(int accIndex) {
//		System.out.println(mapper.interest(accIndex));
//		return mapper.interest(accIndex);
//	}
//
//	public boolean deleteInterestItem(Map<String, Integer> params) {
//
//		return mapper.deleteInterestItem(params) > 0;
//	}

//	public PageInfo selectByNearPlace(int currentPage_, Map<String, Object> map) {
//		System.out.println("selectByNearPlace() 실행");
//		ArrayList<ItemDTO> unpaged_list = mapper.selectByNearPlace(map);
//
//		PageInfo pageinfo = new PageInfo(currentPage_, 5, unpaged_list.size(), 10);
//
//		List<ItemDTO> paged_list = unpaged_list.subList(pageinfo.getFromIndex(), pageinfo.getTillIndex());
//
//		pageinfo.setDtoContainer2(paged_list);
//
//		return pageinfo;
//	}

//	public PageInfo selectByPopular(int currentPage_, Map<String, Object> map) {
//		System.out.println("selectByPopular() 실행");
//		ArrayList<ItemDTO> unpaged_list = mapper.selectByPopular(map);
//
//		PageInfo pageinfo = new PageInfo(currentPage_, 5, unpaged_list.size(), 10);
//
//		List<ItemDTO> paged_list = unpaged_list.subList(pageinfo.getFromIndex(), pageinfo.getTillIndex());
//
//		pageinfo.setDtoContainer2(paged_list);
//
//		return pageinfo;
//	}

//	public PageInfo selectByBestSeller(int currentPage_, Map<String, Object> map) {
//		System.out.println("selectByBestSeller() 실행");
//		ArrayList<ItemDTO> unpaged_list = mapper.selectByBestSeller(map);
//
//		PageInfo pageinfo = new PageInfo(currentPage_, 5, unpaged_list.size(), 10);
//
//		List<ItemDTO> paged_list = unpaged_list.subList(pageinfo.getFromIndex(), pageinfo.getTillIndex());
//
//		pageinfo.setDtoContainer2(paged_list);
//
//		return pageinfo;
//	}

	/*
	 * public PageInfo selectByDefault(int currentPage_, Map<String, Object> map) {
	 * System.out.println("테스터(service2): selectByDefault() 실행");
	 * System.out.println("service.map" + map); ArrayList<ItemDTO> unpaged_list =
	 * mapper.selectByDefault(map); System.out.println("unpaged_list:" +
	 * unpaged_list); PageInfo pageinfo = new PageInfo(currentPage_, 5,
	 * unpaged_list.size(), 10); System.out.println("pageinfo:" + pageinfo);
	 * 
	 * List<ItemDTO> paged_list = unpaged_list.subList(pageinfo.getFromIndex(),
	 * pageinfo.getTillIndex()); System.out.println("paged_list:" + paged_list);
	 * 
	 * pageinfo.setDtoContainer2(paged_list); System.out.println("set 후 pageinfo:" +
	 * pageinfo); return pageinfo; }
	 */

	
		
}
