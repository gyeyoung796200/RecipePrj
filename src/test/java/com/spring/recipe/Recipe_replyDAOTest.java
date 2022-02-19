package com.spring.recipe;


import javax.inject.Inject;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.spring.recipe.domain.Recipe_replyVO;
import com.spring.recipe.persistence.Recipe_replyDAO;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class Recipe_replyDAOTest {

	private static final Logger logger = LoggerFactory.getLogger(Recipe_replyDAOTest.class);
	
	
	@Inject
	private Recipe_replyDAO dao;
	
	
	@Ignore
	public void testInsert() throws Exception{
		
		Recipe_replyVO vo = new Recipe_replyVO();
		
		vo.setRecipe_no(1);
		vo.setReply_writer("레시피 댓글 작성자");
		vo.setReply_text("레시피 댓글 내용");
		vo.setReply_rating(5);
		
		dao.insert(vo);
		
		logger.info(vo.toString());
		
	}

	@Ignore
	public void testList() throws Exception{
		
	}
	
	@Ignore
	public void testReplyImageTest() throws Exception{
	}
	
	
	
	@Ignore
	public void testUpdate() throws Exception{
		
	}
	
	@Test
	public void testDelete() throws Exception{
		
	}
	
	
	@Ignore
	public void testPagingList() throws Exception{
		
	}
	
	
	
}
