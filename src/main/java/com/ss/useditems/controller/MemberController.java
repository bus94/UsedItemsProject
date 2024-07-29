package com.ss.useditems.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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

	// 업로드 메서드
	@GetMapping("/upload")
	public void form() {
	}

	@PostMapping("/uploadOK")
	public String upload(@RequestParam("file") MultipartFile file) {
		// 업로드한 파일명 가져오기
		String fileRealName = file.getOriginalFilename();
		// 파일 사이즈 (용량 클 수 있으므로 int가 아닌 long)
		long size = file.getSize();
		System.out.println("파일명: " + fileRealName);
		System.out.println("파일 크기: " + size);

		// 서버에 저장할 파일명으로 확장자명 지정
		String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."), fileRealName.length());
		String uploadFolder = "C:\\test\\upload";

		// 이미 존재한 파일일 경우를 대비
		UUID uuid = UUID.randomUUID();
		String[] uuids = uuid.toString().split("-");
		String uniqueName = uuids[0];

		// UUID 적용
		File saveFile = new File(uploadFolder + "\\" + uniqueName + fileExtension);
		try {
			// 실제 파일 저장 메서드
			file.transferTo(saveFile);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "account/login";
	}
	
	
	
	
	
	
	
	
	////////////////////////////////////정일/////////////////////
	
	@RequestMapping("/account/myinfo.do")
	public String myinfo(Model model) {
		System.out.println("==account.myinfo==");



		return "account/myinfo";
	}
	
	

}
