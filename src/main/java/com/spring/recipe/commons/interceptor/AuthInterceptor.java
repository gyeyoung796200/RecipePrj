package com.spring.recipe.commons.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

//이용시 로그인이 안되있으면 로그인으로 이동되는 권한 설정
public class AuthInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
	
	
	//권한이되어 로그인할때 눌렀던곳으로 이동하게 함
	private void saveDestination(HttpServletRequest request) {
		
		String uri = request.getRequestURI();
		String query = request.getQueryString();
		
		if(query == null || query.equals("null")) {
			query = "";
		}
		else {
			query = "?" + query;
		}
		
		if(request.getMethod().equals("GET")) {
			logger.info("destinaition" + (uri+query));
			
			request.getSession().setAttribute("destination", uri + query);
		}
		
		
		
	}
	
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("login") == null) {
			
			
			logger.info("로그인이 안되었습니다");
			response.sendRedirect("/");
			
			return false;
		}
		
		return true;
	}
	
	
	

}
