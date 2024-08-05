package com.ss.useditems.controller;

import java.util.HashMap;
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
import com.ss.useditems.util.PageInfo;

@RequestMapping("/blacklist")
@Controller
public class BlacklistController {

	@Autowired
	private BlacklistService service;
	
	
	@RequestMapping("/mainProto1.do")
	public String mainProto1(Model model) {
	
		
		
		
		return "common/mainProto1";

	}
	

	@GetMapping("/complainList.do")		//신고목록 조회
	public String complainList(Model model, @RequestParam Map<String, String> param) {
		System.out.println("==blacklist.complainList==");
//		System.out.println("param: " + param); 7/22수업내용

//----------------------------쿼리 맵 만드는 작업----------------------------		
		Map<String, String> queryMap = new HashMap<String, String>();

		try {
			String searchBlack = param.get("searchBlack");
			if (searchBlack != null && searchBlack.length() > 0) {
				String searchType = param.get("searchType");
				queryMap.put(searchType, searchBlack);
			}
		} catch (Exception e) {
		}

//		try {
//			String black_object = param.get("black_object");
//			if (black_object != null && black_object != "") {
//				queryMap.put("black_object", black_object);
//			}
//		} catch (Exception e) {
//		}
//---------------------------------------------------------------------
//----------------------------현재 페이지와 쿼리맵 넘김----------------------------		
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(param.get("currentPage"));
		} catch (Exception e) {
		}

		System.out.println("queryMap: " + queryMap);
		System.out.println("currentpage: " + currentPage);
		
		//pagination 처리는 서비스에서!
		PageInfo pageInfo = new PageInfo();
		pageInfo = service.getBlacklist(currentPage, queryMap);
		
		
//---------------------------------------------------------------------
		model.addAttribute("blacklist", pageInfo.getDtoContainer());
		model.addAttribute("pageInfo", pageInfo);
		
		return "blacklist/complainList";
	}

	@GetMapping("/complain.do")		//신고 등록페이지
	public String complain(Model model, @RequestParam Map<String, String> param) {
		System.out.println("==blacklist.complain==");
		
		try {
			//url에 get타입 parameter로 "object_id"가 넘어오면 맵에 넣어주겠다.
			//String object_id을 직접 받도록 해두면, 
			//url에서 안 넘어올 시 받을게 없어서 에러가 남
			
			String object_id = param.get("object_id");
			model.addAttribute("object_id", object_id);

		} catch (Exception e) {	}
		return "blacklist/complain";
	}

	@PostMapping("/complainPro.do")		//신고 등록 처리
	public String complainPro(Model model, @RequestParam Map<String, String> param) {
		System.out.println("==blacklist.complainPro==");

		String subject_id = param.get("subject_id");
		String object_id = param.get("object_id");
		String black_content = param.get("black_content");
//		System.out.println(subject_id+"가 "+object_id+"를 신고함 "+black_content);
		
		BlacklistDTO complain = new BlacklistDTO();
		complain.setSubject_id(subject_id);
		complain.setObject_id(object_id);
		complain.setBlack_content(black_content);
		
		try {
		
//		int result = service.enroll(complain);
//		System.out.println("result: "+result);
		service.enroll(complain);
		model.addAttribute("msg", "신고글이 게시되었습니다");
		model.addAttribute("location", "/blacklist/complainList.do");
		
		} catch (Exception e){
			e.printStackTrace();
			model.addAttribute("msg", "오류로 인하여 신고가 정상적으로 처리되지 않았습니다.");
			model.addAttribute("location", "/blacklist/complainList.do");
		}
		return "common/msg";
	}


}
