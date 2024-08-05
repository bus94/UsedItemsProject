package com.ss.useditems.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ss.useditems.dto.ItemDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.service.ItemEnrollService;

@Controller
public class ItemEnrollController {

	@Autowired
	private ItemEnrollService itemEnrollService;

	@RequestMapping("/item/itemEnrollOK.do")
	public String itemEnroll(Model model, HttpSession session, String item_title, String item_content, String item_category, int item_price, String item_place, String item_image) {
		System.out.println("itemEnroll() 실행");
		
		System.out.println("item_title: " + item_title);
		System.out.println("item_content: " + item_content);
		System.out.println("item_category: " + item_category);
		System.out.println("item_price: " + item_price);
		System.out.println("item_place: " + item_place);
		System.out.println("item_image: " + item_image);
		
		ItemDTO enrollItem = new ItemDTO();
		enrollItem.setItem_title(item_title);
		enrollItem.setItem_content(item_content);
		enrollItem.setItem_category(item_category);
		enrollItem.setItem_price(item_price);
		enrollItem.setItem_place(item_place);
		enrollItem.setItem_image(item_image);
		
		System.out.println("enrollItem: " + enrollItem);
		
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		
		if(loginMember != null) {
			int loginMemberIndex = loginMember.getAcc_index();
			System.out.println("itemEnroll()에서 loginMemberIndex: " + loginMemberIndex);
			enrollItem.setItem_seller(loginMemberIndex);
			System.out.println("enrollItem.getItem_seller: " + enrollItem.getItem_seller());
		}
		
		if(itemEnrollService.itemEnroll(enrollItem) > 0) {
			System.out.println("itemEnroll 실행성공");
			System.out.println("성공한 enrollItem: " + enrollItem);
			model.addAttribute("msg", "상품 등록이 완료되었습니다.");
			model.addAttribute("location", "/item/itemEnroll.do");
		} else {
			System.out.println("itemEnroll 실행실패");
			System.out.println("실패한 enrollItem: " + enrollItem);
			model.addAttribute("msg", "상품을 다시 입력해주세요.");
			model.addAttribute("location", "/item/itemEnroll.do");
		}
		return "common/msg";
	}
	
	@PostMapping("/uploadOK")
	public String upload(@RequestParam("file") MultipartFile file, Model model) {
		// 업로드한 파일명 가져오기
		String fileRealName = file.getOriginalFilename();
		if(fileRealName == null || fileRealName.isEmpty()) {
			System.out.println("파일 존재x");
			model.addAttribute("msg", "파일이 존재하지 않거나 업로드에 실패하였습니다.");
			model.addAttribute("location", "/item/itemEnroll.do");
			return "common/msg";
		}
		
		 // 파일 사이즈 (용량 클 수 있으므로 int가 아닌 long) 
		long size = file.getSize();
		System.out.println("파일명: " + fileRealName); 
		System.out.println("파일 크기: " + size);
		 
		// 서버에 저장할 파일명으로 확장자명 지정
		String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."), fileRealName.length());
		String uploadFolder = "C:\\test\\upload";
		
		// 디렉토리 존재 여부 확인 후 없으면 생성
		File directory = new File(uploadFolder);
		if(!directory.exists()) {
			directory.mkdirs();
		}

		// UUID 적용
		String uniqueName = UUID.randomUUID().toString();
		File saveFile = new File(uploadFolder + "\\" + uniqueName + fileExtension);
		try {
			// 실제 파일 저장 메서드
			file.transferTo(saveFile);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "item/itemEnroll";
	}
}
