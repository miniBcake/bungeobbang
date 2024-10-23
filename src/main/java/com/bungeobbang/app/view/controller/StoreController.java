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
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller("store")
@Slf4j
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
    private final String FAIL_DO = "redirect:failInfo.do";
    private final String FOLDER_PATH = "uploads\\board\\"; //webapp기준
    private final String ROOT = "${pageContext.request.contextPath}/uploads/board/";

    //condition
    private final String ADD_STORE = "ADD";
    private final String REPORT_STORE = "USERADD";

    private final String NO = "N";
    private final String YES = "Y";


    @RequestMapping(value = "/addStore.do", method = RequestMethod.POST)
    public String addStore(HttpSession session, StoreDTO storeDTO, StoreMenuDTO storeMenuDTO, StorePaymentDTO storePaymentDTO, BoardDTO boardDTO,
                           String[] workWeek, String[] workStartTime, String[] workEndTime) {

        List<StoreWorkDTO> workList = new ArrayList<>(); //영업정보 (여러 행) 데이터를 취합할 리스트
        //받아온 데이터 취합 저장
        for(int i=0; i<workWeek.length; i++){
            StoreWorkDTO workDTO = new StoreWorkDTO();
            workDTO.setStoreWorkWeek(workWeek[i]);
            workDTO.setStoreWorkOpen(workStartTime[i]);
            workDTO.setStoreWorkClose(workEndTime[i]);
            log.info("log: addStore - workList StoreWorkDTO{} : {}", i, workDTO);
            workList.add(workDTO); //리스트에 추가
        }

        //가게 추가
        if(!this.storeService.insert(storeDTO)){
            //insert 실패 시
            log.error("log: store insert failed");
            return FAIL_DO;
        }

        //추가한 가게의 PK번호
        storeDTO.setCondition("STORE_NEW_SELECTONE");
        int storePK = storeService.selectOne(storeDTO).getMaxPk();
        log.info("log: store insert successful storePK: {}", storePK);

        //PK번호 전달 및 메뉴 추가
        storeMenuDTO.setStoreNum(storePK);
        if(!this.storeMenuService.insert(storeMenuDTO)){
            //insert 실패 시
            log.error("log: storeMenu insert failed");
            return FAIL_DO;
        }

        //PK번호 전달 및 결제 정보 추가
        storePaymentDTO.setStoreNum(storePK);
        if(!this.storePaymentService.insert(storePaymentDTO)){
            //insert 실패 시
            log.error("log: storePayment insert failed");
            return FAIL_DO;
        }

        //PK번호 전달 및 영업 정보 추가
        boolean flag = true;
        for(StoreWorkDTO s : workList){ //여러 줄의 데이터이므로 반복문
            s.setStoreNum(storePK);
            if(!this.storeWorkService.insert(s)){
                //insert 실패 시
                log.error("log: storeWork insert failed");
                flag = false;
                break; //반복 중단
            }
        }
        if(!flag){ //insert 실패 시
            return FAIL_DO;
        }

        //가게 설명
        if(boardDTO != null){ //가게 설명이 있다면
            //ckeditor를 통해 넘어온 context의 이미지 src 서버에 맞춰 수정/////////////
            HashMap<String, String> boardFile = (HashMap<String, String>) session.getAttribute("boardFile");
            String content = boardDTO.getBoardContent(); //작성한 내용
            //이미지 태그의 src 변경
            if(boardFile != null && !boardFile.isEmpty()){ //이미지가 있는 경우라면
                for (Map.Entry<String, String> entry : boardFile.entrySet()) {
                    content = content.replace(entry.getValue(), ROOT + boardDTO.getBoardFolder() + "/" + entry.getKey()); //value값을 찾아 서버 이미지 경로로 변경
                }
            }
            boardDTO.setBoardContent(content); //변경한 내용을 다시 DTO에 저장
            /////////////////////////////////////////////////////////////////////

            boardDTO.setCondition("MARKET_INSERT"); //가게 설명 추가용 condition
            boardDTO.setStoreNum(storePK); //FK설정
            if(!boardService.insert(boardDTO)) {//DB에 추가
                log.error("log: board insert failed");
                return FAIL_DO;
            }
        }
        //등록 성공 시
        return "redirect:loadListStore.do";
    }

    @RequestMapping(value = "/addStore.do", method = RequestMethod.GET)
    public String addStore(String condition, Model model){
        String path;
        if(condition.equals(REPORT_STORE)){//제보라면
            //KS 페이지연결 - 제보
            path = "";
        }
        else if(condition.equals(ADD_STORE)){//가게 추가라면
            //KS 페이지 연결 - 가게 추가
            path = "";
        }
        else {
           path = FAIL_DO;
        }
        model.addAttribute("condition", condition);
        return path;
    }

    @RequestMapping("/updateStoreClose.do")
    public String updateStoreClose(StoreDTO storeDTO){
        storeDTO.setCondition("UPDATE_CLOSED");
        storeDTO.setStoreClosed(this.YES);
        storeService.update(storeDTO);
        return FOLDER_PATH;
    }

    @RequestMapping("/updateStoreVisible.do")
    public String updateStoreVisible(StoreDTO storeDTO){
        //KS condition 확인바람
        storeDTO.setCondition("");
        storeDTO.setStoreDeclared(this.NO);
        storeService.update(storeDTO);
        return FOLDER_PATH;
    }

    @RequestMapping("/infoStore.do")
    public String infoStore(StoreDTO storeDTO, Model model){
        storeDTO.setCondition("INFO_STORE_SELECTONE");
        StoreDTO storeInfo = storeService.selectOne(storeDTO);
        model.addAttribute("storeInfo", storeInfo);
        return "store";
    }

    @RequestMapping("/loadListStore.do")
    public String loadListStore(){
        
        return "storeList";
    }
}
