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
}
