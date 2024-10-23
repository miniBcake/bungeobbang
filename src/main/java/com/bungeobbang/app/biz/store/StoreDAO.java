package com.bungeobbang.app.biz.store;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bungeobbang.app.biz.common.JDBCUtil;
import com.bungeobbang.app.biz.filterSearch.FilterSearchUtil;
import com.bungeobbang.app.biz.filterSearch.StoreFilter;

@Repository
public class StoreDAO {

	//가게 기본정보 추가
	//받은 데이터 : 가게 상호명, 기본&상세주소, 가게 전화번호
	//추가 데이터 : 가게 고유번호(PK), 가게 상호명, 기본&상세주소, 가게 전화번호, 가게폐점여부(N-자동등록)
	private final String INSERT = "INSERT INTO BB_STORE(STORE_NAME, STORE_ADDRESS, STORE_ADDRESS_DETAIL, STORE_CONTACT) VALUES (?, ?, ?, ?)";
	
	private final String DELETE_STORE = "DELETE FROM BB_STORE WHERE STORE_NUM = ?";
	//특정가게 상세정보 조회
	//받은 데이터 : 가게 고유번호(PK)
	//조회 데이터 : 가게 고유번호(PK), 가게 상호명, 기본&상세주소, 가게 전화번호, 가게폐점여부, 비공개 여부
	private final String INFO_STORE_SELECTONE = "SELECT STORE_NUM, STORE_NAME, STORE_ADDRESS, STORE_ADDRESS_DETAIL, STORE_CONTACT, STORE_CLOSED, STORE_DECLARED "
			+ "FROM BB_STORE WHERE STORE_NUM = ?";

	//가게 고유번호(PK) 최댓값 조회(+insert 과정에 활용)
	private final String STORE_NEW_SELECTONE = "SELECT MAX(STORE_NUM) AS MAX_S_NUM FROM BB_STORE";


	//가게 수 조회
	private final String STORE_CNT_SELECTONE = "SELECT COUNT(DISTINCT STORE_NUM) AS STORE_COUNT FROM BB_VIEW_SEARCHSTOREDATA_JOIN ";

	//필터링 후 해당하는 가게 고유번호(PK) 모두 조회
	private final String SELECTALL_VIEW = "SELECT DISTINCT STORE_NUM,STORE_NAME, STORE_CLOSED, STORE_DECLARED, "
			+ "STORE_MENU_NOMAL, STORE_MENU_VEG,"
			+ "STORE_MENU_POTATO, STORE_MENU_ICE, STORE_MENU_CHEESE, STORE_MENU_PASTRY, STORE_MENU_OTHER,"
			+ "STORE_PAYMENT_CASHMONEY, STORE_PAYMENT_CARD, STORE_PAYMENT_ACCOUNT"
			+ "FROM BB_VIEW_SEARCHSTOREDATA_JOIN";
	
	private final String SELECTALL_DECLARED = "SELECT S.STORE_NUM, S.STORE_NAME, S.STORE_DECLARED, D.DECLARE_NUM, D.DECLARE_REASON"
			+ "FROM BB_STORE S "
			+ "JOIN DECLARE D ON S.STORE_NUM = D.DECLARE_NUM";
	
	private final String SELECTALL_DECLARED_CNT= "SELECT S.STORE_NUM, S.STORE_NAME, COUNT(D.DECLARE_NUM) AS DECLARE_COUNT\r\n"
			+ "FROM BB_STORE S\r\n"
			+ "JOIN BB_DECLARE D ON S.STORE_NUM = D.STORE_NUM\r\n"
			+ "GROUP BY S.STORE_NUM, S.STORE_NAME\r\n"
			+ "HAVING COUNT(D.DECLARE_NUM) >= ?\r\n"
			+ "ORDER BY S.STORE_NUM";
	

	//항상 조건절 충족하도록 WHERE 1=1 변수 생성
	private final String SELECTALLNUMFILTER = " WHERE 1=1 ";

	private final String SELECTALL_ENDPART = "ORDER BY STORE_NUM LIMIT ?,?";
	private final String SELECTALL_ENDPART_DESC = "ORDER BY STORE_NUM DESC LIMIT ?,?";


	// UPDATE_필터 변수 모음 ------------------------------------------------------------------------------------------------------
	private final String UPDATE_SET = "UPDATE BB_STORE SET";
	
	// 가게 번호 변수
	private final String WHERE_STORENUM = "WHERE STORE_NUM = ?";
	// 조회할 개수
	private final int CNT = 3;

