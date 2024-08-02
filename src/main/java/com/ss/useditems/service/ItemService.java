package com.ss.useditems.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.dto.ItemDTO;

@Service
public class ItemService {

<<<<<<< HEAD
	/*
	 * @Autowired private ItemMapper mapper;
	 * 
	 * public List<ItemDTO> searchItems(String sear_word) { return
	 * mapper.selectItemList(sear_word); }
	 */
=======
	@Autowired
	private ItemMapper mapper;
	
	  public List<ItemDTO> searchItems() { 
		  System.out.println(mapper.searchItems());
		  return mapper.searchItems(); 
		  }
	 
>>>>>>> moong

}
