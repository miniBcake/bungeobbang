package com.bungeobbang.app.view.controller;

import com.bungeobbang.app.biz.board.BoardDTO;
import com.bungeobbang.app.biz.board.BoardService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;

@Controller("main")
@Slf4j
public class MainController {
    @Autowired
    private BoardService boardService;

    //실패 기본값
    private String msg = "요청한 서비스를 찾을 수 없습니다.";
    private String path = "redirect:/main.do";

    //메인페이지 이동
    @RequestMapping("/main.do")
    public String mainPage(Model model, BoardDTO boardDTO) {
        log.info("log: /main.do mainPage - start");

        // DAO 호출하여 인기 게시물 TOP 3을 가져오기
        boardDTO.setCondition("HOT_BOARD");
        //KS 카테고리
        ArrayList<BoardDTO> hotBoardList = boardService.selectAll(boardDTO); // DAO에서 인기 게시물 조회

        //TODO 메인페이지에서 호출되는 데이터 추가

        // JSP로 전달할 데이터를 request에 설정
        model.addAttribute("hotBoardList", hotBoardList); // 상위 3개 인기 게시물 리스트를 request에 전달
        //확인
        log.info("log: /main.do mainPage - send hotBoardList [{}]", hotBoardList);

        // 로그 및 종료 메시지 출력
        log.info("log: /main.do mainPage - end");
        return "main";
    }

    //실패 알랏 페이지
    @RequestMapping("/failInfo.do")
    public String failInfo(Model model) {
        //전달받은 실패 메세지를 가지고 응답
        model.addAttribute("msg", this.msg); //메세지
        model.addAttribute("path", this.path); //이후 이동 경로
        log.info("log: /failInfo.do failInfo fail msg");
        //스위트 알랏
        return "failInfo2";
    }
}