	// StoreDAO insert --------------------------------------------------------------------------------------

	// pstmt 입력값 선언 및 초기화

	public boolean insert(StoreDTO storeDTO) { // 신규등록가게 추가
		System.out.println("log_StoreDAO_insert : start");
		System.out.println("log_StoreDAO_insert_controller input StoreDTO : " + storeDTO);

		//[1] DB 연결 객체를 'conn' 변수로 선언: JDBC 연결 관리하는 JDBCUtil 클래스에서 DB연결 설정 메서드 실행.
		Connection conn = JDBCUtil.connect();

		//[2] SQL 쿼리 미리 컴파일하는 객체 PreparedStatement를 참조하는 pstmt 변수 선언 및 초기화
		PreparedStatement pstmt = null;
		System.out.println("log_StoreDAO_insert_pstmt null setting complete!");

		// 비정상 프로그램 종료 방지 위한 try-catch 진행
		try { 			
			//SQL DB와 연결하여 INSERT 변수값 미리 컴파일, 실행 준비
			pstmt = conn.prepareStatement(INSERT); // input값 storeDTO 이하 입력
			System.out.println("log_StoreDAO_insert_pstmt prepareStatement insert : " + pstmt);

			/*[4] 인자값으로 받은 데이터 쿼리문에 삽입: 가게 상호명, 기본,상세주소, 전화번호*/
			pstmt.setString(1, storeDTO.getStoreName()); 			// 상호명 입력
			pstmt.setString(2, storeDTO.getStoreDefaultAddress()); 	// 기본주소 입력
			pstmt.setString(3, storeDTO.getStoreDetailAddress()); 	// 상세주소 입력
			pstmt.setString(4, storeDTO.getStorePhoneNum()); 		// 전화번호 입력

			//[5] rs 변수 선언 : INSERT 쿼리문 실행
			int rs = pstmt.executeUpdate(); 						// INSERT 쿼리문 실행
			System.out.println("log_StoreDAO_update_rs complete");

			//[6] 예외처리 : 정상실행 되지 않았을 경우, false
			if (rs <= 0) {//rs >= 1(success) / rs = 0 (fail)
				System.err.println("log_StoreDAO_insert_executeUpdate() fail : if(rs <= 0)");
				return false; 
			}
		} catch (Exception e) {
			System.err.println("log_StoreDAO_insert_Exception fail : Exception e ");
			return false;

			//[7] JDBC 연결 해제 진행
		} finally {
			if (!JDBCUtil.disconnect(conn, pstmt)) { // 만약 JDBC가 연결되어 있다면
				System.err.println("log_StoreDAO_insert_disconnect fail"); // 연결해제 실패
				return false; // 반환값 false
			} // JDBC 연결 해제 되었다면
		}
		System.out.println("log_StoreDAO_insert_true!");
		return true;
	}

	// StoreDAO update 가게 기본 정보 수정
	// ------------------------------------------------------------------------------
	public boolean update(StoreDTO storeDTO) {
		System.out.println("log_StoreDAO_update : start");
		System.out.println("log_StoreDAO_update_controller input StoreDTO : " + storeDTO);

		//[1] DB 연결 객체를 conn 변수로 선언: JDBC 연결 관리하는 JDBCUtil 클래스에서 DB연결 설정 메서드 실행.
		Connection conn = JDBCUtil.connect();

		//[2] SQL 쿼리 미리 컴파일하는 객체 PreparedStatement를 참조하는 pstmt 변수 선언 및 초기화
		PreparedStatement pstmt = null;
		System.out.println("log_StoreDAO_update_pstmt null setting");

		//pstmt 변수 초기화
		int placeholderNum = 1;

		// 비정상 프로그램 종료 방지 위한 try-catch 진행
		try {
			if(storeDTO.getCondition().equals("UPDATE_STORE")) {
				
				//[3]동적 쿼리 queryBuilder 변수 선언 : UPDATE 위한 공통절
				System.out.println("log_StoreDAO_update_queryBuilder UPDATE_SET setting");
				//[4]SET절 추가 및 쿼리문 형성
				HashMap<String, String>filters = storeDTO.getFilterList();
				StoreFilter filterUtil = new StoreFilter();
				String startQuery = UPDATE_SET;
				StringBuilder query = filterUtil.buildFilterQuery(startQuery, filters);
				// 마지막 쉼표 삭제
				if (query.length() > 0 && query.charAt(query.length() - 1) == ',') {
					query.delete(query.length() - 1, query.length());
				}
				
				pstmt = conn.prepareStatement(query.append(" "+WHERE_STORENUM).toString());
				System.out.println("log : UPDATE query = "+pstmt);
				//쿼리문 형성 완료 
				placeholderNum = filterUtil.setFilterKeywords(pstmt, filters, placeholderNum);
				pstmt.setInt(placeholderNum++, storeDTO.getStoreNum());
			}
				
				//[6] rs 변수 선언 : UPDATE 쿼리문 실행
				int rs = pstmt.executeUpdate();
				
				//[7] 예외처리 : 정상실행 되지 않았을 경우, false
				if (rs <= 0) {
					System.err.println("log_StoreDAO_update_executeUpdate() fail : if(rs <= 0)");
					return false;
				}
		} catch (Exception e) {
			System.err.println("log_StoreDAO_update_Exception fail : Exception e ");
			e.printStackTrace();

			return false;
			//[8] JDBC 연결 해제 진행
		} finally { 
			if (!JDBCUtil.disconnect(conn, pstmt)) { // 만약 JDBC가 연결되어 있다면
				System.err.println("log_StoreDAO_update_disconnect fail"); // 연결해제 실패
				return false;
			} // JDBC 연결 해제 되었다면
		}System.out.println("log_StoreDAO_update_true!");
		return true; //반환값 true
	}

