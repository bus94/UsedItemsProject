package com.ss.useditems.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
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

import com.ss.useditems.dto.ItemInfoDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberservice;

	@RequestMapping("/account/login.do")
	public String login(Model model) {
		return "account/login";
	}

	@RequestMapping("/account/signup.do")
	public String signup(Model model) {
		return "account/signup";
	}

	@RequestMapping("/account/loginOK.do")
	public String loginOK(Model model, String acc_id, String acc_password, HttpSession session) {
		System.out.println("loginOK 로그인 확인");

		System.out.println("입력한 acc_id: " + acc_id);
		System.out.println("입력한 acc_password: " + acc_password);

		MemberDTO loginMember = new MemberDTO();
		loginMember.setAcc_id(acc_id);
		loginMember.setAcc_password(acc_password);

		loginMember = memberservice.selectByMember(loginMember);
		if (loginMember != null) {
			session.setAttribute("loginMember", loginMember);
			return "redirect:/";
		} else {
			loginMember = null;
			model.addAttribute("msg", "로그인에 실패하였습니다. 다시 로그인 해주세요.");
			model.addAttribute("location", "/account/login.do");
		}
		return "common/msg";
	}

	@RequestMapping("/account/logoutOK.do")
	public String logoutOK(Model model, HttpSession session) {
		System.out.println("logoutOK");
		try {
			session.removeAttribute("loginMember");
		} catch (Exception e) {
		}
		model.addAttribute("msg", "정상적으로 로그아웃 되었습니다.");
		model.addAttribute("location", "/home");
		return "common/msg";
	}

	// 회원가입 아이디 중복검사 (중복 있으면 사용 불가: 0, 없으면 사용 가능: 1 반환)
	@RequestMapping("/account/duplicateCheckId.do")
	@ResponseBody
	public String duplicateCheckId(Model model, String id) {
		System.out.println("MemberController의 duplicateCheckId()");
		System.out.println("입력한 id: " + id);
		String result = "";
		if (memberservice.selectById(id) > 0) {
			// 사용불가
			result = "0";
		} else {
			// 사용가능
			result = "1";
		}
		System.out.println("result: " + result);
		return result;
	}

	@RequestMapping("/account/signupOK.do")
	public String signupOK(Model model, String id, String password, String name, String birthDate, String address,
			String phone) throws ParseException {
		System.out.println("signupOK() 회원가입 실행");
		System.out.println("id: " + id);
		System.out.println("password: " + password);
		System.out.println("name: " + name);
		System.out.println("birthDate: " + birthDate);
		System.out.println("address: " + address);
		System.out.println("phone: " + phone);

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

		System.out.println("signupMember: " + signupMember);

		if (memberservice.signup(signupMember) > 0) {
			model.addAttribute("msg", "회원가입이 완료되었습니다. 로그인 해주세요.");
			model.addAttribute("location", "/account/login.do");
		} else {
			model.addAttribute("msg", "회원가입에 실패하였습니다. 다시 입력해주세요.");
			model.addAttribute("location", "/account/sign.do");
		}
		System.out.println("signupOK() 회원가입 실행 완료");

		return "common/msg";
	}

	//////////////////////////////////// 정일/////////////////////

	@RequestMapping("/account/my_info.do")
	public String my_info(Model model, HttpSession session) {
		System.out.println("==account.my_info==");
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
//				System.out.println("마이인포 후: " + my_info);

				model.addAttribute("loginMember", my_info);
				
				
				int acc_index = my_info.getAcc_index();
				
				
				//찜 목록 불러오기
				List<ItemInfoDTO> my_interests = new ArrayList<ItemInfoDTO>();
				my_interests = memberservice.getMyInterests(acc_index);
				
				model.addAttribute("my_interests", my_interests);

				
				
				//거래중, 판매내역, 구매내역 불러오기: 길어서 하단에 별도로 함수 정의
				//Map<String, List<ItemInfoDTO>> itemInfo = getItemInfo(acc_index);
				//거래중, 판매내역, 구매내역 불러오기: 서비스에서 전처리
				Map<String, List<ItemInfoDTO>> itemInfo = memberservice.getItemInfo(acc_index);

				
				//model.addAttribute("itemList", itemInfo.get("itemList"));
				model.addAttribute("onsaleItem", itemInfo.get("onsaleItem"));
				model.addAttribute("dropItem", itemInfo.get("dropItem"));
				model.addAttribute("buyItem", itemInfo.get("buyItem"));
				
				
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
		System.out.println("==account.acc_info==");

		System.out.println("request.acc_id: " + acc_id);
		try {
			
			MemberDTO account_info = new MemberDTO();
			account_info = memberservice.selectInfoByAcc_id(acc_id);
			model.addAttribute("other_info", account_info);
			
			
			int acc_index = account_info.getAcc_index();
			//거래중, 판매내역, 구매내역 불러오기: 길어서 하단에 별도로 함수 정의
			//Map<String, List<ItemInfoDTO>> itemInfo = getItemInfo(acc_index);
			//거래중, 판매내역, 구매내역 불러오기: 서비스에서 전처리
			Map<String, List<ItemInfoDTO>> itemInfo = memberservice.getItemInfo(acc_index);

			
			//model.addAttribute("itemList", itemInfo.get("itemList"));
			model.addAttribute("onsaleItem", itemInfo.get("onsaleItem"));
			model.addAttribute("dropItem", itemInfo.get("dropItem"));
			model.addAttribute("buyItem", itemInfo.get("buyItem"));

			
			System.out.println("response acc_info: " + account_info);
			
			
		} catch (Exception e) {
			model.addAttribute("msg", "오류로 인하여 정상적으로 처리되지 않았습니다." + "\\r\\n" + "다시 시도해 주시기 바랍니다.");
			model.addAttribute("location", "/");
		}
		

		return "account/info";
	}

	@RequestMapping("/account/alter.do")
	public String alter(Model model, HttpSession session) { // 정보수정 페이지
		System.out.println("==account.alter==");

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

	
	@RequestMapping("/account/setPW.do")
	@ResponseBody	//return 값을 자동으로 JSON타입으로 변환하여 AJAX 통신 결과로 송신, 대신 jsp로 연결할 수 없음
	public int setPW(Model model, HttpSession session, @RequestParam String currPW_input, @RequestParam String neoPWconf_input) {
		System.out.println("==account.setPW==");
		
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
				System.out.println("수정 후: " + loginMember);
				
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
		System.out.println("==account.setNickname==");
		
		int result = -1;
		try {
			MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
			//System.out.println("수정 전: " + loginMember);
			
			
			if(loginMember.getAcc_nickname().equals(nickname_input)) {
				//기존과 같다
				result = 0;
			} else {
				
				String acc_id = loginMember.getAcc_id();
				result = memberservice.updateNickname(acc_id, nickname_input); //result == 처리된 행의 개수
					
				loginMember.setAcc_nickname(nickname_input);
				System.out.println("수정 후: " + loginMember);
				
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
		System.out.println("==account.setPhone==");
		
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
				System.out.println("수정 후: " + loginMember);
				
				session.setAttribute("loginMember", loginMember);
			}
			
		} catch (Exception e) {
			//System.out.println("예외에 막혔다"); //result == -1
		}

		return result;
	}
	
	@RequestMapping("/account/setRedunds.do")
	@ResponseBody	//return 값을 자동으로 JSON타입으로 변환하여 AJAX 통신 결과로 송신, 대신 jsp로 연결할 수 없음
	public int setRedunds(Model model, HttpSession session, @RequestParam String name_input, @RequestParam String birthDate_input, @RequestParam String address_input) {
		System.out.println("==account.setRedunds==");
		
		int result = -1;
		try {
			MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
//			System.out.println("수정 전: " + loginMember);
//			System.out.println(birthDate_input);
			
			
			//signupOK.do 포매터 : ??? dho sqlDAte를??
			//formatter.format(date) : Date -> String
			//formatter.parse(string) : String -> Date 
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date birthDate_ = formatter.parse(birthDate_input);
			
			
			String acc_id = loginMember.getAcc_id();
			result = memberservice.updateRedunds(acc_id, name_input, birthDate_input, address_input); //result == 처리된 행의 개수
				
			loginMember.setAcc_name(name_input);
			loginMember.setAcc_birthDate(birthDate_);//날짜 포맷
			loginMember.setAcc_address(address_input);
			System.out.println("수정 후: " + loginMember);
			
			session.setAttribute("loginMember", loginMember);
			
		} catch (Exception e) {
			//System.out.println("예외에 막혔다"); //result == -1
		}

		return result;
	}
	
	
	@RequestMapping("/withdraw.do")
	public String withdraw(Model model, HttpSession session, @RequestParam String wd_currPW) {
		System.out.println("==account.withdraw==");
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

	@RequestMapping("/map/maptest1")
	public String mapTest(Model model) {
		System.out.println("maptest 페이지");
		return "map/maptest1";
	}
	
	
	
	@RequestMapping("/map/maptest2")
	public String mapTest2(Model model) {
		System.out.println("maptest 페이지");
		return "map/maptest2";
	}
	
	
	
	
	
	
	
	
	
	
	
}
