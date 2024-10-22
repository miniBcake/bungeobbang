package com.bungeobbang.app.view.controller;

import com.bungeobbang.app.biz.board.BoardDTO;
import com.bungeobbang.app.biz.board.BoardService;
import com.bungeobbang.app.biz.store.StoreDTO;
import com.bungeobbang.app.biz.store.StoreService;
import com.bungeobbang.app.biz.storeMenu.StoreMenuDTO;
import com.bungeobbang.app.biz.storeMenu.StoreMenuService;
import com.bungeobbang.app.biz.storePayment.StorePaymentDTO;
import com.bungeobbang.app.biz.storePayment.StorePaymentService;
import com.bungeobbang.app.biz.storeWork.StoreWorkDTO;
import com.bungeobbang.app.biz.storeWork.StoreWorkService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("store")
public class StoreController {
    @Autowired
    private StoreService storeService;
    @Autowired
    private StoreMenuService storeMenuService;
    @Autowired
    private StorePaymentService storePaymentService;
    @Autowired
    private StoreWorkService storeWorkService;
    @Autowired
    private BoardService boardService;

    private final String FAIL_PATH = "failInfo2";
    private final String FOLDER_PATH = "/uploads/board/";

    @RequestMapping(value = "/addStore.do", method = RequestMethod.POST)
    public String addStore(StoreDTO storeDTO, StoreMenuDTO storeMenuDTO, StorePaymentDTO storePaymentDTO, StoreWorkDTO storeWorkDTO, BoardDTO boardDTO) {

        String path = null;

        return path;
    }

    @RequestMapping(value = "/addStore.do", method = RequestMethod.GET)
    public String addStore(HttpSession session){
        return FAIL_PATH;
    }

    @RequestMapping("/updateStoreClose.do")
    public String updateStoreClose(){
        return FOLDER_PATH;
    }

    @RequestMapping("/updateStoreVisible.do")
    public String updateStoreVisible(){
        return FOLDER_PATH;
    }

    @RequestMapping("/infoStore.do")
    public String infoStore(){
        return FOLDER_PATH;
    }

    @RequestMapping("/loadListStore.do")
    public String loadListStore(){
        return FOLDER_PATH;
    }
}
