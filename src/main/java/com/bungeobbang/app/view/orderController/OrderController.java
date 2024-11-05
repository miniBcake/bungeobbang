package com.bungeobbang.app.view.orderController;

import com.bungeobbang.app.biz.order.OrderDTO;
import com.bungeobbang.app.biz.order.OrderService;
import com.bungeobbang.app.biz.orderDetail.OrderDetailDAO;
import com.bungeobbang.app.biz.orderDetail.OrderDetailDTO;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@RestController
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderDetailDAO orderDetailDAO;

    // 클라이언트에서 보내는 주문 상세 데이터
    @RequestMapping(value = "/addOrder.do", method = RequestMethod.POST)
    public @ResponseBody Object addOrder(HttpSession session, @RequestBody List<OrderDetailDTO> orderDetails,
                                          OrderDTO orderDTO) {

        log.info("[AddOrder] 시작");

        // 세션에서 사용자 PK를 가져옴
        Integer memberPK = (Integer) session.getAttribute("userPK");
        log.info("[AddOrder session에서 가져온 userPK] : {}", memberPK);

        // 주문 기본 정보 설정
        orderDTO.setMemberNum(memberPK);

        // 주문 정보 insert
        boolean flag = orderService.insert(orderDTO);
        log.info("[AddOrder orderService insert 성공 여부] : {}", flag);

        if (flag == true) {
            // 주문 번호 가져오기
            Integer orderNum = orderDTO.getOrderNum();
            log.info("[AddOrder DB에 insert 이후 반환받은 주문 번호] : {}", orderNum);

            // view한테 반환 해줄 productNum 배열 미리 생성
            List<Integer> productNums = new ArrayList<>();

            // 받은 주문 상세 데이터를 하나씩 처리
            for (OrderDetailDTO orderDetailList : orderDetails) {
                // 각 주문 상세 항목을 OrderDetailDTO에 담아 insert 처리
                OrderDetailDTO orderDetailDTO = new OrderDetailDTO();
                orderDetailDTO.setProductNum(orderDetailList.getProductNum());  // 실제 productNum
                log.info("[AddOrder 배열 값 확인한 후 orderDetailDTO에 저장된 상품 번호] : {}", orderDetailDTO.getProductNum());

                orderDetailDTO.setOrderQuantity(orderDetailList.getOrderQuantity());  // 실제 orderQuantity
                log.info("[AddOrder 배열 값 확인한 후 orderDetailDTO에 저장된 상품 수량] : {}", orderDetailDTO.getOrderQuantity());

                orderDetailDTO.setOrderNum(orderNum);  // 이전에 생성된 주문 번호
                log.info("[AddOrder 배열 값 확인한 후 orderDetailDTO에 저장된 주문 번호] : {}", orderDetailDTO.getOrderNum());

                // 주문 상세 정보 insert
                boolean flag1 = orderDetailDAO.insert(orderDetailDTO);
                log.info("[AddOrder OrderDetailDTO insert 성공 여부] : {}", flag1);

                if (flag1 != true) {
                    return false;  // 오류 발생 시 false 반환
                }
                productNums.add(orderDetailDTO.getProductNum());
            }

            // 모든 주문 상세가 정상적으로 저장되었으면, productNum 목록을 반환
            return productNums;  // productNum 리스트 반환
        }

        return false;  // 주문 정보 insert 실패 시 false 반환
    }
}
