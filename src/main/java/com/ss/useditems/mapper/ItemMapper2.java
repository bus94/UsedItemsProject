package com.ss.useditems.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.ItemDTO;

@Mapper
public interface ItemMapper2 {

	ArrayList<ItemDTO> getNew5();

	ArrayList<ItemDTO> getHot5();

}
