package com.spring.recipe.commons.paging;

public class SearchCriteria extends Criteria {

	private String keyword;
	private String searchType; // 검색어 타입

	private String recipeType; // 레시피 종류 타입

	public String getRecipeType() {
		return recipeType;
	}

	public void setRecipeType(String recipeType) {
		this.recipeType = recipeType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	@Override
	public String toString() {
		return "SearchCriteria [keyword=" + keyword + ", searchType=" + searchType + ", recipeType=" + recipeType + "]";
	}

}
