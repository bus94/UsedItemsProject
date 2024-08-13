package com.ss.useditems.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.ItemInfoDTO;
import com.ss.useditems.dto.MemberDTO;

@Mapper
public interface MemberMapper {

	MemberDTO selectByMember(MemberDTO loginMember);
	
	MemberDTO selectInfoByAcc_id(String acc_id); //정일_계정 정보(테이블정보 + 피신고)

	MemberDTO selectAccountByAcc_id(String acc_id); //정일_계정 정보(테이블정보만)
	
	int selectById(String id);

	int signup(MemberDTO signupMember);

	int selectIdIndex(String acc_id);

	int updateProfile(String acc_id, String originalFileName); //정일_프로필이미지 변경
	
	int updatePW(String acc_id, String neoPWconf_input); //정일_비밀번호 변경
	
	int updateNickname(String acc_id, String nickname_input); //정일_별명 변경
	
	int updatePhone(String acc_id, String phone_input); //정일_전화번호 변경
	
	int updateRedunds(String acc_id, String name_input, String birthDate_input, String address_input); //정일_[이름,생년월일,주소] 변경
	
	int withdraw(String acc_id); //정일_회원탈퇴

	MemberDTO getPowerSeller();	//정일_home.jsp_파워셀러

	List<ItemInfoDTO> selectItemByAcc_index(int acc_index);

	List<ItemInfoDTO> selectInterestsByAcc_index(int acc_index); //정일_계정 정보(찜목록)







}
