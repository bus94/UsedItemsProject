package com.ss.useditems.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.ItemDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.dto.ReplyDTO;

@Mapper
public interface ItemViewMapper {

	ItemDTO selectByItemIndex(int item_index);

	MemberDTO selectByIndex(int item_index);

	int insertReply(ReplyDTO dto);
	
}
