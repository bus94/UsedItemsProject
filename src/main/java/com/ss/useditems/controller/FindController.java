package com.ss.useditems.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ss.useditems.service.FindService;

@Controller
public class FindController {
	
	@Autowired
	private FindService service;
	
	@RequestMapping("/account/findId.do")
	public String findId(Model model) {
		return "account/login";
	}
}
