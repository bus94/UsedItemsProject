package com.ss.useditems.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ss.useditems.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	private MemberService service;
	
	@RequestMapping("/account/login.do")
	public String login(Model model) {
		System.out.println("login 페이지");
		return "account/login";
	}
	
	@RequestMapping("/account/signup.do")
	public String signup(Model model) {
		System.out.println("signup 페이지");
		return "account/signup";
	}
	
	@RequestMapping("/account/loginOK.do")
	public String loginOK(Model model) {
		System.out.println("loginOK 로그인 확인");
		
		// 로그인 확인 메서드 실행
		
		return "account/login";
	}
}
