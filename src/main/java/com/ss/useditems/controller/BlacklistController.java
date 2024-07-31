package com.ss.useditems.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@RequestMapping("/blacklist")
@Controller
public class BlacklistController {

	
	
	
	@GetMapping("/complainList")
	public String complainList(Model model, String black_object) {
		System.out.println("==blacklist.complainList==");
		System.out.println("suspect: "+ black_object);

		
		
		
		
		
		return "blacklist/complainList";
	}
	
	@GetMapping("/complain.do")
	public String complain(Model model) {
		System.out.println("==blacklist.complain==");

		//신고페이지

		return "blacklist/complain";
	}
	
	
	@PostMapping("/complainPro.do")
	public String complainPro(Model model) {
		System.out.println("==blacklist.complainPro==");

		//신고 처리 후 사기조회페이지로 이동

		return "blacklist/complainList";
	}
	
	
	
}
