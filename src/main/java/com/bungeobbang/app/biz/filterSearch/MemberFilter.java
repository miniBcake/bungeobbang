package com.bungeobbang.app.biz.filterSearch;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map.Entry;

public class MemberFilter extends FilterSearchUtil{
	public MemberFilter() {
		super();
		memberFilter();
	}
	private void memberFilter() {
		// MEMBER  
		Filter_SQL_MAP.put("SELECT_PART_EMAIL", "AND MEMBER_EMAIL LIKE CONCAT('%', ?, '%')");
		Filter_SQL_MAP.put("SELECT_PART_NICKNAME", "AND MEMBER_NICKNAME LIKE CONCAT('%', ?, '%')");
		Filter_SQL_MAP.put("SELECT_PART_NAME", "AND MEMBER_NAME LIKE CONCAT('%', ?, '%')");
		Filter_SQL_MAP.put("SELECT_PART_ROLE", "AND MEMBER_ROLE = ?");
		Filter_SQL_MAP.put("SELECT_PART_PHONE", "AND MEMBER_PHONE LIKE CONCAT('%', ?, '%')");
		
	}
	
	@Override
	public int setFilterKeywords(PreparedStatement pstmt, HashMap<String, String> filters, int placeholderNum) {
		//Board 키워드 추가
		try {

			for (Entry<String, String> keyword : filters.entrySet()) {
				String key = keyword.getKey();
				String value = keyword.getValue();


				switch(key) {	
				// PAYMENT
				case "SELECT_PART_EMAIL":
					pstmt.setString(placeholderNum++, value);
					break;
				case "SELECT_PART_NICKNAME" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "SELECT_PART_NAME" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "SELECT_PART_ROLE" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "SELECT_PART_PHONE" :
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

