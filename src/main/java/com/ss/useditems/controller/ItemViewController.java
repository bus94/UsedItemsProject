package com.ss.useditems.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ss.useditems.dto.ItemDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.service.ItemViewService;

@Controller
public class ItemViewController {
	
	@Autowired
	private ItemViewService service;

	@RequestMapping("/item/itemView")
	public String itemView(Model model, int item_index) {
		System.out.println("itemView 페이지");
		System.out.println("item_index: " + item_index);
		
		ItemDTO item = service.selectByItemIndex(item_index);
		MemberDTO itemMember = service.selectByIndex(item.getItem_seller());
		System.out.println("item: " + item);
		System.out.println("itemMember: " + itemMember);
		
		model.addAttribute("item", item);
		model.addAttribute("itemMember", itemMember);
		
		return "item/itemView";
	}
}
