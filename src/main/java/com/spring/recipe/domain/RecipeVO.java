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

	/**************** 추가된 컬럼 *******************/

	private String recipe_completeImg; // 완성사진
	private String cook_amount; // 요리 인분
	private String cook_time; // 요리 시간
	private String cook_level; // 요리 레벨
	private String material_name; // 재료 이름
	private String material_amount; // 재료 양

	private int recipe_viewCnt; // 조회수

	/********************************************/

	public String getRecipe_completeImg() {
		return recipe_completeImg;
	}

	public void setRecipe_completeImg(String recipe_completeImg) {
		this.recipe_completeImg = recipe_completeImg;
	}

	public String getCook_time() {
		return cook_time;
	}

	public void setCook_time(String cook_time) {
		this.cook_time = cook_time;
	}

	public String getRecipe_writer() {
		return recipe_writer;
	}

	public String getCook_amount() {
		return cook_amount;
	}

	public void setCook_amount(String cook_amount) {
		this.cook_amount = cook_amount;
	}

	public String getCook_level() {
		return cook_level;
	}

	public void setCook_level(String cook_level) {
		this.cook_level = cook_level;
	}

	public String getMaterial_name() {
		return material_name.toString();
	}

	public void setMaterial_name(String material_name) {
		this.material_name = material_name;
	}

	public String getMaterial_amount() {
		return material_amount;
	}

	public void setMaterial_amount(String material_amount) {
		this.material_amount = material_amount;
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

	public int getRecipe_viewCnt() {
		return recipe_viewCnt;
	}

	public void setRecipe_viewCnt(int recipe_viewCnt) {
		this.recipe_viewCnt = recipe_viewCnt;
	}

	@Override
	public String toString() {
		return "RecipeVO [recipe_no=" + recipe_no + ", recipe_type=" + recipe_type + ", recipe_name=" + recipe_name
				+ ", recipe_image=" + recipe_image + ", recipe_content=" + recipe_content + ", recipe_regdate="
				+ recipe_regdate + ", recipe_updatedate=" + recipe_updatedate + ", recipe_writer=" + recipe_writer
				+ ", recipe_completeImg=" + recipe_completeImg + ", cook_amount=" + cook_amount + ", cook_time="
				+ cook_time + ", cook_level=" + cook_level + ", material_name=" + material_name + ", material_amount="
				+ material_amount + ", recipe_viewCnt=" + recipe_viewCnt + "]";
	}

}
