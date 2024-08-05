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
import com.ss.useditems.service.MemberService;
import com.ss.useditems.util.PageInfo;

@Controller
public class ItemController {

	@Autowired
	private ItemService service;
	private MemberService mService;
	
	@RequestMapping("/item/itemList.do")
	public String itemList(Model model, String searchValue, String currentPage) {
		System.out.println("itemList 페이지");
		System.out.println("currentPage: " + currentPage);
		
		if(currentPage == null) {
			currentPage = "1";
		}
		
		int currentPage_ = Integer.parseInt(currentPage);
		
		//int currentPage = 1;
		try {
			// currentPage = Integer.parseInt(currentPage);
			
		} catch (Exception e) {
		}
		PageInfo pageInfo = service.searchItems(currentPage_, searchValue);
		
		model.addAttribute("itemList", pageInfo.getDtoContainer2());
		model.addAttribute("pageInfo", pageInfo);		

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
			int accIndex = loginMember.getAcc_index();
			List<ItemDTO> interestItemList = service.interestItem(accIndex);
			
			model.addAttribute("interestItemList", interestItemList);
		}else {
			return "account/login";
		}
		return "item/interest";
	}

	@RequestMapping(value = "/item/deleteInterest", method = RequestMethod.POST)
	public String deleteInterest(@RequestParam("itemId") int itemId, HttpSession session, Model model) {
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		
		int accIndex = loginMember.getAcc_index();
		service.deleteInterestItem(accIndex, itemId);
		List<ItemDTO> interestItemList = service.interestItem(accIndex);
		model.addAttribute("interestItemList", interestItemList);

		return "redirect:/item/interest";
	}
}
