package com.bungeobbang.app.view.controller;

import com.bungeobbang.app.biz.board.BoardDTO;
import com.bungeobbang.app.biz.board.BoardService;
import com.bungeobbang.app.biz.boardCate.BoardCateDTO;
import com.bungeobbang.app.biz.boardCate.BoardCateService;
import com.bungeobbang.app.biz.like.LikeDTO;
import com.bungeobbang.app.biz.like.LikeService;
import com.bungeobbang.app.view.util.FileUtil;
import com.bungeobbang.app.view.util.PaginationUtils;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@Controller("board")
@Slf4j
public class BoardController {
    @Autowired
    private BoardService boardService;
    @Autowired
    private LikeService likeService;
    @Autowired
    private BoardCateService boardCateService;

    //경로
    private final String FOLDER_NAME = "uploads/board/";
    private final String ROOT = "${pageContext.request.contextPath}/uploads/board/";
    private final String FAIL_URL = "failInfo2"; //실패 처리할 페이지
    private final String FAIL_DO = "redirect:failInfo.do"; //기본 실패 처리

    //board category condition
    private final String NOTICE = "NOTICE";
    private final String BOARD_LIST = "COMMUNITY";

    //session
    private final String SESSION_PK = "userPK"; //세션에 저장된 memberPK
    private final String SESSION_NICKNAME = "userNickname"; //세션에 저장된 memberPK
    private final String SESSION_IMAGE_SRC = "boardFile";

    //KS View 설계에 따라 수정
    private final int PAGE_SIZE = 6; // 페이지당 게시글 수

    //msg
    private final String FAIL_BOARD_DELETE_MSG = "게시글을 삭제할 수 없습니다. 관리자에게 문의 바랍니다.";
    private final String FAIL_BOARD_UPDATE_MSG = "게시글을 수정할 수 없습니다. 관리자에게 문의 바랍니다.";
    private final String FAIL_BOARD_INSERT_MSG = "게시글을 작성할 수 없습니다. 관리자에게 문의 바랍니다.";

    //page
    private final String PAGE_BOARD_INFO = "board"; //views 하위 게시글 상세
    private final String PAGE_BOARD_NOTICE = "noticeBoard"; //views 하위 문의게시팜
    private final String PAGE_BOARD_COMMU = "boardList"; //views 하위 일반커뮤니티게시판
    private final String PAGE_BOARD_UPDATE = "fixBoard"; //views 하위 게시글 수정
    private final String PAGE_BOARD_ADD = "boardWrite"; //views 하위 게시글 작성

    //게시글 상세보기
    @RequestMapping("/infoBoard.do")
    public String infoBoard(HttpSession session, Model model, LikeDTO likeDTO, BoardDTO boardDTO) {
        log.info("log: /infoBoard.do infoBoard - start");
        log.info("log: infoBoard - input likeDTO : [{}]", likeDTO);
        log.info("log: infoBoard - input boardDTO : [{}]", boardDTO);
        boolean userLiked = false; //좋아요 여부 (기본 좋아요 안한 상태)
        Integer sessionMemberPK = (Integer) session.getAttribute(SESSION_PK); //세션 값

        //데이터 조회
        boardDTO.setCondition("ONE_BOARD");
        boardDTO = boardService.selectOne(boardDTO);

        // 로그인 한 상태라면 좋아요 여부 확인
        if (sessionMemberPK != null) {
            log.info("log: infoBoard - sessionMemberPK : [{}]", sessionMemberPK);
            likeDTO.setMemberNum(sessionMemberPK);
            // 좋아요 상태
            if (likeService.selectOne(likeDTO) != null) {
                log.info("log: infoBoard - likeDTO : true");
                userLiked = true;
            }
        }

        //데이터 전달
        model.addAttribute("board", boardDTO); //게시글 내용 전달
        model.addAttribute("userLiked", userLiked); //초기 좋아요 상태 전달

        log.info("log: /infoBoard.do viewBoard - end");
        return PAGE_BOARD_INFO;
    }

