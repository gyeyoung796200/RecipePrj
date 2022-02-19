package com.spring.recipe.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.domain.ReplyJoinMemberVO;
import com.spring.recipe.domain.ReplyVO;
import com.spring.recipe.persistence.BoardDAO;
import com.spring.recipe.persistence.ReplyDAO;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	
	
	@Inject
	private ReplyDAO replyDAO;
	
	@Inject
	private BoardDAO boardDAO;
	
	
	@Override
	public List<ReplyVO> list(int bno) throws Exception {

		return replyDAO.list(bno);
	}
	
	@Transactional
	@Override
	public void insert(ReplyVO replyVO) throws Exception {

		replyDAO.insert(replyVO);
		
		boardDAO.updateReplyCnt(replyVO.getBno(), 1);
	}

	@Override
	public void update(ReplyVO replyVO) throws Exception {

		replyDAO.update(replyVO);
	}

	@Transactional
	@Override
	public void delete(int reply_no) throws Exception {

		replyDAO.delete(reply_no);
		boardDAO.updateReplyCnt(replyDAO.getBno(reply_no), -1);
	}
	

	@Override
	public List<ReplyVO> pagingList(int bno, Criteria cri) throws Exception {

		return replyDAO.pagingList(bno, cri);
	}

	@Override
	public int countReply(int bno) throws Exception {

		return replyDAO.countReply(bno);
	}

}
