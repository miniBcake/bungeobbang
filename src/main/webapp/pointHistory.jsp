<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포인트 사용 내역</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${path}/resources/assets/css/pointHistory.css" />
</head>
<body>
<!-- Header -->
<custom:header />

<div class="container mt-4">
    <!-- 포인트 및 필터 영역 -->
    <div class="row mb-4">
        <div class="col-md-6">
            <select id="orderFilter" class="form-control small-select">
                <option value="" disabled selected>포인트 사용 내역</option>
                <option value="recent">최근 결제순</option>
                <option value="status">결제 상태</option>
            </select>
        </div>
        <div class="col-md-6 text-right">
            <%
                Object myPoint = application.getAttribute("userPoint");
                if (myPoint == null) myPoint = 0; 
            %>
            <h5 class="current-point">현재 포인트: <strong id="myPoint"><%= myPoint %>P</strong></h5>
            <small class="text-muted current-point-note">* 1년이 지나면 포인트 사용내역이 사라집니다.</small>
        </div>
    </div>

    <!-- 포인트 사용 내역 테이블 -->
    <div class="scrollable-table">
        <table class="table table-bordered order-history">
            <thead>
                <tr>
                    <th>구매일자</th>
                    <th>상품번호</th>
                    <th>상품명</th>
                    <th>결제 상태</th>
                    <th>사용 금액</th>
                </tr>
            </thead>
            <tbody id="orderTable">
                <c:forEach var="item" items="${pointHistoryList}">
                    <tr>
                        <td>${item.purchaseDate}</td>
                        <td>${item.productNumber}</td>
                        <td>${item.productName}</td>
                        <td>${item.paymentStatus}</td>
                        <td>${item.amountUsed}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Footer -->
<custom:footer />

<!-- Scripts -->
<script>
    // 더미 데이터를 추가하는 함수
    function addDummyData() {
        const table = document.querySelector('#orderTable');
        for (let i = 0; i < 5; i++) {
            const newRow = table.insertRow();
            const cells = ["2024.10.0" + (5 + i), (5 + i), "추가된 상품 " + (5 + i), "결제 완료", "-10,000원"];
            cells.forEach((cellData, index) => {
                newRow.insertCell(index).innerHTML = cellData;
            });
        }
    }

    // 무한 스크롤 이벤트 리스너
    document.querySelector('.scrollable-table').addEventListener('scroll', function() {
        if (this.scrollTop + this.clientHeight >= this.scrollHeight) {
            addDummyData(); // 더미 데이터 추가
        }
    });
</script>
</body>
</html>
