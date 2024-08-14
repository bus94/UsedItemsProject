package com.ss.useditems.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.mapper.FindMapper;

@Service
public class FindService {
	
	@Autowired
	private FindMapper mapper;

	public String findId(Map<String, String> request) {
		return mapper.findId(request);
	}

	public String findPw(Map<String, String> request) {
		return mapper.findPw(request);
	}
	
}
