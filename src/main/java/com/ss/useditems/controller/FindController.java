package com.ss.useditems.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.ss.useditems.service.FindService;

@Controller
public class FindController {

	@Autowired
	private FindService service;

	@PostMapping("/account/findId.do")
	public ResponseEntity<Map<String, String>> findId(@RequestBody Map<String, String> request) {
		System.out.println("findId() 실행");
		String name = request.get("name");
		String phone = request.get("phone");

		System.out.println("전송 받은 name: " + name);
		System.out.println("전송 받은 phone: " + phone);

		String checkId = service.findId(request);
		Map<String, String> response = new HashMap<String, String>();
		String msg = null;
		if (checkId == null || checkId.trim().isEmpty()) {
			System.out.println("못찾았습니다.");
			msg = "이름 또는 핸드폰 번호를 다시 확인해주세요.";
			response.put("msg", msg);
		} else {
			System.out.println("찾았습니다.");
			response.put("checkId", checkId);
		}
		System.out.println("checkId: " + checkId);
		System.out.println("msg: " + msg);

		return ResponseEntity.status(HttpStatus.OK).body(response);
	}

	@PostMapping("/account/findPw.do")
	public ResponseEntity<Map<String, String>> findPw(@RequestBody Map<String, String> request) {
		System.out.println("findPw() 실행");
		String id = request.get("id");
		String name = request.get("name");
		String phone = request.get("phone");

		System.out.println("전송 받은 id: " + id);
		System.out.println("전송 받은 name: " + name);
		System.out.println("전송 받은 phone: " + phone);

		String checkPw = "pw_test";
		System.out.println("checkPw: " + checkPw);
		Map<String, String> response = new HashMap<String, String>();

		if (checkPw == null || !checkPw.equals("") || checkPw.isEmpty()) {
			System.out.println("못찾았습니다.");
			String msg = "아이디, 이름, 핸드폰 번호를 다시 확인해주세요.";
			response.put("msg", msg);
		} else {
			System.out.println("찾았습니다.");
			response.put("checkId", checkPw);
		}

		return ResponseEntity.status(HttpStatus.OK).body(response);
	}
}
