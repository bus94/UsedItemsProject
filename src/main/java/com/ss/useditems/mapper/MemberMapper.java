package com.ss.useditems.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.ItemInfoDTO;
import com.ss.useditems.dto.MemberDTO;

@Mapper
public interface MemberMapper {

	// 로그인 확인
	MemberDTO loginOK(MemberDTO loginMember);
	
	// 타 이용자 정보 조회 (acc_id) + 피신고
	MemberDTO selectInfoByAcc_id(String acc_id);

	// 타 이용자 정보 조회
	MemberDTO selectAccountByAcc_id(String acc_id);
	
	// 중복확인
	int selectById(String id);

	// 회원가입
	int signup(MemberDTO signupMember);

	// acc_id로 acc_index 조회
	int selectIdIndex(String acc_id);

	// 프로필 이미지 수정
	int updateProfile(String acc_id, String originalFileName);
	
	// 비밀번호 수정
	int updatePW(String acc_id, String neoPWconf_input);
	
	// 닉네임 수정
	int updateNickname(String acc_id, String nickname_input);
	
	// 핸드폰 번호 수정
	int updatePhone(String acc_id, String phone_input);
	
	// 이름, 생년월일, 주소 수정
	int updateRedunds(String acc_id, String name_input, String birthDate_input, String address_input, String addressDetail_input,String addressX_input,String addressY_input);
	
	// 회원 탈퇴
	int withdraw(String acc_id);

	// home.jsp 파워셀러 불러오기
	MemberDTO getPowerSeller();

	// 마이페이지 물품 조회 리스트 불러오기 (거래중, 판매내역, 구매내역)
	List<ItemInfoDTO> selectItemByAcc_index(int acc_index);

	// 관심 물품 (찜 목록) 리스트 불러오기
	List<ItemInfoDTO> selectInterestsByAcc_index(int acc_index);







}
