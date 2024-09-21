package com.ss.useditems.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.ItemInfoDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.dto.ReplyDTO;

@Mapper
public interface ItemViewMapper {

	// 물품 정보 가져오기
	ItemInfoDTO selectByItemIndex(int item_index);

	// 물품 셀러 정보 불러오기
	MemberDTO selectByIndex(int item_index);

	// 댓글 등록
	int insertReply(ReplyDTO dto);

	// 댓글 불러오기
	List<ReplyDTO> selectReplyByItemIndex(int item_index);

	// 조회수 증가
	void incrementViews(int item_index);

//	int interestnum(int item_index);

	// 댓글삭제
	int deleteReply(Map<String, Integer> hmap);

	// 채팅방이 있는지 확인
	int checkChatRoom(Map<String, Integer> hmap);
	
	// 물품 onsale로 변경
	int updateItemOnsale(Map<String, Integer> hmap);
	
	// 댓글 수정
	int updateReply(ReplyDTO dto);

	// 셀러의 다른 물품 불러오기
	List<ItemInfoDTO> selectByItemSeller(HashMap<String, Integer> map);

	// 관심수 증가
	void addInterest(Map<String,Integer> map);

	// 관심등록확인
	int checkInterest(Map<String, Integer> map);

	// 관심등록 해제
	void removeInterest(Map<String, Integer> map);

	// 물품 삭제
	int deleteItem(int item_index);





}
