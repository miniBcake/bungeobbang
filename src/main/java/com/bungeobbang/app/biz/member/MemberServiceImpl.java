package com.bungeobbang.app.biz.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

//MemberService 구현체
@Service("memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired // 메모리에 new되어있어야함(Repository 먼저 되어있어야 함)
	private MemberDAO memberDAO;

	@Override
	public ArrayList<MemberDTO> selectAll(MemberDTO memberDTO) {
		return (ArrayList<MemberDTO>) this.memberDAO.selectAll(memberDTO);
	}

	@Override
	public MemberDTO selectOne(MemberDTO memberDTO) {
		return this.memberDAO.selectOne(memberDTO);
	}

	@Override
	public boolean insert(MemberDTO memberDTO) {
		return this.memberDAO.insert(memberDTO);
	}

	@Override
	public boolean update(MemberDTO memberDTO) {
		return this.memberDAO.update(memberDTO);
	}

	@Override
	public boolean delete(MemberDTO memberDTO) {
		return this.memberDAO.delete(memberDTO);
	}
	
}
