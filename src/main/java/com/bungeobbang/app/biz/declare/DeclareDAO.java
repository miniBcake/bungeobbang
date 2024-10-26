package com.bungeobbang.app.biz.declare;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository
public class DeclareDAO{
	@Autowired
	private JdbcTemplate jdbcTemplate;
	// 신고 입력
	private final String INSERT = "INSERT INTO BB_DECLARE(STORE_NUM, MEMBER_NUM, DECLARE_CONTENT) VALUES(?,?,?)";
	// 신고 상태 변경
	private final String UPDATE = "UPDATE BB_DECLARE SET DECLARE_STATUS =? WHERE DECLARE_NUM = ?";
	// 해당 신고 삭제
	private final String DELETE = "DELETE FROM BB_DECLARE WHERE DECLARE_NUM = ? ";
	//해당 가게 번호의 신고 내역 모두 보기
	private final String SELECTALL = "SELECT DECLARE_NUM, STORE_NUM, MEMBER_NUM, DECLARE_CONTENT, DECLARE_DAY, DECLARE_STATUS"
			+ " FROM BB_DECLARE"
			+ "WHERE STORE_NUM = ?";
	// 신고 자세히 보기
	private final String SELECTONE = "SELECT DECLARE_NUM, STORE_NUM, MEMBER_NUM, DECLARE_CONTENT, DECLARE_DAY, DECLARE_STATUS"
			+ " FROM BB_DECLARE"
			+ "WHERE DECLARE_NUM = ?";

	public boolean insert(DeclareDTO declareDTO) {
		// 신고 입력
		int rs = jdbcTemplate.update(INSERT, 
				declareDTO.getStoreNum(),
				declareDTO.getDeclareContent()
				);
		if(rs<=0) {
			System.err.println("log: Declare insert fail");
		return false;
		}
		System.out.println("log: Declare insert success");
		return true;
	}
	private boolean update(DeclareDTO declareDTO) {
		int rs = jdbcTemplate.update(UPDATE,
				declareDTO.getDeclareNum());//번호 
		if(rs<=0) {
			System.err.println("log : Declare update fail");
			return false;
		}
		System.out.println("log : Decalre delete success");
		return true;
	}
	public boolean delete(DeclareDTO declareDTO) {
		// 해당 신고 삭제
		int result = jdbcTemplate.update(DELETE, declareDTO.getStoreNum());
		if(result<=0) {
			System.err.println("log: Declare delete fail");
		}
		System.out.println("log : Declare delete success");
		return false;
	}
	public List<DeclareDTO> selectAll(DeclareDTO declareDTO){
		// 해당 가게 번호의 신고 내역 모두 보기
		Object[] args = {declareDTO.getStoreNum()};
		return jdbcTemplate.query(SELECTALL, args, new DeclareRowMapper());
	}
	private DeclareDTO selectOne(DeclareDTO declareDTO) {
		// 신고 내역 자세히보기
		Object[] args = {declareDTO.getDeclareNum()};
		return jdbcTemplate.queryForObject(SELECTONE, args, new DeclareRowMapper());
	}
	
	class DeclareRowMapper implements RowMapper<DeclareDTO>{
		@Override
		public DeclareDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
			DeclareDTO data = new DeclareDTO();
			data.setDeclareNum(rs.getInt("DECLARE_NUM"));
			data.setStoreNum(rs.getInt("STORE_NUM"));
			data.setDeclareContent(rs.getString("DECLARE_CONTENT"));
			System.out.println("log: result exists : data ="+data);
			return data;
		}
		
	}
	
	
}
