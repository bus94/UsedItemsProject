package com.ss.useditems.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.sql.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ss.useditems.dto.ItemInfoDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberservice;

	// 로그인 페이지
	@RequestMapping("/account/login.do")
	public String login(Model model) {
		return "account/login";
	}

	// 회원가입 페이지
	@RequestMapping("/account/signup.do")
	public String signup(Model model) {
		return "account/signup";
	}

	// 로그인 확인
	@RequestMapping("/account/loginOK.do")
	public String loginOK(Model model, String acc_id, String acc_password, HttpSession session) {
		// 로그인할 객체 저장
		MemberDTO loginMember = new MemberDTO();
		loginMember.setAcc_id(acc_id);
		loginMember.setAcc_password(acc_password);

		// 로그인 확인 실행
		loginMember = memberservice.loginOK(loginMember);

		if (loginMember != null) { 
			// 로그인 성공한 경우
			session.setAttribute("loginMember", loginMember);

			// Account Table에 저장된 마지막 수신 메시지
			session.setAttribute("checkedLastMessage", loginMember.getAcc_lastMessage());
			return "redirect:/";
		} else { 
			// 로그인 실패한 경우
			loginMember = null;
			model.addAttribute("msg", "로그인에 실패하였습니다. 다시 로그인 해주세요.");
			model.addAttribute("location", "/account/login.do");
		}
		return "common/msg";
	}

	// 로그아웃 확인
	@RequestMapping("/account/logoutOK.do")
	public String logoutOK(Model model, HttpSession session) {
		try {
			// 로그아웃 시 session에 있는 loginMember, checkedLastMessage 삭제
			session.removeAttribute("loginMember");
			session.removeAttribute("checkedLastMessage");
		} catch (Exception e) {
		}
		model.addAttribute("msg", "정상적으로 로그아웃 되었습니다.");
		model.addAttribute("location", "/");
		return "common/msg";
	}

	// 회원가입 아이디 중복검사 (중복 있으면 사용 불가: 0, 없으면 사용 가능: 1 반환)
	@RequestMapping("/account/duplicateCheckId.do")
	@ResponseBody
	public String duplicateCheckId(Model model, String id) {
		String result = "";
		if (memberservice.selectById(id) > 0) {
			// 중복된 아이디가 있다는 뜻으로 사용불가
			result = "0";
		} else {
			// 중복된 아이디가 없다는 뜻으로 사용가능
			result = "1";
		}
		return result;
	}

	// 회원가입 실행
	@RequestMapping("/account/signupOK.do")
	public String signupOK(Model model, String id, String password, String name, String birthDate, String address,
			String addressx, String addressy, String detail_address, String phone) throws ParseException {

		// 입력한 정보를 MemberDTO 객체에 저장
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		java.util.Date utilDate = formatter.parse(birthDate);

		Date birthDate_ = new Date(utilDate.getTime());

		MemberDTO signupMember = new MemberDTO();
		signupMember.setAcc_id(id);
		signupMember.setAcc_password(password);
		signupMember.setAcc_name(name);
		signupMember.setAcc_birthDate(birthDate_);
		signupMember.setAcc_address(address);
		signupMember.setAcc_phone(phone);
		signupMember.setAcc_addressX(addressx);
		signupMember.setAcc_addressY(addressy);
		signupMember.setAcc_addressDetail(detail_address);

		// DB에 저장한 후 return 값으로 결과 확인
		if (memberservice.signup(signupMember) > 0) {
			model.addAttribute("msg", "회원가입이 완료되었습니다. 로그인 해주세요.");
			model.addAttribute("location", "/account/login.do");
		} else {
			model.addAttribute("msg", "회원가입에 실패하였습니다. 다시 입력해주세요.");
			model.addAttribute("location", "/account/sign.do");
		}

		return "common/msg";
	}

	// 마이페이지
	@RequestMapping("/account/my_info.do")
	public String my_info(Model model, HttpSession session) {
		try {
			if (session.getAttribute("loginMember") == null) {
				// 로그인이 안되어있는 경우 로그인 페이지로 이동
				model.addAttribute("msg", "로그인 먼저 해주세요.");
				model.addAttribute("location", "/account/login.do");
				return "common/msg";
			} else {
				// 로그인 정보를 가지고 있는 loginMember의 정보로 마이페이지 띄우기
				MemberDTO my_info = (MemberDTO) session.getAttribute("loginMember");
				String my_id = my_info.getAcc_id();
				my_info = memberservice.selectInfoByAcc_id(my_id);
				my_info.setAcc_score(my_info.acc_score(my_info.getAcc_count(), my_info.getAcc_blackCount()));

				// 매너등급 (총 5개의 등급)
				if (my_info.getAcc_score() >= 80) {
					my_info.setAcc_level(5);
				} else if (my_info.getAcc_score() >= 60) {
					my_info.setAcc_level(4);
				} else if (my_info.getAcc_score() >= 40) {
					my_info.setAcc_level(3);
				} else if (my_info.getAcc_score() >= 20) {
					my_info.setAcc_level(2);
				} else {
					my_info.setAcc_level(1);
				}

				model.addAttribute("loginMember", my_info);
				int acc_index = my_info.getAcc_index();

				// 거래중, 판매내역, 구매내역 불러오기 (MemberService getItemInfo 메서드 통해 전처리)
				Map<String, List<ItemInfoDTO>> itemInfo = memberservice.getItemInfo(acc_index);

				// 거래 중
				model.addAttribute("ondealItem", itemInfo.get("ondealItem"));
				// 판매 중
				model.addAttribute("onsaleItem", itemInfo.get("onsaleItem"));
				// 판매 내역
				model.addAttribute("soldItem", itemInfo.get("soldItem"));
				// 구매 내역
				model.addAttribute("boughtItem", itemInfo.get("boughtItem"));

				// 관심 물품 (찜 목록) 불러오기 (MemberService getMyInterests 메서드 통해 전처리)
				List<ItemInfoDTO> my_interests = new ArrayList<ItemInfoDTO>();
				my_interests = memberservice.getMyInterests(acc_index);

				// 관심 물품
				model.addAttribute("my_interests", my_interests);
			}
		} catch (Exception e) {
			model.addAttribute("msg", "오류로 인하여 정상적으로 처리되지 않았습니다." + "\\r\\n" + "다시 시도해 주시기 바랍니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		return "account/info";
	}

	// 타 이용자 정보 (다른 이용자의 정보를 조회하는 경우)
	@RequestMapping("/account/acc_info.do")
	public String acc_info(Model model, @RequestParam String acc_id) {
		try {
			// 다른 이용자의 정보를 불러오기
			MemberDTO account_info = new MemberDTO();
			account_info = memberservice.selectInfoByAcc_id(acc_id);

			// 매너등급 계산하는 메서드
			account_info.setAcc_score(
					account_info.acc_score(account_info.getAcc_count(), account_info.getAcc_blackCount()));
			// 매너등급 (총 5개의 등급)
			if (account_info.getAcc_score() >= 80) {
				account_info.setAcc_level(5);
			} else if (account_info.getAcc_score() >= 60) {
				account_info.setAcc_level(4);
			} else if (account_info.getAcc_score() >= 40) {
				account_info.setAcc_level(3);
			} else if (account_info.getAcc_score() >= 20) {
				account_info.setAcc_level(2);
			} else {
				account_info.setAcc_level(1);
			}
			model.addAttribute("other_info", account_info);
			int acc_index = account_info.getAcc_index();

			// 거래중, 판매내역, 구매내역 불러오기 (MemberService getItemInfo 메서드 통해 전처리)
			Map<String, List<ItemInfoDTO>> itemInfo = memberservice.getItemInfo(acc_index);

			// 거래 중
			model.addAttribute("ondealItem", itemInfo.get("ondealItem"));
			// 판매 내역
			model.addAttribute("onsaleItem", itemInfo.get("onsaleItem"));
			// 구매 내역
			model.addAttribute("soldItem", itemInfo.get("soldItem"));
		} catch (Exception e) {
			model.addAttribute("msg", "오류로 인하여 정상적으로 처리되지 않았습니다." + "\\r\\n" + "다시 시도해 주시기 바랍니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}

		return "account/info";
	}

	// 회원 정보 수정 페이지
	@RequestMapping("/account/alter.do")
	public String alter(Model model, HttpSession session) {
		try {
			// 로그인이 안되어있는 경우 로그인 페이지로 이동
			if (session.getAttribute("loginMember") == null) {
				model.addAttribute("msg", "로그인 먼저 해주세요.");
				model.addAttribute("location", "/account/login.do");
				return "common/msg";
			}
		} catch (Exception e) {
			model.addAttribute("msg", "오류로 인하여 정상적으로 처리되지 않았습니다." + "\\r\\n" + "다시 시도해 주시기 바랍니다.");
			model.addAttribute("location", "/account/my_info.do");
			return "common/msg";
		}
		return "account/alter";
	}

	// 프로필 이미지 수정
	@RequestMapping("/account/setProfile.do")
	public String setProfile(Model model, HttpSession session, @RequestParam MultipartFile profile) {
		try {
			// 넘어온 파일 정보 확인
			String originalFileName = profile.getOriginalFilename();
			MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");

			if (originalFileName.equals(loginMember.getAcc_profile())) {
				// 기존 프로필 이미지와 변경하는 이미지의 파일명이 같을 때 파일명 변경 요청 메세지 띄우기
				model.addAttribute("msg", "현재 프로필이미지와 파일명이 같습니다." + "\\r\\n" + "파일명을 변경해주시기 바랍니다.");
				model.addAttribute("location", "/account/alter.do");
			} else {
				memberservice.updateProfile(loginMember, profile);
				loginMember.setAcc_profile(originalFileName);

				session.setAttribute("loginMember", loginMember);

				model.addAttribute("msg", "프로필이미지가 변경되었습니다.");
				model.addAttribute("location", "/account/alter.do");
			}
		} catch (Exception e) {
			model.addAttribute("msg", "오류로 인하여 정상적으로 처리되지 않았습니다." + "\\r\\n" + "다시 시도해 주시기 바랍니다.");
			model.addAttribute("location", "/account/alter.do");
		}
		return "common/msg";
	}

	// 비밀번호 변경할 때
	@RequestMapping("/account/setPW.do")
	@ResponseBody // return 값을 자동으로 JSON타입으로 변환하여 AJAX 통신 결과로 송신 (대신 jsp로 연결할 수 없음)
	public int setPW(Model model, HttpSession session, @RequestParam String currPW_input,
			@RequestParam String neoPWconf_input) {
		int result = -1;
		try {
			MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");

			if (loginMember.getAcc_password().equals(currPW_input)) {
				// 현재 비밀번호와 입력한 비밀번호가 같을 때 현재 아이디와 바꿀 비밀번호로 수정 메서드 실행
				// result : 처리된 행의 개수
				String acc_id = loginMember.getAcc_id();
				result = memberservice.updatePW(acc_id, neoPWconf_input); 
				loginMember.setAcc_password(neoPWconf_input);

				session.setAttribute("loginMember", loginMember);
			} else {
				// 현재 비밀번호와 입력한 비밀번호가 다를 때
				result = 0;
			}
		} catch (Exception e) {
		}
		return result;
	}

	// 닉네임 변경할 때
	@RequestMapping("/account/setNickname.do")
	@ResponseBody // return 값을 자동으로 JSON타입으로 변환하여 AJAX 통신 결과로 송신 (대신 jsp로 연결할 수 없음)
	public int setNickname(Model model, HttpSession session, @RequestParam String nickname_input) {
		int result = -1;
		try {
			MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");

			if (loginMember.getAcc_nickname().equals(nickname_input)) {
				// 현재 닉네임과 입력한 값이 같을 때
				result = 0;
			} else {
				// 현재 닉네임과 입력한 값이 다를 때 현재 아이디와 입력한 닉네임으로 수정 메서드 실행
				// result == 처리된 행의 개수
				String acc_id = loginMember.getAcc_id();
				result = memberservice.updateNickname(acc_id, nickname_input);
				loginMember.setAcc_nickname(nickname_input);
				
				session.setAttribute("loginMember", loginMember);
			}
		} catch (Exception e) {
		}
		return result;
	}

	// 핸드폰 번호 변경할 때
	@RequestMapping("/account/setPhone.do")
	@ResponseBody // return 값을 자동으로 JSON타입으로 변환하여 AJAX 통신 결과로 송신 (대신 jsp로 연결할 수 없음)
	public int setPhone(Model model, HttpSession session, @RequestParam String phone_input) {
		int result = -1;
		try {
			MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");

			if (loginMember.getAcc_phone().equals(phone_input)) {
				// 현재 핸드폰 번호와 입력한 값이 같을 때
				result = 0;
			} else {
				// 현재 핸드폰 번호와 입력한 값이 다를 때 현재 아이디와 입력한 핸드폰 번호로 수정 메서드 실행
				// result == 처리된 행의 개수
				String acc_id = loginMember.getAcc_id();
				result = memberservice.updatePhone(acc_id, phone_input);
				loginMember.setAcc_phone(phone_input);

				session.setAttribute("loginMember", loginMember);
			}
		} catch (Exception e) {
		}

		return result;
	}

	// 이름, 생년월일, 주소 변경할 때
	@RequestMapping("/account/setRedunds.do")
	@ResponseBody // return 값을 자동으로 JSON타입으로 변환하여 AJAX 통신 결과로 송신 (대신 jsp로 연결할 수 없음)
	public int setRedunds(Model model, HttpSession session, @RequestParam String name_input,
			@RequestParam String birthDate_input, @RequestParam String address_input,
			@RequestParam String addressDetail_input, @RequestParam String addressX_input,
			@RequestParam String addressY_input) {
		int result = -1;
		try {
			MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date birthDate_ = formatter.parse(birthDate_input);

			String acc_id = loginMember.getAcc_id();
			result = memberservice.updateRedunds(acc_id, name_input, birthDate_input, address_input,
					addressDetail_input, addressX_input, addressY_input);

			loginMember.setAcc_name(name_input);
			loginMember.setAcc_birthDate(birthDate_);
			loginMember.setAcc_address(address_input);
			loginMember.setAcc_addressDetail(addressDetail_input);
			loginMember.setAcc_addressX(addressX_input);
			loginMember.setAcc_addressY(addressY_input);

			session.setAttribute("loginMember", loginMember);
		} catch (Exception e) {
		}
		return result;
	}

	// 탈퇴하기
	@RequestMapping("/withdraw.do")
	public String withdraw(Model model, HttpSession session, @RequestParam String wd_currPW) {
		try {
			MemberDTO my_info = (MemberDTO) session.getAttribute("loginMember");
			String acc_id = my_info.getAcc_id().trim();
			String acc_password = my_info.getAcc_password().trim();

			// 탈퇴
			if (wd_currPW.trim().equals(acc_password)) {
				// 이미 inactive인 것도 결과는 1로 돌아옴!!!! 예외처리 어떻게?? : 'inactive'는 로그인조차 못하게
				memberservice.withdraw(acc_id);
				session.removeAttribute("loginMember");
				model.addAttribute("msg", "정상적으로 탈퇴 처리되었습니다.");
				model.addAttribute("location", "/");
			} else { 
				// 세션의 비밀번호와 입력 비밀번호가 다를 때
				model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
				model.addAttribute("location", "/account/alter.do");
			}
		} catch (Exception e) {
			model.addAttribute("msg", "오류로 인하여 탈퇴가 정상적으로 처리되지 않았습니다.");
			model.addAttribute("location", "/account/alter.do");
		}
		return "common/msg";
	}
}