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
		//System.out.println("interest 수 리턴");
		return mapper.interestnum(item_index);
	}


	public int deleteReply(Map<String, Integer> hmap) {
		
		int result = -1;
		
		int checkChatRoom = mapper.checkChatRoom(hmap); 
		//댓글이 채팅방이 만들어져 있는 댓글인지 확인
		
		if(checkChatRoom == 0) {
			//System.out.println("채팅방과 관련 없는 댓글 삭제");
			result = mapper.deleteReply(hmap);
		} else if(checkChatRoom > 0) {
			//System.out.println("채팅방이 개설된 댓글 삭제");
			result = mapper.deleteReply(hmap);
			result += mapper.updateItemOnsale(hmap);
			//채팅방까지 삭제 후 item_status: ondeal -> onsale
		}
		
		return result;
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
	public boolean deleteItem(int item_index) {
		return mapper.deleteItem(item_index)>0 ? true :false;
	}

}
