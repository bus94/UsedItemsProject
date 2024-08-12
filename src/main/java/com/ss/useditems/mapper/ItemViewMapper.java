package com.ss.useditems.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.ItemInfoDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.dto.ReplyDTO;

@Mapper
public interface ItemViewMapper {

	ItemInfoDTO selectByItemIndex(int item_index);

	MemberDTO selectByIndex(int item_index);

	int insertReply(ReplyDTO dto);

	List<ReplyDTO> selectReplyByItemIndex(int item_index);

	void incrementViews(int item_index);


	int interestnum(int item_index);

	int deleteReply(Map<String, Integer> hmap);

	int updateReply(ReplyDTO dto);

	List<ItemInfoDTO> selectByItemSeller(int item_seller);


}
