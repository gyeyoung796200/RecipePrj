package com.spring.recipe.persistence;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.recipe.domain.LoginDTO;
import com.spring.recipe.domain.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	private static final String NAMESPACE = "com.spring.recipe.mappers.memberMapper";
	
	
	@Inject
	SqlSession sqlSession;



	@Override
	public void insertMember(MemberVO memberVO) {

		sqlSession.insert(NAMESPACE+".insertMember", memberVO);
	}


	@Override
	public MemberVO infoMember(MemberVO memberVO) {

	
		return sqlSession.selectOne(NAMESPACE+".infoMember", memberVO);
	}


	@Override
	public MemberVO loginMember(LoginDTO loginDTO) throws Exception {
		
		return sqlSession.selectOne(NAMESPACE+".loginMember", loginDTO);
	}


	@Override
	public int idChk(String member_id) throws Exception {
		
		
		return sqlSession.selectOne(NAMESPACE+".idChk", member_id);
	}


	@Override
	public void keepLogin(String member_id, String session_key, Date session_limit) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("member_id", member_id);
		map.put("session_key", session_key);
		map.put("session_limit", session_limit);
		
		
		sqlSession.update(NAMESPACE+".keepLogin", map);
	}


	@Override
	public MemberVO checkSessionKey(String value) throws Exception {

	
		return sqlSession.selectOne(NAMESPACE+".checkSessionKey", value);
		
	}


	@Override
	public void modifyMember(MemberVO memberVO) throws Exception {

		
		sqlSession.update(NAMESPACE+".modifyMember", memberVO);
	}


	@Override
	public void deleteMember(MemberVO memberVO) throws Exception {

		sqlSession.delete(NAMESPACE+".deleteMember", memberVO);
		
	}
	
	
	
	
}
