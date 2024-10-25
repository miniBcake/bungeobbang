package com.bungeobbang.app.view.controller;

import com.bungeobbang.app.biz.declare.DeclareDTO;
import com.bungeobbang.app.biz.declare.DeclareService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
public class ReportAsyncController {
    @Autowired
    private DeclareService declareService;

    //폐점 신고
    @RequestMapping("/addReport.do")
    public @ResponseBody boolean addReport(DeclareDTO declareDTO){
        log.info("log: /addReport.do addReport.do - start");
        declareDTO.setDeclareReason("this store is closed"); //현재 신고가 하나 뿐이라 하드코딩
        log.info("log: addReport.do - declareDTO : {}", declareDTO);
        log.info("log: /addReport.do addReport.do - end");
        return declareService.insert(declareDTO); //결과값 text로 반환
    }

    //해당 가게의 신고 전부 삭제하기
    @RequestMapping("/deleteReport.do")
    public @ResponseBody boolean deleteReport(DeclareDTO declareDTO){
        log.info("log: /deleteReport.do deleteReport.do - start");
        boolean flag = false;//초기값 설정
        log.info("log: deleteReport.do - declareDTO : {}", declareDTO);
        for(DeclareDTO dto : declareService.selectAll(declareDTO)){ //해당 가게 번호를 가진 신고 리스트
            flag = declareService.delete(dto); //신고를 하나씩 삭제
            if(!flag){ //신고에 실패했다면
                log.error("log: deleteReport.do - error : {}", dto);
                break; //종료
            }
            log.info("log: deleteReport.do - delete");
        }
        log.info("log: /deleteReport.do deleteReport.do - end : {}", flag);
        return flag; //결과값 반환
    }
}
