package com.spring.recipe.domain;

import java.util.Date;

public class MemberVO {

	private String member_id;
	private String member_pw;
	private String member_gender;
	private String member_image;
	private Date member_regdate;
	private Date member_updatedate;

	private String session_key;
	private Date session_limit;

	public String getSession_key() {
		return session_key;
	}

	public void setSession_key(String session_key) {
		this.session_key = session_key;
	}

	public Date getSession_limit() {
		return session_limit;
	}

	public void setSession_limit(Date session_limit) {
		this.session_limit = session_limit;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_pw() {
		return member_pw;
	}

	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}


	public String getMember_gender() {
		return member_gender;
	}

	public void setMember_gender(String member_gender) {
		this.member_gender = member_gender;
	}

	public String getMember_image() {
		return member_image;
	}

	public void setMember_image(String member_image) {
		this.member_image = member_image;
	}

	public Date getMember_regdate() {
		return member_regdate;
	}

	public void setMember_regdate(Date member_regdate) {
		this.member_regdate = member_regdate;
	}

	public Date getMember_updatedate() {
		return member_updatedate;
	}

	public void setMember_updatedate(Date member_updatedate) {
		this.member_updatedate = member_updatedate;
	}

	@Override
	public String toString() {
		return "MemberVO [member_id=" + member_id + ", member_pw=" + member_pw +", member_gender=" + member_gender + ", member_image=" + member_image + ", member_regdate="
				+ member_regdate + ", member_updatedate=" + member_updatedate + "]";
	}

}