package com.ss.useditems.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ss.useditems.dto.ItemDTO;
import com.ss.useditems.service.ItemService;

@Controller
public class ItemController {
	
	@Autowired
	private ItemService service;
	
	@RequestMapping("/item/itemList.do")
	public String itemList(Model model) {
		System.out.println("itemList 페이지");
		return "item/itemList";
	}
	
	@RequestMapping("/item/itemView.do")
	public String itemView(Model model) {
		System.out.println("itemView 페이지");
		return "item/itemView";
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
	
//	@RequestMapping("/itemList.do")
//	public String searchItems(Model model, String sear_word) {
//		
//		List<ItemDTO> itemList = service.searchItems(sear_word);
//				
//		model.addAttribute("itemList",itemList);
//        model.addAttribute("sear_word",sear_word);
//		
//		return "item/itemList";
//	}
	
	
	
}

