package com.bungeobbang.app.biz.order;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OrderDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	public boolean insert(OrderDTO orderDTO) {
		// 주문 내역 입력
		int rs = mybatis.insert("OrderDAO.insert",orderDTO);
		System.out.println("log : orderDTO pk = "+orderDTO.getOrderNum());
		return rs>0;
	}
	public boolean update(OrderDTO orderDTO) {
		// 주문 처리 업데이트
		int rs = mybatis.update("OrderDAO.update",orderDTO);
		return rs>0;
	}
	private boolean delete(OrderDTO orderDTO) {
		return false;
	}
	public List<OrderDTO> selectAll(OrderDTO orderDTO){
		// 처리로 주문 보기
		List<OrderDTO> datas;
//		if(orderDTO.getCondition().equals("SELECTALL_MEMBER") && orderDTO.getCondition()!=null) {
//			datas = mybatis.selectList("OrderDAO.selectAll_member",orderDTO);
//		}
//		else {
			datas = mybatis.selectList("OrderDAO.selectAll", orderDTO);						
//		}

		for (OrderDTO order : datas) {
			System.out.println("data: " + order);
		}
		System.out.println("log : OrderDAO selectAll success");
		return datas;
	}
	private OrderDTO selectOne(OrderDTO orderDTO) {
		return null;
	}
}
