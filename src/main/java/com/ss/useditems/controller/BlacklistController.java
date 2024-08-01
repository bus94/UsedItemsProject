package com.ss.useditems.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ss.useditems.dto.BlacklistDTO;
import com.ss.useditems.service.BlacklistService;

@RequestMapping("/blacklist")
@Controller
public class BlacklistController {

	@Autowired
	private BlacklistService service;

	@GetMapping("/complainList.do")
	public String complainList(Model model, @RequestParam Map<String, String> param) {
		System.out.println("==blacklist.complainList==");
//		System.out.println("param: " + param); 7/22수업내용

		Map<String, String> queryMap = new HashMap<String, String>();
		
		try {
			String searchValue = param.get("searchValue");
			if (searchValue != null && searchValue.length() > 0) {
				String searchType = param.get("searchType");
				queryMap.put(searchType, searchValue);
			}
		} catch (Exception e) {}

		
		try {
			String black_object = param.get("black_object");
			if (black_object != null && black_object != "") {
				queryMap.put("black_object", black_object);
			}
		} catch (Exception e) {}
		
		
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(param.get("currentPage"));
		} catch (Exception e) {}
		
		
		System.out.println("queryMap: " + queryMap);
		System.out.println("currentpage: " + currentPage);

		
		List<BlacklistDTO> blacklist =  service.getBlacklist(currentPage, queryMap);
		//페이징작업은 service에서!!!!
		model.addAttribute("blacklist", blacklist);
		
		return "blacklist/complainList";
	}

	@GetMapping("/complain.do")
	public String complain(Model model) {
		System.out.println("==blacklist.complain==");

		// 신고페이지

		return "blacklist/complain";
	}

	@PostMapping("/complainPro.do")
	public String complainPro(Model model) {
		System.out.println("==blacklist.complainPro==");

		// 신고 처리 후 사기조회페이지로 이동

		return "blacklist/complainList";
	}

}