	public boolean delete(StoreDTO storeDTO) { // 가게 삭제(미구현)
		System.out.println("log_StoreDAO_delete : start");
		System.out.println("log_StoreDAO_detle_controller input StoreDTO : " + storeDTO);

		//[1] DB 연결 객체를 conn 변수로 선언: JDBC 연결 관리하는 JDBCUtil 클래스에서 DB연결 설정 메서드 실행.
		Connection conn = JDBCUtil.connect();

		//[2] SQL 쿼리 미리 컴파일하는 객체 PreparedStatement를 참조하는 pstmt 변수 선언 및 초기화
		PreparedStatement pstmt = null;
		System.out.println("log_StoreDAO_update_pstmt null setting");
		//pstmt 변수 초기화
		int placeholderNum = 1;

		// 비정상 프로그램 종료 방지 위한 try-catch 진행
		try {
			//[3]동적 쿼리 queryBuilder 변수 선언 : UPDATE 위한 공통절
			System.out.println("log_StoreDAO_delete_queryBuilder DELETE_STORE setting");
			//[4]SET절 추가 및 쿼리문 형성	
			pstmt = conn.prepareStatement(DELETE_STORE);
			//쿼리문 형성 완료 
			pstmt.setInt(placeholderNum++, storeDTO.getStoreNum());
			//[6] rs 변수 선언 : DELETE_STORE 쿼리문 실행
			int rs = pstmt.executeUpdate();

			//[7] 예외처리 : 정상실행 되지 않았을 경우, false
			if (rs <= 0) {
				System.err.println("log_StoreDAO_update_executeUpdate() fail : if(rs <= 0)");
				return false;
			}
		} catch (Exception e) {
			System.err.println("log_StoreDAO_update_Exception fail : Exception e ");
			e.printStackTrace();

			return false;
			//[8] JDBC 연결 해제 진행
		} finally { 
			if (!JDBCUtil.disconnect(conn, pstmt)) { // 만약 JDBC가 연결되어 있다면
				System.err.println("log_StoreDAO_update_disconnect fail"); // 연결해제 실패
				return false;
			} // JDBC 연결 해제 되었다면
		}System.out.println("log_StoreDAO_update_true!");
		return true; //반환값 true
	}

