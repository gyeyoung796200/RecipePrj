package com.spring.recipe.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.domain.ReplyJoinMemberVO;
import com.spring.recipe.domain.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	private static final String NAMESPACE = "com.spring.recipe.mappers.replyMapper";
	
	@Inject
	private SqlSession session;

	@Override
	public List<ReplyVO> list(int bno) throws Exception {

		return session.selectList(NAMESPACE+".list", bno);
	}

	@Override
	public void insert(ReplyVO replyVO) throws Exception {

		session.insert(NAMESPACE+".insert", replyVO);
	}

	@Override
	public void update(ReplyVO replyVO) throws Exception {

		session.update(NAMESPACE+".update", replyVO);
	}

	@Override
	public void delete(int reply_no) throws Exception {

		session.delete(NAMESPACE+".delete", reply_no);
	}

	@Override
	public List<ReplyVO> pagingList(int bno, Criteria cri) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("bno", bno);
		map.put("criteria", cri);
		
		return session.selectList(NAMESPACE+".pagingList", map);
	}

	@Override
	public int countReply(int bno) throws Exception {

		return session.selectOne(NAMESPACE+".countReply", bno);
	}

	@Override
	public int getBno(int reply_no) throws Exception {

		return session.selectOne(NAMESPACE+".getBno", reply_no);
	}

	
	
}
