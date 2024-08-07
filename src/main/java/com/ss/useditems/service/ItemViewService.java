package com.ss.useditems.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.dto.ItemDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.dto.ReplyDTO;
import com.ss.useditems.mapper.ItemViewMapper;

@Service
public class ItemViewService {
	
	@Autowired
	private ItemViewMapper mapper;

	public ItemDTO selectByItemIndex(int item_index) {
		return mapper.selectByItemIndex(item_index);
	}

	public MemberDTO selectByIndex(int item_seller) {
		return mapper.selectByIndex(item_seller);
	}


	public int saveReply(ReplyDTO dto) {
		return mapper.insertReply(dto);
	}

<<<<<<< HEAD
	public List<ReplyDTO> selectReplyByItemIndex(int item_index) {
	    return mapper.selectReplyByItemIndex(item_index);
=======
	public void incrementViews(Long itemId) {
		mapper.incrementViews(itemId);
		
>>>>>>> ocy
	}
	
	
}
