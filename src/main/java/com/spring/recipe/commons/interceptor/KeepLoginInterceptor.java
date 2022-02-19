package com.spring.recipe.commons.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.spring.recipe.domain.MemberVO;
import com.spring.recipe.service.MemberService;

public class KeepLoginInterceptor extends HandlerInterceptorAdapter{

	
	private static final Logger logger = LoggerFactory.getLogger(KeepLoginInterceptor.class);
	
	
	@Inject
	private MemberService service;
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		
		HttpSession session = request.getSession();
		
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		
		if(loginCookie != null) {
			
			MemberVO member = service.checkSessionKey(loginCookie.getValue());
			
			if(member != null) {

				session.setAttribute("login", member);
			}
			
		}
		return true;
	}
	
}
