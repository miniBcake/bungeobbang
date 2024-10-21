package com.fproject.app.biz.payment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fproject.app.biz.common.JDBCUtil;
import com.fproject.app.biz.filter.PaymentFilter;

@Repository
public class PaymentDAO {
	
	//insert 쿼리
	private final String INSERT_PAYMENT = "INSERT INTO BB_PAYMENT(Payment_NUM, PAYMENT_STATUS, PAYMENT_AMOUNT, PAYMENT_DAY, PAYMENT_USED, POINT_NUM)"
			+ "VALUES(?,?,?,?,?,?)";
	//update 쿼리
	private final String UPDATE_ADMINCHECK = "UPDATE BB_PAYMENT SET ADMIN_CHECKED = 'Y' WHERE BB_PAYMENT = ?";
	
	//selectAll 쿼리
	private final String SELECTALL = "SELECT PAYMENT_NUM, Payment_NUM, PAYMENT_STATUS, PAYMENT_AMOUNT, PAYMENT_DAY, PAYMENT_USED, POINT_NUM, ADMIN_CHECK "
			+ "FROM BB_PAYMENT";
	
	private final String NUMFILTER = "WHERE 1=1";
	
	private final String SELECTALL_ENDPART = "ORDER BY PAYMENT_NUM LIMIT ?,?";
	
	//selectOne 쿼리
	private final String SELECTONE = "SELECT PAYMENT_NUM, Payment_NUM, PAYMENT_STATUS, PAYMENT_AMOUNT, PAYMENT_DAY, PAYMENT_USED, POINT_NUM, ADMIN_CHECK"
			+ "FROM BB_PAYMENT "
			+ "WHERE PAYMENT_NUM = ?";
	
	
	public boolean insert(PaymentDTO paymentDTO) {
		System.out.println("log: Payment insert start");
		Connection conn = JDBCUtil.connect();
		PreparedStatement pstmt = null;
		int placeholderNum =1;
		int rs = 1;
		try{
			if(paymentDTO.getCondition().equals("INSERT_PAYMENT")) {
				// 결제 내역 생성
				System.out.println("log : Payment insert : INSERT_PAYMENT");
				pstmt = conn.prepareStatement(INSERT_PAYMENT);
				pstmt.setInt(placeholderNum++, paymentDTO.getPaymentNum());//회원 번호
				pstmt.setString(placeholderNum, paymentDTO.getPaymentStatus()); //결제 상태
				pstmt.setInt(placeholderNum++, paymentDTO.getPaymentAmount()); //결제 금액
				pstmt.setString(placeholderNum++,paymentDTO.getPaymentDay());//결제일
				pstmt.setString(placeholderNum++, paymentDTO.getPaymentUsed()); //결제 방식
				pstmt.setInt(placeholderNum++, paymentDTO.getPointNum()); //포인트 번호
				
				System.out.println("log: parameter paymentDTO ["+paymentDTO+"]");
			}
			else {
				//컨디션 오류
				System.err.println("log : Payment insert condition fail");
			}
			System.out.println("log : Payment insert pstmt excute : "+pstmt.toString());
			rs = pstmt.executeUpdate();
			
			if(rs<=0) {
				// 쿼리는 정상적으로 실행됐으나 실패
				System.err.println("log : Payment insert execute fail");
				return false;
			}
		}catch(SQLException e) {
			System.err.println("log : Payment insert SQLException fail");
			return false;
		}catch(Exception e ) {
			System.err.println("log : Payment insert Exception fail");
			return false;
		}finally {
			//연결해제
			if(!JDBCUtil.disconnect(conn, pstmt)) {
				//연결해제 실패
				System.err.println("log: Payment insert disconnect fail");
				return false;
			}
			System.out.println("log : Payment insert end");
		}
		System.out.println("log : Payment insert true");
		return true;
	}
	
	
	public boolean update(PaymentDTO paymentDTO) {
		System.out.println("log: Payment update start");
		Connection conn = JDBCUtil.connect();
		PreparedStatement pstmt = null;
		// pstmt 인덱스
		int placeholderNum = 1;
		int rs = 1;
		try{
			if(paymentDTO.getCondition().equals("UPDATE_POINT")) {
				// 관리자 확인 수정
				System.out.println("log : Payment update : ADMIN_CHECK");
				pstmt= conn.prepareStatement(UPDATE_ADMINCHECK);
				pstmt.setInt(placeholderNum++, paymentDTO.getPaymentNum()); //회원번호
				System.out.println("log: parameter getPaymentNum : "+paymentDTO.getPaymentNum());
			}
			else {
				//컨디션 오류
				System.err.println("log : Payment update condition fail");
			}
			System.out.println("log : Payment update pstmt excute : "+pstmt.toString());
			rs = pstmt.executeUpdate();
			
			if(rs<=0) {
				// 쿼리는 정상적으로 실행됐으나 실패
				System.err.println("log : Payment update execute fail");
				return false;
			}
		}catch(SQLException e) {
			System.err.println("log : Payment update SQLException fail");
			return false;
		}catch(Exception e ) {
			System.err.println("log : Payment update Exception fail");
			return false;
		}finally {
			//연결해제
			if(!JDBCUtil.disconnect(conn, pstmt)) {
				//연결해제 실패
				System.err.println("log: Payment update disconnect fail");
				return false;
			}
			System.out.println("log : Payment update end");
		}
		System.out.println("log : Payment update true");
		return true;
	}
	private boolean delete(PaymentDTO paymentDTO) {
		return false;
	}
	
