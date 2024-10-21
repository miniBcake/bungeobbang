package com.fproject.app.biz.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.fproject.app.biz.common.JDBCUtil;
import com.fproject.app.biz.filter.BoardFilter;

@Repository
public class BoardDAO {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	//INSERT 쿼리들
	// 게시글 작성
	private final String INSERT = "INSERT INTO BB_BOARD(BOARD_TITLE, BOARD_CONTENT, BOARD_FOLDER, BOARD_OPEN, CATEGORY_NUM, MEMBER_NUM) "
			+ "VALUES(?,?,?,?,?,?)";
	// 상품 게시글 작성
	private final String INSERT_PRODUCT="INSERT INTO BB_BOARD(BOARD_TITLE, BOARD_CONTENT, BOARD_FOLDER, CATEGORY_NUM) "
			+ "VALUES(?,?,?,?)";
	private final String INSERT_STORE = "INSERT INTO BB_BOARD(BOARD_TITLE, BOARD_CONTENT, STORE_NUM, BOARD_FOLDER) "
			+ "VALUES(?,?,?,?)";

	// UPDATE 쿼리들
	private final String UPDATE = "UPDATE BB_BOARD SET BOARD_TITLE = ?, BOARD_CONTENT = ?, BOARD_OPEN = ? WHERE BOARD_NUM = ?";
	private final String UPDATE_DEL = "UPDATE BB_BOARD SET BOARD_DELETE = 'Y' WHERE BOARD_NUM = ?";

	// DELETE 쿼리
	private final String DELETE = "DELETE FROM BB_BOARD WHERE BOARD_NUM = ?";

	// SELECTALL 쿼리
	private final String SELECTALL = "SELECT @rownum := @rownum + 1 AS RN, BOARD_NUM, BOARD_TITLE, BOARD_CONTENT, BOARD_OPEN, BOARD_DELETE," 
			+"CATEGORY_NUM, CATEGORY_NAME, MEMBER_NUM, MEMBER_NICKNAME, LIKE_CNT, BOARD_WRITE_DAY"
			+"FROM BB_VIEW_BOARD_JOIN, (SELECT @rownum := 0) AS r"
			+"WHERE CATEGORY_NAME = '?'";

	private final String SELECTALL_ENDPART = "ORDER BY BOARD_WRITE_DAY DESC"
			+"LIMIT ?, ?";

	// SELECTALL_HOT 쿼리
	private final String SELECTALL_HOT = "SELECT BOARD_NUM, BOARD_TITLE, BOARD_CONTENT, BOARD_OPEN, BOARD_DELETE, CATEGORY_NUM, CATEGORY_NAME, "
			+ "MEMBER_NUM, MEMBER_NICKNAME, LIKE_CNT, BOARD_WRITE_DAY FROM BB_VIEW_BOARD_JOIN "
			+ "WHERE CATEGORY_NAME = ? AND LIKE_CNT > ? ORDER BY LIKE_CNT DESC LIMIT ?";

	// SELECTALL_MYPAGE 쿼리
	private final String SELECTALL_MYPAGE = "SELECT @rownum := @rownum+1 AS RN, BOARD_NUM, BOARD_TITLE, BOARD_CONTENT, BOARD_OPEN, BOARD_DELETE, "
			+ "CATEGORY_NUM, CATEGORY_NAME, MEMBER_NUM, MEMBER_NICKNAME, LIKE_CNT, BOARD_WRITE_DAY "
			+ "FROM BB_VIEW_BOARD_JOIN, (SELECT @rownum := 0) AS r WHERE MEMBER_NUM = ? "
			+ "ORDER BY BOARD_WRITE_DAY DESC LIMIT ?, ?";

	// SELECTALL_LIKE 쿼리
	private final String SELECTALL_LIKE = "SELECT @rownum := @rownum+1 AS RN, BOARD_NUM, BOARD_TITLE, BOARD_CONTENT, BOARD_OPEN, BOARD_DELETE, "
			+ "CATEGORY_NUM, CATEGORY_NAME, MEMBER_NUM, MEMBER_NICKNAME, LIKE_CNT, BOARD_WRITE_DAY "
			+ "FROM BB_VIEW_BOARD_JOIN, (SELECT @rownum := 0) AS r WHERE BOARD_NUM IN (SELECT BOARD_NUM FROM BB_LIKE WHERE MEMBER_NUM = ?) "
			+ "ORDER BY BOARD_WRITE_DAY DESC LIMIT ?, ?";

