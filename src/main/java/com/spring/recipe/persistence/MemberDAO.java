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
	
	//로그인유지
	public void keepLogin(String member_id, String session_key, Date session_limit) throws Exception;
	
	//세션키 검증
	public MemberVO checkSessionKey(String value) throws Exception;
	
	//회원수정
	public void modifyMember(MemberVO memberVO) throws Exception;
	
	//회원탈퇴
	public void deleteMember(MemberVO memberVO) throws Exception;
	
	
	
	
}
