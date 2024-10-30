package com.bungeobbang.app.view.memberController;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import com.bungeobbang.app.biz.member.MemberDTO;
import com.bungeobbang.app.biz.member.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpSession;

@RestController
public class EmailAPIAsyncController { // 비밀번호 찾기에 사용되는 비동기 controller

    @Autowired
    private MemberService memberService;
    
    @Autowired
    private JavaMailSender mailSender; // JavaMailSender 주입

    
    @PostMapping("/checkNickname.do") // 닉네임 확인 비동기 controller
    public @ResponseBody String checkNickName(HttpSession session, MemberDTO memberDTO) {
        // 결과를 보관할 boolean flag 변수 생성
        // 기본 값은 false
        boolean flag = false;

        // (C -> M) 해당 닉네임 존재 체크
        memberDTO.setCondition("NICKNAME_SELECTONE"); // 나중 수정

        // MemberDAO.selectOne 요청
        // 결과값(MemberDTO) 받아오기
        // memberDTO에 저장
        memberDTO = memberService.selectOne(memberDTO);

        // 만약 사용 가능한 닉네임이라면
        if (memberDTO == null) {
            // flag를 true로 변경
            flag = true;
        }

        // 만약 로그인 시
        if (session.getAttribute("userPK") != null) {
            // session에서 memberNickName 값 받아오기
            String memberNickName = (String) session.getAttribute("userNickName");

            // 만약 memberNickName과 입력 nickName이 같다면
            if (memberNickName != null && memberNickName.equals(memberDTO.getMemberNickname())) {
                // flag값을 true로 변경
                flag = true;
            }
        }

        // V에게 결과 보내기
        // flag를 String 변수에 담아 반환
        String result = flag ? "true" : "false"; // flag 값을 String으로 변환
        return result; // 결과 반환
    }
    
    @PostMapping(value="/checkEmailName.do") // 이메일 이름 비동기 확인 controller
    public @ResponseBody Map<String, Object> emailNameCheck(MemberDTO memberDTO) {
        // 결과를 보관할 boolean flag 변수 생성
    	Map<String, Object> result = new HashMap<>();
        boolean flag = false;

        // MemberDTO 세팅
        memberDTO.setCondition("EMAIL_NAME_SELECTONE");

        // 일치하는 값 확인x
        memberDTO = memberService.selectOne(memberDTO);
        if (memberDTO != null) {
            flag = true;
        }

        result.put("flag", flag);
        result.put("memberDTO", memberDTO);

        
        return result;
    }
    
    @PostMapping("/checkEmailNum.do") // 이메일로 전송된 인증번호 비동기 확인 controller
    public @ResponseBody boolean emailNumCheck(@RequestParam("checkNum") String inputCheckNum, HttpSession session) {
        
        // session에 있는 원본 인증값 가져오기
        String checkNum = (String) session.getAttribute("checkNum");
        
        // 만약 원본 인증값과 V의 입력값이 같다면
        boolean flag = inputCheckNum.equals(checkNum);
        
        return flag; // true 또는 false 반환
    }
    
    @PostMapping("/sendEmail.do") // 이메일 전송(인증번호) 비동기 controller
    public @ResponseBody boolean sendEmail(@RequestParam("email") String receiveEmail, HttpSession session) {
        // 랜덤한 인증번호 4자리 생성
        Random rand = new Random();
        String checkNum = "";

        for (int i = 1; i <= 4; i++) {
            checkNum += rand.nextInt(10);
        }
        System.out.println("	log : SendMail.java		인증번호 생성");

        // 이메일 제목 및 내용 설정
        String title = "갈빵질빵에서 보낸 인증번호 메일입니다.";
        String content = "인증번호 \n" + checkNum;

        // 이메일 송신
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("galbbangjilbbang@naver.com"); // 발신자 설정
            message.setTo(receiveEmail); // 수신자 설정
            message.setSubject(title); // 제목 설정
            message.setText(content); // 내용 설정

            mailSender.send(message); // 이메일 전송
        } catch (Exception e) {
            e.printStackTrace();
            return false; // 전송 실패 시 false 반환
        }

        // 인증번호를 비교하기 위해 session에 저장
        session.setMaxInactiveInterval(180); // 세션의 유효 시간을 3분으로 설정 (180초)
        
        // 남은 시간 계산
        long remainTime = System.currentTimeMillis() + (180 * 1000); // 현재시간 + 180초
        session.setAttribute("checkNum", checkNum); // 세션에 인증번호 저장
        session.setAttribute("remainTime", remainTime); // 세션에 남은 시간 저장

        return true; // 전송 성공 시 true 반환
    }
}
