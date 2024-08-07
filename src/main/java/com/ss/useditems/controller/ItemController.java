package com.ss.useditems.controller;

import java.util.Arrays;
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

	private PageInfo pageInfo;

	@RequestMapping("/item/itemList.do")
	public String itemList(Model model, String searchValue, String searchType, String[] categoryList,
			String currentPage) {
		System.out.println("itemList 페이지");
		System.out.println("currentPage: " + currentPage);
		
		List<String> categoryAllList = Arrays.asList("상의", "하의", "신발", "기타의류", "지갑", "피규어", "전자기기", "가구", "식품", "기타");
		model.addAttribute("categoryAllList", categoryAllList);

		try {
			// 처음 페이지를 들어갈 땐 현재 페이지를 1로 설정
			if (currentPage == null) {
				currentPage = "1";
			}

			System.out.println("불러온 searchType: " + searchType);
			System.out.println("불러온 categoryList: " + categoryList);

			// 체크박스에서 선택한 categoryList이 없다면 default로 설정
			if (categoryList == null || categoryList.length == 0) {
				categoryList = null;
			}

			// 불러온 searchType과 categoryList를 매핑
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("searchValue", searchValue);
			map.put("searchType", searchType);
			map.put("categoryList", categoryList);

			System.out.println("map: " + map);
			System.out.println("searchValue: " + searchValue);
			System.out.println("searchType: " + searchType);
			System.out.println("categoryList: " + Arrays.toString(categoryList));

			// String으로 불러온 현재 페이지를 int 타입으로 형변환
			int currentPage_ = Integer.parseInt(currentPage);

			System.out.println("=====switch 시작=====");

			if (searchType != null) {
				// searchType에 따른 switch문
				switch (searchType) {

				// 각각의 searchType에 따라 현재 페이지와 map을 매개변수로 넘긴다
				case "nearPlace":
					pageInfo = service.selectByNearPlace(currentPage_, map);
					break;

				case "popular":
					pageInfo = service.selectByPopular(currentPage_, map);
					break;

				case "bestSeller":
					pageInfo = service.selectByBestSeller(currentPage_, map);
					break;
				}
			} else {
				pageInfo = service.selectByDefault(currentPage_, map);
			}

			System.out.println("=====switch 끝=====");

			List<ItemDTO> itemList = pageInfo.getDtoContainer2();
			System.out.println("불러오는 itemList: " + itemList);

			model.addAttribute("itemList", itemList);
			model.addAttribute("categoryList", categoryList);
			model.addAttribute("searchValue", searchValue);
			model.addAttribute("pageInfo", pageInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}

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

	@RequestMapping("/common/test.do")
	public String test(Model model) {

		return "common/test";

	}
}

/*
 * // categoryList 문자열을 콤마로 분리하고 공백을 제거하여 List로 변환 String[] categoryArray =
 * categoryList.split(",");
 * 
 * Stream<String> categoriesStream =
 * Arrays.stream(categoryArray).map(String::trim); List<String> categoryListItem
 * = categoriesStream.collect(Collectors.toList());
 * 
 * System.out.println(categoryListItem);
 * 
 * // searchType과 categoryList를 Map에 저장 Map<String, Object> searchParams = new
 * HashMap<>(); searchParams.put("searchType", searchType);
 * searchParams.put("categoryList", categoryListItem);
 * System.out.println(searchParams);
 * 
 * PageInfo pageInfo = service.searchItems(currentPage_, categoryList);
 * 
 * model.addAttribute("itemList", pageInfo.getDtoContainer2());
 * model.addAttribute("pageInfo", pageInfo); model.addAttribute("searchParams",
 * searchParams);
 * 
 */