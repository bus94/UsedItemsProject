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

	// 물품번호로 물품정보 가져오기
	public ItemInfoDTO selectByItemIndex(int item_index) {	

		ItemInfoDTO item = new ItemInfoDTO();
		item = mapper.selectByItemIndex(item_index);
		
		// 물품 상세페이지 사진 불러오기
		String filePath = item.getItem_seller() + "/item_" + item.getItem_index() + "/";
		item.setItem_thumbPath(filePath + item.getShow_thumb());
		item.setItem_img1Path(filePath + item.getShow_img1());
		item.setItem_img2Path(filePath + item.getShow_img2());
		item.setItem_img3Path(filePath + item.getShow_img3());
		item.setItem_img4Path(filePath + item.getShow_img4());
		item.setItem_img5Path(filePath + item.getShow_img5());
		
		return item;
	}

	// 셀러번호로 셀러정보 가져오기
	public MemberDTO selectByIndex(int item_seller) {
		
		// 셀러 정보
		MemberDTO itemMember = mapper.selectByIndex(item_seller);
		
		itemMember.setAcc_score(itemMember.acc_score(itemMember.getAcc_count(), itemMember.getAcc_blackCount()));
		// 매너등급
		if (itemMember.getAcc_score() >= 80) {
			itemMember.setAcc_level(5);
		} else if (itemMember.getAcc_score() >= 60) {
			itemMember.setAcc_level(4);
		} else if (itemMember.getAcc_score() >= 40) {
			itemMember.setAcc_level(3);
		} else if (itemMember.getAcc_score() >= 20) {
			itemMember.setAcc_level(2);
		} else {
			itemMember.setAcc_level(1);
		}
		System.out.println("itemMember: " + itemMember);
		
		return itemMember;
	}


	// 댓글 저장
	public int saveReply(ReplyDTO dto) {
		return mapper.insertReply(dto);
	}

	// 물품번호에 달려있는 댓글들 가져오기
	public List<ReplyDTO> selectReplyByItemIndex(int item_index) {
	    return mapper.selectReplyByItemIndex(item_index);
	}

	// 조회수 증가
	public void incrementViews(int item_index) {
		mapper.incrementViews(item_index);
		
	}

	// 관심등록 여부 확인
	public boolean isInterest(Map<String,Integer> map) {
		return mapper.checkInterest(map)>0;
	}


//	public int interestnum(int item_index) {
//		//System.out.println("interest 수 리턴");
//		return mapper.interestnum(item_index);
//	}


	// 댓글 지우기
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

	// 댓글 수정
	public int updateReply(ReplyDTO dto) {
	    return mapper.updateReply(dto);
	}

	// 셀러의 물품정보 가져오기
	public List<ItemInfoDTO> selectByItemSeller(HashMap<String, Integer> map) {

		// 해당 매물에 대한 판매자의 다른 상품
		List<ItemInfoDTO> otherItemList = mapper.selectByItemSeller(map);
		String filePathOther;
		for (int i = 0; i < otherItemList.size(); i++) {
			filePathOther = otherItemList.get(i).getItem_seller() + "/item_" + otherItemList.get(i).getItem_index()
					+ "/";
			otherItemList.get(i).setItem_thumbPath(filePathOther + otherItemList.get(i).getShow_thumb());
			otherItemList.get(i).setItem_img1Path(filePathOther + otherItemList.get(i).getShow_img1());
			otherItemList.get(i).setItem_img2Path(filePathOther + otherItemList.get(i).getShow_img2());
			otherItemList.get(i).setItem_img3Path(filePathOther + otherItemList.get(i).getShow_img3());
			otherItemList.get(i).setItem_img4Path(filePathOther + otherItemList.get(i).getShow_img4());
			otherItemList.get(i).setItem_img5Path(filePathOther + otherItemList.get(i).getShow_img5());
		}
		
		
		return otherItemList;
	}
	
	// 관심등록
	public void addInterest(Map<String, Integer> map) {
		mapper.addInterest(map);
	}

	// 관심등록 해제
	public void removeInterest(Map<String,Integer> map) {
		mapper.removeInterest(map);
		
	}
	
	// 물품 삭제
	public boolean deleteItem(int item_index) {
		return mapper.deleteItem(item_index)>0 ? true :false;
	}

}
