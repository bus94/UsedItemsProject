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

	// 물품 등록 페이지
	@RequestMapping("/item/itemEnroll.do")
	public String itemEnroll(Model model) {
		return "item/itemEnroll";
	}

	// 물품 등록 확인
	@RequestMapping("/item/itemEnrollOK.do")
	public String itemEnroll(Model model, HttpSession session, String item_title, String item_content,
			String item_category, int item_price, String item_place, String addressX, String addressY,
			String place_name, MultipartHttpServletRequest item_image, MultipartHttpServletRequest item_thumb) {

		// 로그인 객체
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");

		// 등록한 썸네일 파일 저장
		MultipartFile show_thumb = item_thumb.getFile("item_thumb");

		// 등록한 이미지 파일 리스트 저장
		List<MultipartFile> list = item_image.getFiles("item_image");

		ItemInfoDTO enrollItemInfo = new ItemInfoDTO();

		// ===== 파일 업로드 처리 로직 ===== 조건: 썸네일 파일과 이미지 파일이 각각 한 개 이상의 파일을 저장해야한다!

		// 썸네일 파일 또는 이미지 파일 리스트가 비어있는 경우
		if (show_thumb.isEmpty() || list.isEmpty()) {
			model.addAttribute("msg", "파일이 존재하지 않거나 업로드에 실패하였습니다.");
			model.addAttribute("location", "/item/itemEnroll.do");
			return "common/msg";
		}

		try {
			int loginMemberIndex = loginMember.getAcc_index();

			// 등록한 물품의 이미지 파일을 저장하는 폴더명
			// ex) 로그인한 아이디의 식별번호\\item_등록하는 물품의 식별번호
			// itemEnrollService.selectItemIndex() + 1 : 현재 등록되어있는 물품의 개수를 불러와서 1을 더한다.
			// ∵ 아직 등록 전이기 때문에 등록하는 물품의 식별번호가 없기 때문.
			String itemFolderName = loginMemberIndex + "\\item_" + (itemEnrollService.selectItemIndex() + 1);

			// itemFolderName으로 저장한 폴더 기준으로 업로드 위치 지정
			String uploadFolder = "C:\\UsedItemsProject\\UsedItems\\src\\main\\webapp\\resources\\img\\"
					+ itemFolderName;

			// 디렉토리 존재 여부 확인 후 없으면 생성
			File directory = new File(uploadFolder);
			if (!directory.exists()) {
				directory.mkdirs();
			}

			for (int i = 0; i < list.size(); i++) {
				// 파일명 가져오기
				// 파일 업로드 요청에서 가져온 파일 리스트의 i번째 파일의 이름을 저장
				String fileRealName = list.get(i).getOriginalFilename();
				// 파일 사이즈 확인
				// long size = list.get(i).getSize();
				// 현재 최대 저장 가능한 사이즈: 20971520바이트(20MB) → root-context.xml 참고

				// 파일이 저장되는 위치를 나타내는 객체 생성
				File saveFile = new File(uploadFolder + File.separator + fileRealName);

				// 실제 파일 저장 메서드
				// transferTo(): File 객체에 지정된 위치에 파일을 저장하는 역할
				list.get(i).transferTo(saveFile);
			}
			// 썸네일 파일명 새로 지정 (썸네일과 이미지 파일을 구분하기 위함)
			String thumbFileRealName = "thumbnail_" + show_thumb.getOriginalFilename();
			// 썸네일 파일 저장 메서드
			File saveThumbFile = new File(uploadFolder + File.separator + thumbFileRealName);
			show_thumb.transferTo(saveThumbFile);

			// 화면에 띄울 물품 정보를 저장
			enrollItemInfo.setItem_seller(loginMemberIndex);
			enrollItemInfo.setItem_title(item_title);
			enrollItemInfo.setItem_content(item_content);
			enrollItemInfo.setItem_category(item_category);
			enrollItemInfo.setItem_price(item_price);
			enrollItemInfo.setItem_place(parseAddress(item_place));
			enrollItemInfo.setItem_place_name(place_name);
			enrollItemInfo.setItem_place_address(item_place);
			// 물품 판매 장소 저장을 위한 위도, 경도 저장
			enrollItemInfo.setItem_placeX(addressX);
			enrollItemInfo.setItem_placeY(addressY);
			// 썸네일 파일명 저장
			enrollItemInfo.setShow_thumb(thumbFileRealName);
			// 이미지 파일명 저장 (5개의 이미지 파일을 저장할 수 있고, 파일이 없을 경우 null로 저장)
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
				// 물품 등록을 완료했을 때
				model.addAttribute("msg", "상품 등록이 완료되었습니다.");
				model.addAttribute("location", "/item/itemEnroll.do");
			} else {
				// 물품 등록을 실패했을 때
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

	// 물품 수정 확인 (itemEdit.jsp에서 수정 확인)
	@RequestMapping("/item/itemUpdateOK.do")
	public String itemUpdate(Model model, HttpSession session, int item_index, String item_title, String item_content,
			String item_category, int item_price, String item_place, String addressX, String addressY,
			String place_name, MultipartHttpServletRequest item_image, MultipartHttpServletRequest item_thumb,
			boolean thumb_check, boolean img_check) {

		String thumbFileRealName = "";

		// 수정된 썸네일 파일 저장
		MultipartFile newThumb = item_thumb.getFile("item_thumb");

		// 수정된 이미지 파일 리스트 저장
		List<MultipartFile> list = item_image.getFiles("item_image");

		// 기존 Item 정보를 가져옴
		ItemInfoDTO existingItem = itemService.selectByItemIndex(item_index);

		// existingItem으로 저장한 폴더 기준으로 수정한 파일 업로드 위치 지정
		String uploadFolder = "C:\\UsedItemsProject\\UsedItems\\src\\main\\webapp\\resources\\img\\"
				+ existingItem.getItem_seller() + "\\item_" + existingItem.getItem_index();

		try {
			// 파일이 변경되면 check: true, 변경되지 않으면 check: false

			File directory = new File(uploadFolder);
			// 썸네일 파일이 변경된 경우 thumb_check: true → !thumb_check: false
			if (thumb_check) {
				// 썸네일 변경되었을 때 실행
				// 기존 썸네일 이미지 파일 삭제
				File oldThumbFile = new File(uploadFolder + File.separator + existingItem.getShow_thumb());
				if (oldThumbFile.exists()) {
					oldThumbFile.delete();
				}

				// 변경된 썸네일 파일 추가
				thumbFileRealName = "thumbnail_" + newThumb.getOriginalFilename();
				// 수정된 썸네일 파일 경로 지정
				File saveThumbFile = new File(uploadFolder + File.separator + thumbFileRealName);
				// 수정된 썸네일 파일 저장
				newThumb.transferTo(saveThumbFile);
				// existingItem의 기존 썸네일 파일명을 수정된 썸네일 파일명으로 변경
				existingItem.setShow_thumb(thumbFileRealName);
			}

			// 수정된 이미지 파일 저장 (썸네일 파일 제외한 이미지 파일)
			// 이미지 파일이 변경된 경우 img_check: true → !img_check: false
			if (img_check) {
				for (File file : directory.listFiles()) {
					// file이 디렉토리와 썸네일파일(thumbnail_ 문자를 포함하는 파일)이 아닌 경우에만 file을 삭제
					if (!file.isDirectory() && !file.getName().equals(existingItem.getShow_thumb())) {
						file.delete();
					}
				}

				// 이미지 파일을 저장하는 공간 5개를 기준으로 반복문 실행
				for (int i = 0; i < 5; i++) {
					if (i < list.size() && list.get(i) != null) {
						// 수정된 이미지 파일이 있다면 저장
						String fileRealName = list.get(i).getOriginalFilename();
						File saveFile = new File(uploadFolder + File.separator + fileRealName);
						list.get(i).transferTo(saveFile);

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
						// 수정된 이미지 파일이 없다면 null로 저장
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
				model.addAttribute("msg", "상품 수정이 완료되었습니다.");
				model.addAttribute("location", "/item/itemView?item_index=" + existingItem.getItem_index());
			} else {
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

	// 주소 기반 검색을 위한 주소를 저장하는 메서드
	public static String parseAddress(String fullAddress) {
		String result = "";

		if (fullAddress == null || fullAddress.isEmpty()) {
			return result;
		}

		// addressParts[0]: city 저장, addressParts[1]: district 저장
		String[] addressParts = fullAddress.split(" ");

		if (addressParts.length > 1) {
			if (addressParts[0].equals("서울") || addressParts[0].equals("인천")) {
				// ex) 서울특별시 또는 인천광역시의 경우

				// ex) 서울, 인천
				result += addressParts[0];
				// ex) 서초구, 서구 등
				result += " " + addressParts[1];
			} else if (addressParts[0].equals("경기")) {
				// ex) 경기도의 경우
				if (addressParts.length > 2) {
					// ex) 경기 수원시
					result = addressParts[0] + " " + addressParts[1];
					if (addressParts[2].endsWith("구") || addressParts[2].endsWith("군")) {
						// ex) 팔달구 등
						result += " " + addressParts[2];
					}
				}
			} else {
				// 그 외의 경우

				// ex) 시
				result = addressParts[0];
				// ex) 구
				result = addressParts[1];
			}
		}
		return result;
	}
}