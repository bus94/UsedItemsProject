package com.ss.useditems.controller;

import java.util.List;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.ss.useditems.dto.ItemDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.dto.ReplyDTO;
import com.ss.useditems.service.ItemViewService;

@Controller
public class ItemViewController {
	
	@Autowired
	private ItemViewService service;

	@RequestMapping("/item/itemView")
	public String itemView(Model model, int item_index, @SessionAttribute(name="loginMember", required = false) MemberDTO loginMember,HttpServletRequest request, HttpServletResponse response) {
		System.out.println("itemView 페이지");
		System.out.println("item_index: " + item_index);
		
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
       
        
        
		ItemDTO item = service.selectByItemIndex(item_index);
		 System.out.println("조회수 증가" +item.getItem_click());
		List<ReplyDTO> replyList = service.selectReplyByItemIndex(item_index);
		System.out.println("replyList: " + replyList); // []
		
		MemberDTO itemMember = service.selectByIndex(item.getItem_seller());
		System.out.println("item: " + item); // item
		System.out.println("itemMember: " + itemMember); // itemMember
		
		model.addAttribute("item", item);
		model.addAttribute("itemMember", itemMember);
		 model.addAttribute("loginMember", loginMember);
		
		// 댓글 목록을 모델에 추가
	    model.addAttribute("replyList", replyList);
	    
	   
		
		return "item/itemView";
	}
	
	@RequestMapping("/itemView/reply")
	public String writeReply(Model model, String content, int itemNo,
	        @SessionAttribute(name="loginMember", required = false) MemberDTO loginMember) {
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
	
}