	// SELECTONE 쿼리
	private final String SELECTONE = "SELECT BOARD_NUM, BOARD_TITLE, BOARD_CONTENT, BOARD_OPEN, BOARD_DELETE, CATEGORY_NUM, CATEGORY_NAME, "
			+ "MEMBER_NUM, MEMBER_NICKNAME, LIKE_CNT, BOARD_WRITE_DAY, BOARD_FOLDER FROM BB_VIEW_BOARD_JOIN WHERE BOARD_NUM = ?";

	// SELECTONE_SEARCH 쿼리
	private final String SELECTONE_SEARCH = "SELECT COUNT(*) AS CNT FROM BB_BOARD bb JOIN BB_MEMBER bm ON bb.MEMBER_NUM = bm.MEMBER_NUM "
			+ "WHERE CATEGORY_NUM = (SELECT CATEGORY_NUM FROM BB_BOARD_CATEGORY WHERE CATEGORY_NAME = ?)";

	// SELECTONE_MAXPK 쿼리
	private final String SELECTONE_MAXPK = "SELECT IFNULL(MAX(BOARD_NUM), 0) AS MAXPK FROM BB_BOARD";

	private final String SELECTONE_FOLDER = "SELECT BOARD_NUM, BOARD_FOLDER FROM BB_BOARD WHERE BOARD_NUM=?";


	//고정 설정
	private final int MINLIKE = 5;		//인기글 최소 기준
	private final int SHOWHOTBOARD = 3;	//보여줄 인기글 개수
	private final int PRODUCT = 3; // 상품 카테고리 번호


