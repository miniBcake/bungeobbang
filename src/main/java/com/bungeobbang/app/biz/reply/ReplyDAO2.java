package com.bungeobbang.app.biz.reply;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDAO2 {
	private final String INSERT = "INSERT INTO BB_REPLY(REPLY_CONTENT, MEMBER_NUM, BOARD_NUM) VALUES(?, ?, ?);";
	private final String UPDATE = "UPDATE BB_REPLY SET REPLY_CONTENT = ? WHERE REPLY_NUM = ?";
	private final String DELETE = "DELETE FROM BB_REPLY WHERE REPLY_NUM = ?";

	private final String SELECTALL_BOARD = "SELECT RN, REPLY_NUM, REPLY_CONTENT, MEMBER_NUM, MEMBER_NICKNAME, MEMBER_PROFILE_WAY, REPLY_WRITE_DAY "
			+ "FROM (SELECT ROW_NUMBER() OVER(ORDER BY REPLY_WRITE_DAY DESC) AS RN,"
			+ "br.REPLY_NUM, br.REPLY_CONTENT, br.MEMBER_NUM, bm.MEMBER_NICKNAME, bm.MEMBER_PROFILE_WAY, br.REPLY_WRITE_DAY "
			+ "FROM BB_REPLY br " + "JOIN BB_MEMBER bm ON br.MEMBER_NUM = bm.MEMBER_NUM " + "WHERE br.BOARD_NUM = ?"
			+ "ORDER BY br.REPLY_WRITE_DAY DESC) AS REPLY_ALL_TABLE WHERE RN LIMIT ?, ?";

	private final String SELECTALL_MYPAGE = "SELECT RN, REPLY_NUM, REPLY_CONTENT, MEMBER_NICKNAME, MEMBER_PROFILE_WAY, BOARD_NUM, REPLY_WRITE_DAY FROM (SELECT ROW_NUMBER() OVER(ORDER BY REPLY_WRITE_DAY DESC) AS RN, "
			+ " br.REPLY_NUM, br.REPLY_CONTENT, br.BOARD_NUM, bm.MEMBER_NICKNAME, bm.MEMBER_PROFILE_WAY ,br.REPLY_WRITE_DAY FROM BB_REPLY br  JOIN BB_MEMBER bm ON br.MEMBER_NUM = bm.MEMBER_NUM "
			+ "	WHERE br.MEMBER_NUM = ? ORDER BY br.REPLY_WRITE_DAY DESC) AS MY_REPLY_TABLE WHERE RN LIMIT ?, ?";

	private final String SELECTONE = "SELECT br.REPLY_NUM, br.REPLY_CONTENT, br.MEMBER_NUM, bm.MEMBER_NICKNAME, bm.MEMBER_PROFILE_WAY ,br.REPLY_WRITE_DAY FROM BB_REPLY br JOIN BB_MEMBER bm ON br.MEMBER_NUM = bm.MEMBER_NUM "
			+ " WHERE br.REPLY_NUM = ?";
	private final String SELECTONE_BOARD = "SELECT COUNT(*) AS CNT FROM BB_REPLY WHERE BOARD_NUM = ?";
	private final String SELECTONE_MYPAGE = "SELECT COUNT(*) AS CNT FROM BB_REPLY WHERE MEMBER_NUM = ?";

	// 미리 생성한 Spring의 JdbcTemplate을 가져옴
	@Autowired
	private JdbcTemplate jdbcTemplate;

	public boolean insert(ReplyDTO replyDTO) {
		System.out.println("log: Reply insert start");

		// insert 실행 및 결과를 가져옴
		// 내용, 작성자Num 값을 넣어줌
		int result = jdbcTemplate.update(INSERT, replyDTO.getReplyContent(), replyDTO.getMemberNum(),
				replyDTO.getBoardNum());
		if (result <= 0) {
			System.out.println("log: Reply insert false");
			return false;
		}
		System.out.println("log: Reply insert true");
		return true;
	}

	public boolean update(ReplyDTO replyDTO) {
		System.out.println("log: Reply update start");

		// update 실행 및 결과를 가져옴
		// 내용, 댓글Num 값을 넣어줌
		int result = jdbcTemplate.update(UPDATE, replyDTO.getReplyContent(), replyDTO.getReplyNum());
		if (result <= 0) {
			System.out.println("log: Reply update false");
			return false;
		}
		System.out.println("log: Reply update true");
		return true;
	}

	public boolean delete(ReplyDTO replyDTO) {
		System.out.println("log: Reply delete start");

		// delete 실행 및 결과를 가져옴
		// 댓글Num 값을 넣어줌
		int result = jdbcTemplate.update(DELETE, replyDTO.getReplyNum());
		if (result <= 0) {
			System.out.println("log: Reply delete false");
			return false;
		}
		System.out.println("log: Reply delete true");
		return true;
	}

	public List<ReplyDTO> selectAll(ReplyDTO replyDTO) {
		System.out.println("log: Reply selectAll start");
		ArrayList<ReplyDTO> datas = new ArrayList<ReplyDTO>();

		try {
			if (replyDTO.getCondition().equals("ALL_REPLIES")) {
				// 게시물 댓글 조회
				System.out.println("log: Reply selectAll : ALL_REPLIES");

				// 쿼리문에 넣을 값 : 게시글Num, 시작 번호, 끝 번호
				Object[] args = { replyDTO.getBoardNum(), replyDTO.getStartNum(), replyDTO.getEndNum() };

				return jdbcTemplate.query(SELECTALL_BOARD, args, new ReplyRowMapperAll());
			} else if (replyDTO.getCondition().equals("MY_REPLIES")) {
				// 내가 쓴 댓글 모아보기 (마이페이지)
				System.out.println("log: Reply selectAll : MY_REPLIES");

				// 쿼리문에 넣을 값 : 회원Num, 시작 번호, 끝 번호
				Object[] args = { replyDTO.getMemberNum(), replyDTO.getStartNum(), replyDTO.getEndNum() };

				return jdbcTemplate.query(SELECTALL_MYPAGE, args, new ReplyRowMapperAll());
			} else {
				// 컨디션값 오류
				System.err.println("log: Reply selectAll condition fail");
			}
			System.out.println("end");
		} catch (Exception e) {
			System.err.println("log: Reply selectAll Exception fail");
			datas.clear();// 잔여데이터 삭제
		}
		
		System.out.println("log: Reply selectAll return datas");
		return datas;
	}

	public ReplyDTO selectOne(ReplyDTO replyDTO) {
		System.out.println("log: Reply selectOne start");

		try {
			if (replyDTO.getCondition().equals("CNT_BOARD_RP")) {
				// 게시물 댓글 조회
				System.out.println("log: Reply selectOne : CNT_BOARD_RP");
				
				// 쿼리문에 넣을 값 : 게시글Num
				Object[] args = { replyDTO.getBoardNum() };
				return jdbcTemplate.queryForObject(SELECTONE_BOARD, args, new ReplyRowMapperCNT());
			} else if (replyDTO.getCondition().equals("CNT_MY_RP")) {
				// 내가 쓴 댓글 모아보기 (마이페이지)
				System.out.println("log: Reply selectOne : CNT_MY_RP");
				
				// 쿼리문에 넣을 값 : 회원Num
				Object[] args = { replyDTO.getMemberNum() };
				return jdbcTemplate.queryForObject(SELECTONE_MYPAGE, args, new ReplyRowMapperCNT());
			} else if (replyDTO.getCondition().equals("REPLY_ONE")) {
				// 댓글 하나 조회
				System.out.println("log: Reply selectOne : REPLY_ONE");
				
				// 쿼리문에 넣을 값 : 댓글Num
				Object[] args = { replyDTO.getReplyNum() };
				return jdbcTemplate.queryForObject(SELECTONE, args, new ReplyRowMapperAll());
			} else {
				// 컨디션값 오류
				System.err.println("log: Reply selectOne condition fail");
			}
			System.out.println("end");
		} catch (Exception e) {
			System.err.println("log: Reply selectOne Exception fail");
			return null;
		}
			System.out.println("log: Reply selectAll end");
		System.out.println("log: Reply selectAll return datas");
		return null;
	}
}

// 전체 데이터를 가져오는 class
class ReplyRowMapperAll implements RowMapper<ReplyDTO> {

	@Override
	public ReplyDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
		ReplyDTO data = new ReplyDTO();
		data.setReplyNum(rs.getInt("REPLY_NUM")); // 댓글 번호
		data.setReplyContent(rs.getString("REPLY_CONTENT")); // 댓글 내용
		data.setMemberNickname(rs.getString("MEMBER_NICKNAME")); // 작성자 닉네임
		data.setMemberProfileWay(rs.getString("MEMBER_PROFILE_WAY")); // 작성자 프로필
		data.setBoardNum(rs.getInt("BOARD_NUM")); // 게시글 번호
		data.setReplyWriteDay(rs.getString("REPLY_WRITE_DAY")); // 작성일시
		return data;
	}
}

// 갯수를 가져오는 class
class ReplyRowMapperCNT implements RowMapper<ReplyDTO> {
	
	@Override
	public ReplyDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
		ReplyDTO data = new ReplyDTO();
		data.setCnt(rs.getInt("CNT")); // 댓글 개수
		return data;
	}
}
