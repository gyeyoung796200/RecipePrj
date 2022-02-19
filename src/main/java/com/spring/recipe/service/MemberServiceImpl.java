package com.spring.recipe.service;

import java.util.Date;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.recipe.domain.LoginDTO;
import com.spring.recipe.domain.MemberVO;
import com.spring.recipe.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {
	
	
	@Inject
	MemberDAO dao;
	
	

	@Override
	public void insertMember(MemberVO memberVO) throws Exception {

		dao.insertMember(memberVO);
	}

	@Override
	public MemberVO infoMember(MemberVO memberVO) throws Exception {

		return dao.infoMember(memberVO);
	}

	@Override
	public MemberVO loginMember(LoginDTO loginDTO) throws Exception {

		return dao.loginMember(loginDTO);
	}

	@Override
	public int idChk(String member_id) throws Exception {
	
		return dao.idChk(member_id);
	}

	@Override
	public void keepLogin(String member_id, String session_key, Date session_limit) throws Exception {
		
		dao.keepLogin(member_id, session_key, session_limit);
	}

	@Override
	public MemberVO checkSessionKey(String value) throws Exception {

		return dao.checkSessionKey(value);
	}

	@Override
	public void modifyMember(MemberVO memberVO) throws Exception {

		dao.modifyMember(memberVO);
	}

	@Override
	public void deleteMember(MemberVO memberVO) throws Exception {

		dao.deleteMember(memberVO);
	}
	
	

}
