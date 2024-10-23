package com.bungeobbang.app.biz.point;

public class PointDTO {
	private int pointNum; //PK
	private int memberNum; //회원번호 FK
	private int pointPlus; // 포인트 증가
	private int pointMinus; // 포인트 감소
	private String pointContent; //포인트 내용

	//개발용
	private String condition; 
	private int totalMemberPoint; // 회원 포인트 반환용

	public int getPointNum() {
		return pointNum;
	}
	public void setPointNum(int pointNum) {
		this.pointNum = pointNum;
	}
	public int getMemberNum() {
		return memberNum;
	}
	public void setMemberNum(int memberNum) {
		this.memberNum = memberNum;
	}
	public int getPointPlus() {
		return pointPlus;
	}
	public void setPointPlus(int pointPlus) {
		this.pointPlus = pointPlus;
	}
	public int getPointMinus() {
		return pointMinus;
	}
	public void setPointMinus(int pointMinus) {
		this.pointMinus = pointMinus;
	}
	public String getPointContent() {
		return pointContent;
	}
	public void setPointContent(String pointContent) {
		this.pointContent = pointContent;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}


	public int getTotalMemberPoint() {
		return totalMemberPoint;
	}
	public void setTotalMemberPoint(int totalMemberPoint) {
		this.totalMemberPoint = totalMemberPoint;
	}
	@Override
	public String toString() {
		return "PointDTO [pointNum=" + pointNum + ", memberNum=" + memberNum + ", pointPlus=" + pointPlus
				+ ", pointMinus=" + pointMinus + ", pointContent=" + pointContent + ", condition=" + condition + "]";
	}
}
