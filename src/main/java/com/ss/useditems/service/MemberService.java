package com.ss.useditems.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	public int withdraw(String acc_id) {	//정일_회원탈퇴
		System.out.println("service.withdraw: " + acc_id);
		return mapper.withdraw(acc_id);
	}

//	public List<ItemInfoDTO> selectItemByAcc_index(int acc_index) { //범상_인포페이지 내역띄우기
//		System.out.println("MemberService의 selectItemByAcc_index()");
//		return mapper.selectItemByAcc_index(acc_index);
//	}

	
	public List<ItemInfoDTO> getMyInterests(int acc_index) {

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

		return my_Interests;
	}
	
	
	
	
	public Map<String, List<ItemInfoDTO>> getItemInfo(int acc_index) { //정일_(범상_인포페이지 내역띄우기)_0812_수정

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

		
		List<ItemInfoDTO> onsaleItem = new ArrayList<ItemInfoDTO>();
		List<ItemInfoDTO> dropItem = new ArrayList<ItemInfoDTO>();
		List<ItemInfoDTO> buyItem = new ArrayList<ItemInfoDTO>();

		for (int i = 0; i < itemList.size(); i++) {
			String checkStatus = itemList.get(i).getItem_status();
			int checkBuyer = itemList.get(i).getItem_buyer();
			
			// 불러온 itemList 분류 (거래 중/판매내역/구매내역)
			if(checkStatus.equals("onsale") && checkBuyer != acc_index) { // 거래 중
				onsaleItem.add(itemList.get(i));
			} else if (checkStatus.equals("drop") && checkBuyer != acc_index) { // 판매 내역
				dropItem.add(itemList.get(i));
			} else if (checkBuyer == acc_index) { // 구매 내역
				buyItem.add(itemList.get(i));
			}
		}
		
		System.out.println("response item_info: " + itemList);
		
		System.out.println("onsaleItem: " + onsaleItem);
		System.out.println("dropItem: " + dropItem);
		System.out.println("buyItem: " + buyItem);
		
		
		Map<String, List<ItemInfoDTO>> result = new HashMap<String, List<ItemInfoDTO>>();
		//result.put("itemList", itemList);
		result.put("onsaleItem", onsaleItem);
		result.put("dropItem", dropItem);
		result.put("buyItem", buyItem);

		
		return result;
	}
	
}
