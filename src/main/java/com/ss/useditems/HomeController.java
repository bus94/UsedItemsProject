package com.ss.useditems;

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
import com.ss.useditems.service.BlacklistService;

@Controller
public class HomeController {
	
	
	@Autowired
	private BlacklistService blackService;
	
	
	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		
		
		
		
		
		
		//블랙리스트 top5
		List<BlacklistDTO> black5;
		
//		black5 = blackService.getHome();
		
		
		
		
		return "home";
//		return "home2"; //테스트페이지 연결
	}
	
}
