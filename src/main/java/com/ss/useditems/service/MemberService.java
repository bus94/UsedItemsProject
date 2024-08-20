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
	
	public MemberDTO selectByMember(MemberDTO loginMember) {
		System.out.println("MemberService의 selectByMember()");
		return mapper.selectByMember(loginMember);
	}
	
	public int selectById(String id) {
		System.out.println("MemberService의 selectById()");
		return mapper.selectById(id);
	}

	public int signup(MemberDTO signupMember) {
		System.out.println("MemberService의 signup()");
		return mapper.signup(signupMember);
	}
	
	
	public MemberDTO selectInfoByAcc_id(String acc_id) {     //정일_계정정보
		System.out.println("MemberService의 selectInfoByAcc_id()");
		
		MemberDTO account_info = new MemberDTO();
		account_info = mapper.selectInfoByAcc_id(acc_id);
		
		//개인 비공개정보는 메모리에서 삭제
		account_info.setAcc_password(null);
		account_info.setAcc_birthDate(null);
		account_info.setAcc_status(null);
		account_info.setAcc_enrollDate(null);
		
		return account_info;
	}

	public int selectIdIndex(String acc_id) {
		return mapper.selectIdIndex(acc_id);
	}

	public int updateProfile(MemberDTO loginMember, MultipartFile profile) throws Exception {
		//정일_계정정보수정_프로필이미지
		
		String fileDirPath = "C:\\UsedItemsProject\\UsedItems\\src\\main\\webapp\\resources\\img";
		fileDirPath += "\\" + loginMember.getAcc_index() + "\\profile";//저장폴더 경로
		//System.out.println(fileDirPath);
		
		File fileDir = new File(fileDirPath);//저장폴더 객체 생성
		
		if(!fileDir.exists()) {
			fileDir.mkdirs();	//저장폴더 생성
		}
		
		String originalFileName = profile.getOriginalFilename();

		File newProfile = new File(fileDirPath+ "\\" + originalFileName);
		profile.transferTo(newProfile); //해당 경로에 프로필 파일 저장
		
		
		String acc_id = loginMember.getAcc_id();
		//DB에 originalFileName 값으로 저장
		return mapper.updateProfile(acc_id, originalFileName);
	}
	
	public int updatePW(String acc_id, String neoPWconf_input) {	//정일_계정정보수정_비밀번호
		return mapper.updatePW(acc_id, neoPWconf_input);
	}

	public int updateNickname(String acc_id, String nickname_input) {	//정일_계정정보수정_별명
		System.out.println("servece.nick");
		return mapper.updateNickname(acc_id, nickname_input);
	}

	public int updatePhone(String acc_id, String phone_input) {		//정일_계정정보수정_전화번호
		return mapper.updatePhone(acc_id, phone_input);
	}

	public int updateRedunds(String acc_id, String name_input, String birthDate_input, String address_input, String addressDetail_input) {
		return mapper.updateRedunds(acc_id, name_input, birthDate_input, address_input, addressDetail_input);
	}	//정일_계정정보수정_[이름,생년월일,주소]
	
	public int withdraw(String acc_id) {	//정일_회원탈퇴
		System.out.println("service.withdraw: " + acc_id);
		return mapper.withdraw(acc_id);
	}

//	public List<ItemInfoDTO> selectItemByAcc_index(int acc_index) { //범상_인포페이지 내역띄우기
//		System.out.println("MemberService의 selectItemByAcc_index()");
//		return mapper.selectItemByAcc_index(acc_index);
//	}

	public Map<String, List<ItemInfoDTO>> getItemInfo(int acc_index) { 
		//정일_(범상_인포페이지 [거래중 ,판매내역,구매내역]내역띄우기)_0812_수정
		//0819 추가 수정
		List<ItemInfoDTO> itemList = mapper.selectItemByAcc_index(acc_index);
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

		List<ItemInfoDTO> ondealItem = new ArrayList<ItemInfoDTO>();	//거래중
		List<ItemInfoDTO> onsaleItem = new ArrayList<ItemInfoDTO>();	//판매중
		List<ItemInfoDTO> soldItem = new ArrayList<ItemInfoDTO>();	//판매내역
		List<ItemInfoDTO> boughtItem = new ArrayList<ItemInfoDTO>();	//구매내역

		for (int i = 0; i < itemList.size(); i++) {
			String checkStatus = itemList.get(i).getItem_status();
			int checkSeller = itemList.get(i).getItem_seller();
			int checkBuyer = itemList.get(i).getItem_buyer();
			// 불러온 itemList 분류 (거래 중/판매내역/구매내역)
//			if(checkStatus.equals("onsale") && checkBuyer != acc_index) { // 거래 중
//				onsaleItem.add(itemList.get(i));
//			} else if (checkStatus.equals("drop") && checkBuyer != acc_index) { // 판매 내역
//				dropItem.add(itemList.get(i));
//			} else if (checkBuyer == acc_index) { // 구매 내역
//				buyItem.add(itemList.get(i));
//			}
			
			//0819 ji 수정
			if(checkStatus.equals("ondeal")) { // 거래 중
				ondealItem.add(itemList.get(i));
			} else if(checkStatus.equals("onsale") && checkSeller == acc_index) { //판매 중
				onsaleItem.add(itemList.get(i));
			} else if (checkStatus.equals("donedeal") && checkSeller == acc_index) { // 판매 내역
				soldItem.add(itemList.get(i));
			} else if (checkBuyer == acc_index) { // 구매 내역
				boughtItem.add(itemList.get(i));
			}
		}
		//System.out.println("response item_info: " + itemList.size());
		System.out.println("ondealItem: " + ondealItem.size());
		System.out.println("onsaleItem: " + onsaleItem.size());
		System.out.println("soldItem: " + soldItem.size());
		System.out.println("boughtItem: " + boughtItem.size());
		
		Map<String, List<ItemInfoDTO>> result = new HashMap<String, List<ItemInfoDTO>>();
		//result.put("itemList", itemList);
		result.put("ondealItem", ondealItem);
		result.put("onsaleItem", onsaleItem);
		result.put("soldItem", soldItem);
		result.put("boughtItem", boughtItem);
		
		return result;
	}


	public List<ItemInfoDTO> getMyInterests(int acc_index) {	//정일_인포페이지 관심상품 띄우기

		List<ItemInfoDTO> my_Interests = mapper.selectInterestsByAcc_index(acc_index);
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

		System.out.println("my_Interests: " + my_Interests.size());
		return my_Interests;
	}



	
}
