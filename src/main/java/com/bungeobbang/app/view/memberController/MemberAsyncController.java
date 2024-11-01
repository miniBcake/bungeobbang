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

    //이메일 중복확인
    @RequestMapping(value = "/checkEmailName.do", method = RequestMethod.POST)
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

    //비밀번호 변경 확인 로직 => 이름, 이메일
    @PostMapping("/checkPWFind.do")
    public @ResponseBody int checkEmail(@RequestBody MemberDTO memberDTO, Model model) {
        log.info("[CheckEmail] 시작");
        int flag = -1;

        // View에게서 이메일 데이터 받기
        memberDTO.setCondition("PASSWORD_RESET_CONDITION");
        memberDTO = memberService.selectOne(memberDTO);
        log.info("[View에서 받아온 memberDTO] : "+memberDTO);

        // 비밀번호 변경 로직에서 사용하는 조건문
        if (memberDTO != null) {
            flag = memberDTO.getMemberNum();
            model.addAttribute(memberDTO.getMemberNum());
            log.info("[CheckEmail 비밀번호 변경로직 조건문 통과] : "+model);

        }
        log.info("[CheckEmail 종료후 반환되는 값] : " + flag);
        return flag; // 결과 반환
    }


}
