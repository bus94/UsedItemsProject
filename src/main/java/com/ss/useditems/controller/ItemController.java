package com.ss.useditems.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ss.useditems.dto.ItemDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.service.ItemService;
import com.ss.useditems.util.PageInfo;

@Controller
public class ItemController {

	@Autowired
	private ItemService service;

	@RequestMapping("/item/itemList.do")
	public String itemList(Model model, String searchValue, String currentPage) {
		System.out.println("itemList 페이지");

		if (currentPage == null) {
			currentPage = "1";
		}

		int currentPage_ = Integer.parseInt(currentPage);
		System.out.println("currentPage: " + currentPage);

		PageInfo pageInfo = service.searchItems(currentPage_, searchValue);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("itemList", pageInfo.getDtoContainer2());
		model.addAttribute("pageInfo", pageInfo);

		return "item/itemList";
	}

	@RequestMapping("/item/categoryList.do")
	public String categoryList(Model model, String categoryList, String currentPage) {
		System.out.println("itemList 페이지");
		System.out.println("currentPage: " + currentPage);
		System.out.println("categoryList: " + categoryList);

		if (currentPage == null) {
			currentPage = "1";
		}

		int currentPage_ = Integer.parseInt(currentPage);

		PageInfo pageInfo = service.searchItems(currentPage_, categoryList);

		model.addAttribute("itemList", pageInfo.getDtoContainer2());
		model.addAttribute("pageInfo", pageInfo);

		return "item/itemList";
	}

	@RequestMapping("/item/itemEnroll.do")
	public String itemEnroll(Model model) {
		System.out.println("itemEnroll 페이지");
		return "item/itemEnroll";
	}

	@RequestMapping("/item/interest.do")
	public String interest(Model model, HttpSession session, String currentPage) {
		System.out.println("insert 페이지");
		System.out.println("currentPage: " + currentPage);
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember != null) {
			if (currentPage == null) {
				currentPage = "1";
			}
			int accIndex = loginMember.getAcc_index();
			int currentPage_ = Integer.parseInt(currentPage);

			PageInfo pageInfo = service.interestItem(currentPage_, accIndex);
			List<ItemDTO> interestitemList = pageInfo.getDtoContainer2();
			System.out.println("controller  : " + interestitemList);
			model.addAttribute("interestitemList", interestitemList);
			model.addAttribute("pageInfo", pageInfo);

		} else {
			return "account/login";
		}
		return "item/interest";
	}

	@RequestMapping("/item/deleteInterest.do")
	public String deleteInterest(@RequestParam("itemId") int itemId, HttpSession session, Model model) {
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		int accIndex = loginMember.getAcc_index();
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("accIndex", accIndex);
		params.put("itemId", itemId);
		boolean isDeleted = service.deleteInterestItem(params);
		System.out.println(isDeleted);
		if (isDeleted) {
			List<ItemDTO> interestItemList = service.interestItem(accIndex);
			model.addAttribute("interestItemList", interestItemList);
		} else {
			// 삭제 실패 시 처리 로직 추가
			model.addAttribute("error", "삭제 실패");
		}

		return "redirect:/item/interest.do";
	}
}
