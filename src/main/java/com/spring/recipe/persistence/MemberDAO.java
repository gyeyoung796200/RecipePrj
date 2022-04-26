package com.spring.recipe.persistence;

import java.util.Date;

import com.spring.recipe.domain.LoginDTO;
import com.spring.recipe.domain.MemberVO;

public interface MemberDAO {
	
	//회원가입
	public void insertMember(MemberVO memberVO) throws Exception;
	
	//아이디로 회원조회
	public MemberVO infoMember(MemberVO memberVO) throws Exception;
	
	//로그인
	public MemberVO loginMember(LoginDTO loginDTO) throws Exception;
	
	//아이디 중복체크
	public int idChk(String member_id) throws Exception;
	
	//이메일 중복체크
	public int emailChk(String member_email) throws Exception;
	
	//아이디 비밀번호 찾기
		//아이디 찾기
		public String find_Id(String member_email) throws Exception;
		
		//조건에 맞는 비밀번호 있는지 확인
		public int find_Pw(String member_id, String member_email) throws Exception;
			//조건에 맞는게 있으면 비밀번호 새로운 값으로 저장
			public void pw_update(String member_id) throws Exception;
		
	//로그인유지
	public void keepLogin(String member_id, String session_key, Date session_limit) throws Exception;
	
	//세션키 검증
	public MemberVO checkSessionKey(String value) throws Exception;
	
	//회원수정
	public void modifyMember(MemberVO memberVO) throws Exception;
	
	//회원탈퇴
	public void deleteMember(MemberVO memberVO) throws Exception;
	
	
	
	
}
