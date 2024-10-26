package com.bungeobbang.app.view.controller;

import com.bungeobbang.app.biz.order.OrderDTO;
import com.bungeobbang.app.biz.order.OrderService;
import com.bungeobbang.app.biz.store.StoreDTO;
import com.bungeobbang.app.biz.store.StoreService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
public class AdminController {
    @Autowired
    private OrderService orderService;
    @Autowired
    private StoreService storeService;

    private final String FAIL_URL = "failInfo2"; //실패 처리할 페이지
    private final String FAIL_DO = "redirect:failInfo.do"; //기본 실패 처리

    //msg
    private final String ORDER_UPDATE_FAIL = "주문 완료 처리를 실패했습니다.";
    private final String STORE_DELETE_FAIL = "가게 정보 삭제에 실패했습니다.";

    @RequestMapping("/updateOrderCheck.do")
    public String updateOrderCheck(OrderDTO orderDTO, Model model) {
        log.info("log: /updateOrderCheck.do updateOrderCheck - start");
        log.info("log: updateOrderCheck - input orderDTO: {}", orderDTO);
        if(!orderService.update(orderDTO)){
            log.error("log: updateOrderCheck - update failed");
            model.addAttribute("msg", ORDER_UPDATE_FAIL);
            model.addAttribute("path", "");
            return FAIL_URL;
        }
        log.info("log: /updateOrderCheck.do updateOrderCheck - end");
        return "";
    }

    @RequestMapping("/loadListOrder.do")
    public String loadListOrder(){
        //KS 일단 보류 장바구니쪽이 정리되면 맞춰서 데이터 전달
        return "adminMainProduct";
    }

    @RequestMapping("/loadListStoreReport.do")
    public String loadListStoreReport(Model model){
        StoreDTO storeDTO = new StoreDTO();
        storeDTO.setCondition("SELECTALL_DECLARED_CNT");
        model.addAttribute("storeReportList", storeService.selectAll(storeDTO));
        return "closedStoreDeclareList";
    }

    //KS DB확인
    @RequestMapping("/loadListStoreTipOff.do")
    public String loadListStoreTipOff(Model model){
        StoreDTO storeDTO = new StoreDTO();
        storeDTO.setCondition("");
        model.addAttribute("storeTipOffList", storeService.selectAll(storeDTO));
        return "storeDeclareList";
    }

    @RequestMapping("/deleteStore.do")
    public String deleteStore(StoreDTO storeDTO, Model model){
        log.info("log: /deleteStore.do deleteStore - start");
        log.info("log: deleteStore - input storeDTO: {}", storeDTO);
        if(!storeService.delete(storeDTO)){
            log.error("log: deleteStore - delete failed");
            model.addAttribute("msg", STORE_DELETE_FAIL);
            model.addAttribute("path", "");
            return FAIL_URL;
        }
        log.info("log: /deleteStore.do deleteStore - end");
        return "redirect:loadListStoreReport.do";
    }
}
