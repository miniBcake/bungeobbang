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
    private final String FOLDER_PATH = "uploads/board/"; //webapp기준
    private final String ROOT = "${pageContext.request.contextPath}/"+FOLDER_PATH;

    //condition
    private final String ADD_STORE = "ADD";
    private final String REPORT_STORE = "USERADD";

    private final String NO = "N";
    private final String YES = "Y";

    //page
    private final String PAGE_ADD_STORE = "adminStoreRegister"; //views 하위, 가게 등록
    private final String PAGE_REPORT_STORE = "userStoreReport"; //views 하위, 가게 제보
    private final String PAGE_INFO_STORE = "store"; //views 하위, 가게 상세
    private final String PAGE_LOAD_LIST_STORE = "storeList"; //views 하위, 가게 검색+리스트


    //가게 등록 페이지 이동
    @RequestMapping(value = "/addStore.do", method = RequestMethod.GET)
    public String addStore(String condition, Model model){
        log.info("log: /addStore.do addStore GET - start");
        log.info("log: addStore - input condition : [{}]", condition);
        String path; //경로 저장 변수
        if(condition.equals(REPORT_STORE)){//제보라면
            log.info("log: addStore report");
            path = PAGE_REPORT_STORE;
        }
        else if(condition.equals(ADD_STORE)){//가게 추가라면
            log.info("log: addStore admin");
            path = PAGE_ADD_STORE;
        }
        else {
            log.error("log: addStore - error condition");
            path = FAIL_DO; //일치하는 컨디션 값이 아닐 때 실패처리
        }
        model.addAttribute("condition", condition);
        //확인
        log.info("log: addStore - send condition : [{}]", condition);
        log.info("log: /addStore.do addStore GET - end");
        return path;
    }


    //가게 등록 기능 수행
    @RequestMapping(value = "/addStore.do", method = RequestMethod.POST)
    public String addStore(HttpSession session, StoreDTO storeDTO, StoreMenuDTO storeMenuDTO, StorePaymentDTO storePaymentDTO, BoardDTO boardDTO,
                           String[] workWeek, String[] workStartTime, String[] workEndTime) {
        log.info("log: /addStore.do addStore - start");
        log.info("log: addStore param - storeDTO : {}", storeDTO);
        log.info("log: addStore param - storeMenuDTO : {}", storeMenuDTO);
        log.info("log: addStore param - storePaymentDTO : {}", storePaymentDTO);
        log.info("log: addStore param - boardDTO : {}", boardDTO);
        log.info("log: addStore param - workWeek : {}", (Object) workWeek);
        log.info("log: addStore param - workStartTime : {}", (Object) workStartTime);
        log.info("log: addStore param - workEndTime : {}", (Object) workEndTime);

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
        log.info("log: addStore - workList (workInfoList create) : {}", workList);

        //가게 추가
        if(!this.storeService.insert(storeDTO)){
            //insert 실패 시
            log.error("log: store insert failed");
            return FAIL_DO;
        }

        //추가한 가게의 PK번호
        storeDTO.setCondition("STORE_NEW_SELECTONE");
        int storePK = storeService.selectOne(storeDTO).getMaxPK();
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
                log.error("log: storeWork insert failed : {}", s);
                flag = false;
                break; //반복 중단
            }
        }
        if(!flag){ //insert 실패 시
            return FAIL_DO;
        }

        //가게 설명
        if(boardDTO != null){ //가게 설명이 있다면
            log.info("log: addStore board is not null - boardDTO : {}", boardDTO);
            //ckeditor를 통해 넘어온 context의 이미지 src 서버에 맞춰 수정/////////////
            HashMap<String, String> boardFile = (HashMap<String, String>) session.getAttribute("boardFile");
            log.info("log: addStore - change image src info boardFile : {}", boardFile);
            String content = boardDTO.getBoardContent(); //작성한 내용
            //이미지 태그의 src 변경
            if(boardFile != null && !boardFile.isEmpty()){ //이미지가 있는 경우라면
                for (Map.Entry<String, String> entry : boardFile.entrySet()) {
                    content = content.replace(entry.getValue(), ROOT + boardDTO.getBoardFolder() + "/" + entry.getKey()); //value값을 찾아 서버 이미지 경로로 변경
                }
            }
            log.info("log: addStore - refresh boardContent [{}]", content);
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
        log.info("log: /addStore.do addStore - end");
        return "redirect:loadListStore.do";
    }

    //가게 상세 조회
    @RequestMapping("/infoStore.do")
    public String infoStore(StoreDTO storeDTO, StoreWorkDTO storeWorkDTO, Model model){
        log.info("log: /infoStore.do infoStore - start");
        log.info("log: infoStore - input storeDTO num : [{}]", storeDTO.getStoreNum());
        storeDTO.setCondition("INFO_STORE_SELECTONE");
        storeDTO = storeService.selectOne(storeDTO);
        //영업정보 추가
        storeDTO.setWorkList(storeWorkService.selectAll(storeWorkDTO));
        //데이터 전달
        model.addAttribute("storeInfo", storeDTO);
        //확인
        log.info("log: infoStore - send storeInfo : [{}]", storeDTO);
        log.info("log: /infoStore.do infoStore - end");
        return PAGE_INFO_STORE;
    }

    //가게 검색 (동기, 전체)
    @RequestMapping("/loadListStore.do")
    public String loadListStore(){
        //TODO 나중에 view와 함께 데이터 타입 정리 후 진행
        return PAGE_LOAD_LIST_STORE;
    }
}
