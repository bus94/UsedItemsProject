package com.ss.useditems.service;

import java.util.HashMap;
//<<<<<<< HEAD
//=======
import java.util.ArrayList;
//>>>>>>> 52bf10d17a31d737f3ffce4135e3792ec2b7baf1
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

<<<<<<< HEAD
//<<<<<<< HEAD
=======
>>>>>>> 5dc6e6b9b1beb0720396f99e89cbc1922537198b
   public PageInfo interestItem(int currentPage,int accIndex) {
      System.out.println(mapper.interest(accIndex));
      
      ArrayList<ItemDTO> unpaged_list=mapper.interest(accIndex);
      
      PageInfo pageinfo= new PageInfo(currentPage,5,unpaged_list.size(),10);
      
      List<ItemDTO> paged_list = unpaged_list.subList(pageinfo.getFromIndex(), pageinfo.getTillIndex());
      
      pageinfo.setDtoContainer2(paged_list);
      
      return pageinfo;
   }

<<<<<<< HEAD
   public boolean deleteInterestItem(Map<String, Integer> params) {
      
      return mapper.deleteInterestItem(params) > 0;
   }

//=======
=======
>>>>>>> 5dc6e6b9b1beb0720396f99e89cbc1922537198b
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
<<<<<<< HEAD
//>>>>>>> 8a36ba9de1de559fec6f52d1c01be6e17b849468
=======

	public boolean deleteInterestItem(Map<String, Integer> params) {
		// TODO Auto-generated method stub
		return false;
	}
>>>>>>> 5dc6e6b9b1beb0720396f99e89cbc1922537198b
}
