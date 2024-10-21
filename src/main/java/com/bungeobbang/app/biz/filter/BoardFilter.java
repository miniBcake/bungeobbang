package com.fproject.app.biz.filter;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map.Entry;

public class BoardFilter extends FilterSearchUtil{
	public BoardFilter() {
		super();
		boardFilter();
	}
	private void boardFilter() {
		// BOARD 
		Filter_SQL_MAP.put("SELECT_PART_PERIOD", "AND BOARD_WRITE_DAY >= NOW() - INTERVAL ? DAY");
		Filter_SQL_MAP.put("SELECT_PART_TITLE", "AND BOARD_TITLE LIKE CONCAT('%', ?, '%')");
		Filter_SQL_MAP.put("SELECT_PART_NICKNAME", "AND MEMBER_NICKNAME LIKE CONCAT('%', ?, '%')");
		Filter_SQL_MAP.put("SELECT_PART_CONTENT", "AND BOARD_CONTENT LIKE CONCAT('%', ?, '%')");
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
				case "SELECT_PART_PERIOD":
					pstmt.setInt(placeholderNum++, Integer.parseInt(value));
					break;
				case "SELECT_PART_TITLE" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "SELECT_PART_NICKNAME" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "SELECT_PART_CONTENT" :
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
