package com.ss.useditems.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ss.useditems.dto.ItemInfoDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.dto.ReplyDTO;
import com.ss.useditems.service.ItemViewService;

@Controller
public class ItemViewController {

	@Autowired
	private ItemViewService service;

	// 아이템 상세페이지
	@RequestMapping("/item/itemView")
	public String itemView(Model model, int item_index,
			@SessionAttribute(name = "loginMember", required = false) MemberDTO loginMember, HttpServletRequest request,
			HttpServletResponse response) {

		// 관심 등록 전
		boolean isInterested=false;
		// 로그인 되어있으면
		if(loginMember!=null){
			isInterested=service.isInterest(acc_item_index(loginMember.getAcc_index(),item_index));
			acc_item_index(loginMember.getAcc_index(),item_index);
		}
		
		// 조회수 증가 로직
		String cookieName = "itemView_" + item_index;
		// 서버의 쿠키를 가져옴
		Cookie[] cookies = request.getCookies();
		// 조회수 증가 변수
		boolean viewed = false;

		// 쿠키가 비어있지 않다면
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				// 쿠키 이름으로 같은지 비교
				if (cookie.getName().equals(cookieName)) {
					viewed = true;
					break;
				}
			}
		}

		if (!viewed) { // 쿠키가 비어있다면
			service.incrementViews(item_index);
			// 새로운 쿠키 생성
			Cookie newCookie = new Cookie(cookieName, "true");
			newCookie.setMaxAge(3600); // 1시간 동안 유효
			newCookie.setPath("/");
			// 새로운 쿠키 전송
			response.addCookie(newCookie);
		}

		ItemInfoDTO item = service.selectByItemIndex(item_index);
		
		List<ReplyDTO> replyList = service.selectReplyByItemIndex(item_index);
		
		// 셀러 정보
		MemberDTO itemMember = service.selectByIndex(item.getItem_seller());		

		HashMap<String, Integer> map = new HashMap<>();
		map.put("item_seller", item.getItem_seller());
		map.put("item_index", item_index);

		// 해당 매물에 대한 판매자의 다른 상품
		List<ItemInfoDTO> otherItemList = service.selectByItemSeller(map);

		model.addAttribute("item", item);
		model.addAttribute("itemMember", itemMember);
		model.addAttribute("loginMember", loginMember);
		model.addAttribute("otherItemList", otherItemList);
		model.addAttribute("isInterested", isInterested);
		model.addAttribute("replyList", replyList);

		return "item/itemView";
	}

	// 댓글 달기
	@RequestMapping("/itemView/reply")
	public String writeReply(Model model, String content, int itemNo,
			@SessionAttribute(name = "loginMember", required = false) MemberDTO loginMember) {

		// 로그인 안되었으면
		if (loginMember == null) {
			model.addAttribute("msg", "로그인 후 이용 바랍니다.");
			model.addAttribute("location", "/account/login.do");
			return "common/msg";
		}

		// 댓글내용에 아무것도 입력하지 않으면
		if (content == null || content.trim().isEmpty()) {
			model.addAttribute("msg", "댓글을 입력하세요.");
			model.addAttribute("location", "/item/itemView?item_index=" + itemNo);
			return "common/msg";
		}

		ReplyDTO dto = new ReplyDTO();
		dto.setRepl_item(itemNo);
		dto.setRepl_content(content);
		dto.setRepl_candidate(loginMember.getAcc_index());
		dto.setRepl_nickname(loginMember.getAcc_nickname());
		
		// 댓글 저장 변수
		int result = service.saveReply(dto);
		if (result > 0) {
			model.addAttribute("msg", "리플이 등록되었습니다.");
		} else {
			model.addAttribute("msg", "리플 등록에 실패했습니다.");
		}

		// 댓글목록 조회
		List<ReplyDTO> replyList = service.selectReplyByItemIndex(itemNo);
		model.addAttribute("replyList", replyList);
		model.addAttribute("location", "/item/itemView?item_index=" + itemNo);

		return "common/msg";
	}

	// 댓글 지우기
	@RequestMapping("/itemView/replyDel")
	public String deleteReply(Model model, int replyNo, int itemNo) {
		Map<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("replyNo", replyNo);
		hmap.put("itemNo", itemNo);
		
		int result = service.deleteReply(hmap);
		if (result > 0) {
			model.addAttribute("msg", "댓글이 삭제되었습니다");
		} else {
			model.addAttribute("msg", "댓글 삭제에 실패했습니다");
		}
		model.addAttribute("location", "/item/itemView?item_index=" + itemNo);

		return "common/msg";
	}

	// 댓글 수정
	@RequestMapping("/itemView/replyEdit")
	public String editReply(Model model, String content, int replyNo, int itemNo) {

		ReplyDTO dto = new ReplyDTO();
		dto.setRepl_index(replyNo);
		dto.setRepl_content(content);

		int result = service.updateReply(dto);
		if (result > 0) {
			model.addAttribute("msg", "댓글이 수정되었습니다.");
		} else {
			model.addAttribute("msg", "댓글 수정에 실패했습니다.");
		}
		model.addAttribute("location", "/item/itemView?item_index=" + itemNo);

		return "common/msg";
	}

	// 관심 등록
	@RequestMapping(value = "/item/itemView/addInterest", method = RequestMethod.POST)
	public String addInterest(@RequestParam(value = "acc_index", required = false) Integer accIndex,
			@RequestParam("item_index") int itemIndex, Model model) {

		if (accIndex == null) {
			// acc_index가 null인 경우 로그인 페이지로 리디렉션
			model.addAttribute("msg", "로그인 후 이용해 주세요.");
			model.addAttribute("location", "/account/login.do"); // 로그인 페이지 URL로 설정
			return "common/msg"; // msg.jsp로 이동	
		}

		service.addInterest(acc_item_index(accIndex, itemIndex));

		// 성공 메시지와 함께 현재 페이지로 리디렉션
		model.addAttribute("msg", "관심 상품에 등록되었습니다.");
		model.addAttribute("location", "/item/itemView?item_index=" + itemIndex);
		return "common/msg"; // msg.jsp로 이동
	}

	// 관심등록 해제
	@PostMapping("/item/itemView/removeInterest")
	public String removeInterest(@RequestParam("acc_index") int accIndex, @RequestParam("item_index") int itemIndex,
			Model model) {

		service.removeInterest(acc_item_index(accIndex, itemIndex));

		model.addAttribute("msg", "관심 상품이 삭제되었습니다.");
		model.addAttribute("location", "/item/itemView?item_index=" + itemIndex);
		// 처리 후, 다시 뷰로 돌아가기
		return "common/msg";
	}

	// 계정 정보 저장
	public Map<String, Integer> acc_item_index(int acc_index, int item_index) {
		Map<String, Integer> map = new HashMap<>();
		map.put("acc_index", acc_index);
		map.put("item_index", item_index);

		return map;
	}
	
	// 물품 삭제
	@RequestMapping("/itemView/itemDel.do")
	public String itemDel(Model model, int item_index) {
		boolean check = service.deleteItem(item_index);
		if(check) {
			model.addAttribute("msg", "삭제가 완료됐습니다.");
			model.addAttribute("location", "/item/itemList.do");
		}else {
			model.addAttribute("msg", "삭제에 실패했습니다");
			model.addAttribute("location", "/item/itemView?item_index"+item_index);
		}
		return "common/msg";
	}
	
	// 물품 수정
	@RequestMapping("/item/itemEdit.do")
	public String editItem(Model model,int item_index){
		// 물품 정보 가져오기
		ItemInfoDTO item = service.selectByItemIndex(item_index);
	    
		model.addAttribute("item", item);
		
		return "/item/itemEdit";
	}
}
