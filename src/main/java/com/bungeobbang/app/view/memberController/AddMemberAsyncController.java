package com.bungeobbang.app.view.memberController;

import com.bungeobbang.app.biz.member.MemberDTO;
import com.bungeobbang.app.biz.member.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpSession;

@RestController
public class AddMemberAsyncController { // 회원가입 할 때 사용되는 비동기 controller / 이메일 인증의 경우에는 CheckEmailAsyncController.java 에 있음

    @Autowired
    private MemberService memberService;

    @PostMapping("/checkEmail.do") // 이메일 확인 비동기 controller
    public @ResponseBody String checkEmail(HttpSession session, MemberDTO memberDTO, Model model) {
        boolean flag = true;

        // View에게서 이메일 데이터 받기
        memberDTO.setCondition("PASSWORD_RESET_CONDITION");
        memberDTO = memberService.selectOne(memberDTO);

        // 비밀번호 변경 로직에서 사용하는 조건문
        if (memberDTO != null) {
            flag = false;
            model.addAttribute(memberDTO.getMemberNum());
        }
        String result = flag ? "true" : "false"; // flag 값을 String으로 변환
        return result; // 결과 반환
    }

    //FIXME EmailAPIController checkNickname.do 요청과 충돌
    //@PostMapping("/checkNickname.do") // 회원가입할 때 닉네임 중복 체크 비동기 controller
    public @ResponseBody String checkNickName(HttpSession session, MemberDTO memberDTO) {
        boolean flag = false;

        // memberDTO에 condition : NICKNAME 넣어주기
        memberDTO.setCondition("NICKNAME_CONDITION"); // 나중 수정

        // MemberDAO.selectOne 요청
        memberDTO = memberService.selectOne(memberDTO);

        // 만약 사용 가능한 닉네임이라면
        if (memberDTO == null) {
            // flag를 true로 변경
            flag = true;
        }

        // V에게 결과 보내기
        // flag를 String 변수에 담아 반환
        String result = flag ? "true" : "false"; // flag 값을 String으로 변환
        return result; // 결과 반환
    }
}