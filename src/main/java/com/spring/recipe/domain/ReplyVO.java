package com.spring.recipe.domain;

import java.util.Date;

public class ReplyVO {

	private int reply_no;
	private int bno;
	private String reply_text;
	private String reply_writer;
	private Date reply_regdate;
	private Date reply_updatedate;

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

	public Date getReply_updatedate() {
		return reply_updatedate;
	}

	public void setReply_updatedate(Date reply_updatedate) {
		this.reply_updatedate = reply_updatedate;
	}

	@Override
	public String toString() {
		return "ReplyVO [reply_no=" + reply_no + ", bno=" + bno + ", reply_text=" + reply_text + ", reply_writer="
				+ reply_writer + ", reply_regdate=" + reply_regdate + ", reply_updatedate=" + reply_updatedate + "]";
	}

}
