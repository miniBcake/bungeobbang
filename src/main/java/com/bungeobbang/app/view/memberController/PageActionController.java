package com.bungeobbang.app.view.memberController;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PageActionController { // redirect 방식의 페이지 이동 controller

/*	@PostMapping(value="/checkMyPagePW.do") // MyPage 이동 controller / session에 있는 로그인 정보에 따라 다른 페이지 이동
	public String checkPassword(HttpSession session) {					// 로그인 상태라면 마이페이지 들어가기전 비밀번호 확인 페이지
																		// 로그아웃 상태라면 로그인 페이지로 이동
		// 로그인이 안 된 경우 로그인 페이지로 이동
		// 만약 session 값이 null이라면
		if(session.getAttribute("memberPK") == null) {
			return "redirect:loginPage.do";
		}
		return "redirect:checkPw.jsp";
	}*/
	
	@PostMapping(value="/deleteMemberAccount.do") // 회원 탈퇴 페이지 이동 controller
	public String deleteMember() {
		// 이동 페이지 : deleteAccount.jsp
		return "redirect:deleteAccount.jsp";
	}
	
	@PostMapping(value="/findPW.do") // 비밀번호 찾기 페이지 이동 controller
	public String findPW() {
		// 이동 페이지 : findPw.jsp
		return "findPw.jsp";
	}
	
	@GetMapping(value="/addMember.do") // 회원 가입 페이지 이동 controller
	public String joinPage() {

		return "signup";
	}
	
	@RequestMapping(value="/loginPage.do") // 로그인 페이지 이동 controller
	public String loginiPage() {

		return "login";
	}
	
	@GetMapping(value="/findPW.do") // 비밀번호 변경 모달에서 사용하는 controller
	public String updatePW() {
		// 모달에서 findPW.jsp로 이동
		return "redirect:findPW.jsp";
	}
	
	@RequestMapping(value="/logout.do") // 로그아웃 controller
	public String logout (HttpSession session) {
		session.invalidate(); // invalidate == 현재 세션 무효화
		
		return "redirect:main.do"; // mainPage.do 요청으로 이동
	}


	@GetMapping(value = "/addPoint.do") // 포인트 충전 페이지 이동 controller
	public String addPoint() {

		return "redirect:pointRecharge.jsp";
	}

	@GetMapping(value = "/signupPage.do")
	public String signup() {
		return "signUp";
	}
}
