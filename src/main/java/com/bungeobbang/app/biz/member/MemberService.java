package com.bungeobbang.app.biz.member;

import java.util.List;

// Member 인터페이스
public interface MemberService {
	List<MemberDTO> selectAll(MemberDTO memberDTO);
	MemberDTO selectOne(MemberDTO memberDTO);
	boolean insert(MemberDTO memberDTO);
	boolean update(MemberDTO memberDTO);
	boolean delete(MemberDTO memberDTO);
	
}