	//  StoreDAO selectAll ------------------------------------------------------------------------------------   
	public ArrayList<StoreDTO> selectAll(StoreDTO storeDTO) { // 검색 가게 모두 조회
		System.out.println("log_StoreDAO_selectaAll : start");
		System.out.println("log_StoreDAO_selectAll controller input StoreDTO : " + storeDTO.toString());

		//[1] DB 연결 객체를 conn 변수로 선언: JDBC 연결 관리하는 JDBCUtil 클래스에서 DB연결 설정 메서드 실행.
		Connection conn = JDBCUtil.connect();
		System.out.println("log_StoreDAO_selectaAll conn setting complete");

		//[2] SQL 쿼리 미리 컴파일하는 객체 PreparedStatement를 참조하는 pstmt 변수 선언 및 초기화
		PreparedStatement pstmt = null;
		System.out.println("log_StoreDAO_selectaAll pstmt null setting complete");

		//[3] rs 변수 선언 : selectAll 쿼리문 실행
		ResultSet rs = null;
		System.out.println("log_StoreDAO_selectaAll rs null setting complete");

		//[4] input값 pstmt에 넣을 때 활용하는 인덱스 번호
		int placeholderNum = 1; 

		//[5] datas 변수 선언 : 결과값 담을 datas
		ArrayList<StoreDTO> datas = new ArrayList<StoreDTO>();
		//필터 검색 객체 생성


		//[6] queryBuilder 변수 선언 : 필터기능 위한 문자열 조작
		System.out.println("log_StoreDAO_selectaAll queryBuilder null setting complete");

		String startQuery; 
		try {
			if(storeDTO.getCondition().equals("SELECTALL_STORE_DESC")) {
				// 가게 등록 역순 검색
				System.out.println("log : Store selectAll : SELECTALL_STORE");
				HashMap<String, String> filters = storeDTO.getFilterList();
				StoreFilter filterUtil = new StoreFilter();
				startQuery = SELECTALL_VIEW + " ";
				//쿼리문 생성
				pstmt = conn.prepareStatement(filterUtil.buildFilterQuery(startQuery, filters).append(" "+SELECTALL_ENDPART_DESC).toString());
				//검색어 입력
				placeholderNum = filterUtil.setFilterKeywords(pstmt, filters, placeholderNum);
				pstmt.setInt(placeholderNum++, storeDTO.getStartNum());
				pstmt.setInt(placeholderNum++, storeDTO.getEndNum()); // 페이지 네이션 시작, 끝 번호
				System.out.println("log: parameter getStoreStartPage : "+storeDTO.getStartNum());
				System.out.println("log: parameter getStoreEndpage : "+storeDTO.getEndNum());
				System.out.println("log : Store selectAll sql query = "+pstmt.toString());
				rs = pstmt.executeQuery();
				while(rs.next()) {
					StoreDTO data = new StoreDTO();
					data.setStoreNum(rs.getInt("STORE_NUM"));							// 가게 고유번호
					data.setStoreName(rs.getString("STORE_NAME")); 						// 가게 상호명
					data.setStoreDefaultAddress(rs.getString("STORE_ADDRESS")); 		// 가게 기본주소
					data.setStoreDetailAddress(rs.getString("STORE_ADDRESS_DETAIL")); 	// 가게 상세주소
					data.setStorePhoneNum(rs.getString("STORE_CONTACT"));				// 가게 전화번호
					data.setStoreClosed(rs.getString("STORE_CLOSED")); 					// 가게 폐점여부
					data.setStoreDeclared(rs.getNString("STORE_DECLARED"));				// 가게 신고(비공개) 여부
					datas.add(data);	//datas로 취합
					System.out.println("log_StoreDAO_selectAll_data : " + data);
				}
			}
			else if(storeDTO.getCondition().equals("SELECTALL_VIEW_FILTER")){ //전체검색
				System.out.println("log : Store selectAll : SELECTALL_VIEW");
				HashMap<String, String> filters = storeDTO.getFilterList();
				StoreFilter filterUtil = new StoreFilter();
				//메서드를 통해 쿼리문을 완성한 후 toString을 통해 다시 String으로 변환
				startQuery = SELECTALL_VIEW +" "+ SELECTALLNUMFILTER; // 필터 검색 시작 쿼리문
				pstmt = conn.prepareStatement(filterUtil.buildFilterQuery(startQuery,filters).append(" "+SELECTALL_ENDPART).toString());
				placeholderNum = filterUtil.setFilterKeywords(pstmt, filters, placeholderNum); //필터 검색 검색어
				if(placeholderNum < 0) {
					// filterKeywordSetter 오류 발생
					throw new SQLException();
					// SQL에러 처리
				}
				pstmt.setInt(placeholderNum++, storeDTO.getStartNum());
				pstmt.setInt(placeholderNum++, storeDTO.getEndNum()); // 페이지 네이션 시작, 끝 번호
				System.out.println("log: parameter getStoreStartPage : "+storeDTO.getStartNum());
				System.out.println("log: parameter getStoreEndpage : "+storeDTO.getEndNum());
				System.out.println("log : Store selectAll sql query = "+pstmt.toString());
				rs = pstmt.executeQuery();
				while(rs.next()) {
					StoreDTO data = new StoreDTO();
					data.setStoreNum(rs.getInt("STORE_NUM"));							// 가게 고유번호
					data.setStoreName(rs.getString("STORE_NAME")); 						// 가게 상호명
					data.setStoreDefaultAddress(rs.getString("STORE_ADDRESS")); 		// 가게 기본주소
					data.setStoreDetailAddress(rs.getString("STORE_ADDRESS_DETAIL")); 	// 가게 상세주소
					data.setStorePhoneNum(rs.getString("STORE_CONTACT"));				// 가게 전화번호
					data.setStoreClosed(rs.getString("STORE_CLOSED")); 					// 가게 폐점여부
					data.setStoreDeclared(rs.getNString("STORE_DECLARED"));				// 가게 신고(비공개) 여부
					datas.add(data);	//datas로 취합
					System.out.println("log_StoreDAO_selectAll_data : " + data);
				}
			}
			else if(storeDTO.getCondition().equals("SELECTALL_DECLARED_CNT")) {
				// 신고 개수 조회
				System.out.println("log : Store selectAll : SELECTALL_DECLARED_CNT");
				startQuery = SELECTALL_DECLARED_CNT;
				pstmt = conn.prepareStatement(startQuery);
				// 조회할 개수
				pstmt.setInt(placeholderNum++, CNT);
				System.out.println("log : Store selectAll sql query = "+pstmt.toString());
				rs = pstmt.executeQuery();
				while(rs.next()) {
					StoreDTO data = new StoreDTO();
					data.setStoreNum(rs.getInt("STORE_NUM"));							// 가게 고유번호
					data.setStoreName(rs.getString("STORE_NAME")); 						// 가게 상호명
					datas.add(data);	//datas로 취합
					System.out.println("log_StoreDAO_selectAll_data : " + data);
				}
			}
			else {
				//컨디션 오류
				System.err.println("log: Store selectAll condition fail");
			}
			

		}catch(SQLException e){
			System.err.println("log: Store selectAll SQLException fail");
			datas.clear(); //잔여데이터 삭제
		}catch(Exception e) {
			System.err.println("log : Store selectAll Exception fail");
			e.printStackTrace();
			datas.clear();
		}
		finally {
			//연결해제
			if(!JDBCUtil.disconnect(conn, pstmt)) {
				System.err.println("log : Store selectAll disconnect fail");
				datas.clear();
			}
			System.out.println("log: Store selectAll return end");
		}
		System.out.println("log: Store selectAll return datas");
		return datas;
	}

