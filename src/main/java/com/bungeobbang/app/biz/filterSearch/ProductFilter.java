package com.bungeobbang.app.biz.filterSearch;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map.Entry;

public class ProductFilter extends FilterSearchUtil{
	
	public ProductFilter() {
		super();
		productFilter();
	}
	
	public void productFilter() {
		//Product
		Filter_SQL_MAP.put("SELECT_PART_CATEGORY","AND PRODUCT_CATEGORY_NUM = ?");
		Filter_SQL_MAP.put("SELECT_PART_NAME", "AND PRODUCT_NAME LIKE CONCAT('%',?,'%')");
		Filter_SQL_MAP.put("SELECT_PART_TITLE", "AND BOARD_TITLE LIKE CONCAT('%',?,'%')");
		Filter_SQL_MAP.put("SELECT_PART_PRICE_MIN", "AND PRODUCT_PRICE >= ?");
		Filter_SQL_MAP.put("SELECT_PART_PRICE_MAX", "AND PRODUCT_PRICE <= ?");	
	}

	@Override
	public int setFilterKeywords(PreparedStatement pstmt, HashMap<String, String> filters, int placeholderNum) {
		//Product 관련 키워드 추가
		try {

			for (Entry<String, String> keyword : filters.entrySet()) {
				String key = keyword.getKey();
				String value = keyword.getValue();

				switch(key) {	
				//STORE
				case "SELECT_PART_CATEGORY" :
					pstmt.setInt(placeholderNum++, Integer.parseInt(value));
					break;
				case "SELECT_PART_NAME" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "SELECT_PART_TITLE" :
					pstmt.setString(placeholderNum++, value);
					break;
				case "SELECT_PART_PRICE_MIN" :
					pstmt.setInt(placeholderNum++, Integer.parseInt(value));
					break;
				case "SELECT_PART_PRICE_MAX" :
					pstmt.setInt(placeholderNum++, Integer.parseInt(value));
					break;
				default:
					throw new IllegalArgumentException("Invalid filter key: " + key);
				}
			}
		}
		catch (NumberFormatException e) {
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