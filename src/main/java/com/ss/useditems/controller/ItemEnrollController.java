package com.ss.useditems.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ss.useditems.dto.ItemDTO;
import com.ss.useditems.service.ItemEnrollService;

@Controller
public class ItemEnrollController {

	@Autowired
	private ItemEnrollService itemEnrollService;

	@RequestMapping("/item/itemEnrollOK.do")
	public String itemEnroll(Model model, HttpSession session, String item_title, String item_content, String item_category, int item_price, String item_place, String item_image) {
		System.out.println("itemEnroll() 실행");
		
		System.out.println("item_title: " + item_title);
		System.out.println("item_content: " + item_content);
		System.out.println("item_category: " + item_category);
		System.out.println("item_price: " + item_price);
		System.out.println("item_place: " + item_place);
		System.out.println("item_image: " + item_image);
		
		ItemDTO enrollItem = new ItemDTO();
		enrollItem.setItem_title(item_title);
		enrollItem.setItem_content(item_content);
		enrollItem.setItem_category(item_category);
		enrollItem.setItem_price(item_price);
		enrollItem.setItem_place(item_place);
		enrollItem.setItem_image(item_image);
		
		if(session.getAttribute("loginMemberNo") != null) {
			int loginMemberNo = (Integer) session.getAttribute("loginMemberNo");
			System.out.println("itemEnroll()에서 loginMemberNo: " + loginMemberNo);
			enrollItem.setItem_seller(loginMemberNo);
		}
		
		if(itemEnrollService.itemEnroll(enrollItem) > 0) {
			model.addAttribute("msg", "상품 등록이 완료되었습니다.");
			model.addAttribute("location", "/item/itemEnroll.do");
		} else {
			model.addAttribute("msg", "상품을 다시 입력해주세요.");
			model.addAttribute("location", "/item/itemEnroll.do");
		}
		return "common/msg";
	}
}
