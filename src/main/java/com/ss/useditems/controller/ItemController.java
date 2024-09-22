package com.ss.useditems.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ss.useditems.dto.ItemInfoDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.service.ItemService;
import com.ss.useditems.util.PageInfo;

@Controller
public class ItemController {

	@Autowired
	private ItemService service;

	private PageInfo pageInfo;

	// 물품 리스트 페이지
	@RequestMapping("/item/itemList.do")
	public String itemList(Model model, String searchValue, String searchType, String[] categoryList,
			String currentPage, HttpSession session) {

		// 기본 카테고리 셋팅
		List<String> categoryAllList = Arrays.asList("상의", "하의", "신발", "기타의류", "지갑", "피규어", "전자기기", "가구", "식품", "기타");
		model.addAttribute("categoryAllList", categoryAllList);

		try {
			// 처음 페이지 들어갈 땐 현재 페이지를 1로 설정
			if (currentPage == null) {
				currentPage = "1";
			}

			// 불러온 searchType과 categoryList를 매핑
			Map<String, Object> map = new HashMap<String, Object>();
			// 검색어 (검색어 입력한 값)
			map.put("searchValue", searchValue);
			// 정렬 ("조회순", "매너등급순")
			map.put("searchType", searchType);
			// 카테고리 필터 ("상의", "하의", "신발", "기타의류", "지갑", "피규어", "전자기기", "가구", "식품", "기타")
			map.put("categoryList", categoryList);
			MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
			String loginMemberAddr = null;
			String[] searchAddress = null;

			// 로그인이 되어있는 경우
			if (loginMember != null) {
				// 주소 기반 검색을 위해 로그인한 아이디의 주소를 저장
				loginMemberAddr = parseAddress(loginMember.getAcc_address());
				searchAddress = searchAddress(loginMember.getAcc_addressX(), loginMember.getAcc_addressY());
			}
			map.put("address", loginMemberAddr);
			map.put("searchAddressList", searchAddress);

			// String으로 불러온 현재 페이지를 int 타입으로 형변환
			int currentPage_ = Integer.parseInt(currentPage);

			// searchType에 따른 switch문
			if (searchType != null) {
				// 각각의 searchType에 따라 현재 페이지와 map을 매개변수로 넘긴다
				switch (searchType) {
				// 조회순
				case "popular":
					pageInfo = service.selectByPopular(currentPage_, map);
					break;
				// 매너등급순
				case "bestSeller":
					pageInfo = service.selectByBestSeller(currentPage_, map);
					break;
				// searchType이 없을 때
				default:
					pageInfo = service.selectByDefault(currentPage_, map);
					break;
				}
			} else {
				pageInfo = service.selectByDefault(currentPage_, map);
			}

			// 페이지네이션 itemList 불러오기
			List<ItemInfoDTO> itemList = pageInfo.getDtoContainerInfo();
			// 이미지 파일 경로 불러오기
			String filePath;
			for (int i = 0; i < itemList.size(); i++) {
				filePath = itemList.get(i).getItem_seller() + "/item_" + itemList.get(i).getItem_index() + "/";
				itemList.get(i).setItem_thumbPath(filePath + itemList.get(i).getShow_thumb());
				itemList.get(i).setItem_img1Path(filePath + itemList.get(i).getShow_img1());
				itemList.get(i).setItem_img2Path(filePath + itemList.get(i).getShow_img2());
				itemList.get(i).setItem_img3Path(filePath + itemList.get(i).getShow_img3());
				itemList.get(i).setItem_img4Path(filePath + itemList.get(i).getShow_img4());
				itemList.get(i).setItem_img5Path(filePath + itemList.get(i).getShow_img5());
			}
			model.addAttribute("itemList", itemList);
			model.addAttribute("searchValue", searchValue);
			model.addAttribute("searchType", searchType);
			model.addAttribute("categoryList", categoryList);
			model.addAttribute("pageInfo", pageInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "item/itemList";
	}

	// 근처 지역 주소 반환 리스트 메서드
	private String[] searchAddress(String acc_addressX, String acc_addressY) {
		Map<String, String> params = new HashMap<String, String>();
		// 경도, 위도 저장
		params.put("acc_addressX", acc_addressX);
		params.put("acc_addressY", acc_addressY);

		// haversine 공식을 이용하여 반경 700m 지역 저장
		List<String> itemPlace = service.nearDistrict(params);
		// Set: 자바 컬렉션 프레임워크의 인터페이스로 중복된 요소를 허용하지 않는 자료구조 (순서 유지하지 않고, 각 요소가 유일해야함) / 빠른 조회 가능
		Set<String> addresses = new HashSet<>();
		for (String place : itemPlace) {
			addresses.add(place);
		}
		String[] result = addresses.toArray(new String[0]);
		return result;
	}

	// 관심 물품 페이지 (찜 목록)
	@RequestMapping("/item/interest.do")
	public String interest(Model model, HttpSession session, String currentPage) {
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember != null) {
			// 로그인 되어있는 경우
			if (currentPage == null) {
				currentPage = "1";
			}
			int accIndex = loginMember.getAcc_index();
			int currentPage_ = Integer.parseInt(currentPage);

			PageInfo pageInfo = service.interestItem(currentPage_, accIndex);
			List<ItemInfoDTO> interestitemList = pageInfo.getDtoContainerInfo();
			String filePath;
			for (int i = 0; i < interestitemList.size(); i++) {
				filePath = interestitemList.get(i).getItem_seller() + "/item_" + interestitemList.get(i).getItem_index()
						+ "/";
				interestitemList.get(i).setItem_thumbPath(filePath + interestitemList.get(i).getShow_thumb());
			}
			model.addAttribute("interestitemList", interestitemList);
			model.addAttribute("pageInfo", pageInfo);
		} else {
			// 로그인이 안되어 있는 경우 로그인 페이지로 이동
			return "account/login";
		}
		return "item/interest";
	}

	// 관심 물품 삭제
	@RequestMapping("/item/deleteInterest.do")
	public String deleteInterest(@RequestParam("itemId") int itemId, HttpSession session, Model model) {
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		int accIndex = loginMember.getAcc_index();
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("accIndex", accIndex);
		params.put("itemId", itemId);
		boolean isDeleted = service.deleteInterestItem(params);
		if (isDeleted) {
			// 삭제 성공 시
			List<ItemInfoDTO> interestItemList = service.interestItem(accIndex);
			model.addAttribute("interestItemList", interestItemList);
		} else {
			// 삭제 실패 시 처리 로직 추가
			model.addAttribute("error", "삭제 실패");
		}
		return "redirect:/item/interest.do";
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