	// StoreDAO selectOne ----------------------------------------------------------------------------------------------------------------------------
	public StoreDTO selectOne(StoreDTO storeDTO) {
		System.out.println("log_StoreDAO_selectOne : start");
		System.out.println("log_StoreDAO_selectOne controller input StoreDTO : " + storeDTO);

		//[1] DB 연결 객체를 conn. 변수로 선언: JDBC 연결 관리하는 JDBCUtil 클래스에서 DB연결 설정 메서드 실행.
		Connection conn = JDBCUtil.connect();
		System.out.println("log_StoreDAO_selectOne conn setting complete");

		//[2] SQL 쿼리 미리 컴파일하는 객체 PreparedStatement를 참조하는 pstmt 변수 선언 및 초기화
		PreparedStatement pstmt = null;
		System.out.println("log_StoreDAO_selectOne psmt null setting complete");

		//[3] rs 변수 선언 : selectOne 쿼리문 실행
		ResultSet rs = null;
		System.out.println("log_StoreDAO_selectOne rs null setting complete");

		//[4] data 변수 선언 : 결과값 담을 data
		StoreDTO data = null;
		System.out.println("log_StoreDAO_selectOne data null setting complete");

		try {
			// 값이 가장 큰 가게고유번호(PK) 조회(+insert 과정에 활용)---------------------------------------------------
			if (storeDTO.getCondition().equals("STORE_NEW_SELECTONE")) {
				System.out.println("log_StoreDAO_selectOne condition : STORE_NEW_SELECTONE");

				//[5] pstmt 변수 선언 : () 안 쿼리문으로 실행 준비 완료.
				//SQL DB와 연결하여 STORE_NEW_SELECTONE 변수값 미리 컴파일, 실행 준비
				pstmt = conn.prepareStatement(STORE_NEW_SELECTONE);
				System.out.println("log_StoreDAO_selectOne pstmt conn");

				//[6] rs 변수 선언 : STORE_NEW_SELECTONE 쿼리문 실행
				rs = pstmt.executeQuery(); // 이하 rs 실행 및 데이터 불러오기
				System.out.println("log_StoreDAO_selectOne executeQuery() complete");

				//[7] 가게 고유번호 최댓값 불러오기
				if (rs.next()) {
					data = new StoreDTO(); // 데이터 요소 담기 위한 객체 생성
					data.setMaxPk(rs.getInt("MAX_S_NUM"));
					System.out.println("log_StoreDAO_selectOne_data finish : " + data);
				}
			}
			else if(storeDTO.getCondition().equals("STORE_CNT_SELECTONE")) {
				//필터링된 가게 수
				System.out.println("log : SelectOne STORE_CNT_SELECTONE");
				HashMap<String, String> filters = storeDTO.getFilterList();
				StoreFilter filterUtil = new StoreFilter();
				int placeholderNum=1;
				String startQuery = STORE_CNT_SELECTONE + " " + SELECTALLNUMFILTER;
				//메서드를 통해 쿼리문을 완성한 후 toString을 통해 다시 String으로 변환
				pstmt = conn.prepareStatement(filterUtil.buildFilterQuery(startQuery,filters).toString());
				placeholderNum = filterUtil.setFilterKeywords(pstmt, filters, placeholderNum); //필터 검색 검색어
				if(placeholderNum < 0) {
					// filterKeywordSetter 오류 발생
					throw new SQLException();
					// SQL에러 처리
				}
				rs = pstmt.executeQuery();
				if (rs.next()) {
					data = new StoreDTO(); // 데이터 요소 담기 위한 객체 생성
					data.setCnt(rs.getInt("STORE_COUNT"));
				}
			}
			// 특정가게 상세정보 조회---------------------------------------------------------------------------------
			else if (storeDTO.getCondition().equals("INFO_STORE_SELECTONE")) {
				System.out.println("log_StoreDAO_selectOne_condition : INFO_STORE_SELECTONE");

				//[5] pstmt 변수 선언 : () 안 쿼리문으로 실행 준비 완료.
				//SQL DB와 연결하여 INFO_STORE_SELECTONE 변수값 미리 컴파일, 실행 준비
				pstmt = conn.prepareStatement(INFO_STORE_SELECTONE);
				System.out.println("log_StoreDAO__selectOne_pstmt conn");

				//[6] 인자값으로 받은 데이터 쿼리문에 삽입
				pstmt.setInt(1, storeDTO.getStoreNum()); // 폐점 여부 입력
				System.out.println("log_StoreDAO_selectOne_pstmt input complete");

				//[7] rs 변수 선언 : INFO_STORE_SELECTONE 쿼리문 실행
				rs = pstmt.executeQuery();
				System.out.println("log_StoreDAO_selectOne_executeQuery() complete");

				//[8] 특정 가게의 기본정보 불러오기
				if (rs.next()) {
					data = new StoreDTO(); // 데이터 요소 담기 위한 객체 생성
					data.setStoreNum(rs.getInt("STORE_NUM"));							//가게 고유번호
					data.setStoreName(rs.getString("STORE_NAME"));						//가게 상호명
					data.setStoreDefaultAddress(rs.getString("STORE_ADDRESS"));			//가게 기본주소
					data.setStoreDetailAddress(rs.getString("STORE_ADDRESS_DETAIL"));	//가게 상세주소
					data.setStorePhoneNum(rs.getString("STORE_CONTACT"));				//가게 전화번호
					data.setStoreClosed(rs.getString("STORE_CLOSED"));					//가게 폐점 여부
					System.out.println("log_StoreDAO_selectOne_data INFO_STORE_SELECTONE finish : " + data);
				}
			}rs.close();
			System.out.println("log_StoreDAO_selectOne_complet!");
		} catch (SQLException e) {
			System.err.println("log_StoreDAO_selectOne_Exception fail : Exception e ");
		} finally {
			if (!JDBCUtil.disconnect(conn, pstmt)) { // 연결해제 실패
				System.err.println("log_StoreDAO_selectOne_disconnect fail");
			}
			System.out.println("log_StoreDAO_selectOne_disconnect complet!"); // 연결해제 성공
		}
		System.out.println("log_StoreDAO_selectOne_SEARCH_STORE_SELECTOne return data!");
		return data; // 데이터 반환
	}
}