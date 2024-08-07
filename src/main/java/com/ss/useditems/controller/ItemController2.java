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
import com.ss.useditems.service.ItemService2;
import com.ss.useditems.util.PageInfo;

@Controller
public class ItemController2 {

	//테스트서비스(ItemService2) 연결
	@Autowired
	private ItemService2 service2;

	
	private PageInfo pageInfo;

	@RequestMapping("/item/itemList2.do")
	public String itemList(Model model, String searchValue, String searchType, String[] categoryList,
			String currentPage) {
		System.out.println("!!!테스터: itemList2 페이지");
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
//					pageInfo = service2.selectByNearPlace(currentPage_, map);
						System.out.println("nearPlace of 테스트컨트롤러(2) searchType: " + searchType);
					break;

				case "popular":
//					pageInfo = service2.selectByPopular(currentPage_, map);
					System.out.println("popular of 테스트컨트롤러(2) searchType: " + searchType);

					break;

				case "bestSeller":
//					pageInfo = service2.selectByBestSeller(currentPage_, map);
					System.out.println("bestSeller of 테스트컨트롤러(2) searchType: " + searchType);

					break;
				}
			} else {
				pageInfo = service2.selectByDefault(currentPage_, map);
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

		return "item/itemList2";
	}

	
	
}
