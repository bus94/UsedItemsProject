package com.ss.useditems.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.BlacklistDTO;

@Mapper
public interface BlacklistMapper {

	List<BlacklistDTO> getBlacklist(Map<String, String> queryMap);

	
	
	
}
