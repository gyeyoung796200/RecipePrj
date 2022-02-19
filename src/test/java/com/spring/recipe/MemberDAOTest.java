package com.spring.recipe;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.recipe.domain.MemberVO;
import com.spring.recipe.persistence.MemberDAO;



@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class MemberDAOTest {

	
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOTest.class);
	
	@Inject
	private MemberDAO dao;
	
	
	
	/*
	@Test
	public void insertMember() throws Exception {
		
		MemberVO memberVO = new MemberVO();
		
		memberVO.setUser_id("Test Member");
		memberVO.setUser_pw("1234");
		memberVO.setUser_name("테스트맴버");
		memberVO.setUser_gender("남");
	
		dao.insertMember(memberVO);
		
		logger.info("가입된 회원정보는 "+ memberVO);
	}
	 */
	
	@Test
	public void readMember() throws Exception{
		
		
//		dao.infoMember("test");
		
		
		
	}
	
	
	
	
}
