package com.spring.recipe.commons.paging;

public class Criteria {

	private int page; // 현재 보여질 페이지번호
	private int perPageNum; // 한페이지에 보여질 글의 개수

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		
		if(perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		
		this.perPageNum = perPageNum;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + "]";
	}
	
	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
	}
	
	public Criteria(int page) {
		
		if(page <= 0) this.page = 1;
		
		this.page = page;
	}
	
	public int getPageStart() { //현재 페이지 시작번호 메서드
		
		return (this.page - 1) * perPageNum;
	}

}
