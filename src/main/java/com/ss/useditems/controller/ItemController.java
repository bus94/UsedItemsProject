package com.ss.useditems.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ss.useditems.dto.ItemDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.service.ItemService;

@Controller
public class ItemController {

	@Autowired
	private ItemService service;

	@RequestMapping("/item/itemList.do")
	public String itemList(Model model, String searchValue) {
		System.out.println("itemList 페이지");
		System.out.println("searchValue: " + searchValue);
		List<ItemDTO> itemList = service.searchItems(searchValue);

		model.addAttribute("itemList", itemList);
		model.addAttribute("searchValue", searchValue);
		System.out.println(itemList);

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
	public String interest(HttpSession session, Model model) {
		System.out.println("interest 페이지");

		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");

		if (loginMember != null) {
			int accIndex = loginMember.getAcc_Index();
			List<ItemDTO> interestItemList = service.getInterestItem(accIndex);
			model.addAttribute("interestItemList", interestItemList);
		} else {
			return "redirect:/account/login";
		}
		return "item/interest";
	}
	
    @RequestMapping(value = "/item/deleteInterest", method = RequestMethod.POST)
    public String deleteInterest(@RequestParam("itemId") int itemId, HttpSession session, Model model) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember != null) {
            int accIndex = loginMember.getAccIndex();
            service.deleteInterestItem(accIndex, itemId);
            List<ItemDTO> interestItemList = itemService.getInterestItems(accIndex);
            model.addAttribute("interestItemList", interestItemList);
        }
        return "redirect:/item/interest";
    }
}
