package com.spring.recipe.domain;

import java.util.Date;

public class MemberJoinBoardVO {

	private String member_id;
	private String member_image;
	private int bno;
	private String title;
	private String content;
	private String writer;
	private int viewCnt;
	private String b_pwd;
	private Date regdate;
	private Date updatedate;

	public String getMember_id() {
		return member_id;
	}

	@Override
	public String toString() {
		return "MemberJoinBoardVO [member_id=" + member_id + ", member_image=" + member_image + ", bno=" + bno
				+ ", title=" + title + ", content=" + content + ", writer=" + writer + ", viewCnt=" + viewCnt
				+ ", b_pwd=" + b_pwd + ", regdate=" + regdate + ", updatedate=" + updatedate + "]";
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_image() {
		return member_image;
	}

	public void setMember_image(String member_image) {
		this.member_image = member_image;
	}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public int getViewCnt() {
		return viewCnt;
	}

	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}

	public String getB_pwd() {
		return b_pwd;
	}

	public void setB_pwd(String b_pwd) {
		this.b_pwd = b_pwd;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public Date getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}

}
