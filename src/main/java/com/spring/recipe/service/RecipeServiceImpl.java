package com.spring.recipe.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.commons.paging.SearchCriteria;
import com.spring.recipe.domain.RecipeVO;
import com.spring.recipe.persistence.RecipeDAO;

@Service
public class RecipeServiceImpl implements RecipeService {
	
	
	@Inject
	private RecipeDAO dao;

	@Override
	public void addRecipe(RecipeVO recipeVO) throws Exception {
		
		dao.addRecipe(recipeVO);
	}

	@Override
	public List<RecipeVO> recipeList() throws Exception {

		return dao.recipeList();
	}

	@Override
	public RecipeVO info(int recipe_no) throws Exception {

		return dao.info(recipe_no);
	}

	@Override
	public List<RecipeVO> listCirteriaRecipe(Criteria cri) throws Exception {

		return dao.listCirteriaRecipe(cri);
	}

	@Override
	public int totalCount() throws Exception {

		return dao.totalCount();
	}

	@Override
	public void update(RecipeVO recipeVO) throws Exception {

		dao.update(recipeVO);
	}

}
