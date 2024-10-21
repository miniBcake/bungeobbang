package com.bungeobbang.app.view.controller;

import com.bungeabbang.app.biz.board.BoardDTO;
import com.bungeabbang.app.biz.board.BoardService;
import com.bungeabbang.app.biz.boardCate.BoardCateDTO;
import com.bungeabbang.app.biz.boardCate.BoardCateService;
import com.bungeabbang.app.biz.like.LikeDTO;
import com.bungeabbang.app.biz.like.LikeService;
import com.bungeabbang.app.biz.reply.ReplyDTO;
import com.bungeabbang.app.biz.reply.ReplyService;
import com.bungeabbang.app.view.util.FileUtil;
import com.bungeabbang.app.view.util.PaginationUtils;
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
    private ReplyService replyService;
    @Autowired
    private LikeService likeService;
    @Autowired
    private BoardCateService boardCateService;

    //KS boardInsert 작업을 할 때는 
    // CKEditor의 경우 이미지 경로만 변경해서 저장할 것,

    //경로
    private final String FOLDER_NAME = "/uploads/board/";
    private final String FAIL_URL = "failInfo2"; //실패 처리할 페이지
    private final String FAIL_DO = "redirect:failInfo.do"; //기본 실패 처리

    private final int PAGE_SIZE = 6; // 페이지당 게시글 수

    //msg
    private final String FAIL_BOARD_DELETE_MSG = "게시글을 삭제할 수 없습니다. 관리자에게 문의 바랍니다.";

    //게시글 상세보기
    @RequestMapping("/viewBoard.do")
    public String viewBoard(HttpSession session, Model model,
                            ReplyDTO replyDTO, LikeDTO likeDTO, BoardDTO boardDTO) {
        log.info("log: /viewBoard.do viewBoard - start");
        boolean userLiked = false; //좋아요 여부
        Integer sessionMemberPK; //세션 값
        int totalReplies; //댓글 수

        //데이터 조회
        boardDTO.setCondition("ONE_BOARD");
        boardDTO = boardService.selectOne(boardDTO);
        //댓글 조회
        replyDTO.setCondition("CNT_BOARD_RP");
        totalReplies = replyService.selectOne(replyDTO).getCnt();

        // 로그인 한 상태라면 좋아요 여부 확인
        if ((sessionMemberPK = (Integer) session.getAttribute("memberPK")) != null) {
            likeDTO.setMemberNum(sessionMemberPK);
            // 좋아요 상태
            if (likeService.selectOne(likeDTO) != null) {
                userLiked = true;
            }
        }

        //데이터 전달
        model.addAttribute("totalReplies", totalReplies);
        model.addAttribute("board", boardDTO);
        model.addAttribute("userLiked", userLiked);

        log.info("log: /viewBoard.do viewBoard - end");
        return "board";
    }

    //게시글 삭제
    @RequestMapping("/deleteBoard.do")
    public String deleteBoard(HttpServletRequest request, Model model, HttpSession session, BoardDTO boardDTO) {
        log.info("log: /deleteBoard.do deleteBoard - start");
        //세션 값
        Integer writerPK = (Integer) session.getAttribute("memberPK");
        String imagePath; //경로
        //검증
        if (writerPK != boardDTO.getMemberNum()) {
            log.error("log: deleteBoard - wrong member PK");
            //글 작성자가 아닐 경우
            //기본 실패 안내처리 후 메인으로 이동(디폴트값)
            return FAIL_DO;
        }
        boardDTO.setCondition("ONE_BOARD");
        boardDTO = boardService.selectOne(boardDTO);
        // 해당 게시글 이미지 조회
        imagePath = request.getContextPath() + FOLDER_NAME + boardDTO.getBoardNum();  // 이미지 경로 설정
        if(FileUtil.deleteFileAndDirectory(new File(imagePath))){
            log.error("log: deleteBoard - delete file fail check");
        }
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

    //전체 게시글 보기
    @RequestMapping("/listBoards.do")
    public String listBoards(Model model, int page, String categoryName, BoardDTO totalCNT, BoardDTO boardDTO) {

        //페이지 정보
        int currentPage = page <= 0? 1 : page; //페이지 정보가 있다면 해당 페이지, 없다면 기본값 1
        int totalPages; //페이지 수 정보
        int totalRecords; //게시글 수
        ArrayList<BoardDTO> boardList = null; //게시글 정보

        // 총 게시글 수 조회 및 페이지네이션 설정
        totalCNT.setCondition("CNT_BOARD");
        totalRecords = boardService.selectOne(totalCNT).getCnt();

        // 페이지네이션 정보 설정 (startNum, endNum - 기존 Pagination util 재활용)
        PaginationUtils.setPagination(currentPage, PAGE_SIZE, totalRecords, boardDTO);

        // selectAll 요청
        boardDTO.setCondition("FILTER_BOARD");
        boardList = boardService.selectAll(boardDTO);
        
        // view 에게 보낼 총 페이지 수
        totalPages = PaginationUtils.calTotalPages(totalRecords, PAGE_SIZE);

        // JSP로 데이터 전달
        model.addAttribute("boardList", boardList); // 게시글 내용
        model.addAttribute("currentPage", currentPage); // 현재 페이지 번호
        model.addAttribute("totalPages", totalPages); // 게시글 페이지네이션 갯수
        //model.addAttribute("boardCateName", categoryName); // 게시글 카테고리 이름

        String path = null; //기본 공개 게시판
        if (categoryName.equals("REQUEST")) { //문의 게시판이라면
            path = "noticeBoard"; // 문의게시판으로 포워딩
        }
        else if (categoryName.equals("NORMAL")) { //공개 게시판이라면
            path = "boardList"; // 공개게시판으로 포워딩
        }
        return path;
    }

    //게시글 검색
    @RequestMapping("/searchBoards.do")
    public String searchBoards(Model model, int page, String categoryName, String contentFilter, String keyword, String writeDayFilter,
                               BoardDTO boardDTO, BoardDTO boardTotalCNT) {

        // 기본값 설정
        int currentPage = 1;

        // 요청으로부터 페이지 번호 받아오기
        currentPage = page;

        // 사용자 입력 값(검색 키워드, 검색어, 카테고리, 검색기간)을 요청 객체에서 가져오기

        // 검색 키워드 및 기타 필수 입력 값 유효성 검사
        if (categoryName == null || categoryName.isEmpty()) {
            throw new RuntimeException("카테고리명 누락");
        }

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

        // 게시글 수 조회
        int totalRecords = boardService.selectOne(boardTotalCNT).getCnt();

        // 페이지네이션 설정
        PaginationUtils.setPagination(currentPage, PAGE_SIZE, totalRecords, boardDTO);

        // 전체 게시글 조회
        ArrayList<BoardDTO> searchResults = boardService.selectAll(boardDTO);

        // 총 페이지 수 계산
        int totalPages = PaginationUtils.calTotalPages(totalRecords, PAGE_SIZE);

        // JSP로 데이터 전달
        model.addAttribute("boardList", searchResults);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("boardCateName", categoryName);

        // 검색 조건을 유지하기 위한 필터 값 KS 전달 GET으로 전달할 것
        model.addAttribute("filter", contentFilter); // 검색 필터
        model.addAttribute("keyword", keyword); // 검색어
        model.addAttribute("writeDayFilter", contentFilter); // 작성일 필터

        // 카테고리 이름에 따라 다른 JSP 페이지로 포워딩
        String path = null; //기본 공개 게시판
        if (categoryName.equals("REQUEST")) { //문의 게시판이라면
            path = "noticeBoard"; // 문의게시판으로 포워딩
        }
        else if (categoryName.equals("NORMAL")) { //공개 게시판이라면
            path = "boardList"; // 공개게시판으로 포워딩
        }
        return path;
    }

    //게시글 수정 페이지로 이동
    @RequestMapping(value = "/checkBoard.do", method = RequestMethod.GET)
    public String checkBoard(HttpSession session, Model model, BoardDTO boardDTO) {

        boardDTO.setCondition("ONE_BOARD");
        boardDTO = boardService.selectOne(boardDTO);

        if (boardDTO.getMemberNum() != (int) session.getAttribute("memberPK")) {
            log.error("log: checkBoard - wrong member PK");
            return FAIL_DO;
        }
        //데이터
        model.addAttribute("board", boardDTO);
        //전달
        return "fixBoard";
    }

    //신규 게시글 페이지 이동
    @RequestMapping(value = "/newBoard.do", method = RequestMethod.GET)
    public String newBoard(Model model, String categoryName) {
        log.info("log: /newBoard.do newBoard - start");
        model.addAttribute("categoryName", categoryName);
        //확인
        log.info("log: newBoard - send categoryName : [{}]", categoryName);
        log.info("log: /newBoard.do newBoard - end : forward");
        return "boardWrite";
    }

    //자신이 작성한 게시글 목록 페이지
    @RequestMapping("/myBoardList.do")
    public String myBoardList(Model model, HttpSession session, BoardDTO boardTotalCNT, int page, BoardCateDTO boardCateDTO, BoardDTO boardDTO) {
        log.info("[INFO] MyBoardListPageAction 실행 시작");

        Integer memberPK;
        String nickName = null;
        HashMap<String, String> filterList = new HashMap<>();

        // 세션에서 값을
        memberPK = (Integer) session.getAttribute("memberPK");
        nickName = (String) session.getAttribute("memberNickName");

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
        //TODO 수정바람
        String profilePic = null;
        //String profilePic = ProfilePicUpload.loginProfilePic(request, response);
        model.addAttribute("memberProfileWay", profilePic);
        model.addAttribute("myBoardList", datas);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);

        // 페이지 이동 설정
        return "myBoardList";
    }

    //좋아요한 게시글 목록 페이지
    //KS 사용 안한 기능
    //@RequestMapping("/likeBoardList.do")
    public String likeBoardList(Model model, HttpSession session, Integer page, BoardDTO boardDTO) {
        log.info("[INFO] LikeBoardListPageAction 실행 시작");

        Integer memberPK;
        String nickName = null;
        try {
            // 1. 세션에서 사용자 정보 가져오기
//            HttpSession session = request.getSession();
//
//            // 로그인 여부를 확인하여 로그인되지 않았으면 null을 반환
//            if (!CheckLoginUtils.checkLogin(session, response, request)) {
//                log.info("[ERROR] 사용자 로그인 필요");
//                return null;
//            }

            // 세션에서 사용자 ID (memberPK) 가져오기
            memberPK = (Integer) session.getAttribute("memberPK");
            log.info("[INFO] 사용자 인증 성공, memberPK: " + memberPK);

            // 세션에서 닉네임 값 받아옴
            nickName = (String) session.getAttribute("memberNickName");
            log.info("[INFO] 세션에서 가져온 닉네임: " + nickName);

        } catch (Exception e) {
            log.error("[ERROR] 사용자 정보 처리 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException();
        }


        // 페이지 기본 설정
        int currentPage = 1; // 기본 현재 페이지
        int pageSize = 6; // 페이지당 게시글 수
        if (page != null) {
            currentPage = page;
            log.info("[INFO] 현재 페이지: " + currentPage);
        }


        // 2.내가 좋아요한 게시글을 조회하기 위한 BoardDTO 초기설정
        boardDTO.setCondition("MYFAVORITE_BOARD");
        boardDTO.setMemberNum(memberPK);


        // 게시글 목록 조회
        ArrayList<BoardDTO> datas = boardService.selectAll(boardDTO);
        log.info("[INFO] 게시글 목록 조회 완료: " + datas.size());


        // View에 전달할 데이터 설정
        String profilePic = null;
        //TODO 수정
        //String profilePic = ProfilePicUpload.loginProfilePic(request, response);
        model.addAttribute("memberProfileWay", profilePic);
        model.addAttribute("myLikeList", datas);
        model.addAttribute("currentPage", currentPage);

        log.info("[INFO] View에 데이터 전달 완료");

        // 페이지 이동 설정
        return "myBoardList";
    }

}
