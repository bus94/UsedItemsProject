package com.ss.useditems;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ss.useditems.dto.BlacklistDTO;
import com.ss.useditems.dto.ItemDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.service.BlacklistService;

@Controller
public class HomeController {
	
	
	@Autowired
	private BlacklistService blackService;
	
	
	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		
		
		//아이템 new5
		ArrayList<ItemDTO> new5;
		
		new5 = blackService.getNew5();//임시로 블랙서비스에서 실행, 안겹치려고
		System.out.println("HomeCont new5 result: "+new5.size()+"개" + new5);

		model.addAttribute("new5", new5);
		
		
		//아이템 hot5(현재 판매 중인 아이템 중 관심상품 순//DB에 더미데이터가 불안해서 조인으로 구함
		ArrayList<ItemDTO> hot5;
		hot5 = blackService.getHot5();//임시로 블랙서비스에서 실행, 안겹치려고
		
		model.addAttribute("hot5", hot5);
		
		
		
		//파워셀러의 last3
		MemberDTO powerSeller = new MemberDTO();
		//임시로 블랙서비스에서 실행, 안겹치려고
		powerSeller = blackService.getPowerSeller();
		model.addAttribute("powerSeller", powerSeller);//DB에 거래성사 건이 별로 없어서 매물 등록 최다 계정으로...
		
		//파워셀러의 최근 매물 3개 가져오기
		ArrayList<ItemDTO> last3;

		
		
		
		
		//블랙리스트 top5
		ArrayList<MemberDTO> black5;
		
		black5 = blackService.getBlack5();
		
		model.addAttribute("black5", black5);
		
		
		
		return "home";
		
		
//		return "home2"; //테스트페이지로 연결하면 홈2에서 불러와요
	}
	
}
