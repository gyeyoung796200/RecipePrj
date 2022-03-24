package com.spring.recipe.controller;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponents;

import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.commons.paging.PageMaker;
import com.spring.recipe.commons.paging.SearchCriteria;
import com.spring.recipe.domain.BoardVO;
import com.spring.recipe.domain.MemberJoinBoardVO;
import com.spring.recipe.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	private BoardService service;
	
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public ModelAndView getBoardWrite() throws Exception{
		
		logger.info("get board write");
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("subtitle", "글작성");
		mav.addObject("mainData", "board/write.jsp");
		mav.setViewName("index");
		
		return mav;
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public ModelAndView postBoardWrite(BoardVO board) throws Exception{
		
		logger.info("post board write");
		
		ModelAndView mav = new ModelAndView();
		
		service.writeBoard(board);
		
		mav.addObject("mainData", "board/listCriteria.jsp");
		
		mav.setViewName("redirect:/board/listCriteria");
		
		return mav;
	}
	
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public ModelAndView getBoardRead(@RequestParam("bno")int bno, @ModelAttribute("searchCriteria") SearchCriteria criteria, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{

		ModelAndView mav = new ModelAndView();
		
		MemberJoinBoardVO board = service.selectBoard(bno);
		
		String loginId = session.getId(); //value값
		
		logger.info("세션에 있는 로그인 아이디: " +loginId);
		
		Cookie newCookie = null;
		
		//요청한 쿠키정보를 가져와 cookie배열에 담는다
		Cookie[] cookies = request.getCookies();
		
		//쿠키가 있으면
		if(cookies != null) {
			
			//반복문을 통해 쿠키를 돌면서
			for (Cookie cookie : cookies) {
				
				//쿠키가 이름이 readCookie과 같은게 있다면
				if(cookie.getName().equals("readCookie")) {
					
					//그쿠키를 newCookie에 담는다
					newCookie = cookie;
				}
			}
		}
		
		//newCookie가 있다면(readCookie가 존재한다면)
		if(newCookie != null) {
			
			//새로운 값이 bno를 포함하고있지않으면 값을 셋팅함
			if(!newCookie.getValue().contains("[" + bno + "]")) {
				
				service.updateViewCnt(bno);
				newCookie.setValue(newCookie.getValue() + "_[" + bno + "]");
				newCookie.setPath("/");
				newCookie.setMaxAge(60 * 60 * 24);
				response.addCookie(newCookie);
			}
		}
		
		//readCookie가 없으면
		else {
			
			//조회수를 증가하고 readCookie를 만듬
			service.updateViewCnt(bno);
			Cookie newnewCookie = new Cookie("readCookie", "[" + bno + "]");
			newnewCookie.setPath("/");
			newnewCookie.setMaxAge(60 * 60 * 24);
			response.addCookie(newnewCookie);
		}

		mav.addObject("subtitle", "상세정보");
		mav.addObject("board", board);
		mav.addObject("mainData", "board/read.jsp");
		mav.setViewName("index");
		
		return mav;
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public ModelAndView getBoardUpdate(@ModelAttribute("bno")int bno , @ModelAttribute("searchCriteria")SearchCriteria criteria) throws Exception{
		
		logger.info("get board update form");
		
		logger.info("넘겨받은 boardVO:"+ service.selectBoard(bno));
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("board", service.selectBoard(bno));
		mav.addObject("mainData", "board/update.jsp");
		
		mav.setViewName("index");
		
		return mav;
	}
	
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public ModelAndView postBoardUpdate(@ModelAttribute("board") BoardVO board, @ModelAttribute("searchCriteria")SearchCriteria criteria) throws Exception{
		
		logger.info("post board update");
		
		logger.info("넘겨받은 정보:"+board);
		
		ModelAndView mav = new ModelAndView();
		
		service.updateBoard(board);
		
		logger.info("수정하고 넘겨받은 정보:"+board);
		
		mav.addObject("mainData", "board/read.jsp");
		mav.addObject("board", service.selectBoard(board.getBno()));
		mav.setViewName("index");
		
		return mav;
	}
	
	@RequestMapping(value = "/findPassword", method = RequestMethod.POST)
	@ResponseBody
	public String findPassword(@RequestParam("bno")int bno) throws Exception{
		
		String pwd = service.boardPassword(bno);
		
		logger.info("글번호:"+bno +", 비밀번호:"+pwd);
		
		return pwd;
	}
	
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public ModelAndView postBoardDelete(int bno) throws Exception{
		
		logger.info("post board delete");
		
		service.deleteBoard(bno);
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("mainData", "board/listCriteria.jsp");
		
		mav.setViewName("index");
		
		return mav;
	}
	
	@RequestMapping(value = "/listCriteria", method = RequestMethod.GET)
	public ModelAndView getListCriteria(@ModelAttribute("searchCriteria") SearchCriteria cri, Model model) throws Exception{
		
		logger.info("get board ListCriteria");
		
		int cnt = service.boardCount();
		
		if(cnt == 0) {
			model.addAttribute("boardCount", 0);
		}
		else if(cnt != 0 ) {
			model.addAttribute("boardCount", 1);
		}
		
		PageMaker pageMaker = new PageMaker();
		
		pageMaker.setCriteria(cri);
		pageMaker.setTotalCount(service.boardCount());
		
		logger.info("넘겨 받은 현재 페이지 getCriteria:" + pageMaker.getCriteria().getPage());

		ModelAndView mav = new ModelAndView();
		
		
		mav.addObject("subtitle", "게시판");
		mav.addObject("pageMaker", pageMaker);
		mav.addObject("board", service.listCriteria(cri));
		mav.addObject("mainData", "board/listCriteria.jsp");
		mav.setViewName("index");
		
		return mav;
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public ModelAndView searchBoardList(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria, Model model) throws Exception{
		
		logger.info("search board list");
		logger.info("넘겨받은 searchType="+ searchCriteria.getSearchType());
		logger.info("넘겨받은 keyword="+  searchCriteria.getKeyword());
		
		int cnt = service.countSearchBoardList(searchCriteria);
		
		if(cnt == 0) {
			model.addAttribute("boardCount", 0);
		}
		else if(cnt != 0) {
			model.addAttribute("boardCount", 1);
		}
		
		logger.info("검색된 게시글의 개수:"+ service.countSearchBoardList(searchCriteria));
		
		PageMaker pageMaker = new PageMaker();
		
		pageMaker.setCriteria(searchCriteria);
		pageMaker.setTotalCount(service.countSearchBoardList(searchCriteria));
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("subtitle", "게시판");
		mav.addObject("pageMaker", pageMaker);
		mav.addObject("mainData", "board/listCriteria.jsp");
		mav.addObject("board", service.searchBoardList(searchCriteria));
		
		mav.setViewName("index");
		
		return mav;
	}
	
	
	
	
}
