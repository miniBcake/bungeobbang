package com.fproject.app.biz.filter;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map.Entry;

public class PaymentFilter extends FilterSearchUtil{
	public PaymentFilter() {
		super();
		paymentFilter();
	}

	private void paymentFilter() {
		// PAYMENT 
		// 관리자 확인여부
		Filter_SQL_MAP.put("ADMIN_CHECKED", "AND ADMIN_CHECK =?");
		// 회원 번호
		Filter_SQL_MAP.put("MEMBER_NUM", "AND MEMBER_NUM =?");
	}
	
	@Override
	public int setFilterKeywords(PreparedStatement pstmt, HashMap<String, String> filters, int placeholderNum) {
		//// Payment 관련 필터 키워드 추가 설정
		try {

			for (Entry<String, String> keyword : filters.entrySet()) {
				String key = keyword.getKey();
				String value = keyword.getValue();

				switch(key) {	
				// PAYMENT
				case "ADMIN_CHECKED":
					pstmt.setString(placeholderNum++, value); // 'Y' 또는 'N' 체크
					break;
				case "MEMBER_NUM" :
					pstmt.setInt(placeholderNum++, Integer.parseInt(value));
				default:
					throw new IllegalArgumentException("Invalid filter key: " + key);
				}

			}
		}catch (NumberFormatException e) {
			System.err.println("log: setFilterKeywords "+e.getMessage());
			return-1;
		}
		catch(SQLException e) {
			System.err.println("log: setFilterKeywords " + e.getMessage());
			return -1;
		}
		System.out.println("log: setFilterKeywords end");

		return placeholderNum;
	}
}