    //게시글 삭제
    @RequestMapping("/deleteBoard.do")
    public String deleteBoard(Model model, BoardDTO boardDTO,
                              //상대경로 변환용 realPath 사용을 위한 객체
                              ServletContext servletContext) {
        log.info("log: /deleteBoard.do deleteBoard - start");
        log.info("log: deleteBoard - input boardDTO : [{}]", boardDTO);
        String imagePath; //경로

        //이미지 폴더 삭제 안할 시 필요없는 로직 범위//////////////////////////////////////////////
        //이미지 폴더를 삭제하기 위한 DB 폴더명 조회
        boardDTO.setCondition("ONE_BOARD");
        boardDTO = boardService.selectOne(boardDTO);

        //해당 게시글 이미지 폴더 삭제
        imagePath = servletContext.getRealPath(FOLDER_NAME) + boardDTO.getBoardFolder();  // 이미지 경로 설정
        if(FileUtil.deleteFileAndDirectory(new File(imagePath))){
            log.error("log: deleteBoard - delete file fail check");
        }
        ///////////////////////////////////////////////////////////////////////////////////

        //게시글 삭제
        if (!boardService.delete(boardDTO)) {
            log.error("log: deleteBoard - delete board fail");
            //게시글 삭제 실패
            model.addAttribute("msg", FAIL_BOARD_DELETE_MSG);
            model.addAttribute("path", "listBoards.do?categoryName="+boardDTO.getBoardCategoryName());
            return FAIL_URL;
        }

        //해당 카테고리 게시판으로 이동
        log.info("log: /deleteBoard.do deleteBoard - end : listBoards.do");
        return "listBoards.do?categoryName="+boardDTO.getBoardCategoryName();
    }

    //게시글 전체 리스트
    //KS 작업해야함 loadListBoard's' check!
    @RequestMapping("/loadListBoards.do")
    public String loadListBoards(Model model, int page, String categoryName, BoardDTO totalCNT, BoardDTO boardDTO,
                                 String keyword, String contentFilter, String writeDayFilter, BoardDTO boardTotalCNT) {

        //페이지 정보
        int currentPage = page <= 0? 1 : page; //페이지 정보가 있다면 해당 페이지, 없다면 기본값 1
        int totalPages; //페이지 수 정보
        int totalRecords; //게시글 수
        ArrayList<BoardDTO> boardList; //게시글 정보

        // 총 게시글 수 조회 및 페이지네이션 설정
        totalCNT.setCondition("CNT_BOARD");
        totalRecords = boardService.selectOne(totalCNT).getCnt(); //게시글 수

        // 페이지네이션 정보 설정 (startNum, endNum - 기존 Pagination util 재활용)
        PaginationUtils.setPagination(currentPage, PAGE_SIZE, totalRecords, boardDTO);

        // selectAll 요청
        boardDTO.setCondition("FILTER_BOARD");
        boardList = boardService.selectAll(boardDTO);

        // HashMap을 사용하여 검색 조건을 설정
        HashMap<String, String> filterList = new HashMap<>();

        // 검색 조건 설정
        if (contentFilter != null && keyword != null && !keyword.isEmpty()) {
            filterList.put(contentFilter, keyword);
        }

        // 작성일 필터 처리
        if (writeDayFilter != null) {
            filterList.put("WRITEDAY_FILTER", writeDayFilter);
        }

        //게시글을 검색조건에 맞게 검색하기 위한 DTO
        boardDTO.setCondition("FILTER_BOARD");
        boardDTO.setFilterList(filterList);
        boardDTO.setBoardCategoryName(categoryName);

        //CNT를 구하기위한 DTO
        boardTotalCNT.setCondition("CNT_BOARD");
        boardTotalCNT.setFilterList(filterList);
        boardTotalCNT.setBoardCategoryName(categoryName);

        // view 에게 보낼 총 페이지 수
        totalPages = PaginationUtils.calTotalPages(totalRecords, PAGE_SIZE);

        // JSP로 데이터 전달
        model.addAttribute("boardList", boardList); // 게시글 내용
        model.addAttribute("currentPage", currentPage); // 현재 페이지 번호
        model.addAttribute("totalPages", totalPages); // 게시글 페이지네이션 갯수
        model.addAttribute("boardCateName", categoryName); // 게시글 카테고리 이름

        String path = null;
        if (categoryName.equals(NOTICE)) { //문의 게시판이라면
            path = PAGE_BOARD_NOTICE; // 문의게시판으로 포워딩
        }
        else if (categoryName.equals(BOARD_LIST)) { //공개 게시판이라면
            path = PAGE_BOARD_COMMU; // 공개게시판으로 포워딩
        }
        return path;
    }

