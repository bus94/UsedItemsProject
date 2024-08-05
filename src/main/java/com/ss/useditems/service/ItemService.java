package com.ss.useditems.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.dto.ItemDTO;
import com.ss.useditems.mapper.ItemMapper;

@Service
public class ItemService {

	@Autowired
	private ItemMapper mapper;

	public List<ItemDTO> searchItems(String searchValue) {
		System.out.println(mapper.searchItems(searchValue));
		return mapper.searchItems(searchValue);
	}

	public List<ItemDTO> interestItem(int accIndex) {
		System.out.println(mapper.interest(accIndex));
		return mapper.interest(accIndex);
	}

	public boolean deleteInterestItem(int accIndex, int itemId) {
		Map<String, Integer> params = new HashMap<String, Integer>();
		System.out.println("service acc"+accIndex+"  Item"+itemId);
		params.put("accIndex", accIndex);
		params.put("itemId", itemId);
		return mapper.deleteInterestItem(params) > 0;

	}

}
