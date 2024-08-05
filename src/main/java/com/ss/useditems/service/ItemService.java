package com.ss.useditems.service;

<<<<<<< HEAD
import java.util.HashMap;
=======
import java.util.ArrayList;
>>>>>>> 3b57cebb56ba316ecd797a822427341ee94b1c60
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
<<<<<<< HEAD

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

=======
	
	  public PageInfo searchItems(int currentPage,String searchValue) { 
		  ArrayList<ItemDTO> unpaged_list = mapper.searchItems(searchValue);
		  
		  PageInfo pageinfo = new PageInfo(currentPage, 5, unpaged_list.size(), 10);
		  
		  List<ItemDTO> paged_list = unpaged_list.subList(pageinfo.getFromIndex(), pageinfo.getTillIndex());
		  
		  pageinfo.setDtoContainer2(paged_list);
			
		  return pageinfo;
	  }
	 
	  public List<ItemDTO> interestItem(int accIndex){
		  System.out.println(mapper.interest(accIndex));
		  return mapper.interest(accIndex);
	  }
	  
	    public void deleteInterestItem(int accIndex, int itemId) {
	        mapper.deleteInterestItem(accIndex, itemId);
	    }
	  
>>>>>>> 3b57cebb56ba316ecd797a822427341ee94b1c60
}
