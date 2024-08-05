package com.ss.useditems.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.ss.useditems.dto.ItemDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.service.ItemEnrollService;

@Controller
public class ItemEnrollController {

	@Autowired
	private ItemEnrollService itemEnrollService;

	@RequestMapping("/item/itemEnrollOK.do")
	public String itemEnroll(Model model, HttpSession session, String item_title, String item_content,
			String item_category, int item_price, String item_place, MultipartFile item_image) {
		System.out.println("itemEnroll() 실행");
		
		System.out.println("MultipartFile의 item_image 이름: " + item_image);

		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");

		// 파일 업로드 처리 로직
		if (item_image.isEmpty()) {
			model.addAttribute("msg", "파일이 존재하지 않거나 업로드에 실패하였습니다.");
			model.addAttribute("location", "/item/itemEnroll.do");
			return "common/msg";
		}

		String fileRealName = item_image.getOriginalFilename();
		long size = item_image.getSize();

		// 서버에 저장할 파일명으로 확장자명 지정하기
		String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."));
		String uploadFolder = "C:\\test\\upload";

		// 디렉토리 존재 여부 확인 후 없으면 생성
		File directory = new File(uploadFolder);
		if (!directory.exists()) {
			directory.mkdirs();
		}

		// UUID 적용하여 고유 파일명 생성하기
		String uniqueName = UUID.randomUUID().toString();
		String saveFileName = uniqueName + fileExtension;
		System.out.println("saveFileName 이름: " + saveFileName);
		File saveFile = new File(uploadFolder + "\\" + saveFileName);

		try {
			// 실제 파일 저장 메서드
			item_image.transferTo(saveFile);
		} catch (IllegalStateException e) {
			e.printStackTrace();
			model.addAttribute("msg", "파일 업로드 중 오류가 발생하였습니다.");
			model.addAttribute("location", "/item/itemEnroll.do");
			return "common/msg";
		} catch (IOException e) {
			e.printStackTrace();
			model.addAttribute("msg", "파일 업로드 중 오류가 발생하였습니다.");
			model.addAttribute("location", "/item/itemEnroll.do");
			return "common/msg";
		}

		ItemDTO enrollItem = new ItemDTO();
		enrollItem.setItem_title(item_title);
		enrollItem.setItem_content(item_content);
		enrollItem.setItem_category(item_category);
		enrollItem.setItem_price(item_price);
		enrollItem.setItem_place(item_place);
		enrollItem.setItem_image(saveFileName);
		enrollItem.setItem_seller(loginMember.getAcc_index());

		if (itemEnrollService.itemEnroll(enrollItem) > 0) {

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

}
