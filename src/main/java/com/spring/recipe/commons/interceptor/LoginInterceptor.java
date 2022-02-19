package com.spring.recipe.commons.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

//로그인을 할떄 먼저 LoginInterceptor에서 처리가 된다
public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	
	private static final String LOGIN = "login";
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);



	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		HttpSession session = request.getSession();
		ModelMap modelMap = modelAndView.getModelMap();
		
		Object memberVO = modelMap.get("member");
		
		if(memberVO != null) {
			logger.info("new login access");
			session.setAttribute(LOGIN, memberVO);
			
			
		if(request.getParameter("useCookie") != null) {
			
			logger.info("login Cookie keep");
			
			//쿠키생성
			Cookie loginCookie = new Cookie("loginCookie", session.getId());
			loginCookie.setPath("/");
			loginCookie.setMaxAge(60*60*24*7);

			response.addCookie(loginCookie);
		}
			
			Object destination = session.getAttribute("destination");
			
			response.sendRedirect(destination != null ? (String) destination : "/");
		}
	}
	
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute(LOGIN) != null) {
			
			logger.info("clear login data");
			session.removeAttribute(LOGIN);
		}
		
		return true;
	}
}
