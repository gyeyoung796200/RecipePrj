package com.spring.recipe.domain;

import java.util.Date;

public class ReplyJoinMemberVO {

	private String member_id;
	private String member_image;
	private int reply_no;
	private int bno;
	private String reply_text;
	private String reply_writer;
	private Date reply_regdate;

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_image() {
		return member_image;
	}

	@Override
	public String toString() {
		return "ReplyJoinMemberVO [member_id=" + member_id + ", member_image=" + member_image + ", reply_no=" + reply_no
				+ ", bno=" + bno + ", reply_text=" + reply_text + ", reply_writer=" + reply_writer + ", reply_regdate="
				+ reply_regdate + "]";
	}

	public void setMember_image(String member_image) {
		this.member_image = member_image;
	}

	public int getReply_no() {
		return reply_no;
	}

	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public String getReply_text() {
		return reply_text;
	}

	public void setReply_text(String reply_text) {
		this.reply_text = reply_text;
	}

	public String getReply_writer() {
		return reply_writer;
	}

	public void setReply_writer(String reply_writer) {
		this.reply_writer = reply_writer;
	}

	public Date getReply_regdate() {
		return reply_regdate;
	}

	public void setReply_regdate(Date reply_regdate) {
		this.reply_regdate = reply_regdate;
	}

}
