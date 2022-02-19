package com.spring.recipe.persistence;

import java.util.List;

import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.domain.ReplyJoinMemberVO;
import com.spring.recipe.domain.ReplyVO;

public interface ReplyDAO {
	
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
	
	//댓글의 게시글 번호 조회 (댓글 갱신위해서 작성) transaction 처리
	public int getBno(int reply_no) throws Exception;
	
}
