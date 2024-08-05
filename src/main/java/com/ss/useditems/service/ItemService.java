package com.ss.useditems.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.dto.ItemDTO;
import com.ss.useditems.mapper.ItemMapper;
import com.ss.useditems.util.PageInfo;

@Service
public class ItemService {

	@Autowired
	private ItemMapper mapper;
	
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
	        itemMapper.deleteInterestItem(accIndex, itemId);
	    }
	  
}
