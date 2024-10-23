package com.bungeobbang.app.biz.store;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.HashMap;

@Getter @Setter @ToString
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
	private int maxPk;					//가장 최근에 사용된 PK번호
	
	//필터 검색을 위한 DTO
	private HashMap<String, String> filterList; //필터검색용 <검색구분용, 검색값>

	private int startNum; // 시작 페이지
	private int endNum; // 종료 페이지
	private int cnt; //페이지 네이션 개수 반환용
}