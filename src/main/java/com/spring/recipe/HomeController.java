package com.spring.recipe;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	

	
	@RequestMapping(value="/", method = RequestMethod.GET)
	public String index() {
		
		return "index";
	}
	
	
	@RequestMapping(value = "/handlebars", method = RequestMethod.GET)
	public String handlebars() throws Exception{
		
		
		return "include/handlebars";
	}
	
	
}
