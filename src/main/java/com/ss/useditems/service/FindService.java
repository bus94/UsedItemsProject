package com.ss.useditems.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.mapper.FindMapper;

@Service
public class FindService {
	
	@Autowired
	private FindMapper mapper;
	
}
