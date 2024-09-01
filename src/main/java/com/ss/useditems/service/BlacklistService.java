package com.ss.useditems.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.dto.BlacklistDTO;
import com.ss.useditems.dto.ItemInfoDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.mapper.BlacklistMapper;
import com.ss.useditems.mapper.ItemMapper2;
import com.ss.useditems.mapper.MemberMapper;
import com.ss.useditems.util.PageInfo;

@Service
public class BlacklistService {

	@Autowired
	private BlacklistMapper blacklistMapper;

	@Autowired
	private MemberMapper memberMapper;

	// 신고 리스트 및 페이징 처리
	public PageInfo getBlacklist(int currentPage, Map<String, String> queryMap) { // 정일_신고등록
		System.out.println("BlacklistService.getBlacklist()");
		// 일단 쿼리맵 검색으로 전체리스트 받아옴
		ArrayList<BlacklistDTO> unpaged_list = blacklistMapper.getBlacklist(queryMap);

		// 생성자: pageInfo(currentPage, pagePerViewer, dtoTotal, dtoPerPage)
		PageInfo pageinfo = new PageInfo(currentPage, 5, unpaged_list.size(), 10);

		// 페이지인포로 서브리스트 만들어서
		List<BlacklistDTO> paged_list = unpaged_list.subList(pageinfo.getFromIndex(), pageinfo.getTillIndex());

		// 페이지인포 dto컨테이너에 가공된 리스트 넣어줌
		pageinfo.setDtoContainer(paged_list);

		return pageinfo;
	}

	// 신고 등록
	public int enroll(BlacklistDTO complain) {
		System.out.println("BlacklistService.enroll()");
		// 신고자 id로 계정정보 조회(index)
		MemberDTO subject = memberMapper.selectAccountByAcc_id(complain.getSubject_id());
		MemberDTO object = memberMapper.selectAccountByAcc_id(complain.getObject_id());
		// 개인 비공개정보 제거??
		complain.setBlack_subject(subject.getAcc_index());
		complain.setBlack_object(object.getAcc_index());

		return blacklistMapper.enroll(complain);
	}

	// 신고 삭제 (본인 또는 관리자 권한)
	public int delet(String black_index) {
		System.out.println("BlacklistService.delet()");
		return blacklistMapper.delet(black_index);
	}

	/////////// arraylist 받아서 map으로 sql 집어넣기 test

	public int testNull(ArrayList<String> strlist) {

		System.out.println("atService.param(null): " + strlist.toString());

		Map<String, String> testMap = new HashMap<String, String>();

		try {
			for (int i = 0; i < strlist.size(); i++) {
				testMap.put("img" + (i + 1), strlist.get(i));
			}

		} catch (Exception e) {
			System.out.println("안되넹");
		}

		System.out.println("testMap:" + testMap);
		return blacklistMapper.testarr(testMap);

	}

	public int testarr1(ArrayList<String> strlist) {
		System.out.println("atService.param(Single): " + strlist.toString());

		Map<String, String> testMap = new HashMap<String, String>();

		try {
			for (int i = 0; i < strlist.size(); i++) {
				testMap.put("img" + (i + 1), strlist.get(i));
			}

		} catch (Exception e) {
			System.out.println("안되넹");
		}

		System.out.println("testMap:" + testMap);

		return blacklistMapper.testarr(testMap);
	}

	public int testarr4(ArrayList<String> strlist) {

		System.out.println("atService.param(arr4): " + strlist.toString());

		Map<String, String> testMap = new HashMap<String, String>();
		try {
			for (int i = 0; i < strlist.size(); i++) {

				System.out.println((i + 1) + "번" + strlist.get(i));

				testMap.put("img" + (i + 1), strlist.get(i));
			}

		} catch (Exception e) {
			System.out.println("안되넹");
		}

		System.out.println("testMap:" + testMap);

		return blacklistMapper.testarr(testMap);
	}

}
