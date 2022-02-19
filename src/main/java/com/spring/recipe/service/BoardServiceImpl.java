package com.spring.recipe.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.commons.paging.SearchCriteria;
import com.spring.recipe.domain.BoardVO;
import com.spring.recipe.domain.MemberJoinBoardVO;
import com.spring.recipe.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {

	
	@Inject
	private BoardDAO dao;

	@Override
	public void writeBoard(BoardVO boardVO) throws Exception {
		
		dao.writeBoard(boardVO);
	}

	@Override
	public void updateBoard(BoardVO boardVO) throws Exception {

		dao.updateBoard(boardVO);
	}

	@Override
	public void deleteBoard(int bno) throws Exception {

		dao.deleteBoard(bno);
	}
	
	@Override
	public String boardPassword(int bno) throws Exception {
		
		return dao.boardPassword(bno);
	}

	@Override
	public int boardCount() throws Exception {

		return dao.boardCount();
	}

	@Override
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {

		return dao.listCriteria(cri);
	}

	@Override
	public List<BoardVO> searchBoardList(SearchCriteria cri) throws Exception {

		return dao.searchBoardList(cri);
	}

	@Override
	public int countSearchBoardList(SearchCriteria cri) throws Exception {

		return dao.countSearchBoardList(cri);
	}

//	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public MemberJoinBoardVO selectBoard(int bno) throws Exception {

//		dao.updateViewCnt(bno);
		return dao.selectBoard(bno);
	}

	@Override
	public void updateViewCnt(int bno) throws Exception {

		dao.updateViewCnt(bno);
	}

}
