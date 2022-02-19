package com.spring.recipe.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.domain.Recipe_replyVO;

@Repository
public class Recipe_replyDAOImpl implements Recipe_replyDAO {

	private static final String NAMESPACE = "com.spring.recipe.mappers.recipeReplyMapper";
	
	@Inject
	private SqlSession session;

	@Override
	public List<Recipe_replyVO> list(int recipe_no) throws Exception {

		return session.selectList(NAMESPACE+".list", recipe_no);
	}

	@Override
	public void insert(Recipe_replyVO recipe_replyVO) throws Exception {

		session.insert(NAMESPACE+".insert", recipe_replyVO);
	}

	@Override
	public void update(Recipe_replyVO recipe_replyVO) throws Exception {

		session.update(NAMESPACE+".update", recipe_replyVO);
	}

	@Override
	public void delete(int reply_no) throws Exception {

		session.delete(NAMESPACE+".delete", reply_no);
	}

	@Override
	public int countReply(int recipe_no) throws Exception {

		return session.selectOne(NAMESPACE+".countReply", recipe_no);
	}

	@Override
	public int getRecipe_no(int reply_no) throws Exception {
		
		return session.selectOne(NAMESPACE+".getRecipe_no", reply_no);
	}

	@Override
	public List<Recipe_replyVO> listPaging(int recipe_no, Criteria cri) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("recipe_no", recipe_no);
		map.put("cri", cri);

		return session.selectList(NAMESPACE+".listPaging", map);
	}

}
