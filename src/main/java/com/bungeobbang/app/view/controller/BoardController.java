package com.bungeobbang.app.view.controller;

import com.bungeobbang.app.biz.board.BoardDTO;
import com.bungeobbang.app.biz.board.BoardService;
import com.bungeobbang.app.biz.boardCate.BoardCateDTO;
import com.bungeobbang.app.biz.boardCate.BoardCateService;
import com.bungeobbang.app.biz.like.LikeDTO;
import com.bungeobbang.app.biz.like.LikeService;
import com.bungeobbang.app.biz.reply.ReplyDTO;
import com.bungeobbang.app.biz.reply.ReplyService;
import com.bungeobbang.app.view.util.FileUtil;
import com.bungeobbang.app.view.util.PaginationUtils;
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
    private final String FOLDER_NAME = "uploads\\board\\";
    private final String FAIL_URL = "failInfo2"; //실패 처리할 페이지
    private final String FAIL_DO = "redirect:failInfo.do"; //기본 실패 처리

    //board category condition
    private final String NOTICE = "NOTICE";
    private final String BOARD_LIST = "COMMUNITY";

    //session
    private final String SESSION_PK = "userPK"; //세션에 저장된 memberPK
    private final String SESSION_NICKNAME = "userNickname"; //세션에 저장된 memberPK

    private final int PAGE_SIZE = 6; // 페이지당 게시글 수

    //msg
    private final String FAIL_BOARD_DELETE_MSG = "게시글을 삭제할 수 없습니다. 관리자에게 문의 바랍니다.";
    private final String FAIL_BOARD_UPDATE_MSG = "게시글을 수정할 수 없습니다. 관리자에게 문의 바랍니다.";
    private final String FAIL_BOARD_INSERT_MSG = "게시글을 작성할 수 없습니다. 관리자에게 문의 바랍니다.";

    //게시글 상세보기
    @RequestMapping("/infoBoard.do")
    public String infoBoard(HttpSession session, Model model, LikeDTO likeDTO, BoardDTO boardDTO) {
        log.info("log: /infoBoard.do infoBoard - start");
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
        return "board";
    }

    //게시글 삭제
    @RequestMapping("/deleteBoard.do")
    public String deleteBoard(HttpServletRequest request, Model model, BoardDTO boardDTO) {
        log.info("log: /deleteBoard.do deleteBoard - start");
        String imagePath; //경로
        boardDTO.setCondition("ONE_BOARD");
        boardDTO = boardService.selectOne(boardDTO);
        // 해당 게시글 이미지 폴더 삭제
        imagePath = request.getContextPath() + FOLDER_NAME + boardDTO.getBoardFolder();  // 이미지 경로 설정
        if(FileUtil.deleteFileAndDirectory(new File(imagePath))){
            log.error("log: deleteBoard - delete file fail check");
        }
        //게시글 삭제
        if (!boardService.delete(boardDTO)) {
            log.error("log: deleteBoard - delete board fail");
            //게시글 삭제 실패
            model.addAttribute("msg", FAIL_BOARD_DELETE_MSG);
            model.addAttribute("path", "listBoards.do?categoryName="+boardDTO.getBoardCateName());
            return FAIL_URL;
        }
        log.info("log: /deleteBoard.do deleteBoard - end : listBoards.do");
        //해당 카테고리 게시판으로 이동
        return "listBoards.do?categoryName="+boardDTO.getBoardCateName();
    }

    //게시글 전체 리스트
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
        totalRecords = boardService.selectOne(totalCNT).getCnt();

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
        boardDTO.setBoardCateName(categoryName);

        //CNT를 구하기위한 DTO
        boardTotalCNT.setCondition("CNT_BOARD");
        boardTotalCNT.setFilterList(filterList);
        boardTotalCNT.setBoardCateName(categoryName);

        // view 에게 보낼 총 페이지 수
        totalPages = PaginationUtils.calTotalPages(totalRecords, PAGE_SIZE);

        // JSP로 데이터 전달
        model.addAttribute("boardList", boardList); // 게시글 내용
        model.addAttribute("currentPage", currentPage); // 현재 페이지 번호
        model.addAttribute("totalPages", totalPages); // 게시글 페이지네이션 갯수
        model.addAttribute("boardCateName", categoryName); // 게시글 카테고리 이름

        String path = null;
        if (categoryName.equals(NOTICE)) { //문의 게시판이라면
            path = "noticeBoard"; // 문의게시판으로 포워딩
        }
        else if (categoryName.equals(BOARD_LIST)) { //공개 게시판이라면
            path = "boardList"; // 공개게시판으로 포워딩
        }
        return path;
    }

    //게시글 수정 페이지로 이동
    @RequestMapping(value = "/updateBoard.do", method = RequestMethod.GET)
    public String updateBoard(Model model, BoardDTO boardDTO) {
        log.info("log: /updateBoard.do updateBoard - start");
        boardDTO.setCondition("ONE_BOARD");
        boardDTO = boardService.selectOne(boardDTO);
        //데이터
        model.addAttribute("board", boardDTO);
        //확인
        log.info("log: updateBoard - send board : [{}]", boardDTO);

        log.info("log: /updateBoard.do updateBoard - end");
        return "fixBoard";
    }

    //게시글 작성 페이지 이동
    @RequestMapping(value = "/addBoard.do", method = RequestMethod.GET)
    public String addBoard(Model model, BoardDTO boardDTO) {
        log.info("log: /addBoard.do addBoard - start");
        boardDTO.setBoardFolder(FileUtil.createFileName());
        model.addAttribute("data", boardDTO);
        //확인
        log.info("log: addBoard - send data : [{}]", boardDTO);
        log.info("log: /addBoard.do addBoard - end : forward");
        return "boardWrite";
    }

    //게시글 수정
    @RequestMapping(value = "/updateBoard.do", method = RequestMethod.POST)
    public String updateBoard(BoardDTO boardDTO, BoardCateDTO boardCateDTO, Model model) {
        boardDTO.setBoardCateNum(boardCateService.selectOne(boardCateDTO).getBoardCateNum());
        boardDTO.setCondition("BOARD_UPDATE");
        if(boardService.update(boardDTO)){
            model.addAttribute("msg", FAIL_BOARD_UPDATE_MSG);
            model.addAttribute("path", "infoBoard.do?BoardNum="+boardDTO.getBoardNum());
            return FAIL_URL;
        }
        return "redirect:boardList.do?categoryName="+boardCateDTO.getBoardCateName();
    }

    //게시글 작성
    @RequestMapping(value = "/addBoard.do", method = RequestMethod.POST)
    public String addBoard(BoardDTO boardDTO, BoardCateDTO boardCateDTO, Model model){
        boardDTO.setBoardCateNum(boardCateService.selectOne(boardCateDTO).getBoardCateNum());
        boardDTO.setCondition("BOARD_INSERT");
        if(boardService.insert(boardDTO)){
            model.addAttribute("msg", FAIL_BOARD_INSERT_MSG);
            model.addAttribute("path", "boardList.do?categoryName="+boardCateDTO.getBoardCateName());
            return FAIL_URL;
        }
        return "redirect:boardList.do?categoryName="+boardCateDTO.getBoardCateName();
    }

    //마이페이지 - 자신이 작성한 게시글 목록 페이지 => 마이페이지에서 처리
    //@RequestMapping("/loadListBoardMyList.do")
    public String myBoardList(Model model, HttpSession session, BoardDTO boardTotalCNT, int page, BoardCateDTO boardCateDTO, BoardDTO boardDTO) {
        log.info("[INFO] MyBoardListPageAction 실행 시작");

        Integer memberPK; //세션 memberPK
        String nickName; //세션 닉네임
        HashMap<String, String> filterList = new HashMap<>(); //필터 검색용

        // 세션에서 값을
        memberPK = (Integer) session.getAttribute(SESSION_PK);
        nickName = (String) session.getAttribute(SESSION_NICKNAME);

        // 페이지 기본 설정
        int currentPage = 1; // 기본 현재 페이지
        if (page > 0) {
            currentPage = page;
        }

        // 내가 쓴 게시글 조회하기 위한 BoardDTO 초기설정
        boardDTO.setCondition("MY_BOARD");
        boardDTO.setMemberNum(memberPK);

        // 총 개수를 조회하기 위한 필터 설정
        filterList.put("NICKNAMEV", nickName);

        // 카테고리 조회에서 모든 카테고리 게시판에 쓴글 갯수 조회
        int totalRecords = 0;

        // BoardCateDTO 목록 조회
        ArrayList<BoardCateDTO> boardCateList = boardCateService.selectAll(boardCateDTO);

        // 각 카테고리별로 게시글 수를 조회
        for (BoardCateDTO cateDTO : boardCateList) {
            String categoryName = cateDTO.getBoardCateName();

            // 게시글 수 조회를 위한 DTO 설정
            boardTotalCNT.setCondition("CNT_BOARD");
            boardTotalCNT.setFilterList(filterList);
            boardTotalCNT.setBoardCateName(categoryName);

            // 각 카테고리별 게시글 수 조회
            int categoryRecords = boardService.selectOne(boardTotalCNT).getCnt();

            // 전체 게시글 수에 추가
            totalRecords += categoryRecords;
        }

        // 페이지네이션 함수 실행
        PaginationUtils.setPagination(currentPage, PAGE_SIZE, totalRecords, boardDTO);

        // 게시글 목록 조회
        ArrayList<BoardDTO> datas;
        datas = boardService.selectAll(boardDTO);

        // 총 페이지 수 계산
        int totalPages = PaginationUtils.calTotalPages(totalRecords, PAGE_SIZE);

        // View에 전달할 데이터 설정
        String profilePic = null;
        //String profilePic = ProfilePicUpload.loginProfilePic(request, response);
        model.addAttribute("memberProfileWay", profilePic);
        model.addAttribute("myBoardList", datas);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);

        // 페이지 이동 설정
        return "myBoardList";
    }
}
