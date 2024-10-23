package com.bungeobbang.app.biz.declare;

public class DeclareDTO {
	private int declareNum; //신고 번호
	private int storeNum; // 가게 번호
	private String declareReason;

	
	
	public int getStoreNum() {
		return storeNum;
	}
	public void setStoreNum(int storeNum) {
		this.storeNum = storeNum;
	}

	public String getDeclareReason() {
		return declareReason;
	}
	public void setDeclareReason(String declareReason) {
		this.declareReason = declareReason;
	}
	public int getDeclareNum() {
		return declareNum;
	}
	public void setDeclareNum(int declareNum) {
		this.declareNum = declareNum;
	}
	
	@Override
	public String toString() {
		return "DeclareDTO [declareNum=" + declareNum + ", storeNum=" + storeNum + ", declareReason=" + declareReason
				+ "]";
	}
}
