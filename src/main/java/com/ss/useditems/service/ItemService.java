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
public class ItemService {

	@Autowired
	private ItemMapper mapper;

	public PageInfo searchItems(int currentPage, String searchValue) {
		ArrayList<ItemDTO> unpaged_list = mapper.searchItems(searchValue);

		PageInfo pageinfo = new PageInfo(currentPage, 5, unpaged_list.size(), 10);

		List<ItemDTO> paged_list = unpaged_list.subList(pageinfo.getFromIndex(), pageinfo.getTillIndex());

		pageinfo.setDtoContainer2(paged_list);

		return pageinfo;
	}

	public PageInfo interestItem(int currentPage, int accIndex) {
		System.out.println(mapper.interest(accIndex));

		ArrayList<ItemDTO> unpaged_list = mapper.interest(accIndex);

		PageInfo pageinfo = new PageInfo(currentPage, 5, unpaged_list.size(), 10);

		List<ItemDTO> paged_list = unpaged_list.subList(pageinfo.getFromIndex(), pageinfo.getTillIndex());

		pageinfo.setDtoContainer2(paged_list);

		return pageinfo;
	}

	public List<ItemDTO> interestItem(int accIndex) {
		System.out.println(mapper.interest(accIndex));
		return mapper.interest(accIndex);
	}

	public boolean deleteInterestItem(Map<String, Integer> params) {

		return mapper.deleteInterestItem(params) > 0;
	}

	public PageInfo selectByNearPlace(int currentPage_, Map<String, Object> map) {
		System.out.println("selectByNearPlace() 실행");
		ArrayList<ItemDTO> unpaged_list = mapper.selectByNearPlace(map);

		PageInfo pageinfo = new PageInfo(currentPage_, 5, unpaged_list.size(), 10);

		List<ItemDTO> paged_list = unpaged_list.subList(pageinfo.getFromIndex(), pageinfo.getTillIndex());

		pageinfo.setDtoContainer2(paged_list);

		return pageinfo;
	}

	public PageInfo selectByPopular(int currentPage_, Map<String, Object> map) {
		System.out.println("selectByPopular() 실행");
		ArrayList<ItemDTO> unpaged_list = mapper.selectByPopular(map);

		PageInfo pageinfo = new PageInfo(currentPage_, 5, unpaged_list.size(), 10);

		List<ItemDTO> paged_list = unpaged_list.subList(pageinfo.getFromIndex(), pageinfo.getTillIndex());

		pageinfo.setDtoContainer2(paged_list);

		return pageinfo;
	}

	public PageInfo selectByBestSeller(int currentPage_, Map<String, Object> map) {
		System.out.println("selectByBestSeller() 실행");
		ArrayList<ItemDTO> unpaged_list = mapper.selectByBestSeller(map);

		PageInfo pageinfo = new PageInfo(currentPage_, 5, unpaged_list.size(), 10);

		List<ItemDTO> paged_list = unpaged_list.subList(pageinfo.getFromIndex(), pageinfo.getTillIndex());

		pageinfo.setDtoContainer2(paged_list);

		return pageinfo;
	}

	public PageInfo selectByDefault(int currentPage_) {
		System.out.println("selectByDefault() 실행");
		
		ArrayList<ItemDTO> unpaged_list = mapper.selectByDefault();
		System.out.println("1");
		
		PageInfo pageinfo = new PageInfo(currentPage_, 5, unpaged_list.size(), 10);
		System.out.println("2");
		
		List<ItemDTO> paged_list = unpaged_list.subList(pageinfo.getFromIndex(), pageinfo.getTillIndex());
		System.out.println("3");
		
		pageinfo.setDtoContainer2(paged_list);
		System.out.println("4");

		return pageinfo;
	}

}