	public List<PaymentDTO> selectAll(PaymentDTO paymentDTO){
		System.out.println("log: Payment selectAll start");
		List<PaymentDTO> datas = new ArrayList<>();
		Connection conn = JDBCUtil.connect();
		PreparedStatement pstmt = null;
		
		//인덱스 번호
		int placeholderNum =1;
		try {
			if(paymentDTO.getCondition().equals("SELECTALL_PAYMENT")) {
				//지불 내역 전체 검색
				System.out.println("log : Payment selectAll : SELECTALL_PAYMENT");
				pstmt = conn.prepareStatement(SELECTALL);	
			}
			else if(paymentDTO.getCondition().equals("SELECTALL_PAYMENT_CHECKED")) {
				// 체크된 항목만 검색
				System.out.println("log : Payment selectAll : SELECTALL_PAYMENT_CHECKED");
				//메서드를 통해 쿼리문을 완성한 후 toString을 통해 다시 String으로 변환
				String startQuery = SELECTALL+" "+NUMFILTER;
				// 필터검색을 위한 filters Map 받아오기
				HashMap<String, String> filters = paymentDTO.getFilterList();
				// 필터 검색 객체 생성
				PaymentFilter filterUtil = new PaymentFilter();
				
				// Map에 따른 query문 생성
				pstmt = conn.prepareStatement(filterUtil.buildFilterQuery(startQuery,filters).append(" "+SELECTALL_ENDPART).toString());
				placeholderNum = filterUtil.setFilterKeywords(pstmt, filters, placeholderNum);
				if(placeholderNum<=0) {
					//만약 filterKeywordSetter 메서드에서 오류 -> SQL예외처리
					throw new SQLException();
				}
				pstmt.setInt(placeholderNum++, paymentDTO.getStartNum());
				pstmt.setInt(placeholderNum++, paymentDTO.getEndNum());
				// 페이지 네이션 시작, 끝 (Limit ?,?)
				System.out.println("log: Payment SELECTALL_PAYMENT_FILTER (startNum, endNum) = ( "
									+paymentDTO.getStartNum()+" , "+paymentDTO.getEndNum()+" )");
			}
			else {
				//컨디션값 오류
				System.err.println("log : Payment selectAll condition fail");
			}
			// 쿼리문 실행
			System.out.println("log : Payment query = "+pstmt.toString());
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) { 
				PaymentDTO data = new PaymentDTO();
				data.setPaymentNum(rs.getInt("PAYMENT_NUM")); //지불내역 번호
				data.setPaymentStatus(rs.getString("PAYMENT_STATUS")); //결제 상태
				data.setPaymentAmount(rs.getInt("PAYMENT_AMOUNT")); // 결제 금액
				data.setPaymentDay(rs.getString("PAYMENT_DAY")); //결제일
				data.setPaymentUsed(rs.getString("PAYMENT_USED")); //결제 방식
				data.setPointNum(rs.getInt("POINT_NUM")); //포인트 번호
				data.setAdminChecked(rs.getString("ADMIN_CHECK")); // 관리자 확인 여부
				datas.add(data);
				System.out.println("log : result ["+data.getPaymentNum()+"]");
			}
			rs.close();
			System.out.println("end");
		}catch (SQLException e) {
			System.err.println("log: Payment selectAll SQLException fail");
			datas.clear();//잔여데이터 삭제
		} catch (Exception e) {
			System.err.println("log: Payment selectAll Exception fail");
			e.printStackTrace();
			datas.clear();//잔여데이터 삭제
		} finally {
			//연결해제
			if(!JDBCUtil.disconnect(conn, pstmt)) {
				//연결해제 실패
				System.err.println("log: Payment selectAll disconnect fail");
				datas.clear();//잔여데이터 삭제
			}
			System.out.println("log: Payment selectAll end");
		}
		System.out.println("log: Payment selectAll return datas");
		return datas;
	}
	
	public PaymentDTO selectOne(PaymentDTO paymentDTO) {
		System.out.println("log: Payment selectOne start");
		Connection conn = JDBCUtil.connect();
		PreparedStatement pstmt = null;
		PaymentDTO data = new PaymentDTO();
		try {
			if(paymentDTO.getCondition().equals("SELECTONE_PAYMENT")) {
				System.out.println("log : Payment selectOne : SELECTONE_PAYMENT");
				pstmt = conn.prepareStatement(SELECTONE);	
			}
			else {
				//컨디션값 오류
				System.err.println("log: Payment selectOne condition fail");
			}
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) { 
				data.setPaymentNum(rs.getInt("PAYMENT_NUM")); //지불내역 번호
				data.setPaymentStatus(rs.getString("PAYMENT_STATUS")); //결제 상태
				data.setPaymentAmount(rs.getInt("PAYMENT_AMOUNT")); // 결제 금액
				data.setPaymentDay(rs.getString("PAYMENT_DAY")); //결제일
				data.setPaymentUsed(rs.getString("PAYMENT_USED")); //결제 방식
				data.setPointNum(rs.getInt("POINT_NUM")); //포인트 번호
				data.setAdminChecked(rs.getString("ADMIN_CHECK")); // 관리자 확인 여부
				System.out.println("log : result ["+data+"]");
			}
			rs.close();
			System.out.println("end");
		} catch (SQLException e) {
			System.err.println("log: Payment selectOne SQLException fail");
			return null;
		} catch (Exception e) {
			System.err.println("log: Payment selectOne Exception fail");
			e.printStackTrace();
			return null;
		} finally {
			//연결해제
			if(!JDBCUtil.disconnect(conn, pstmt)) {
				//연결해제 실패
				System.err.println("log: Payment selectOne disconnect fail");
				return null;
			}
			System.out.println("log: Payment selectOne end");
		}
		System.out.println("log: Payment selectOne return datas");
		return data;
	}
	
}	
