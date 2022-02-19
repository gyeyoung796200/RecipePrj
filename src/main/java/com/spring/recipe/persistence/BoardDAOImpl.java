package com.spring.recipe.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.commons.paging.SearchCriteria;
import com.spring.recipe.domain.BoardVO;
import com.spring.recipe.domain.MemberJoinBoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	private static final String NAMESPACE = "com.spring.recipe.mappers.boardMapper";
	
	
	@Inject
	SqlSession session;


	@Override
	public void writeBoard(BoardVO boardVO) throws Exception {
		
		session.insert(NAMESPACE+".writeBoard", boardVO);
	}


	@Override
	public void updateBoard(BoardVO boardVO) throws Exception {

		
		session.update(NAMESPACE+".updateBoard", boardVO);
	}


	@Override
	public void deleteBoard(int bno) throws Exception {

		session.delete(NAMESPACE+".deleteBoard", bno);
	}


	@Override
	public String boardPassword(int bno) throws Exception {
		
		return session.selectOne(NAMESPACE+".boardPassword", bno);
	}


	@Override
	public int boardCount() throws Exception {
		
		return session.selectOne(NAMESPACE+".boardCount");
	}

	@Override
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {

		return session.selectList(NAMESPACE+".listCriteria", cri);
	}

	@Override
	public List<BoardVO> searchBoardList(SearchCriteria cri) throws Exception {

		return session.selectList(NAMESPACE+".searchBoardList", cri);
	}

	@Override
	public int countSearchBoardList(SearchCriteria cri) throws Exception {

		return session.selectOne(NAMESPACE+".countSearchBoardList", cri);
	}

	@Override
	public MemberJoinBoardVO selectBoard(int bno) throws Exception {

		return session.selectOne(NAMESPACE+".selectBoard", bno);
	}

	@Override
	public void updateReplyCnt(int bno, int amount) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bno", bno);
		map.put("amount", amount);
		
		session.update(NAMESPACE+".updateReplyCnt", map);
	}

	@Override
	public void updateViewCnt(int bno) throws Exception {

		session.update(NAMESPACE+".updateViewCnt", bno);
	}


	
	
	
}
