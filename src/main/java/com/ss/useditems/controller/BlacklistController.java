package com.ss.useditems.controller;

import java.util.ArrayList;
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

	// 신고 목록 조회
	@GetMapping("/complainList.do")
	public String complainList(Model model, @RequestParam Map<String, String> param) {

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

		try {
			String subject_id = param.get("subject_id");
			if (subject_id != null && subject_id != "") {
				queryMap.put("subject_id", subject_id);
			}
		} catch (Exception e) {
		}

//----------------------------현재 페이지와 쿼리맵 넘김----------------------------
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(param.get("currentPage"));
		} catch (Exception e) {
		}

		// pagination 처리는 서비스에서!
		PageInfo pageInfo = new PageInfo();
		pageInfo = service.getBlacklist(currentPage, queryMap);

		model.addAttribute("blacklist", pageInfo.getDtoContainer());
		model.addAttribute("pageInfo", pageInfo);

		return "blacklist/complainList";
	}

	// 신고 등록 페이지
	@GetMapping("/complain.do")
	public String complain(Model model, @RequestParam Map<String, String> param) {
		// URL을 통해 object_id의 넘어올 값이 없는 경우에 대한 예외처리
		// ->
		
		// try 실행하여 param Map에 "object_id"가 넘어오는 경우 신고대상자 ID 자동 입력
		// 매개변수가 넘어오지 않는 경우 신고대상자 ID 공란(직접 입력)
		
		// 매개변수로 String object_id를 직접 받는 경우, 매개변수가 넘어오지 않을 경우 에러 발생
		try {
			String object_id = param.get("object_id");
			model.addAttribute("object_id", object_id);
		} catch (Exception e) {
		}
		return "blacklist/complain";
	}

	// 신고 등록
	@PostMapping("/complainPro.do") 
	public String complainPro(Model model, @RequestParam Map<String, String> param) {

		BlacklistDTO complain = new BlacklistDTO();
		complain.setSubject_id(param.get("subject_id"));
		complain.setObject_id(param.get("object_id"));
		complain.setBlack_content(param.get("black_content"));

		try {
			service.enroll(complain);
			model.addAttribute("msg", "신고글이 게시되었습니다");
			model.addAttribute("location", "/blacklist/complainList.do");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "오류로 인하여 신고가 정상적으로 처리되지 않았습니다." + "\\r\\n" + "아이디를 확인하여 주시기 바랍니다.");
			model.addAttribute("location", "/blacklist/complainList.do");
		}
		return "common/msg";
	}

	// 신고 삭제
	@GetMapping("/complainDel.do") 
	public String complainDel(Model model, @RequestParam String black_index) {
		try {
			int result = service.delete(black_index);
			if (result > 0) {
				model.addAttribute("msg", "게시글이 삭제되었습니다.");
				model.addAttribute("location", "/blacklist/complainList.do");
			} else {
				//System.out.println("blacklist.complainDel_result <= 0");
				model.addAttribute("msg", "오류로 인하여 삭제가 정상적으로 처리되지 않았습니다.");
				model.addAttribute("location", "/blacklist/complainList.do");
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "오류로 인하여 삭제가 정상적으로 처리되지 않았습니다.");
			model.addAttribute("location", "/blacklist/complainList.do");
		}
		return "common/msg";
	}


	
	/////////// arraylist 받아서 map으로 sql 집어넣기 test
	@GetMapping("/testNull.do")
	public String testNull() {
		ArrayList<String> strlist = new ArrayList<String>();
		service.testNull(strlist);

		return "blacklist/complain";
	}

	@GetMapping("/testarr1.do")
	public String testarr1() {
		ArrayList<String> strlist = new ArrayList<String>();
		strlist.add("testerSingle");
		service.testarr1(strlist);

		return "blacklist/complain";
	}

	@GetMapping("/testarr4.do")
	public String testarr4() {
		ArrayList<String> strlist = new ArrayList<String>();
		strlist.add("tester1");
		strlist.add("tester2");
		strlist.add("tester3");
		strlist.add("tester4");
		service.testarr4(strlist);

		return "blacklist/complain";
	}

}
