package com.bungeobbang.app.view.memberController;

import com.bungeobbang.app.biz.member.MemberDTO;
import com.bungeobbang.app.biz.member.MemberService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpSession;

@Slf4j
@Controller
public class LoginController {

	@Autowired
	private MemberService memberService;

	@PostMapping(value = "/login.do") // 로그인 controller
	public String login(HttpSession session, MemberDTO memberDTO, Model model) {
		log.info("[Login] 시작");

		// 로그인 로직에 사용할 condition 저장
		memberDTO.setCondition("LOGIN_CONDITON");
		log.info("[Login View에서 전달한 값] : {}", memberDTO);

		memberDTO = memberService.selectOne(memberDTO); // memberService == memberDAO / memberDTO에 selectOne 된 값 저장
		log.info("[Login selectOne된 값] : {}", memberDTO);

		if (memberDTO == null) { // 로그인이 실패한다면
			return "redirect:login.do"; // 로그인 페이지로 돌아가기
		}

		// 로그인 성공 시 세션에 사용자 정보 저장
		session.setAttribute("UserPK", memberDTO.getMemberNum());
		session.setAttribute("UserNickname", memberDTO.getMemberNickname());
		session.setAttribute("UserRole", memberDTO.getMemberRole());

		return "redirect:main.do"; // 메인 페이지로 리다이렉트
	}
}
