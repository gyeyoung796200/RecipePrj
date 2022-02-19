package com.spring.recipe.domain;

import java.util.Date;

public class Recipe_replyVO {

	private int reply_no;
	private int recipe_no;
	private String reply_writer;
	private String reply_text;
	private Date reply_regdate;
	private Date reply_updatedate;
	private int reply_rating;

	public int getReply_no() {
		return reply_no;
	}

	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}

	public int getRecipe_no() {
		return recipe_no;
	}

	public void setRecipe_no(int recipe_no) {
		this.recipe_no = recipe_no;
	}

	public String getReply_writer() {
		return reply_writer;
	}

	public void setReply_writer(String reply_writer) {
		this.reply_writer = reply_writer;
	}

	public String getReply_text() {
		return reply_text;
	}

	public void setReply_text(String reply_text) {
		this.reply_text = reply_text;
	}

	public Date getReply_regdate() {
		return reply_regdate;
	}

	public void setReply_regdate(Date reply_regdate) {
		this.reply_regdate = reply_regdate;
	}

	public Date getReply_updatedate() {
		return reply_updatedate;
	}

	public void setReply_updatedate(Date reply_updatedate) {
		this.reply_updatedate = reply_updatedate;
	}

	public int getReply_rating() {
		return reply_rating;
	}

	public void setReply_rating(int reply_rating) {
		this.reply_rating = reply_rating;
	}

	@Override
	public String toString() {
		return "Recipe_replyVO [reply_no=" + reply_no + ", recipe_no=" + recipe_no + ", reply_writer=" + reply_writer
				+ ", reply_text=" + reply_text + ", reply_regdate=" + reply_regdate + ", reply_updatedate="
				+ reply_updatedate + ", reply_rating=" + reply_rating + "]";
	}

}
