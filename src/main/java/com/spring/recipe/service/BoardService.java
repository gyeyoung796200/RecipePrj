package com.spring.recipe.service;

import java.util.List;

import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.commons.paging.SearchCriteria;
import com.spring.recipe.domain.BoardVO;
import com.spring.recipe.domain.MemberJoinBoardVO;

public interface BoardService {

	
	//게시글 개수
	public int boardCount() throws Exception;

	//게시글 작성
	public void writeBoard(BoardVO boardVO) throws Exception;
	
	//게시글 수정
	public void updateBoard(BoardVO boardVO) throws Exception;
	
	//게시글 삭제
	public void deleteBoard(int bno) throws Exception;
	
	//게시글 보기 사진나오게
	public MemberJoinBoardVO selectBoard(int bno) throws Exception;
	
	//게시글 삭제를 위한 비밀번호 가져오기
	public String boardPassword(int bno) throws Exception;
	
	
	//-------------------------
	
	//페이징
	//criteria 페이징 게시글 목록
	public List<BoardVO> listCriteria(Criteria cri) throws Exception;
	
	//검색목록
	public List<BoardVO> searchBoardList(SearchCriteria cri) throws Exception;
		
	//검색된 게시글 개수
	public int countSearchBoardList(SearchCriteria cri) throws Exception;
	
	//조회수 갱신
	public void updateViewCnt(int bno) throws Exception;
}
