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
import com.ss.useditems.service.ItemViewService;

@Controller
public class ItemEnrollController {

	@Autowired
	private ItemEnrollService itemEnrollService;
	@Autowired
	private ItemViewService itemService;

	@RequestMapping("/item/itemEnrollOK.do")
	public String itemEnroll(Model model, HttpSession session, String item_title, String item_content,
			String item_category, int item_price, String item_place, String addressX, String addressY, String place_name,
			MultipartHttpServletRequest item_image, MultipartHttpServletRequest item_thumb) {
		System.out.println("itemEnroll() 실행");

		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");

		List<MultipartFile> list = item_image.getFiles("item_image");

		MultipartFile show_thumb = item_thumb.getFile("item_thumb");

		ItemInfoDTO enrollItemInfo = new ItemInfoDTO();
		// 파일 업로드 처리 로직
		if (list.isEmpty() || show_thumb.isEmpty()) {
			model.addAttribute("msg", "파일이 존재하지 않거나 업로드에 실패하였습니다.");
			model.addAttribute("location", "/item/itemEnroll.do");
			return "common/msg";
		}

		try {
			int loginMemberIndex = loginMember.getAcc_index();
			System.out.println("selectItemSeq_curr(): " + (itemEnrollService.selectItemIndex() + 1));
			String itemFolderName = loginMemberIndex + "\\item_" + (itemEnrollService.selectItemIndex() + 1);
			System.out.println(itemFolderName);
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

			enrollItemInfo.setItem_seller(loginMemberIndex);
			enrollItemInfo.setItem_title(item_title);
			enrollItemInfo.setItem_content(item_content);
			enrollItemInfo.setItem_category(item_category);
			enrollItemInfo.setItem_price(item_price);
			enrollItemInfo.setItem_place(parseAddress(item_place));
			enrollItemInfo.setItem_place_name(place_name);
			enrollItemInfo.setItem_place_address(item_place);
			
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

	@RequestMapping("/item/itemUpdateOK.do")
	public String itemUpdate(Model model, HttpSession session, int item_index, String item_title, String item_content,
			String item_category, int item_price, String item_place, String addressX, String addressY,String place_name,
			MultipartHttpServletRequest item_image, MultipartHttpServletRequest item_thumb, boolean thumb_check,boolean img_check) {
		System.out.println("itemUpdate() 실행");
		System.out.println("item_index: " + item_index);

		String thumbFileRealName = "";

		List<MultipartFile> list = item_image.getFiles("item_image");

		MultipartFile newThumb = item_thumb.getFile("item_thumb");

		// 기존 Item 정보를 가져옴
		ItemInfoDTO existingItem = itemService.selectByItemIndex(item_index);

		String uploadFolder = "C:\\UsedItemsProject\\UsedItems\\src\\main\\webapp\\resources\\img\\"
				+ existingItem.getItem_seller() + "\\item_" + existingItem.getItem_index();
		System.out.println(uploadFolder);
		try {
			// 썸네일이 변경되면 check: false, 변경되지않으면 check: true
			System.out.println("check: " + thumb_check);

			File directory = new File(uploadFolder);
			// 썸네일이 변경된 경우 (check: false → !check: true)
			if (thumb_check) {
				System.out.println("썸네일 변경되는 경우 실행!");

				// 기존 썸네일 이미지 파일 삭제
				File oldThumbFile = new File(uploadFolder + File.separator + existingItem.getShow_thumb());
				System.out.println("Deleting file at path: " + oldThumbFile.getAbsolutePath());
				if (oldThumbFile.exists()) {
					oldThumbFile.delete();
				}

				// 변경된 썸네일 파일 추가
				thumbFileRealName = "thumbnail_" + newThumb.getOriginalFilename();
				System.out.println("thumbFileRealName: " + thumbFileRealName);
				File saveThumbFile = new File(uploadFolder + File.separator + thumbFileRealName);
				newThumb.transferTo(saveThumbFile);
				existingItem.setShow_thumb(thumbFileRealName);
				System.out.println("썸네일 변경 및 저장 성공!");
			} 
			

			System.out.println("기존 이미지 파일 추가 내용 실행!");

			// 새로 저장하는 사진 파일
			if (img_check) {
				for (File file : directory.listFiles()) {
					System.out.println("else문의 file: " + file);
					// file이 디렉토리가 아니고, 썸네일파일(thumbnail_ 문자를 포함하는 파일)이 아닌 경우에만 file을 삭제
					if (!file.isDirectory() && !file.getName().equals(existingItem.getShow_thumb())) {            
						file.delete();        
					}
				}
				
				
				
				for (int i = 0; i < 5; i++) {
					if (i < list.size() && list.get(i) != null) {
						String fileRealName = list.get(i).getOriginalFilename();
						System.out.println((i + 1) + ".파일명: " + fileRealName);

						File saveFile = new File(uploadFolder + File.separator + fileRealName);
						list.get(i).transferTo(saveFile);
						System.out.println((i + 1) + "번 파일 저장 성공!!");

						switch (i) {
						case 0:
							existingItem.setShow_img1(fileRealName);
							break;
						case 1:
							existingItem.setShow_img2(fileRealName);
							break;
						case 2:
							existingItem.setShow_img3(fileRealName);
							break;
						case 3:
							existingItem.setShow_img4(fileRealName);
							break;
						case 4:
							existingItem.setShow_img5(fileRealName);
							break;
						}
					} else {
						switch (i) {
						case 0:
							existingItem.setShow_img1(null);
							break;
						case 1:
							existingItem.setShow_img2(null);
							break;
						case 2:
							existingItem.setShow_img3(null);
							break;
						case 3:
							existingItem.setShow_img4(null);
							break;
						case 4:
							existingItem.setShow_img5(null);
							break;
						}
					}
				}
			}
			// 기존 아이템 정보를 업데이트
			existingItem.setItem_title(item_title);
			existingItem.setItem_content(item_content);
			existingItem.setItem_category(item_category);
			existingItem.setItem_price(item_price);
			existingItem.setItem_place(parseAddress(item_place));
			existingItem.setItem_place_address(item_place);
			existingItem.setItem_place_name(place_name);
			existingItem.setItem_placeX(addressX);
			existingItem.setItem_placeY(addressY);
			existingItem.setShow_thumb(thumbFileRealName);

			// 업데이트 DB 작업 수행
			if (itemEnrollService.updateItem(existingItem, thumb_check, img_check) > 0) {
				System.out.println("itemUpdate 실행 성공");
				model.addAttribute("msg", "상품 수정이 완료되었습니다.");
				model.addAttribute("location", "/item/itemView?item_index=" + existingItem.getItem_index());
			} else {
				System.out.println("itemUpdate 실행 실패");
				model.addAttribute("msg", "상품을 다시 수정해주세요.");
				model.addAttribute("location", "/item/itemEdit.do?item_index=" + existingItem.getItem_index());
			}

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "파일 업로드 중 오류가 발생하였습니다.");
			model.addAttribute("location", "/item/itemEdit.do?item_index=" + existingItem.getItem_index());
			return "common/msg";
		}

		return "common/msg";
	}

	public static String parseAddress(String fullAddress) {
		String result = "";// [0]: city, [1]: district

		if (fullAddress == null || fullAddress.isEmpty()) {
			return result;
		}

		String[] addressParts = fullAddress.split(" ");

		if (addressParts.length > 1) {
			if (addressParts[0].equals("서울") || addressParts[0].equals("인천")) {
				// 서울특별시 또는 인천광역시의 경우
				result += addressParts[0]; // 서울, 인천
				result += " " + addressParts[1]; // 서초구, 서구 등
			} else if (addressParts[0].equals("경기")) {
				// 경기도의 경우
				if (addressParts.length > 2) {
					result = addressParts[0] + " " + addressParts[1]; // 경기 수원시
					if (addressParts[2].endsWith("구") || addressParts[2].endsWith("군")) {
						result += " " + addressParts[2]; // 팔달구 등
					}
				}
			} else {
				// 그 외 다른 경우
				result = addressParts[0]; // 시
				result = addressParts[1]; // 구
			}
		}

		return result;
	}
}