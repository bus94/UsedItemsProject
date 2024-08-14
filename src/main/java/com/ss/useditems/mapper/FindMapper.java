package com.ss.useditems.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FindMapper {

	String findId(Map<String, String> request);

	String findPw(Map<String, String> request);
	
}
