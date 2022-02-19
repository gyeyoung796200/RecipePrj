package com.spring.recipe.persistence;

import java.util.List;

import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.domain.Recipe_replyVO;

public interface Recipe_replyDAO {
	
	
	//댓글 목록
	public List<Recipe_replyVO> list(int recipe_no) throws Exception;
	
	//댓글 페이징
	public List<Recipe_replyVO> listPaging(int recipe_no, Criteria cri) throws Exception;
	
	//댓글 추가
	public void insert(Recipe_replyVO recipe_replyVO) throws Exception;
	
	//댓글 수정
	public void update(Recipe_replyVO recipe_replyVO) throws Exception;
	
	//댓글 삭제
	public void delete(int reply_no) throws Exception;
	
	//댓글 개수
	public int countReply(int recipe_no) throws Exception;
	
	//레시피 번호
	public int getRecipe_no(int reply_no) throws Exception;
}
