package com.fproject.app.biz.filter;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map.Entry;

public class StoreFilter extends FilterSearchUtil{
	public StoreFilter() {
		super();
		storeFilter();
	}
	public void storeFilter() {
		//STORE
		Filter_SQL_MAP.put("NAME_LIKE", "AND STORE_NAME LIKE CONCAT('%', ?, '%')");
		Filter_SQL_MAP.put("STORE_CLOSED", "AND STORE_CLOSED = ?");
		Filter_SQL_MAP.put("MENU_NOMAL", "AND STORE_MENU_NOMAL = ?");
		Filter_SQL_MAP.put("MENU_VEG", "AND STORE_MENU_VEG = ?");
		Filter_SQL_MAP.put("MENU_MINI", "AND STORE_MENU_MINI = ?");
		Filter_SQL_MAP.put("MENU_POTATO", "AND STORE_MENU_POTATO = ?");
		Filter_SQL_MAP.put("MENU_ICE", "AND STORE_MENU_ICE = ?");
		Filter_SQL_MAP.put("MENU_CHEESE", "AND STORE_MENU_CHEESE = ?");
		Filter_SQL_MAP.put("MENU_PASTRY", "AND STORE_MENU_PASTRY = ?");
		Filter_SQL_MAP.put("MENU_OTHER", "AND STORE_MENU_OTHER = ?");
		Filter_SQL_MAP.put("PAYMENT_CARD", "AND STORE_PAYMENT_CARD = ?");
		Filter_SQL_MAP.put("PAYMENT_CASHMONEY", "AND STORE_PAYMENT_CASHMONEY = ?");
		Filter_SQL_MAP.put("PAYMENT_ACCOUNT", "AND STORE_PAYMENT_ACCOUNT = ?");
		Filter_SQL_MAP.put("STORE_DECLARED", "AND STORE_DECLARED=?");

		//update
		Filter_SQL_MAP.put("UPDATE_NAME", "STORE_NAME = ?,");
		Filter_SQL_MAP.put("UPDATE_ADDRESS", "STORE_ADDRESS = ?,");
		Filter_SQL_MAP.put("UPDATE_STORE_ADDRESS_DETAIL", "STORE_ADDRESS_DETAIL = ?,");
		Filter_SQL_MAP.put("UPDATE_PHONENUM", "STORE_CONTACT = ?,");
		Filter_SQL_MAP.put("UPDATE_CLOSED", "STORE_CLOSED = ?,");

	}
	@Override
	public int setFilterKeywords(PreparedStatement pstmt, HashMap<String, String> filters, int placeholderNum) {
		//Store 관련 필터 키워드 추가 설정
		try {

			for (Entry<String, String> keyword : filters.entrySet()) {
				String key = keyword.getKey();
				String value = keyword.getValue();

				switch(key) {	
				//STORE
				case "NAME_LIKE" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "STORE_CLOSED" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "MENU_NOMAL" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "MENU_VEG" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "MENU_MINI" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "MENU_POTATO" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "MENU_ICE" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "MENU_CHEESE" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "MENU_PASTRY" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "MENU_OTHER" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "PAYMENT_CARD" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "PAYMENT_CASHMONEY" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "PAYMENT_ACCOUNT" :
					pstmt.setString(placeholderNum++, value);
					break;
					//update
				case "UPDATE_NAME" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "UPDATE_ADDRESS" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "UPDATE_STORE_ADDRESS_DETAIL" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "UPDATE_PHONENUM" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "UPDATE_CLOSED" :
					pstmt.setString(placeholderNum++, value);
					break;
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
