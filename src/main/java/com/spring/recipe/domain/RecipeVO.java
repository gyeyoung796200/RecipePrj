package com.spring.recipe.domain;

import java.util.Date;

public class RecipeVO {

	private int recipe_no;
	private String recipe_type;
	private String recipe_name;
	private String recipe_image;
	private String recipe_content;
	private Date recipe_regdate;
	private Date recipe_updatedate;
	private String recipe_writer;

	public String getRecipe_writer() {
		return recipe_writer;
	}

	public void setRecipe_writer(String recipe_writer) {
		this.recipe_writer = recipe_writer;
	}

	public int getRecipe_no() {
		return recipe_no;
	}

	public void setRecipe_no(int recipe_no) {
		this.recipe_no = recipe_no;
	}

	public String getRecipe_type() {
		return recipe_type;
	}

	public void setRecipe_type(String recipe_type) {
		this.recipe_type = recipe_type;
	}

	public String getRecipe_name() {
		return recipe_name;
	}

	public void setRecipe_name(String recipe_name) {
		this.recipe_name = recipe_name;
	}

	public String getRecipe_image() {
		return recipe_image;
	}

	public void setRecipe_image(String recipe_image) {
		this.recipe_image = recipe_image;
	}

	public String getRecipe_content() {
		return recipe_content;
	}

	public void setRecipe_content(String recipe_content) {
		this.recipe_content = recipe_content;
	}

	public Date getRecipe_regdate() {
		return recipe_regdate;
	}

	public void setRecipe_regdate(Date recipe_regdate) {
		this.recipe_regdate = recipe_regdate;
	}

	public Date getRecipe_updatedate() {
		return recipe_updatedate;
	}

	public void setRecipe_updatedate(Date recipe_updatedate) {
		this.recipe_updatedate = recipe_updatedate;
	}

	@Override
	public String toString() {
		return "RecipeVO [recipe_no=" + recipe_no + ", recipe_type=" + recipe_type + ", recipe_name=" + recipe_name
				+ ", recipe_image=" + recipe_image + ", recipe_content=" + recipe_content + ", recipe_regdate="
				+ recipe_regdate + ", recipe_updatedate=" + recipe_updatedate + ", recipe_writer=" + recipe_writer
				+ "]";
	}

}
