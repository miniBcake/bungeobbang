package com.bungeobbang.app.view.orderController;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bungeobbang.app.biz.order.OrderDTO;
import com.bungeobbang.app.biz.order.OrderService;
import com.bungeobbang.app.biz.orderDetail.OrderDetailDAO;
import com.bungeobbang.app.biz.orderDetail.OrderDetailDTO;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderDetailDAO orderDetailDAO;

    @RequestMapping(value = "/addOrder.do", method = RequestMethod.POST)
    public @ResponseBody Object addOrder(HttpSession session, @RequestBody OrderDTO orderDTO) {
        log.info("[AddOrder] 시작");

        Integer memberPK = (Integer) session.getAttribute("userPK");
        log.info("[AddOrder session에서 가져온 userPK] : {}", memberPK);
        orderDTO.setMemberNum(memberPK);

        boolean flag = orderService.insert(orderDTO);
        log.info("[AddOrder orderService insert 성공 여부] : {}", flag);

        if (flag) {
            Integer orderNum = orderDTO.getOrderNum();
            log.info("[AddOrder DB에 insert 이후 반환받은 주문 번호] : {}", orderNum);

            List<Integer> productNums = new ArrayList<>();
            for (OrderDetailDTO orderDetailDTO : orderDTO.getOrderDetails()) {
                orderDetailDTO.setOrderNum(orderNum);
                boolean flag1 = orderDetailDAO.insert(orderDetailDTO);
                log.info("[AddOrder OrderDetailDTO insert 성공 여부] : {}", flag1);

                if (!flag1) {
                    return false;
                }
                productNums.add(orderDetailDTO.getProductNum());
            }
            return productNums;
        }

        return false;
    }
}