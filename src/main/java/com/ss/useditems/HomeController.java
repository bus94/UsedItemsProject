package com.ss.useditems;

import java.util.ArrayList;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ss.useditems.dto.ItemInfoDTO;
import com.ss.useditems.dto.MemberDTO;
import com.ss.useditems.service.HomeService;

@Controller
public class HomeController {

	@Autowired
	private HomeService homeService;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		// 아이템 new5
		ArrayList<ItemInfoDTO> new5;

		new5 = homeService.getNew5();// 임시로 블랙서비스에서 실행, 안겹치려고
		System.out.println("HomeCont new5 result: " + new5.size() + "개" + new5);
		System.out.println();

		// 이미지 파일을 불러올 때 필요한 경로를 저장
		String filePath;
		for (int i = 0; i < new5.size(); i++) {
			filePath = new5.get(i).getItem_seller() + "/item_" + new5.get(i).getItem_index() + "/";
			new5.get(i).setItem_thumbPath(filePath + new5.get(i).getShow_thumb());
			new5.get(i).setItem_img1Path(filePath + new5.get(i).getShow_img1());
			new5.get(i).setItem_img2Path(filePath + new5.get(i).getShow_img2());
			new5.get(i).setItem_img3Path(filePath + new5.get(i).getShow_img3());
			new5.get(i).setItem_img4Path(filePath + new5.get(i).getShow_img4());
			new5.get(i).setItem_img5Path(filePath + new5.get(i).getShow_img5());
		}
		
		model.addAttribute("new5", new5);

		// 아이템 hot5
		ArrayList<ItemInfoDTO> hot5;
		hot5 = homeService.getHot5();// 임시로 블랙서비스에서 실행, 안겹치려고
		
		for (int i = 0; i < hot5.size(); i++) {
			filePath = hot5.get(i).getItem_seller() + "/item_" + hot5.get(i).getItem_index() + "/";
			hot5.get(i).setItem_thumbPath(filePath + hot5.get(i).getShow_thumb());
			hot5.get(i).setItem_img1Path(filePath + hot5.get(i).getShow_img1());
			hot5.get(i).setItem_img2Path(filePath + hot5.get(i).getShow_img2());
			hot5.get(i).setItem_img3Path(filePath + hot5.get(i).getShow_img3());
			hot5.get(i).setItem_img4Path(filePath + hot5.get(i).getShow_img4());
			hot5.get(i).setItem_img5Path(filePath + hot5.get(i).getShow_img5());
		}

		model.addAttribute("hot5", hot5);

		// 파워셀러의 last3
		//MemberDTO powerSeller = new MemberDTO();
		// 임시로 블랙서비스에서 실행, 안겹치려고
		//powerSeller = homeService.getPowerSeller();
		//model.addAttribute("powerSeller", powerSeller);// DB에 거래성사 건이 별로 없어서 매물 등록 최다 계정으로...

		// 파워셀러의 최근 매물 3개 가져오기
		//ArrayList<ItemInfoDTO> last3;

		// 블랙리스트 top5
		//ArrayList<MemberDTO> black5;

		//black5 = homeService.getBlack5();

		//model.addAttribute("black5", black5);

		return "home";

	}

}
