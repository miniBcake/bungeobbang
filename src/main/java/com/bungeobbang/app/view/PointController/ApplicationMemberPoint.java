package com.bungeobbang.app.view.pointController;

import com.bungeobbang.app.biz.point.PointDTO;
import com.bungeobbang.app.biz.point.PointService;
import jakarta.servlet.ServletContext;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class ApplicationMemberPoint {

    @Autowired
    private PointService pointService;

    @Autowired
    private ServletContext application;

    // 어플리케이션 속성에 포인트 저장하는 메서드 / util로 빼기
    public void updateApplicationPoint(PointDTO pointDTO) {
        log.info("[UpdateApplicationPoint");

            pointDTO.setCondition("SELECTONE_MEMBER_POINT");

            PointDTO memberPoint = pointService.selectOne(pointDTO);
            // 이때 반환값에 PointNum memberNum pointPlus pointMinus pointContent(충전 내역)
            if (memberPoint != null) {
                application.setAttribute("applicationPoint", memberPoint.getTotalMemberPoint());
                log.info("[UpdateApplicationPoint 어플리케이션에 저장된 회원 포인트] : {}", application.getAttribute("applicationPoint"));
            }
        }
    }

