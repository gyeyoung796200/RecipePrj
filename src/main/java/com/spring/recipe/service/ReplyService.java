package com.spring.recipe.service;

import java.util.List;

import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.domain.ReplyJoinMemberVO;
import com.spring.recipe.domain.ReplyVO;

public interface ReplyService {
	
	//댓글 리스트
	public List<ReplyVO> list(int bno) throws Exception;
	
	//댓글 작성
	public void insert(ReplyVO replyVO) throws Exception;
	
	//댓글 수정
	public void update(ReplyVO replyVO) throws Exception;
	
	//댓글 삭제
	public void delete(int reply_no) throws Exception;
	
	//댓글 페이징
	public List<ReplyVO> pagingList(int bno, Criteria cri) throws Exception;
	
	//댓글 개수
	public int countReply(int bno) throws Exception; 
}
