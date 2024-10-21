package com.fproject.app.biz.store;

import java.util.HashMap;

public class StoreDTO {
	private int storeNum; // 가게 고유번호(PK)	
	private String storeName; // 가게 상호명
	private String storeDefaultAddress; // 가게 기본주소
	private String storeDetailAddress; // 가게 상세주소
	private String storePhoneNum; // 가게 전화번호
	private String storeClosed; // 폐점여부(Y/N)
	private String storeDeclared; // 가게 비공개
	private String condition; // 상태여부
	
	// 폐점한 가게 수
	private int storeClosedCnt;
	
	//필터 검색을 위한 DTO
	private HashMap<String, String> filterList; //필터검색용 <검색구분용, 검색값>

	private int startNum; // 시작 페이지
	private int endNum; // 종료 페이지
	private int cnt; //페이지 네이션 개수 반환용
	
	public int getStoreNum() {
		return storeNum;
	}
	public void setStoreNum(int storeNum) {
		this.storeNum = storeNum;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public String getStoreDefaultAddress() {
		return storeDefaultAddress;
	}
	public void setStoreDefaultAddress(String storeDefaultAddress) {
		this.storeDefaultAddress = storeDefaultAddress;
	}
	public String getStoreDetailAddress() {
		return storeDetailAddress;
	}
	public void setStoreDetailAddress(String storeDetailAddress) {
		this.storeDetailAddress = storeDetailAddress;
	}
	public String getStorePhoneNum() {
		return storePhoneNum;
	}
	public void setStorePhoneNum(String storePhoneNum) {
		this.storePhoneNum = storePhoneNum;
	}
	public String getStoreClosed() {
		return storeClosed;
	}
	public void setStoreClosed(String storeClosed) {
		this.storeClosed = storeClosed;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public int getStoreClosedCnt() {
		return storeClosedCnt;
	}
	public void setStoreClosedCnt(int storeClosedCnt) {
		this.storeClosedCnt = storeClosedCnt;
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
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getStoreDeclared() {
		return storeDeclared;
	}
	public void setStoreDeclared(String storeDeclared) {
		this.storeDeclared = storeDeclared;
	}
	@Override
	public String toString() {
		return "StoreDTO [storeNum=" + storeNum + ", storeName=" + storeName + ", storeDefaultAddress="
				+ storeDefaultAddress + ", storeDetailAddress=" + storeDetailAddress + ", storePhoneNum="
				+ storePhoneNum + ", storeClosed=" + storeClosed + ", storeDeclared=" + storeDeclared + ", condition="
				+ condition + ", storeClosedCnt=" + storeClosedCnt + ", filterList=" + filterList + ", startNum="
				+ startNum + ", endNum=" + endNum + ", cnt=" + cnt + "]";
	}
	
	
}