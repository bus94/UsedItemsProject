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

	@RequestMapping("/item/itemView")
	public String itemView(Model model, int item_index,
			@SessionAttribute(name = "loginMember", required = false) MemberDTO loginMember, HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("itemView 페이지");
		System.out.println("item_index controlloer: " + loginMember);
		
		boolean isInterested=false;
		if(loginMember!=null){
			isInterested=service.isInterest(acc_item_index(loginMember.getAcc_index(),item_index));
		}
		
		acc_item_index(loginMember.getAcc_index(),item_index);
		// 조회수 증가 로직
		String cookieName = "itemView_" + item_index;
		Cookie[] cookies = request.getCookies();
		boolean viewed = false;

		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals(cookieName)) {
					viewed = true;
					break;
				}
			}
		}

		if (!viewed) {
			service.incrementViews(item_index);
			Cookie newCookie = new Cookie(cookieName, "true");
			newCookie.setMaxAge(3600); // 1시간 동안 유효
			newCookie.setPath("/");
			response.addCookie(newCookie);
		}

		ItemInfoDTO item = service.selectByItemIndex(item_index);
		String filePath = item.getItem_seller() + "/item_" + item.getItem_index() + "/";
		item.setItem_thumbPath(filePath + item.getShow_thumb());
		item.setItem_img1Path(filePath + item.getShow_img1());
		item.setItem_img2Path(filePath + item.getShow_img2());
		item.setItem_img3Path(filePath + item.getShow_img3());
		item.setItem_img4Path(filePath + item.getShow_img4());
		item.setItem_img5Path(filePath + item.getShow_img5());

		System.out.println("조회수 증가" + item.getItem_click());
		List<ReplyDTO> replyList = service.selectReplyByItemIndex(item_index);
		System.out.println("replyList: " + replyList); // []

		MemberDTO itemMember = service.selectByIndex(item.getItem_seller());
		System.out.println("item: " + item); // item
		System.out.println("itemMember: " + itemMember); // itemMember

		HashMap<String, Integer> map = new HashMap<>();
		map.put("item_seller", item.getItem_seller());
		map.put("item_index", item_index);

		// 해당 매물에 대한 판매자의 다른 상품
		List<ItemInfoDTO> otherItemList = service.selectByItemSeller(map);
		String filePathOther;
		for (int i = 0; i < otherItemList.size(); i++) {
			filePathOther = otherItemList.get(i).getItem_seller() + "/item_" + otherItemList.get(i).getItem_index()
					+ "/";
			otherItemList.get(i).setItem_thumbPath(filePathOther + otherItemList.get(i).getShow_thumb());
			otherItemList.get(i).setItem_img1Path(filePathOther + otherItemList.get(i).getShow_img1());
			otherItemList.get(i).setItem_img2Path(filePathOther + otherItemList.get(i).getShow_img2());
			otherItemList.get(i).setItem_img3Path(filePathOther + otherItemList.get(i).getShow_img3());
			otherItemList.get(i).setItem_img4Path(filePathOther + otherItemList.get(i).getShow_img4());
			otherItemList.get(i).setItem_img5Path(filePathOther + otherItemList.get(i).getShow_img5());
		}

		System.out.println();
		System.out.println("otherItemList: " + otherItemList.size() + "개");
		for (int i = 0; i < otherItemList.size(); i++) {
			System.out.println("otherItemList: " + otherItemList.get(i));
		}
		System.out.println();

		model.addAttribute("item", item);
		model.addAttribute("itemMember", itemMember);
		model.addAttribute("loginMember", loginMember);
		model.addAttribute("otherItemList", otherItemList);
		model.addAttribute("isInterested",isInterested);
		// 댓글 목록을 모델에 추가
		model.addAttribute("replyList", replyList);

		return "item/itemView";
	}

	@RequestMapping("/itemView/reply")
	public String writeReply(Model model, String content, int itemNo,
			@SessionAttribute(name = "loginMember", required = false) MemberDTO loginMember) {
		System.out.println("writeReply() 실행");
		System.out.println("itemNo: " + itemNo);
		System.out.println("content: " + content);

		if (loginMember == null) {
			model.addAttribute("msg", "로그인 후 이용 바랍니다.");
			model.addAttribute("location", "/account/login.do");
			return "common/msg";
		}

		if (content == null || content.trim().isEmpty()) {
			model.addAttribute("msg", "댓글을 입력하세요.");
			model.addAttribute("location", "/item/itemView?item_index=" + itemNo);
			return "common/msg";
		}

		ReplyDTO dto = new ReplyDTO();
		dto.setRepl_item(itemNo);
		dto.setRepl_content(content);
		dto.setRepl_nickname(loginMember.getAcc_nickname());

		int result = service.saveReply(dto);
		if (result > 0) {
			model.addAttribute("msg", "리플이 등록되었습니다.");
		} else {
			model.addAttribute("msg", "리플 등록에 실패했습니다.");
		}

		// 댓글 목록 다시 조회
		List<ReplyDTO> replyList = service.selectReplyByItemIndex(itemNo);
		model.addAttribute("replyList", replyList);

		model.addAttribute("location", "/item/itemView?item_index=" + itemNo);

		return "common/msg";
	}

	@RequestMapping("/itemView/replyDel")
	public String deleteReply(Model model, int replyNo, int itemNo) {
		System.out.println("deleteReply() 실행");
		System.out.println(replyNo + "+" + itemNo);
		Map<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("replyNo", replyNo);
		int result = service.deleteReply(hmap);
		if (result > 0) {
			model.addAttribute("msg", "댓글이 삭제되었습니다");
		} else {
			model.addAttribute("msg", "댓글 삭제에 실패했습니다");
		}
		model.addAttribute("location", "/item/itemView?item_index=" + itemNo);

		return "common/msg";
	}

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

	@RequestMapping(value = "/item/itemView/addInterest", method = RequestMethod.POST)
	public String addInterest(@RequestParam(value = "acc_index", required = false) Integer accIndex,
			@RequestParam("item_index") int itemIndex, Model model) {

		if (accIndex == null) {
			// acc_index가 null인 경우 로그인 페이지로 리디렉션
			model.addAttribute("msg", "로그인 후 이용해 주세요.");
			model.addAttribute("location", "/login"); // 로그인 페이지 URL로 설정
			return "common/msg"; // msg.jsp로 이동
		}

		// 관심 항목 추가 로직 수행
		System.out.println("acc_index: " + accIndex + "\nitem_index: " + itemIndex);
		

		service.addInterest(acc_item_index(accIndex,itemIndex));

		// 성공 메시지와 함께 현재 페이지로 리디렉션
		model.addAttribute("msg", "관심 상품에 등록되었습니다.");
		model.addAttribute("location", "/item/itemView?item_index=" + itemIndex);
		return "common/msg"; // msg.jsp로 이동
	}
	
	@PostMapping("/item/itemView/removeInterest")
	public String removeInterest(@RequestParam("acc_index") int accIndex,
	                             @RequestParam("item_index") int itemIndex, Model model) {
		
	    service.removeInterest(acc_item_index(accIndex,itemIndex));
	    
	    model.addAttribute("msg","관심 상품이 삭제되었습니다.");
	    model.addAttribute("location", "/item/itemView?item_index=" + itemIndex);
	    // 처리 후, 다시 뷰로 돌아가기
	    return "common/msg";
	}
	public Map<String, Integer> acc_item_index(int acc_index,int item_index){
		Map<String, Integer> map = new HashMap<>();
		map.put("acc_index", acc_index);
		map.put("item_index", item_index);
		
		return map;
	}

}
