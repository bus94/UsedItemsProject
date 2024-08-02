package com.ss.useditems.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.ItemDTO;
@Mapper
public interface ItemMapper {

	List<ItemDTO> searchItems(String searchValue);

}
