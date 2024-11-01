<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 내역</title>
    <!-- Bootstrap CSS 로드 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- 페이지에 적용할 커스텀 CSS 파일 로드 -->
    <link rel="stylesheet" href="${path}/resources/assets/css/pointHistory.css" />
</head>
<body>
<!-- Header -->
<custom:header /> <!-- 커스텀 헤더 컴포넌트 삽입 -->

<div class="container mt-4">
    <!-- 타이틀과 현재 포인트 표시 -->
    <div class="row mb-4">
        <div class="col-md-6">
            <h3 class="current-point2">포인트 충전</h3> <!-- 페이지의 주요 타이틀 -->
        </div>
        <div class="col-md-6 text-right">
            <%  // 애플리케이션 범위에서 현재 포인트를 가져오며, 값이 없으면 0으로 초기화
                Object myPoint = application.getAttribute("userPoint");
                if (myPoint == null) {
                    myPoint = 0; 
                }
            %>
            <h5 class="current-point">현재 포인트: <strong id="myPoint"><%= myPoint %>P</strong></h5> <!-- 포인트 값 표시 -->
            <small class="text-muted current-point-note">* 1년이 지나면 포인트 사용내역이 사라집니다.</small> <!-- 알림 문구 -->
        </div>
    </div>

    <!-- 결제 내역 테이블 -->
    <div class="scrollable-table">
        <table class="table table-bordered order-history">
            <thead>
                <tr>
                    <th>일자/일시</th>
                    <th>내용</th>
                    <th>충전포인트</th>
                </tr>
            </thead>
            <tbody id="orderTable">
                <!-- 서버로부터 가져온 결제 내역을 반복하여 테이블에 표시 -->
                <c:forEach var="payment" items="${paymentList}">
                    <tr>
                        <td><c:out value="${payment.paymentDate}"/></td> <!-- 결제 날짜 및 시간 -->
                        <td><c:out value="${payment.paymentContent}"/></td> <!-- 결제 내용 -->
                        <td><c:out value="${payment.paymentAmount}"/>P</td> <!-- 충전된 포인트 양 -->
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- 무한 스크롤 자바스크립트 -->
<script>
    document.querySelector('.scrollable-table').addEventListener('scroll', function() {
        var table = document.querySelector('#orderTable'); // 결제 내역 테이블의 tbody 요소를 가져옴
        // 스크롤이 하단에 도달할 경우 더 많은 데이터를 로드
        if (this.scrollTop + this.clientHeight >= this.scrollHeight) {
            // 서버로부터 더 많은 결제 데이터를 요청
            fetch("${path}/loadMorePayments.do")
                .then(response => response.json()) // JSON 형태의 데이터를 파싱
                .then(data => {
                    // 각 결제 데이터를 테이블에 추가
                    data.forEach(payment => {
                        const newRow = table.insertRow(); // 새로운 행 추가
                        newRow.insertCell(0).innerHTML = payment.paymentDate; // 일자/일시 셀 추가
                        newRow.insertCell(1).innerHTML = payment.paymentContent; // 내용 셀 추가
                        newRow.insertCell(2).innerHTML = payment.paymentAmount + 'P'; // 충전포인트 셀 추가
                    });
                })
                .catch(error => console.error('Error loading more payments:', error)); // 오류 발생 시 콘솔에 로그 출력
        }
    });
</script>

</body>
</html>
