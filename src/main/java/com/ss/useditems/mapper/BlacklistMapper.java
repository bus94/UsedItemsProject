package com.ss.useditems.mapper;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.BlacklistDTO;
import com.ss.useditems.dto.MemberDTO;

@Mapper
public interface BlacklistMapper {

	ArrayList<BlacklistDTO> getBlacklist(Map<String, String> queryMap);

	int enroll(BlacklistDTO complain);

	ArrayList<MemberDTO> getBlack5();

	int delet(String black_index);



	///////////arraylist 받아서 map으로 sql 집어넣기
	int testarr(Map<String, String> testMap);

	
	
	
}
