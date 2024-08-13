package com.ss.useditems.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.dto.ItemInfoDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.dto.ReplyDTO;
import com.ss.useditems.mapper.ItemViewMapper;

@Service
public class ItemViewService {
	
	@Autowired
	private ItemViewMapper mapper;

	public ItemInfoDTO selectByItemIndex(int item_index) {
		return mapper.selectByItemIndex(item_index);
	}

	public MemberDTO selectByIndex(int item_seller) {
		return mapper.selectByIndex(item_seller);
	}


	public int saveReply(ReplyDTO dto) {
		return mapper.insertReply(dto);
	}

	public List<ReplyDTO> selectReplyByItemIndex(int item_index) {
	    return mapper.selectReplyByItemIndex(item_index);
	}
	    
	public void incrementViews(int item_index) {
		mapper.incrementViews(item_index);
		
	}

	public boolean isInterest(Map<String,Integer> map) {
		return mapper.checkInterest(map)>0;
	}


	public int interestnum(int item_index) {
		System.out.println("interest 수 리턴");
		return mapper.interestnum(item_index);
	}


	public int deleteReply(Map<String, Integer> hmap) {
		return mapper.deleteReply(hmap);
	}

	public int updateReply(ReplyDTO dto) {
	    return mapper.updateReply(dto);
	}

	public List<ItemInfoDTO> selectByItemSeller(HashMap<String, Integer> map) {
		return mapper.selectByItemSeller(map);
	}
	
	public void addInterest(Map<String, Integer> map) {
		mapper.addInterest(map);
	}

	public void removeInterest(Map<String,Integer> map) {
		mapper.removeInterest(map);
		
	}

}
