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
			session.setAttribute("loginMember", loginMember);
			// 마지막 수신 메세지 저장
			session.setAttribute("checkedLastMessage", loginMember.getAcc_lastMessage());
			return "redirect:/";
		} else {
			loginMember = null;
			model.addAttribute("msg", "로그인에 실패하였습니다. 다시 로그인 해주세요.");
			model.addAttribute("location", "/account/login.do");
		}
		return "common/msg";
	}

	// 로그아웃 확인
	@RequestMapping("/account/logoutOK.do")
	public String logoutOK(Model model, HttpSession session) {
		//System.out.println("logoutOK");
		try {
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
			// 사용불가
			result = "0";
		} else {
			// 사용가능
			result = "1";
		}
		//System.out.println("result: " + result);
		return result;
	}

	@RequestMapping("/account/signupOK.do")
	public String signupOK(Model model, String id, String password, String name, String birthDate, String address,
			String addressx,String addressy,String detail_address,String phone) throws ParseException {
		//System.out.println("signupOK() 회원가입 실행");
		//System.out.println("id: " + id);
		//System.out.println("password: " + password);
		//System.out.println("name: " + name);
		//System.out.println("birthDate: " + birthDate);
		//System.out.println("address: " + address);
		//System.out.println("phone: " + phone);

		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		//System.out.println(detail_address);
		//System.out.println(addressx);
		//System.out.println(addressy);
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
		
		//System.out.println("signupMember: " + signupMember);

		if (memberservice.signup(signupMember) > 0) {
			model.addAttribute("msg", "회원가입이 완료되었습니다. 로그인 해주세요.");
			model.addAttribute("location", "/account/login.do");
		} else {
			model.addAttribute("msg", "회원가입에 실패하였습니다. 다시 입력해주세요.");
			model.addAttribute("location", "/account/sign.do");
		}
		//System.out.println("signupOK() 회원가입 실행 완료");

		return "common/msg";
	}

	//////////////////////////////////// 정일/////////////////////

	@RequestMapping("/account/my_info.do")
	public String my_info(Model model, HttpSession session) {
		//System.out.println("==account.my_info==");
		// 마이페이지 눌렀을 때 실행!!!

		try {
			if (session.getAttribute("loginMember") == null) {
				model.addAttribute("msg", "로그인 먼저 해주세요.");
				model.addAttribute("location", "/account/login.do");
				return "common/msg";
			} else { // 0804추가
				MemberDTO my_info = (MemberDTO) session.getAttribute("loginMember");
//				System.out.println("마이인포 전: " + my_info);
				String my_id = my_info.getAcc_id();
				my_info = memberservice.selectInfoByAcc_id(my_id);
				
				//System.out.println("my_info.getAcc_count(): " + my_info.getAcc_count());
				//System.out.println("my_info.getAcc_blackCount(): " + my_info.getAcc_blackCount());
				
				my_info.setAcc_score(my_info.acc_score(my_info.getAcc_count(), my_info.getAcc_blackCount()));
				//System.out.println("my_info.getAcc_score(): " + my_info.getAcc_score());
				
				// 매너등급
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
				//System.out.println("my_info.getAcc_score: " + my_info.getAcc_score());
				//System.out.println("my_info.getAcc_level: " + my_info.getAcc_level());
				System.out.println("my_info : " + my_info);

				model.addAttribute("loginMember", my_info);
				int acc_index = my_info.getAcc_index();
				
				//거래중, 판매내역, 구매내역 불러오기: 길어서 하단에 별도로 함수 정의
				//Map<String, List<ItemInfoDTO>> itemInfo = getItemInfo(acc_index);
				//거래중, 판매내역, 구매내역 불러오기: 서비스에서 전처리
				Map<String, List<ItemInfoDTO>> itemInfo = memberservice.getItemInfo(acc_index);

				
				//model.addAttribute("itemList", itemInfo.get("itemList"));
				model.addAttribute("ondealItem", itemInfo.get("ondealItem"));
				model.addAttribute("onsaleItem", itemInfo.get("onsaleItem"));
				model.addAttribute("soldItem", itemInfo.get("soldItem"));
				model.addAttribute("boughtItem", itemInfo.get("boughtItem"));
				
				
				//찜 목록 불러오기
				List<ItemInfoDTO> my_interests = new ArrayList<ItemInfoDTO>();
				my_interests = memberservice.getMyInterests(acc_index);
				
				model.addAttribute("my_interests", my_interests);
				
			}
		} catch (Exception e) {
			model.addAttribute("msg", "오류로 인하여 정상적으로 처리되지 않았습니다." + "\\r\\n" + "다시 시도해 주시기 바랍니다.");
			model.addAttribute("location", "/");
		}

		return "account/info";
	}

	@RequestMapping("/account/acc_info.do")
	public String acc_info(Model model, @RequestParam String acc_id) {
		// 다른사람의 계정을 눌렀을 때 실행!!!
		//System.out.println("==account.acc_info==");

		//System.out.println("request.acc_id: " + acc_id);
		try {
			
			MemberDTO account_info = new MemberDTO();
			account_info = memberservice.selectInfoByAcc_id(acc_id);
			
			account_info.setAcc_score(account_info.acc_score(account_info.getAcc_count(), account_info.getAcc_blackCount()));
			// 매너등급
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
			System.out.println("response acc_info: " + account_info);

			
			//System.out.println("account_info.getAcc_score: " + account_info.getAcc_score());
			//System.out.println("account_info.getAcc_level: " + account_info.getAcc_level());
			
			model.addAttribute("other_info", account_info);
			int acc_index = account_info.getAcc_index();
			//거래중, 판매내역, 구매내역 불러오기: 길어서 하단에 별도로 함수 정의
			//Map<String, List<ItemInfoDTO>> itemInfo = getItemInfo(acc_index);
			//거래중, 판매내역, 구매내역 불러오기: 서비스에서 전처리
			Map<String, List<ItemInfoDTO>> itemInfo = memberservice.getItemInfo(acc_index);
			
			
			//model.addAttribute("itemList", itemInfo.get("itemList"));
			model.addAttribute("ondealItem", itemInfo.get("ondealItem"));
			model.addAttribute("onsaleItem", itemInfo.get("onsaleItem"));
			model.addAttribute("soldItem", itemInfo.get("soldItem"));
			//model.addAttribute("boughtItem", itemInfo.get("boughtItem"));
			
			
		} catch (Exception e) {
			model.addAttribute("msg", "오류로 인하여 정상적으로 처리되지 않았습니다." + "\\r\\n" + "다시 시도해 주시기 바랍니다.");
			model.addAttribute("location", "/");
		}
		
		return "account/info";
	}

	@RequestMapping("/account/alter.do")
	public String alter(Model model, HttpSession session) { // 정보수정 페이지
		//System.out.println("==account.alter==");

		try {
			if (session.getAttribute("loginMember") == null) {
				model.addAttribute("msg", "로그인 먼저 해주세요.");
				model.addAttribute("location", "/account/login.do");
				return "common/msg";
			}

		} catch (Exception e) {
			model.addAttribute("msg", "오류로 인하여 정상적으로 처리되지 않았습니다." + "\\r\\n" + "다시 시도해 주시기 바랍니다.");
			model.addAttribute("location", "/account/my_info.do");
		}

		return "account/alter";
	}
	
	
	@RequestMapping("/account/setProfile.do")	//프로필이미지 수정
	public String setProfile(Model model, HttpSession session, @RequestParam MultipartFile profile) { 
		//System.out.println("==account.setProfile==");
		
		try {
			//넘어온 파일 정보 확인
			String originalFileName = profile.getOriginalFilename();
			//long fileSize = profile.getSize();
			//System.out.println("파일명: " + originalFileName + " 파일크기: " + fileSize);
			
			MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
			
			if(originalFileName.equals(loginMember.getAcc_profile())) {
				model.addAttribute("msg", "현재 프로필이미지와 파일명이 같습니다."+ "\\r\\n" + "파일명을 변경해주시기 바랍니다.");
				model.addAttribute("location", "/account/alter.do");
				
			} else {
				
				memberservice.updateProfile(loginMember, profile);
				
				loginMember.setAcc_profile(originalFileName);
				//System.out.println("수정 후: " + loginMember);
				
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
	
	
	@RequestMapping("/account/setPW.do")
	@ResponseBody	//return 값을 자동으로 JSON타입으로 변환하여 AJAX 통신 결과로 송신, 대신 jsp로 연결할 수 없음
	public int setPW(Model model, HttpSession session, @RequestParam String currPW_input, @RequestParam String neoPWconf_input) {
		//System.out.println("==account.setPW==");
		
		//System.out.println(currPW_input + "////" + neoPWconf_input); //넘어온 값 확인
		
		int result = -1;
		try {
			MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
			//System.out.println("수정 전: " + loginMember);
			
			if(loginMember.getAcc_password().equals(currPW_input)) {
				//System.out.println("같다");
				String acc_id = loginMember.getAcc_id();
				//현재 아이디와 바꿀 비밀번호 넘겨줌
				result = memberservice.updatePW(acc_id, neoPWconf_input); //result == 처리된 행의 개수
				
				loginMember.setAcc_password(neoPWconf_input);
				//System.out.println("수정 후: " + loginMember);
				
				session.setAttribute("loginMember", loginMember);
				
			} else {
				//System.out.println("다르다");
				result = 0;
			}
			
		} catch (Exception e) {
			//System.out.println("예외에 막혔다"); //result == -1
		}

		return result;
	}
	
	
	@RequestMapping("/account/setNickname.do")
	@ResponseBody	//return 값을 자동으로 JSON타입으로 변환하여 AJAX 통신 결과로 송신, 대신 jsp로 연결할 수 없음
	public int setNickname(Model model, HttpSession session, @RequestParam String nickname_input) {
		//System.out.println("==account.setNickname==");
		int result = -1;
		try {
			MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
			//System.out.println("수정 전: " + loginMember);
			
			if(loginMember.getAcc_nickname().equals(nickname_input)) {
				
				result = 0;
			} else {
				
				String acc_id = loginMember.getAcc_id();
				result = memberservice.updateNickname(acc_id, nickname_input); //result == 처리된 행의 개수
					
				loginMember.setAcc_nickname(nickname_input);
				//System.out.println("수정 후: " + loginMember);
				session.setAttribute("loginMember", loginMember);
			}
			
		} catch (Exception e) {
			//System.out.println("예외에 막혔다"); //result == -1
		}

		return result;
	}
	
	@RequestMapping("/account/setPhone.do")
	@ResponseBody	//return 값을 자동으로 JSON타입으로 변환하여 AJAX 통신 결과로 송신, 대신 jsp로 연결할 수 없음
	public int setPhone(Model model, HttpSession session, @RequestParam String phone_input) {
		//System.out.println("==account.setPhone==");
		
		int result = -1;
		try {
			MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
			//System.out.println("수정 전: " + loginMember);
			
			
			if(loginMember.getAcc_phone().equals(phone_input)) {
				//기존과 같다
				result = 0;
			} else {
				
				String acc_id = loginMember.getAcc_id();
				result = memberservice.updatePhone(acc_id, phone_input); //result == 처리된 행의 개수
					
				loginMember.setAcc_phone(phone_input);
				//System.out.println("수정 후: " + loginMember);
				
				session.setAttribute("loginMember", loginMember);
			}
			
		} catch (Exception e) {
			//System.out.println("예외에 막혔다"); //result == -1
		}

		return result;
	}
	
	@RequestMapping("/account/setRedunds.do")
	@ResponseBody	//return 값을 자동으로 JSON타입으로 변환하여 AJAX 통신 결과로 송신, 대신 jsp로 연결할 수 없음
	public int setRedunds(Model model, HttpSession session, @RequestParam String name_input, @RequestParam String birthDate_input, 
			@RequestParam String address_input, @RequestParam String addressDetail_input,@RequestParam String addressX_input,@RequestParam String addressY_input) {
		//System.out.println("==account.setRedunds==");
		
		int result = -1;
		try {
			MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
//			System.out.println("수정 전: " + loginMember);
//			System.out.println(birthDate_input);
			//System.out.println(addressX_input);
			//System.out.println(addressY_input);
			//formatter.format(date) : Date -> String
			//formatter.parse(string) : String -> Date 
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date birthDate_ = formatter.parse(birthDate_input);
			
			
			String acc_id = loginMember.getAcc_id();
			result = memberservice.updateRedunds(acc_id, name_input, birthDate_input, address_input, addressDetail_input,addressX_input,addressY_input); //result == 처리된 행의 개수
				
			loginMember.setAcc_name(name_input);
			loginMember.setAcc_birthDate(birthDate_);//날짜 포맷
			loginMember.setAcc_address(address_input);
			loginMember.setAcc_addressDetail(addressDetail_input);


			//System.out.println("수정 후: " + loginMember);

			loginMember.setAcc_addressX(addressX_input);
			loginMember.setAcc_addressY(addressY_input);
			//System.out.println("수정 후: " + loginMember);

			
			session.setAttribute("loginMember", loginMember);
			
		} catch (Exception e) {
			//System.out.println("예외에 막혔다"); //result == -1
		}

		return result;
	}
	
	
	@RequestMapping("/withdraw.do")
	public String withdraw(Model model, HttpSession session, @RequestParam String wd_currPW) {
		//System.out.println("==account.withdraw==");
		try {
			MemberDTO my_info = (MemberDTO) session.getAttribute("loginMember");
			String acc_id = my_info.getAcc_id().trim();
			String acc_password = my_info.getAcc_password().trim();
//			System.out.println("acc_id: "+ acc_id + ", acc_pw: " + acc_password);
//			System.out.println("Param.wd_currPW: "+ wd_currPW);

			if (wd_currPW.trim().equals(acc_password)) { // 탈퇴 처리
				// int result = memberservice.withdraw(acc_id);
				// 이미 inactive인 것도 결과는 1로 돌아옴!!!! 예외처리 어떻게?? : 'inactive'는 로그인조차 못하게
//				System.out.println("result: " +result);
				memberservice.withdraw(acc_id);
				session.removeAttribute("loginMember");
				model.addAttribute("msg", "정상적으로 탈퇴 처리되었습니다.");
				model.addAttribute("location", "/");
			} else { // 세션의 비밀번호와 입력 비밀번호가 다르면
				model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
				model.addAttribute("location", "/account/alter.do");
			}

		} catch (Exception e) {
			model.addAttribute("msg", "오류로 인하여 탈퇴가 정상적으로 처리되지 않았습니다.");
			model.addAttribute("location", "/account/alter.do");
		}

		return "common/msg";
	}


	//////////////////////////////////// 정일/////////////////////

	
}
