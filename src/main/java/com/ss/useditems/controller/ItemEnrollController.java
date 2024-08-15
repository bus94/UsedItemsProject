package com.ss.useditems.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ss.useditems.dto.ItemInfoDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.service.ItemEnrollService;

@Controller
public class ItemEnrollController {

	@Autowired
	private ItemEnrollService itemEnrollService;

	@RequestMapping("/item/itemEnrollOK.do")
	public String itemEnroll(Model model, HttpSession session, String item_title, String item_content,
			String item_category, int item_price, String item_place, String addressX, String addressY, MultipartHttpServletRequest item_image,
			MultipartHttpServletRequest item_thumb) {
		System.out.println("itemEnroll() 실행");

		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");

		List<MultipartFile> list = item_image.getFiles("item_image");

		MultipartFile show_thumb = item_thumb.getFile("item_thumb");

		// 파일 업로드 처리 로직
		if (list.isEmpty() || show_thumb.isEmpty()) {
			model.addAttribute("msg", "파일이 존재하지 않거나 업로드에 실패하였습니다.");
			model.addAttribute("location", "/item/itemEnroll.do");
			return "common/msg";
		}

		try {
			int loginMemberIndex = loginMember.getAcc_index();
			System.out.println("selectItemSeq_curr(): " + (itemEnrollService.selectItemIndex() +1));
			String itemFolderName = loginMemberIndex + "\\item_" + (itemEnrollService.selectItemIndex() + 1);
			
			// 업로드 위치 지정
			String uploadFolder = "C:\\UsedItemsProject\\UsedItems\\src\\main\\webapp\\resources\\img\\"
					+ itemFolderName;
			System.out.println("uploadFolder: " + uploadFolder);

			// 디렉토리 존재 여부 확인 후 없으면 생성
			File directory = new File(uploadFolder);
			if (!directory.exists()) {
				directory.mkdirs();
			}

			for (int i = 0; i < list.size(); i++) {
				// 파일명 가져오기
				String fileRealName = list.get(i).getOriginalFilename();
				// 파일 사이즈
				long size = list.get(i).getSize();
				System.out.println((i + 1) + ".파일명: " + fileRealName);
				System.out.println((i + 1) + ".파일 사이즈: " + size);

				File saveFile = new File(uploadFolder + File.separator + fileRealName);

				// 실제 파일 저장 메서드
				list.get(i).transferTo(saveFile);
				System.out.println((i + 1) + "번 파일 저장 성공!!");
			}
			String thumbFileRealName = "thumbnail_" + show_thumb.getOriginalFilename();
			System.out.println("thumbFileRealName: " + thumbFileRealName);
			File saveThumbFile = new File(uploadFolder + File.separator + thumbFileRealName);
			show_thumb.transferTo(saveThumbFile);
			System.out.println("썸네일 저장 성공!!");

			ItemInfoDTO enrollItemInfo = new ItemInfoDTO();
			enrollItemInfo.setItem_seller(loginMemberIndex);
			enrollItemInfo.setItem_title(item_title);
			enrollItemInfo.setItem_content(item_content);
			enrollItemInfo.setItem_category(item_category);
			enrollItemInfo.setItem_price(item_price);
			enrollItemInfo.setItem_place(item_place);
			enrollItemInfo.setItem_placeX(addressX);
			enrollItemInfo.setItem_placeY(addressY);
			enrollItemInfo.setShow_thumb(thumbFileRealName);
			if (list.get(0) != null) {
				enrollItemInfo.setShow_img1(list.get(0).getOriginalFilename());
			} else if (list.get(1) != null) {
				enrollItemInfo.setShow_img2(list.get(1).getOriginalFilename());
			} else if (list.get(2) != null) {
				enrollItemInfo.setShow_img3(list.get(2).getOriginalFilename());
			} else if (list.get(3) != null) {
				enrollItemInfo.setShow_img4(list.get(3).getOriginalFilename());
			} else if (list.get(4) != null) {
				enrollItemInfo.setShow_img5(list.get(4).getOriginalFilename());
			}

			if (itemEnrollService.enrollItem(enrollItemInfo) > 0) {

				System.out.println("enrollItem 실행성공");
				System.out.println("성공한 enrollItemInfo: " + enrollItemInfo);
				model.addAttribute("msg", "상품 등록이 완료되었습니다.");
				model.addAttribute("location", "/item/itemEnroll.do");
			} else {
				System.out.println("enrollItem 실행실패");
				System.out.println("실패한 enrollItem: " + enrollItemInfo);
				model.addAttribute("msg", "상품을 다시 입력해주세요.");
				model.addAttribute("location", "/item/itemEnroll.do");
			}

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "파일 업로드 중 오류가 발생하였습니다.");
			model.addAttribute("location", "/item/itemEnroll.do");
			return "common/msg";
		}

		return "common/msg";
	}

}