    //게시글 수정 페이지로 이동
    @RequestMapping(value = "/updateBoard.do", method = RequestMethod.GET)
    public String updateBoard(Model model, BoardDTO boardDTO) {
        log.info("log: /updateBoard.do updateBoard GET - start");
        log.info("log: updateBoard - input boardDTO : [{}]", boardDTO);
        boardDTO.setCondition("ONE_BOARD");
        boardDTO = boardService.selectOne(boardDTO);
        //데이터
        model.addAttribute("board", boardDTO);
        //확인
        log.info("log: updateBoard - send board : [{}]", boardDTO);

        log.info("log: /updateBoard.do updateBoard GET - end");
        return PAGE_BOARD_UPDATE;
    }

    //게시글 작성 페이지 이동
    @RequestMapping(value = "/addBoard.do", method = RequestMethod.GET)
    public String addBoard(Model model, BoardDTO boardDTO) {
        log.info("log: /addBoard.do addBoard GET - start");
        log.info("log: /addBoard GET - input boardDTO : [{}]", boardDTO);
        boardDTO.setBoardFolder(FileUtil.createFileName()); //폴더명 전달
        model.addAttribute("data", boardDTO);
        //확인
        log.info("log: addBoard GET - send data : [{}]", boardDTO);
        log.info("log: /addBoard.do addBoard GET - end : forward");
        return PAGE_BOARD_ADD;
    }

    //게시글 수정
    @RequestMapping(value = "/updateBoard.do", method = RequestMethod.POST)
    public String updateBoard(BoardDTO boardDTO, BoardCateDTO boardCateDTO, Model model) {
        log.info("log: /updateBoard.do updateBoard - start");
        log.info("log: updateBoard - input boardDTO : [{}]", boardDTO);
        boardDTO.setBoardCategoryNum(boardCateService.selectOne(boardCateDTO).getBoardCateNum());//카테고리이름을 번호로 변경
        boardDTO.setCondition("BOARD_UPDATE");//컨디션 설정
        if(boardService.update(boardDTO)){
            log.error("log: updateBoard - update fail");
            model.addAttribute("msg", FAIL_BOARD_UPDATE_MSG);
            //업데이트 실패 시 해당 글 상세보기로 이동
            model.addAttribute("path", "infoBoard.do?BoardNum="+boardDTO.getBoardNum());
            return FAIL_URL;
        }
        //업데이트 성공 시 해당 글 상세보기로 이동
        log.info("log: /updateBoard.do updateBoard - end");
        return "redirect:infoBoard.do?BoardNum="+boardDTO.getBoardNum();
    }

    //게시글 작성
    @RequestMapping(value = "/addBoard.do", method = RequestMethod.POST)
    public String addBoard(HttpSession session, BoardDTO boardDTO, BoardCateDTO boardCateDTO, Model model){
        log.info("log: /addBoard.do addBoard - start");
        //ckeditor를 통해 넘어온 content의 이미지 src 서버에 맞춰 수정하는 로직///////////////////////////
        //세션에 저장해둔 파일 명 변경 정보 호출
        HashMap<String, String> boardFile = (HashMap<String, String>) session.getAttribute(SESSION_IMAGE_SRC);
        String content = boardDTO.getBoardContent(); //작성한 내용
        //이미지 태그의 src 변경
        if(boardFile != null && !boardFile.isEmpty()){ //이미지가 있는 경우라면
            for (Map.Entry<String, String> entry : boardFile.entrySet()) {
                //value값을 찾아 서버 이미지 경로로 변경
                content = content.replace(entry.getValue(),
                        ROOT + boardDTO.getBoardFolder() + "/" + entry.getKey());
            }
            session.removeAttribute(SESSION_IMAGE_SRC); //다 바꾼 뒤에는 세션에서 삭제
        }
        boardDTO.setBoardContent(content); //변경한 내용을 다시 DTO에 저장 이미지가 없다면 그대로 저장
        /////////////////////////////////////////////////////////////////////////////////////////

        //카테고리 번호 조회해 저장
        boardDTO.setBoardCategoryNum(boardCateService.selectOne(boardCateDTO).getBoardCateNum());
        boardDTO.setCondition("BOARD_INSERT");//컨디션 설정
        //게시글 추가
        if(boardService.insert(boardDTO)){
            //실패 시
            log.error("log: addBoard - insert fail");
            model.addAttribute("msg", FAIL_BOARD_INSERT_MSG);
            model.addAttribute("path", "boardList.do?categoryName="+boardCateDTO.getBoardCateName());
            return FAIL_URL;
        }
        //작성한 글이 있는 카테고리 페이지로 이동
        log.info("log: /addBoard.do addBoard - end");
        return "redirect:loadListBoards.do?categoryName="+boardCateDTO.getBoardCateName();
    }
}
