package com.ss.useditems.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ss.useditems.service.ItemViewService;

public class ItemViewController {
	@Autowired
	private ItemViewService service;

	@RequestMapping("/item/itemView")
	public String itemView(Model model, int item_index) {
		System.out.println("itemView 페이지");
		
		
		
		return "item/itemView";
	}
}
