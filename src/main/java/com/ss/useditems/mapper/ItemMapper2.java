package com.ss.useditems.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.ItemInfoDTO;

@Mapper
public interface ItemMapper2 {

	ArrayList<ItemInfoDTO> getNew5();

	ArrayList<ItemInfoDTO> getHot5();

}
