package com.ss.useditems.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ss.useditems.dto.ItemDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.dto.ReplyDTO;
import com.ss.useditems.service.ItemViewService;

@Controller
public class ItemViewController {
	
	@Autowired
	private ItemViewService service;

	@RequestMapping("/item/itemView")
	public String itemView(Model model, int item_index) {
		System.out.println("itemView 페이지");
		System.out.println("item_index: " + item_index);
		
		ItemDTO item = service.selectByItemIndex(item_index);

		MemberDTO itemMember = service.selectByIndex(item.getItem_seller());
		System.out.println("item: " + item);
		System.out.println("itemMember: " + itemMember);
		
		model.addAttribute("item", item);
		model.addAttribute("itemMember", itemMember);
		
		model.addAttribute("replyList", item.getReplies());
		
		return "item/itemView";
	}
	
	@RequestMapping("/itemView/reply")
	public String writeReply(Model model, String content,int itemNo,
			@SessionAttribute(name="loginMember",required = false) MemberDTO loginMember) {
		System.out.println(itemNo);
		System.out.println(content);
		ReplyDTO dto = new ReplyDTO();
		dto.setRepl_item(itemNo);
//		reply.setRepl_index(loginMember.getAcc_index());
		int result = service.saveReply(dto);
		if(result > 0) {
			model.addAttribute("msg","리플이 등록되었습니다.");
		}else {
			model.addAttribute("msg","리플 등록에 실패했습니다.");
		}
		model.addAttribute("location",  "/item/itemView?item_index=" + itemNo);
		
		return "common/msg";
	}
	
	@PostMapping("/incrementViews")
	public void incrementViews(@RequestParam Long itemId, HttpServletRequest request, HttpServletResponse response) {
	    String cookieName = "itemView_" + itemId;
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
	        service.incrementViews(itemId);
	        Cookie newCookie = new Cookie(cookieName, "true");
	        newCookie.setMaxAge(3600); // 1시간 동안 유효
	        newCookie.setPath("/");
	        response.addCookie(newCookie);
	    }

	    response.setStatus(HttpServletResponse.SC_OK); // 상태 코드 200 설정
	}
}
