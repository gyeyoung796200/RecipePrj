package com.spring.recipe.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/reply")
public class ReplyTestController {

	
	@RequestMapping("/test")
	public ModelAndView replyAjaxTest() {
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("mainData", "replyTest.jsp");
		mav.setViewName("index");
		
		return mav;
	}
}
