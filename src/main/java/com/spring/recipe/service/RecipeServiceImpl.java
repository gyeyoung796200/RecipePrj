package com.spring.recipe.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

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

	
	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public RecipeVO info(int recipe_no) throws Exception {

//		dao.updateViewCnt(recipe_no);
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

	@Override
	public List<RecipeVO> searchList(SearchCriteria cri) throws Exception {

		return dao.searchList(cri);
	}

	@Override
	public int searchCount(SearchCriteria cri) throws Exception {

		return dao.searchCount(cri);
	}

	@Override
	public void delete(int recipe_no) throws Exception {

		dao.delete(recipe_no);
	}

	@Override
	public List<RecipeVO> searchRecipeList(SearchCriteria cri) throws Exception {

		return dao.searchRecipeList(cri);
	}

	@Override
	public int searchRecipeCount(SearchCriteria cri) throws Exception {
		
		return dao.searchRecipeCount(cri);
	}

	@Override
	public void updateViewCnt(int recipe_no) throws Exception {

		dao.updateViewCnt(recipe_no);
	}
	
	

}
