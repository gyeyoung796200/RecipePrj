package com.spring.recipe;



import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.commons.paging.SearchCriteria;
import com.spring.recipe.domain.BoardVO;
import com.spring.recipe.persistence.BoardDAO;

import jdk.nashorn.internal.ir.annotations.Ignore;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class BoardDAOTest {
	
	
	private static final Logger logger = LoggerFactory.getLogger(BoardDAOTest.class);
	
	
	@Autowired
	BoardDAO dao;
	
	@Ignore
	public void testCreate() throws Exception{
		
		for(int i = 1; i <= 103; i++) {
			
			BoardVO board =  new BoardVO();
			board.setTitle(i+"번째 글");
			board.setContent("안녕하세요"+i+"번째 글이에요");
			board.setWriter("유저"+i);
			board.setB_pwd(i+"234");
			
			dao.writeBoard(board);
		}
		
	}
	
	@Ignore
	public void testListPaging() throws Exception{
		
	}
	
	@Ignore
	public void testListCriteria() throws Exception{
		
		Criteria cri = new Criteria();
		
		cri.setPage(3);
		
		List<BoardVO> list = dao.listCriteria(cri);
		
		for (BoardVO boardVO : list) {
			
			logger.info("게시글 번호:"+boardVO.getBno()+", 제목:"+boardVO.getTitle());
		}
		
	}
	
	@Ignore
	public void testUri() throws Exception{
		
		Criteria cri = new Criteria();
		
		cri.setPage(10);
		
		UriComponents uriComponents = UriComponentsBuilder.newInstance().path("/board/read").queryParam("bno", cri.getPage()).queryParam("perPageNum", cri.getPerPageNum()).build();
		
		logger.info("/board/read?bno=15&perPageNUm=20");
		logger.info(uriComponents.toString());
		
	}
	
	@Ignore
	public void testSearchList() throws Exception{
		
		
		SearchCriteria cri = new SearchCriteria();
		
		cri.setPage(1);
		cri.setKeyword("90");
		cri.setSearchType("t");
		
		List<BoardVO> list = dao.searchBoardList(cri);
		
		for (BoardVO boardVO : list) {
			
			logger.info("글번호:"+boardVO.getBno()+", 글제목:"+boardVO.getTitle());
		}
	}
	
	@Test
	public void testCountSearchList() throws Exception{
		
		SearchCriteria cri = new SearchCriteria();
		
		cri.setSearchType("t");
		cri.setKeyword("90");
		
		int count = dao.countSearchBoardList(cri);
		
		logger.info("검색된 게시글 개수:"+ count);
	}

}
