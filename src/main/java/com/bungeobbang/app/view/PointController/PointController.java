package com.bungeobbang.app.view.pointController;

import com.bungeobbang.app.biz.point.PointDTO;
import com.bungeobbang.app.biz.point.PointService;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;

@Slf4j
@Controller
public class PointController {

    @Autowired
    private PointService pointService;

    @Autowired
    private ServletContext application;

    // 포인트 사용 마이너스 포인트
    @PostMapping(value = "/minusPoint.do")
    public boolean minusPoint(HttpSession session, PointDTO pointDTO, @RequestParam int amount){
        log.info("[MinusPoint] 시작");

        Integer memberPK = (Integer) session.getAttribute("userPk"); // session에 저장된 memberPK 가져오기

        // view에서 전달해주는 product의 가격을 받아 사용자의 point에서 minus 진행
        pointDTO.setMemberNum(memberPK);
        pointDTO.setPointMinus(amount);
        log.info("[MinusPoint View에서 전달해준 값] : {}" + pointDTO);
        boolean flag = pointService.insert(pointDTO);
        log.info("[MinusPoint DB 처리 결과] : {}" + flag);
        return flag;
    }

    // 해당 회원의 모든 포인트 사용내역 보기
    @PostMapping(value = "/loadListPoint.do")
    public String loadListPoint(HttpSession session, PointDTO pointDTO, Model model){
        log.info("[LoadListPoint] 시작");
        Integer memberPK = (Integer) session.getAttribute("userPk"); // session에 저장된 memberPK 가져오기
        if(memberPK == null){
            return "redirect:/login.do";
        }

        pointDTO.setCondition("SELECTONE_POINT");
        pointDTO.setMemberNum(memberPK);
        log.info("[LoadListPoint View에서 전달해주는 값] : {}" + pointDTO);
        ArrayList<PointDTO> memberPoint = pointService.selectAll(pointDTO);
        if(memberPoint == null){
            return null;
        }

        model.addAttribute("pointHistoryList", memberPoint);
        log.info("[LoadListPoint 반환해주는 model 값] : {}" + model);
        return "pointHistory";
    }

    // 포인트 내역 자세히 보기

    // 포인트 잔액
    @PostMapping(value = "/infoMemberPoint.do")
    public String memberPoint(Model model){
        log.info("[MemberPoint] 시작");
        Integer applicationPoint = (Integer) application.getAttribute("applicationPoint");
        model.addAttribute("applicationPoint", applicationPoint);
        log.info("[MemberPoint 어플리케이션에 저장된 사용자의 포인트 값] : {} " + applicationPoint);
        return "memberPoint";
    }
}
