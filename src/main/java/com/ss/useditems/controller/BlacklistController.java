package com.ss.useditems.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
			String searchBlack = param.get("searchBlack");
			if (searchBlack != null && searchBlack.length() > 0) {
				String searchType = param.get("searchType");
				queryMap.put(searchType, searchBlack);
			}
		} catch (Exception e) {
		}

		try {
			String black_object = param.get("black_object");
			if (black_object != null && black_object != "") {
				queryMap.put("black_object", black_object);
			}
		} catch (Exception e) {
		}

		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(param.get("currentPage"));
		} catch (Exception e) {
		}

		System.out.println("queryMap: " + queryMap);
		System.out.println("currentpage: " + currentPage);

		List<BlacklistDTO> blacklist = service.getBlacklist(currentPage, queryMap);
		// 페이징작업은 service에서!!!!
		model.addAttribute("blacklist", blacklist);

		return "blacklist/complainList";
	}

	@GetMapping("/complain.do")
	public String complain(Model model, @RequestParam Map<String, String> param) {
		System.out.println("==blacklist.complain==");
		
		try {
			//url에 get타입 parameter로 "black_object"가 넘오오면 모델에 넣어주겠다.
			//String black_object을 직접 받도록 해두면, 
			//url에서 안 넘어올 시 받을게 없어서 에러가 남
			
			String black_object = param.get("black_object");
			model.addAttribute("black_object", black_object);

		} catch (Exception e) {
			
		}
		
		

		return "blacklist/complain";
	}

	@PostMapping("/complainPro.do")
	public String complainPro() {
		System.out.println("==blacklist.complainPro==");

		// 신고 처리 후 사기조회페이지로 이동

		return "blacklist/complainList";
	}


}
