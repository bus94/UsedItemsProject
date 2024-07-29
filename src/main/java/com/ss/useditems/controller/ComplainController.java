package com.ss.useditems.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class ComplainController {

	@RequestMapping("/complain/complainList.do")
	public String complainList(Model model) {
		System.out.println("==complain.complainList==");



		return "complain/complainList";
	}
	
	@RequestMapping("/complain/complain.do")
	public String complain(Model model) {
		System.out.println("==complain.complain==");



		return "complain/complain";
	}
	
}
