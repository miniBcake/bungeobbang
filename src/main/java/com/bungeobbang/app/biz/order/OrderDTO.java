package com.bungeobbang.app.biz.order;

public class OrderDTO {
	private int orderNum; //주문 번호
	private int memberNum; //회원 번호
	private int productNum; //상품 번호
	private String orderStatus; //처리 상태
	
	// 개발용
	private String condition;
	
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public int getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}
	public int getMemberNum() {
		return memberNum;
	}
	public void setMemberNum(int memberNum) {
		this.memberNum = memberNum;
	}
	public int getProductNum() {
		return productNum;
	}
	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	@Override
	public String toString() {
		return "OrderDTO [orderNum=" + orderNum + ", memberNum=" + memberNum + ", productNum=" + productNum
				+ ", orderStatus=" + orderStatus + "]";
	}
	
}
