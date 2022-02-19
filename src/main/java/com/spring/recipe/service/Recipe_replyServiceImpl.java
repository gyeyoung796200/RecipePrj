package com.spring.recipe.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.domain.Recipe_replyVO;
import com.spring.recipe.persistence.Recipe_replyDAO;

@Service
public class Recipe_replyServiceImpl implements Recipe_replyService {
	
	@Inject
	private Recipe_replyDAO dao;

	@Override
	public List<Recipe_replyVO> list(int recipe_no) throws Exception {
		
		return dao.list(recipe_no);
	}

	@Override
	public void insert(Recipe_replyVO recipe_replyVO) throws Exception {

		dao.insert(recipe_replyVO);
	}

	@Override
	public void update(Recipe_replyVO recipe_replyVO) throws Exception {

		dao.update(recipe_replyVO);
	}

	@Override
	public void delete(int reply_no) throws Exception {

		dao.delete(reply_no);
	}

	@Override
	public int countReply(int recipe_no) throws Exception {

		return dao.countReply(recipe_no);
	}

	@Override
	public int getRecipe_no(int reply_no) throws Exception {
		
		return dao.getRecipe_no(reply_no);
	}

	@Override
	public List<Recipe_replyVO> listPaging(int recipe_no, Criteria cri) throws Exception {
		
		return dao.listPaging(recipe_no, cri);
	}

}
