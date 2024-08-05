package com.ss.useditems.service;

import java.util.List;

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
	 
	  public List<ItemDTO> interestItem(int accIndex){
		  System.out.println(mapper.interest(accIndex));
		  return mapper.interest(accIndex);
	  }
	  
	    public void deleteInterestItem(int accIndex, int itemId) {
	        mapper.deleteInterestItem(accIndex, itemId);
	    }
	  
}
