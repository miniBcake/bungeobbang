package com.bungeobbang.app.view.memberController;

import com.bungeobbang.app.biz.member.MemberDTO;
import com.bungeobbang.app.biz.member.MemberService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
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
}
