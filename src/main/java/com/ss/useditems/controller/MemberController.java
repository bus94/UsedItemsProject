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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.service.MemberService;

// 모델에 저장이 될 때 밑에  loginMember 자동으로 세션에 저장
@SessionAttributes("loginMember")
@Controller
public class MemberController {
	@Autowired
	private MemberService memberservice;

	@RequestMapping("/account/login.do")
	public String login(Model model) {
		return "account/login";
	}

	@RequestMapping("/account/signup.do")
	public String signup(Model model) {
		return "account/signup";
	}

	@RequestMapping("/account/loginOK.do")
	public String loginOK(Model model, String acc_id, String acc_password) {
		System.out.println("loginOK 로그인 확인");
		
		System.out.println("입력한 acc_id: " + acc_id);
		System.out.println("입력한 acc_password: " + acc_password);
		
		MemberDTO loginMember = new MemberDTO();
		loginMember.setAcc_id(acc_id);
		loginMember.setAcc_password(acc_password);
		
		System.out.println("불러오기 전 loginMember: " + loginMember);
		
		loginMember = memberservice.selectByMember(loginMember);
		if(loginMember != null) {
			model.addAttribute("msg", "정상적으로 로그인 되었습니다.");
			model.addAttribute("location", "/");
		} else {
			loginMember = null;
			model.addAttribute("msg", "로그인에 실패하였습니다. 다시 로그인 해주세요.");
			model.addAttribute("location", "/account/login.do");
		}
		model.addAttribute("loginMember", loginMember);
		
		System.out.println("불러오기 후 loginMember: " + loginMember);

		return "common/msg";
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
	
	@RequestMapping("/account/my_info.do")
	public String my_info(Model model) {
		System.out.println("==account.my_info==");

		
		
		
		
		return "account/info";
	}
	
	
	
	@RequestMapping("/account/acc_info.do")
	public String acc_info(Model model) {
		System.out.println("==account.acc_info==");

		
		
		
		
		return "account/info";
	}
	
	
	
	
	
	
	
	@RequestMapping("/account/alter.do")
	public String alter(Model model) {
		System.out.println("==account.alter==");

		return "account/alter";
	}


}
