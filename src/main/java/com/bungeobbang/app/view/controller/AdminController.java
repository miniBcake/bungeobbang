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

import java.util.HashMap;

@Controller
@Slf4j
public class AdminController {
    @Autowired
    private OrderService orderService;
    @Autowired
    private StoreService storeService;

    private final String FAIL_DO = "redirect:failInfo.do"; //기본 실패 처리
    private final String FAIL_URL = "failInfo2"; //실패 처리할 페이지

    //msg
    private final String ORDER_UPDATE_FAIL = "주문 완료 처리를 실패했습니다.";
    private final String STORE_DELETE_FAIL = "가게 정보 삭제에 실패했습니다.";
    private final String CLOSE_FAIL_MSG = "폐점 전환에 실패했습니다.";
    private final String SECRET_FAIL_MSG = "가게 승인(공개) 전환에 실패했습니다.";

    private final String NO = "N";
    private final String YES = "Y";

    //page
    private final String PAGE_ORDER_LIST = "adminMainProduct"; //views 하위 주문 목록 페이지
    private final String PAGE_REPORT_LIST = "closedStoreDeclareList"; //views 하위 신고목록 페이지
    private final String PAGE_TIPOFF_LIST = "storeDeclareList"; //views 하위 가게 제보목록 페이지

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
        return "redirect:/loadListOrder.do";
    }

    @RequestMapping("/loadListOrder.do")
    public String loadListOrder(){
        //KS 일단 보류 장바구니쪽이 정리되면 맞춰서 데이터 전달
        return PAGE_ORDER_LIST;
    }

    @RequestMapping("/loadListStoreReport.do")
    public String loadListStoreReport(Model model){
        StoreDTO storeDTO = new StoreDTO();
        storeDTO.setCondition("SELECTALL_DECLARED_CNT");
        model.addAttribute("storeReportList", storeService.selectAll(storeDTO));
        return PAGE_REPORT_LIST;
    }

    //KS DB확인 STORE_TIP_OFF_LIST
    @RequestMapping("/loadListStoreTipOff.do")
    public String loadListStoreTipOff(Model model){
        StoreDTO storeDTO = new StoreDTO();
        storeDTO.setCondition("STORE_TIP_OFF_LIST");
        model.addAttribute("storeTipOffList", storeService.selectAll(storeDTO));
        return PAGE_TIPOFF_LIST;
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

    //관리자 파트에서 사용하는 기능

    //가게 폐점설정
    @RequestMapping("/updateStoreClose.do")
    public String updateStoreClose(StoreDTO storeDTO, Model model){
        log.info("log: /updateStoreClose.do updateStoreClose - start");
        log.info("log: updateStoreClose - input storeDTO num : [{}]", storeDTO.getStoreNum());
        HashMap<String, String> filterList = new HashMap<>();
        filterList.put("UPDATE_CLOSED", this.YES);
        storeDTO.setFilterList(filterList);
        if(!storeService.update(storeDTO)){
            //폐점처리 실패시
            log.error("log: updateStoreClose - store update closed failed");
            model.addAttribute("msg", CLOSE_FAIL_MSG);
            //관리자 가게 신고 목록으로 이동
            model.addAttribute("path", "loadListStoreReport.do");
            return FAIL_URL;
        }
        log.info("log: /updateStoreClose.do updateStoreClose - end");
        //관리자 가게 신고 목록으로 이동
        return "redirect:loadListStoreReport.do";
    }

    //가게 비공개 설정
    @RequestMapping("/updateStoreVisible.do")
    public String updateStoreVisible(StoreDTO storeDTO, Model model){
        log.info("log: /updateStoreVisible.do updateStoreVisible - start");
        log.info("log: updateStoreVisible - input storeDTO num : [{}]", storeDTO.getStoreNum());
        HashMap<String, String> filterList = new HashMap<>();
        filterList.put("UPDATE_SECRET", this.NO);
        storeDTO.setFilterList(filterList);
        if(!storeService.update(storeDTO)){
            log.error("log: updateStoreVisible - store update visible failed");
            model.addAttribute("msg", SECRET_FAIL_MSG);
            //관리자 가게 제보 목록으로 이동
            model.addAttribute("path", "loadListStoreTipOff.do");
            return FAIL_URL;
        }
        log.info("log: /updateStoreVisible.do updateStoreVisible - end");
        //관리자 가게 제보 목록으로 이동
        return "redirect:loadListStoreTipOff.do";
    }
}
