package com.spring.recipe.persistence;

import java.util.List;

import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.commons.paging.SearchCriteria;
import com.spring.recipe.domain.RecipeVO;

public interface RecipeDAO {
	
	
	//레시피 등록
	public void addRecipe(RecipeVO recipeVO) throws Exception;
	
	//레시피 목록
	public List<RecipeVO> recipeList() throws Exception;
	
	//레시피 정보
	public RecipeVO info(int recipe_no) throws Exception;
	
	
	//레시피 기본 페이징(하단 번호 없음)
	public List<RecipeVO> listCirteriaRecipe(Criteria cri) throws Exception;
	
	//레시피 총 개수
	public int totalCount() throws Exception;
	
	//레시피 수정
	public void update(RecipeVO recipeVO) throws Exception;
}
