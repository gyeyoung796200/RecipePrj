package com.spring.recipe.service;

import java.util.List;

import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.commons.paging.SearchCriteria;
import com.spring.recipe.domain.RecipeVO;

public interface RecipeService {
	
	
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
	
	//레시피 검색
	public List<RecipeVO> searchList(SearchCriteria cri) throws Exception;
	
	//레시피 검색결과 수
	public int searchCount(SearchCriteria cri) throws Exception;
	
	//레시피 삭제
	public void delete(int recipe_no) throws Exception;
	
	
	//레시피 타입검색
	public List<RecipeVO> searchRecipeList(SearchCriteria cri) throws Exception;
		
	//레시피 타입 검색결과 수
	public int searchRecipeCount(SearchCriteria cri) throws Exception; 

	//조회수 증가
	public void updateViewCnt(int recipe_no) throws Exception;
}
