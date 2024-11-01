package com.bungeobbang.app.view.memberController;

import com.bungeobbang.app.biz.member.MemberDTO;
import com.bungeobbang.app.biz.member.MemberService;
import com.bungeobbang.app.view.util.FileUtil;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

@Controller
@Slf4j
public class MemberController {
    @Autowired
    private MemberService memberService;

    private final String FAIL_DO = "redirect:failInfo.do"; //기본 실패 처리

    //session
    private final String SESSION_ROLE = "userRole";
    private final String SESSION_PK = "userPk";
    private final String SESSION_NICKNAME = "userNickname";
    private final String SESSION_PROFILE = "userProfile";
    private final String SESSION_POINT = "userPoint";

    @PostMapping("/join.do") // 회원가입 controller
    public String join(ServletContext servletContext,MemberDTO memberDTO, MultipartFile file) {
        log.info("[Join] 시작");

        // 프로필 사진 업로드 처리
        String path = "uploads/"; // 업로드할 경로
        String fileName = FileUtil.createFileName(); // 파일 이름 생성
        String profilePicPath = FileUtil.insertFile(servletContext, path, file, fileName);
        log.info("[Join view에서 받은 프로필사진 경로] : {}", profilePicPath);

        memberDTO.setMemberProfileWay(profilePicPath);

        // 회원가입 요청
        boolean flag = memberService.insert(memberDTO);
        log.info("[Join insert 성공 실패 여부] : {}", flag);

        // 회원가입 실패 시 파일 삭제
        if (!flag) {
            return FAIL_DO; // 에러 페이지로 이동
        }

        return "redirect:login.do"; // 로그인 페이지로 리다이렉트
    }

    @PostMapping(value = "/login.do") // 로그인 controller
    public String login(HttpSession session, MemberDTO memberDTO) {
        log.info("[Login] 시작");

        // 로그인 로직에 사용할 condition 저장
        memberDTO.setCondition("LOGIN_CONDITON");
        log.info("[Login View에서 전달한 값] : {}", memberDTO);

        memberDTO = memberService.selectOne(memberDTO); // memberService == memberDAO / memberDTO에 selectOne 된 값 저장
        log.info("[Login selectOne된 값] : {}", memberDTO);

        if (memberDTO == null) { // 로그인이 실패한다면
            return "redirect:login.do"; // 로그인 페이지로 돌아가기
        }
        //KS 포인트 정보 조회
        session.setAttribute(SESSION_POINT, "1000");

        // 로그인 성공 시 세션에 사용자 정보 저장
        session.setAttribute(SESSION_PK, memberDTO.getMemberNum());
        session.setAttribute(SESSION_NICKNAME, memberDTO.getMemberNickname());
        session.setAttribute(SESSION_ROLE, memberDTO.getMemberRole());
        session.setAttribute(SESSION_PROFILE, memberDTO.getMemberProfileWay());

        return "redirect:main.do"; // 메인 페이지로 리다이렉트
    }

    //회원탈퇴
    @PostMapping(value="/deleteMember.do")
    public String deleteMember(HttpSession session, MemberDTO memberDTO) {
        log.info("[DeleteMember] 시작");
        // View에서 받아올 데이터 없음

        // session에서 회원번호(PK)값 받아옴
        int memberNum = (int)session.getAttribute(SESSION_PK);

        // MemberDTO, DAO 객체 new 생성
        memberDTO.setMemberNum(memberNum);

        // MemberDAO.delete 요청
        // 결과값(boolean flag) 받아오기
        boolean flag = memberService.delete(memberDTO);
        log.info("[DeleteMember 성공 여부 flag] : {}", flag);

        // 계정 삭제 실패 시
        if(!flag) {
            //실패로 이동
            return FAIL_DO;
        }
        //로그아웃 진행
        return "redirect:logout.do";
    }

    @PostMapping(value="/setPw.do") // 비빌번호 수정 controller
    public String updatePW(MemberDTO memberDTO) {
        log.info("[UpdatePW] 시작");

        // memberDTO.setCondition : PASSWORD_UPDATE 값 넣어주기
        // memberDTO.set으로 memberNum, password 값 넣기
        memberDTO.setCondition("UPDATE_PASSWORD_CONDTION");
        log.info("[UpdatePW View에서 전달 받은 값] : {}", memberDTO);

        //FIXME 선언한 적 없는 변수 호출 확인 바람 (주석처리)
//		memberDTO.setMemberNum(memberNum);
//		memberDTO.setMemberPassword(memberPassword);

        // memberDAO.update을 사용하여 memberDTO 업데이트
        // boolean flag에 반환값 저장
        boolean flag = memberService.update(memberDTO);
        log.info("[UpdatePW update 수행 이후 반환 값] : {}", flag);
        // 업데이트에 성공했다면
        // flag가 false이면
        if(!flag) {
            return FAIL_DO;
        }

        // 이동할 페이지 : loginPage.do
        return "redirect:login.do";

    }

    @PostMapping(value="/deleteMemberAccount.do") // 회원 탈퇴 페이지 이동 controller
    public String deleteMember() {
        // 이동 페이지 : deleteAccount.jsp
        return "redirect:deleteAccount.jsp";
    }

    @PostMapping(value="/findPW.do") // 비밀번호 찾기 페이지 이동 controller
    public String findPW() {
        // 이동 페이지 : findPw.jsp
        return "redirect:findPw.jsp";
    }

    @GetMapping(value="/addMember.do") // 회원 가입 페이지 이동 controller
    public String joinPage() {
        return "redirect:signup.jsp";
    }

    @RequestMapping(value="/login.do") // 로그인 페이지 이동 controller
    public String loginiPage() {
        return "redirect:login.jsp";
    }

    @GetMapping(value="/findPW.do") // 비밀번호 변경 모달에서 사용하는 controller
    public String updatePW() {
        // 모달에서 findPW.jsp로 이동
        return "redirect:findPW.jsp";
    }

    @RequestMapping(value="/logout.do") // 로그아웃 controller
    public String logout (HttpSession session) {
        session.removeAttribute(SESSION_PK);
        session.removeAttribute(SESSION_NICKNAME);
        session.removeAttribute(SESSION_ROLE);
        session.removeAttribute(SESSION_PROFILE);
        session.removeAttribute(SESSION_POINT);
        return "redirect:main.do"; // mainPage.do 요청으로 이동
    }


    @GetMapping(value = "/addPoint.do") // 포인트 충전 페이지 이동 controller
    public String addPoint() {
        return "redirect:pointRecharge.jsp";
    }

    @GetMapping(value = "/signupPage.do")
    public String signup() {
        return "redirect:signUp.jsp";
    }
}
