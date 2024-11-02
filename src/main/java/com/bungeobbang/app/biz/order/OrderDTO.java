package com.bungeobbang.app.biz.order;

import lombok.Data;

@Data
public class OrderDTO {
	private int orderNum; //주문 번호
	
	private int memberNum; //회원 번호
	private int productNum; //상품 번호
	private String orderStatus; //처리 상태
	private String orderDay;
	
	private String condition; 
}
