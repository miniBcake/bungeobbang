package com.bungeobbang.app.view.paymentController;


import com.bungeobbang.app.biz.payment.PaymentDTO;
import com.bungeobbang.app.biz.payment.PaymentService;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Slf4j
@Controller
public class PaymentController {

    // 결제 내역 보기 전체 조회 단건 조회 x
    // loadListPayment.do 요청 보내면 uuid 받아서 조회
    // 이때 반환 값은 uuid만 반환 해줌
    // session에서 userPK 꺼낸뒤 paymentDTO에 담고
    // 반환 받은 uuid 도 paymentDTO에 담아서
    // selectAll 하면
    // 회원이 결제할때 사용한 uuid가 반환됨
    // 이 uuid 배열을 가지고 단건 조회를 반복문으로 돌림

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private ServletContext application;

    // 포인트 환전 내역 전체 검색
    @PostMapping(value = "loadListPayment.do")
    public String paymentSelectAll(HttpSession session, PaymentDTO paymentDTO, Model model) {
        log.info("[PaymentSelectAll] 시작");

        Integer memberPK = (Integer) session.getAttribute("userPK");

        paymentDTO.setCondition("SELECTALL_PAYMENT");
        paymentDTO.setMemberNum(memberPK);
        log.info("[PaymentSelectAll View에서 전달 받은 값] : {}", paymentDTO);
        List<PaymentDTO> paymentList = paymentService.selectAll(paymentDTO);

        if(paymentList != null && !paymentList.isEmpty()) {
            Integer applicationPoint = (Integer) application.getAttribute("applicationPoint");
            model.addAttribute("applicationPoint", applicationPoint);
            model.addAttribute("paymentList", paymentList); // 모델에 리스트 추가
            log.info("[PaymentSelectAll selectAll 이후에 보내주는 model 값] : {}", model);
        }
        return "moneyToPoint";
    }

}
