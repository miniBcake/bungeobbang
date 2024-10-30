package com.bungeobbang.app.biz.order;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository
public class OrderDAO {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	//주문 내역 입력
	private final String INSERT = "INSERT INTO BB_ORDER(MEMBER_NUM, PRODUCT_NUM) VALUES(?,?)";

	private final String UPDATE = "UPDATE BB_ORDER SET ORDER_STATUS = ? WHERE ORDER_NUM =?";
	// 전체 내역
	private final String SELECTALL = "SELECT ORDER_NUM, MEMBER_NUM, PRODUCT_NUM, ORDER_STATUS FROM BB_ORDER ORDER BY ORDER_NUM DESC";
	// 처리 완료 내역
	private final String SELECTALL_STATUS = """
			SELECT
				ORDER_NUM,
				MEMBER_NUM,
				PRODUCT_NUM,
				ORDER_DAY,
				ORDER_STATUS
			FROM
				BB_ORDER
			WHERE 
				ORDER_STATUS= ? 
			ORDER BY 
				ORDER_NUM DESC
			""";

	public boolean insert(OrderDTO orderDTO) {
		// 주문 내역 입력
		int rs =  jdbcTemplate.update(INSERT, orderDTO.getMemberNum(), orderDTO.getProductNum());
		if(rs<=0) {
			System.err.println("log : Order insert fail");
			return false;
		}
		System.out.println("log : Order insert success");
		return true;
	}
	public boolean update(OrderDTO orderDTO) {
		// 주문 처리 업데이트
		int rs = jdbcTemplate.update(UPDATE, orderDTO.getOrderStatus(), orderDTO.getOrderNum());
		if(rs<=0) {
			System.err.println("log : Order update fail");
			return false;
		}
		System.out.println("log : Order update success");
		return true;
	}
	private boolean delete(OrderDTO orderDTO) {
		return false;
	}
	public List<OrderDTO> selectAll(OrderDTO orderDTO){
		// 처리로 주문 보기
		if(orderDTO.getCondition().equals("SELECTALL_STATUS")) {
			Object[] args = {orderDTO.getOrderStatus()};
			return jdbcTemplate.query(SELECTALL_STATUS, args , new OrderRowMapper());			
		}
		// 전체 주문 보기
		else if(orderDTO.getCondition().equals("SELECTALL")) {
			return jdbcTemplate.query(SELECTALL, new OrderRowMapper());
		}
		else {
			System.err.println("log : SELECTALL condition fail");
		}
		return null;
	}
	private OrderDTO selectOne(OrderDTO orderDTO) {
		return null;
	}

	class OrderRowMapper implements RowMapper<OrderDTO>{

		@Override
		public OrderDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
			OrderDTO data = new OrderDTO();
			data.setOrderNum(rs.getInt("ORDER_NUM"));
			data.setMemberNum(rs.getInt("MEMBER_NUM"));
			data.setProductNum(rs.getInt("PRODUCT_NUM"));
			data.setOrderStatus(rs.getString("ORDER_STATUS"));
			return data;
		}


	}

}
