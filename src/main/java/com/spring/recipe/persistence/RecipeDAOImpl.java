package com.spring.recipe.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.commons.paging.SearchCriteria;
import com.spring.recipe.domain.RecipeVO;

@Repository
public class RecipeDAOImpl implements RecipeDAO {
	
	
	private static final String NAMESPACE = "com.spring.recipe.mappers.recipeMapper";
	
	
	@Inject
	private SqlSession session;
	

	@Override
	public void addRecipe(RecipeVO recipeVO) throws Exception {

		session.insert(NAMESPACE+".addRecipe", recipeVO);
	}


	@Override
	public List<RecipeVO> recipeList() throws Exception {

		return session.selectList(NAMESPACE+".listRecipe");
	}


	@Override
	public RecipeVO info(int recipe_no) throws Exception {

		return session.selectOne(NAMESPACE+".info", recipe_no);
	}


	@Override
	public List<RecipeVO> listCirteriaRecipe(Criteria cri) throws Exception {
		
		return session.selectList(NAMESPACE+".listCirteriaRecipe", cri);
	}


	@Override
	public int totalCount() throws Exception {

		return session.selectOne(NAMESPACE+".totalCount");
	}


	@Override
	public void update(RecipeVO recipeVO) throws Exception {

		session.update(NAMESPACE+".update", recipeVO);
	}


	@Override
	public List<RecipeVO> searchList(SearchCriteria cri) throws Exception {

		return session.selectList(NAMESPACE+".searchList", cri);
	}


	@Override
	public int searchCount(SearchCriteria cri) throws Exception {
		
		return session.selectOne(NAMESPACE+".searchCount", cri);
		
	}


	@Override
	public void delete(int recipe_no) throws Exception {

		session.delete(NAMESPACE+".delete", recipe_no);
		
		
		
	}


	@Override
	public List<RecipeVO> searchRecipeList(SearchCriteria cri) throws Exception {

		return session.selectList(NAMESPACE+".searchRecipeList", cri);
	}


	@Override
	public int searchRecipeCount(SearchCriteria cri) throws Exception {

		return session.selectOne(NAMESPACE+".searchRecipeCount", cri);
	}


	@Override
	public void updateViewCnt(int recipe_no) throws Exception {

		session.update(NAMESPACE+".updateViewCnt", recipe_no);
	}

}
