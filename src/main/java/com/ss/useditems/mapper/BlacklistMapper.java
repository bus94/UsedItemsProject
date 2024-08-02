package com.ss.useditems.mapper;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.BlacklistDTO;

@Mapper
public interface BlacklistMapper {

	ArrayList<BlacklistDTO> getBlacklist(Map<String, String> queryMap);

	
	
	
}
