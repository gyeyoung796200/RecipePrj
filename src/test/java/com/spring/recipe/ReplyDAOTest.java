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
import org.springframework.test.context.web.WebAppConfiguration;

import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.domain.ReplyJoinMemberVO;
import com.spring.recipe.domain.ReplyVO;
import com.spring.recipe.persistence.ReplyDAO;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class ReplyDAOTest {

	private static final Logger logger = LoggerFactory.getLogger(ReplyDAOTest.class);
	
	
	@Inject
	private ReplyDAO dao;
	
	
	@Ignore
	public void testInsert() throws Exception{
		
		for(int i = 1; i <= 50; i++) {
			
			ReplyVO reply = new ReplyVO();
			
			reply.setBno(1);
			reply.setReply_writer("댓글작성자++"+i);
			reply.setReply_text("댓글 내용++"+i);

			dao.insert(reply);
		}
	}

	@Ignore
	public void testList() throws Exception{
		
	}
	
	@Test
	public void testReplyImageTest() throws Exception{
		
	}
	
	
	
	
	@Ignore
	public void testUpdate() throws Exception{
		
		ReplyVO reply = new ReplyVO();
		
		reply.setReply_no(2);
		reply.setReply_text("내용++수정");

		dao.update(reply);
	}
	
	@Ignore
	public void testDelete() throws Exception{
		
		dao.delete(2);
	}
	
	
	@Ignore
	public void testPagingList() throws Exception{
		
		logger.info("보여질 글정보:"+dao.list(1));
		
		Criteria cri = new Criteria();
		
		cri.setPage(1);
		cri.setPerPageNum(10);
		
		List<ReplyVO> list = new ArrayList<ReplyVO>();
		
		list = dao.pagingList(1, cri);
		
		for (ReplyVO replyVO : list) {
			
			logger.info("댓글정보:"+ replyVO);
		}
	}
	
	
	
}
