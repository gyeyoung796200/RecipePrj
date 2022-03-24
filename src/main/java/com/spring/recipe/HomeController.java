package com.spring.recipe;


import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.commons.paging.PageMaker;
import com.spring.recipe.commons.paging.SearchCriteria;
import com.spring.recipe.service.RecipeService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	

	/*
	@RequestMapping(value="/", method = RequestMethod.GET)
	public String index(Model model) {
		
		
		return "index";
	}
	*/
	
	
	@Inject
	private RecipeService service;
	
	
	/*  검색 안되는 리스트
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView getRecipeListCriteria(@ModelAttribute("criteria") Criteria cri) throws Exception {

		logger.info("get Recipe listCriteria");

		cri.setPerPageNum(12);

		logger.info("크리테리아 정보: " + cri.toString());

		PageMaker pageMaker = new PageMaker();

		pageMaker.setCriteria(cri);
		pageMaker.setTotalCount(service.totalCount());

		logger.info("페이지 메이커 정보: " + pageMaker.toString());

		ModelAndView mav = new ModelAndView();

		mav.addObject("mainData", "recipe/list.jsp");
		mav.addObject("pageMaker", pageMaker);
		mav.addObject("recipe", service.listCirteriaRecipe(cri));

		mav.setViewName("index");

		return mav;
	}
	
	*/
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView getRecipeListCriteria(@ModelAttribute("criteria") SearchCriteria cri) throws Exception {

		logger.info("get Recipe search optionlist");

		cri.setPerPageNum(12);

		logger.info("크리테리아 정보: " + cri.toString());

		PageMaker pageMaker = new PageMaker();

		pageMaker.setCriteria(cri);
		pageMaker.setTotalCount(service.totalCount());

		logger.info("페이지 메이커 정보: " + pageMaker.toString());

		ModelAndView mav = new ModelAndView();

		mav.addObject("mainData", "recipe/list.jsp");
		mav.addObject("pageMaker", pageMaker);
		mav.addObject("recipe", service.listCirteriaRecipe(cri));

		mav.setViewName("index");

		return mav;
	}
	
	
	@RequestMapping(value = "/handlebars", method = RequestMethod.GET)
	public String handlebars() throws Exception{
		
		
		return "include/handlebars";
	}
	
	
}
