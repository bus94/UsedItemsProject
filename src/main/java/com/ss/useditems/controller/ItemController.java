package com.ss.useditems.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ItemController {
	@RequestMapping("/item/itemList.do")
	public String itemList(Model model) {
		System.out.println("itemList 페이지");
		return "item/itemList";
	}
	
	
	@RequestMapping("/item/itemEnroll.do")
	public String itemEnroll(Model model) {
		System.out.println("itemEnroll 페이지");
		return "item/itemEnroll";
	}
	
	@RequestMapping("/item/interest.do")
	public String interest(Model model) {
		System.out.println("interest 페이지");
		return "item/interest";
	}
	
	
}

