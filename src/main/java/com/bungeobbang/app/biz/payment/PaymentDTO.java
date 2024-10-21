package com.fproject.app.biz.payment;

import java.util.HashMap;

public class PaymentDTO {
	private int paymentNum; //PK
	private int memberNum; // 회원 번호(외래키)
	private int pointNum; //포이트 번호(외래키)
	private int paymentAmount; // 결제 금액
	private String paymentStatus; // 결제 상태(wait, complete)
	private String paymentDay; // 결제 일시
	private String paymentUsed; // 결제 방식
	
	private String adminChecked; //관리자 확인
	
	//개발용
	private String condition;
	private HashMap<String, String> filterList; //필터(키 값, 사용자 입력값)
	private int startNum;
	private int endNum;
	
	public int getPaymentNum() {
		return paymentNum;
	}
	public void setPaymentNum(int paymentNum) {
		this.paymentNum = paymentNum;
	}
	public int getMemberNum() {
		return memberNum;
	}
	public void setMemberNum(int memberNum) {
		this.memberNum = memberNum;
	}
	public int getPointNum() {
		return pointNum;
	}
	public void setPointNum(int pointNum) {
		this.pointNum = pointNum;
	}
	public String getPaymentStatus() {
		return paymentStatus;
	}
	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}
	public int getPaymentAmount() {
		return paymentAmount;
	}
	public void setPaymentAmount(int paymentAmount) {
		this.paymentAmount = paymentAmount;
	}
	public String getPaymentDay() {
		return paymentDay;
	}
	public void setPaymentDay(String paymentDay) {
		this.paymentDay = paymentDay;
	}
	public String getPaymentUsed() {
		return paymentUsed;
	}
	public void setPaymentUsed(String paymentUsed) {
		this.paymentUsed = paymentUsed;
	}
	public String getAdminChecked() {
		return adminChecked;
	}
	public void setAdminChecked(String adminChecked) {
		this.adminChecked = adminChecked;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public HashMap<String, String> getFilterList() {
		return filterList;
	}
	public void setFilterList(HashMap<String, String> filterList) {
		this.filterList = filterList;
	}
	public int getStartNum() {
		return startNum;
	}
	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}
	public int getEndNum() {
		return endNum;
	}
	public void setEndNum(int endNum) {
		this.endNum = endNum;
	}
	@Override
	public String toString() {
		return "PaymentDTO [paymentNum=" + paymentNum + ", memberNum=" + memberNum + ", pointNum=" + pointNum
				+ ", paymentAmount=" + paymentAmount + ", paymentStatus=" + paymentStatus + ", paymentDay=" + paymentDay
				+ ", paymentUsed=" + paymentUsed + ", adminChecked=" + adminChecked + ", condition=" + condition
				+ ", filterList=" + filterList + "]";
	}
		
}