	public boolean insert(BoardDTO boardDTO) {
		System.out.println("log: Board insert start");
		//결과를 담을 변수
		int rs=0;
		String query ="";
		Object[] args = null;
		if(boardDTO.getCondition().equals("BOARD_INSERT")) {
			//새 게시글 작성
			System.out.println("log : Board insert : BOARD_INSERT");
			args = new Object[]{
					boardDTO.getBoardTitle(),
					boardDTO.getBoardContent(),
					boardDTO.getBoardFolder(),
					boardDTO.getBoardOpen(),
					boardDTO.getBoardCateNum(),
					boardDTO.getMemberNum()
			};
			query = INSERT;
			rs = jdbcTemplate.update(query, args);
		}
		else if(boardDTO.getCondition().equals("PRODUCT_INSERT")) {
			//상품설명용 게시글 작성
			System.out.println("log: Board insert : PRODUCT_INSERT");
			args= new Object[]{
					boardDTO.getBoardTitle(),
					boardDTO.getBoardContent(),
					boardDTO.getBoardFolder(),
					PRODUCT //상품 카테고리 번호
			};
			query=INSERT_PRODUCT;
			rs=jdbcTemplate.update(query,args);
		}
		else if(boardDTO.getCondition().equals("MARKET_INSERT")) {
			// 가게 게시글 등록
			System.out.println("log : Board insert : MARKET_INSERT");
			args = new Object[]{
					boardDTO.getBoardTitle(),
					boardDTO.getBoardContent(),
					boardDTO.getStoreNum(),
					boardDTO.getBoardFolder()
			};
			query = INSERT_STORE;
		}
		else {
			//컨디션값 오류
			System.err.println("log: Board insert condition fail");
		}
		// 쿼리 실행

		try {
			rs = jdbcTemplate.update(query, args);
		}catch (Exception e) {
			System.err.println("log: Board insert Exception fail :"+ e.getMessage());
			return false;
		}

		if(rs <=0) {
			System.err.println("log: Board insert fail");
			return false;
		}
		System.out.println("log: Board insert success");
		return true;
	}
	public boolean update(BoardDTO boardDTO) {
		System.out.println("log: Board update start");
		Object args = null;
		String query = "";
		int rs=0;
		if(boardDTO.getCondition().equals("BOARD_UPDATE")) {
			//게시글 수정
			System.out.println("log: Board update : BOARD_UPDATE");
			args = new Object[] {
					boardDTO.getBoardTitle(),
					boardDTO.getBoardContent(),
					boardDTO.getBoardOpen(),
					boardDTO.getBoardNum()
			};
			query = UPDATE;
		}
		else if(boardDTO.getCondition().equals("ADMIN_DELETE")) {
			//관리자 삭제
			System.out.println("log: Board update : ADMIN_DELETE");
			args = new Object[] {
					boardDTO.getBoardNum()
			};
			query = UPDATE_DEL;
		}
		else {
			System.err.println("log: Board update condition fail");
		}
		try {
			rs = jdbcTemplate.update(query, args);
		}catch (Exception e) {
			System.err.println("log: Board update Exception fail :"+ e.getMessage());
			return false;
		}

		if(rs <=0) {
			System.err.println("log: Board update fail");
			return false;
		}
		System.out.println("log: Board update success");
		return true;
	}
	public boolean delete(BoardDTO boardDTO) {
		System.out.println("log: Board delete start");
		int rs = 0;
		Object[] args = null;
		String query = "";
		args = new Object[] {
				boardDTO.getBoardNum()
		};
		query = DELETE;
		try {
			rs = jdbcTemplate.update(query, args);
		}catch (Exception e) {
			System.err.println("log: Board update Exception fail :"+ e.getMessage());
			return false;
		}

		if(rs <=0) {
			System.err.println("log: Board update fail");
			return false;
		}
		System.out.println("log: Board update success");
		return true;
	}
	public List<BoardDTO> selectAll(BoardDTO boardDTO){
		List<BoardDTO> datas = new ArrayList<BoardDTO>();
		Object[] args=null; // 입력값 배열
		String query = ""; //쿼리문 초기화
		if(boardDTO.getCondition().equals("FILTER_BOARD")) {
			Connection conn = JDBCUtil.connect();
			PreparedStatement pstmt = null;
			//게시물 리스트 (+필터검색)
			System.out.println("log: Board selectAll : FILTER_BOARD");
			HashMap<String, String> filters = boardDTO.getFilterList();//넘어온 MAP filter키워드
			BoardFilter filterUtil = new BoardFilter();
			try{
				//메서드를 통해 쿼리문을 완성한 후 toString을 통해 다시 String으로 변환
				pstmt = conn.prepareStatement(filterUtil.buildFilterQuery(SELECTALL,filters).append(" "+SELECTALL_ENDPART).toString());
				int placeholderNum = 1; //필터검색 선택한 것만 검색어를 넣기 위한 카운트
				pstmt.setString(placeholderNum++, boardDTO.getBoardCateName()); 	//카테고리 명
				placeholderNum = filterUtil.setFilterKeywords(pstmt,filters,placeholderNum); 		//필터 검색 검색어 
				if(placeholderNum < 0) {
					//만약 filterKeywordSetter 메서드에서 오류가 발생했다면 SQL예외처리
					throw new SQLException();
				}
				pstmt.setInt(placeholderNum++, boardDTO.getStartNum());			//페이지네이션 용 시작번호
				pstmt.setInt(placeholderNum++, boardDTO.getEndNum());				//페이지네이션 용 끝번호
				//넘어온 값 확인 로그
				System.out.println("log: parameter getBoardCateName : "+boardDTO.getBoardCateName());
				System.out.println("log: parameter getStartNum : "+boardDTO.getStartNum());
				System.out.println("log: parameter getEndNum : "+boardDTO.getEndNum());
			}
			catch (SQLException e) {
				System.err.println("log: Board selectAll SQLException fail");
				datas.clear();//잔여데이터 삭제
			} catch (Exception e) {
				System.err.println("log: Board selectAll Exception fail");
				datas.clear();//잔여데이터 삭제
			} finally {
				//연결해제
				if(!JDBCUtil.disconnect(conn, pstmt)) {
					//연결해제 실패
					System.err.println("log: Board selectAll disconnect fail");
					datas.clear();//잔여데이터 삭제
				}
				System.out.println("log: Board selectAll end");
			}
			return datas;
		}
		else if(boardDTO.getCondition().equals("HOT_BOARD")) {
			//게시판 별 인기글
			System.out.println("log: Board selectAll : HOT_BOARD");
			args=new Object[] {
					boardDTO.getBoardCateName(),
					MINLIKE,
					SHOWHOTBOARD
			};
			query = SELECTALL_HOT;
		}
		else if(boardDTO.getCondition().equals("MY_BOARD")) {
			//내 게시글 모아보기
			System.out.println("log: Board selectAll : MY_BOARD");
			args = new Object[] {
					boardDTO.getMemberNum(),
					boardDTO.getStartNum(),
					boardDTO.getEndNum()
			};
			query = SELECTALL_MYPAGE;
		}
		else {
			//컨디션값 오류
			System.err.println("log: Board selectAll condition fail");
		}
		datas = jdbcTemplate.query(query, args, new BoardRowMapper());
		System.out.println("log: Board selectAll return datas");
		return datas;
	}
	public BoardDTO selectOne(BoardDTO boardDTO) {
		System.out.println("log: Board selectOne start");
		Object[] args = null;
		String query="";

		if(boardDTO.getCondition().equals("ONE_BOARD")) {			
			//게시물 상세보기
			query = SELECTONE;
			args = new Object[]{
					boardDTO.getBoardNum()
			};
		}
		else if(boardDTO.getCondition().equals("CNT_BOARD")) {
			//게시판 별 글 개수(+필터검색)
			System.out.println("log: Board selectOne : CNT_BOARD");
			//필터검색 추가
			PreparedStatement pstmt = null;
			Connection conn = JDBCUtil.connect();
			BoardDTO data = new BoardDTO();
			try {
				HashMap<String, String> filters = boardDTO.getFilterList();//넘어온 MAP filter키워드
				BoardFilter filterUtil = new BoardFilter();
				pstmt = conn.prepareStatement(filterUtil.buildFilterQuery(SELECTONE_SEARCH,filters).toString());
				int placeholderNum = 1; //필터검색 선택한 것만 검색어를 넣기 위한 카운트
				pstmt.setString(placeholderNum++, boardDTO.getBoardCateName()); 	//카테고리 명
				//넘어온 값 확인 로그
				System.out.println("log: parameter getBoardCateName : "+boardDTO.getBoardCateName());
				placeholderNum = filterUtil.setFilterKeywords(pstmt,filters,placeholderNum); 		//필터 검색 검색어 
				if(placeholderNum < 0) {
					//만약 filterKeywordSetter 메서드에서 오류가 발생했다면 SQL예외처리
					throw new SQLException();
				}
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) { 
					data = new BoardDTO();
					data.setCnt(rs.getInt("CNT")); //게시글 개수
					System.out.println("result exists");
				}
				rs.close();
			}catch (SQLException e) {
				System.err.println("log: Board selectOne SQLException failasdfaf");
				return null;
			} catch (Exception e) {
				System.err.println("log: Board selectOne Exception fail");
				return null;
			} finally {
				//연결해제
				if(!JDBCUtil.disconnect(conn, pstmt)) {
					//연결해제 실패
					System.err.println("log: Board selectOne disconnect fail");
					return null;
				}
				System.out.println("log: Board selectAll end");
			}
			System.out.println("log: Board selectAll return datas");
			return data;
		}
		else if(boardDTO.getCondition().equals("MAXPK_BOARD")) {
			//가장 최근 PK
			System.out.println("log: Board selectOne : MAXPK_BOARD");
			query = SELECTONE_MAXPK;
			return jdbcTemplate.queryForObject(query, new MaxRowMapper());			
		}
		else if(boardDTO.getCondition().equals("FOLDER_BOARD")) {
			//게시판 번호로 폴더 검색
			System.out.println("log: Board selectOne : FOLDER_BOARD");
			query = SELECTONE_FOLDER;
			args = new Object[] {
					boardDTO.getBoardNum()
			};
			return jdbcTemplate.queryForObject(query, args, new FolderRowMaaper());
		}
		else {
			//컨디션값 오류
			System.err.println("log: Board selectOne condition fail");
		}
		return jdbcTemplate.queryForObject(query, args, new BoardRowMapper());
	}

	// 회원 조회 selectAll RowMapper
	class BoardRowMapper implements RowMapper<BoardDTO>{

		@Override
		public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
			BoardDTO data = new BoardDTO();
			data.setBoardNum(rs.getInt("BOARD_NUM")); 				//게시글 번호
			data.setBoardTitle(rs.getString("BOARD_TITLE")); 		//제목
			data.setBoardContent(rs.getString("BOARD_CONTENT")); 	//내용
			data.setBoardOpen(rs.getString("BOARD_OPEN")); 			//공개여부
			data.setBoardCateNum(rs.getInt("CATEGORY_NUM")); 		//카테고리 번호
			data.setBoardCateName(rs.getString("CATEGORY_NAME")); 	//카테고리 명
			data.setMemberNum(rs.getInt("MEMBER_NUM")); 			//멤버 PK
			data.setMemberNickname(rs.getString("MEMBER_NICKNAME")); //멤버 닉네임
			data.setLikeCnt(rs.getInt("LIKE_CNT")); 				//좋아요 수
			data.setBoardWriteDay(rs.getString("BOARD_WRITE_DAY")); //작성일자
			data.setBoardDelete(rs.getString("BOARD_DELETE")); 		//관리자 글 삭제여부				

			System.out.print(" | result "+data.getBoardNum());
			return data;
		}

	}
	class MaxRowMapper implements RowMapper<BoardDTO>{
		
		@Override
		public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
			BoardDTO data = new BoardDTO();
			data.setMaxPk(rs.getInt("MAXPK"));
			return data;
		}		
	}
	class FolderRowMaaper implements RowMapper<BoardDTO>{

		@Override
		public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
			BoardDTO data = new BoardDTO();
			data.setBoardNum(rs.getInt("BOARD_NUM"));
			data.setBoardFolder(rs.getString("BOARD_FOLDER"));
			System.out.println("log : result exists");
			return data;
		}
		
	}
}
