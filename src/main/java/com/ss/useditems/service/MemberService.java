package com.ss.useditems.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ss.useditems.dto.ItemInfoDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.mapper.MemberMapper;

@Service
public class MemberService {
	@Autowired
	private MemberMapper mapper;
	
	// 로그인 확인
	public MemberDTO loginOK(MemberDTO loginMember) {
		return mapper.loginOK(loginMember);
	}
	
	// ID로 조회
	public int selectById(String id) {
		return mapper.selectById(id);
	}

	// 회원가입
	public int signup(MemberDTO signupMember) {
		return mapper.signup(signupMember);
	}
	
	// acc_id로 조회 (타 이용자 정보 조회할 때)
	public MemberDTO selectInfoByAcc_id(String acc_id) {
		MemberDTO account_info = new MemberDTO();
		account_info = mapper.selectInfoByAcc_id(acc_id);
		
		// 개인 비공개정보는 메모리에서 삭제
		//account_info.setAcc_password(null);
		//account_info.setAcc_birthDate(null);
		//account_info.setAcc_status(null);
		//account_info.setAcc_enrollDate(null);
		
		return account_info;
	}

	// acc_id로 acc_index 조회
	public int selectIdIndex(String acc_id) {
		return mapper.selectIdIndex(acc_id);
	}

	// 프로필 수정
	public int updateProfile(MemberDTO loginMember, MultipartFile profile) throws Exception {
		// 저장 폴더 경로
		String fileDirPath = "C:\\UsedItemsProject\\UsedItems\\src\\main\\webapp\\resources\\img";
		fileDirPath += "\\" + loginMember.getAcc_index() + "\\profile";
		
		// 저장 폴더 객체 생성
		File fileDir = new File(fileDirPath);
		
		// 저장 폴더 없는 경우 생성
		if(!fileDir.exists()) {
			fileDir.mkdirs();	
		}
		
		String originalFileName = profile.getOriginalFilename();

		File newProfile = new File(fileDirPath+ "\\" + originalFileName);
		// 해당 경로에 프로필 파일 저장
		profile.transferTo(newProfile); 
		
		
		String acc_id = loginMember.getAcc_id();
		// DB에 originalFileName으로 저장
		return mapper.updateProfile(acc_id, originalFileName);
	}
	
	// 정보 수정 (비밀번호)
	public int updatePW(String acc_id, String neoPWconf_input) {
		return mapper.updatePW(acc_id, neoPWconf_input);
	}

	// 정보 수정 (닉네임)
	public int updateNickname(String acc_id, String nickname_input) {
		return mapper.updateNickname(acc_id, nickname_input);
	}

	// 정보 수정 (핸드폰 번호)
	public int updatePhone(String acc_id, String phone_input) {
		return mapper.updatePhone(acc_id, phone_input);
	}

	// 정보 수정 (이름, 생년월일, 주소)
	public int updateRedunds(String acc_id, String name_input, String birthDate_input, String address_input, String addressDetail_input,String addressX_input,String addressY_input) {
		return mapper.updateRedunds(acc_id, name_input, birthDate_input, address_input, addressDetail_input,addressX_input,addressY_input);
	}
	
	// 회원 탈퇴
	public int withdraw(String acc_id) {
		return mapper.withdraw(acc_id);
	}

	// 마이페이지 물품 조회 리스트 불러오기 (거래중, 판매내역, 구매내역)
	public Map<String, List<ItemInfoDTO>> getItemInfo(int acc_index) { 
		List<ItemInfoDTO> itemList = mapper.selectItemByAcc_index(acc_index);
		// 이미지 경로 불러오기
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

		// 거래 중
		List<ItemInfoDTO> ondealItem = new ArrayList<ItemInfoDTO>();
		// 판매 중
		List<ItemInfoDTO> onsaleItem = new ArrayList<ItemInfoDTO>();
		// 판매 내역
		List<ItemInfoDTO> soldItem = new ArrayList<ItemInfoDTO>();
		// 구매 내역
		List<ItemInfoDTO> boughtItem = new ArrayList<ItemInfoDTO>();

		for (int i = 0; i < itemList.size(); i++) {
			String checkStatus = itemList.get(i).getItem_status();
			int checkSeller = itemList.get(i).getItem_seller();
			int checkBuyer = itemList.get(i).getItem_buyer();
			
			if(checkStatus.equals("ondeal")) { 
				// 거래 중
				ondealItem.add(itemList.get(i));
			} else if(checkStatus.equals("onsale") && checkSeller == acc_index) { 
				// 판매 중
				onsaleItem.add(itemList.get(i));
			} else if (checkStatus.equals("donedeal") && checkSeller == acc_index) { 
				// 판매 내역
				soldItem.add(itemList.get(i));
			} else if (checkBuyer == acc_index) { 
				// 구매 내역
				boughtItem.add(itemList.get(i));
			}
		}
		
		Map<String, List<ItemInfoDTO>> result = new HashMap<String, List<ItemInfoDTO>>();
		//result.put("itemList", itemList);
		result.put("ondealItem", ondealItem);
		result.put("onsaleItem", onsaleItem);
		result.put("soldItem", soldItem);
		result.put("boughtItem", boughtItem);
		
		return result;
	}

	// 관심 물품 (찜 목록) 리스트 불러오기
	public List<ItemInfoDTO> getMyInterests(int acc_index) {
		List<ItemInfoDTO> my_Interests = mapper.selectInterestsByAcc_index(acc_index);
		// 이미지 경로 불러오기
		String filePath;
		for (int i = 0; i < my_Interests.size(); i++) {
			filePath = my_Interests.get(i).getItem_seller() + "/item_" + my_Interests.get(i).getItem_index() + "/";
			my_Interests.get(i).setItem_thumbPath(filePath + my_Interests.get(i).getShow_thumb());
			my_Interests.get(i).setItem_img1Path(filePath + my_Interests.get(i).getShow_img1());
			my_Interests.get(i).setItem_img2Path(filePath + my_Interests.get(i).getShow_img2());
			my_Interests.get(i).setItem_img3Path(filePath + my_Interests.get(i).getShow_img3());
			my_Interests.get(i).setItem_img4Path(filePath + my_Interests.get(i).getShow_img4());
			my_Interests.get(i).setItem_img5Path(filePath + my_Interests.get(i).getShow_img5());
		}

		return my_Interests;
	}
}