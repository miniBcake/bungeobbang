package com.bungeobbang.app.view.memberController;

import com.bungeobbang.app.biz.member.MemberDTO;
import com.bungeobbang.app.biz.member.MemberService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@RestController
@Slf4j
public class MemberAsyncController {
    @Autowired
    private MemberService memberService;

    @RequestMapping(value = "/checkEmailName.do", method = RequestMethod.POST) // 이메일 이름 비동기 확인 controller
    public @ResponseBody String emailNameCheck(MemberDTO memberDTO) {
        log.info("[CheckEmailName] 시작");

        // 결과를 보관할 boolean flag 변수 생성
        boolean flag = false;

        // MemberDTO 세팅
        memberDTO.setCondition("EMAIL_CONDITION");
        log.info("[CheckEmailName View에서 받아온 값] : {}", memberDTO);

        // 일치하는 값 확인x
        memberDTO = memberService.selectOne(memberDTO);
        log.info("[CheckEmailName selectOne 이후 반환 받은 값] : {}", memberDTO);

        if (memberDTO != null) {
            flag = true;
        }
        return flag+"";
    }

    //TODO 로직이 이메일 중복확인이 아니고 비밀번호 찾기..? 로직으로 보이는데 확인 후 수정바랍니다.
    @PostMapping("/checkEmail.do") // 이메일 확인 비동기 controller
    public @ResponseBody boolean checkEmail(MemberDTO memberDTO, Model model) {
        log.info("[CheckEmail] 시작");
        boolean flag = true;

        // View에게서 이메일 데이터 받기
        memberDTO.setCondition("PASSWORD_RESET_CONDITION");
        memberDTO = memberService.selectOne(memberDTO);
        log.info("[View에서 받아온 memberDTO] : "+memberDTO);

        // 비밀번호 변경 로직에서 사용하는 조건문
        if (memberDTO != null) {
            flag = false;
            model.addAttribute(memberDTO.getMemberNum());
            log.info("[CheckEmail 비밀번호 변경로직 조건문 통과] : "+model);

        }
        log.info("[CheckEmail 종료후 반환되는 값] : " + flag);
        return flag; // 결과 반환
    }

    //    //FIXME EmailAPIController checkNickname.do 요청과 충돌
//    //@PostMapping("/checkNickname.do") // 회원가입할 때 닉네임 중복 체크 비동기 controller
//    public @ResponseBody String checkNickName(HttpSession session, MemberDTO memberDTO) {
//        boolean flag = false;
//
//        // memberDTO에 condition : NICKNAME 넣어주기
//        memberDTO.setCondition("NICKNAME_CONDITION"); // 나중 수정
//
//        // MemberDAO.selectOne 요청
//        memberDTO = memberService.selectOne(memberDTO);
//
//        // 만약 사용 가능한 닉네임이라면
//        if (memberDTO == null) {
//            // flag를 true로 변경
//            flag = true;
//        }
//
//        // V에게 결과 보내기
//        // flag를 String 변수에 담아 반환
//        String result = flag ? "true" : "false"; // flag 값을 String으로 변환
//        return result; // 결과 반환
//    }
}
