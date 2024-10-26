<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:if test="${not empty memberPK}">
    <span id="memberPK" style="display: none;">${memberPK}</span>
</c:if>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${path}/resources/assets/css/main.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="${path}/resources/assets/css/productCart.css" />
</head>

<body>
    <!-- Header -->
    <custom:header />

    <div class="container mt-5">
        <div class="row">
            <h2 class="text-center">장바구니</h2>
        </div>

        <!-- 상단: 선택, 포인트, 충전하기 버튼 -->
        <div class="row cart-header">
            <div class="col-md-6 d-flex align-items-center select-all-container">
                <div class="select-all-container d-flex align-items-center">
                    <input type="checkbox" id="selectAll" class="form-check-input me-2">
                    <label for="selectAll" class="mb-0">전체 선택</label>
                </div>
                <button id="deleteAllBtn" class="btn btn-outline-secondary ms-3" style="display: none;">선택된 상품 삭제</button>
            </div>

			<div class="col-md-6 text-end">
			    <%
			        Object myPoint = application.getAttribute("userPoint");
			        if (myPoint == null) {
			            myPoint = 0; // 기본값 설정
			        }
			    %>
			    <span>현재 포인트:<strong id="myPoint"><%= myPoint %>P</strong></span>
			    <button id="chargeButton" class="btn btn-outline-secondary ms-3">충전하기</button>
			</div>
        </div>

        <!-- 장바구니 아이템들이 렌더링될 영역 -->
        <div class="cart-products"> </div>

        <!-- 장바구니 하단: 총 금액 및 구매하기 버튼 -->
        <div class="cart-footer">
            <div class="col-md-6">
                <h5>주문 금액</h5>
            </div>
            <div class="col-md-6 text-end">
                <span class="total-price">0P</span>
                <button id="purchaseButton" class="btn btn-outline-secondary ms-3">구매하기</button>
            </div>
        </div>
    </div>
   

    <!-- Footer -->
    <custom:footer />
    <script>
        // JSON 문자열을 JavaScript에서 사용하기 전에 디코딩합니다.
        const encodedCartItemsString = '${fn:escapeXml(cartItemsJson)}';
        
        // HTML 엔티티를 일반 문자열로 변환하는 함수
        function decodeHTMLEntities(text) {
            const textarea = document.createElement("textarea");
            textarea.innerHTML = text;
            return textarea.value;
        }

        // 디코딩된 JSON 문자열
        const decodedCartItemsString = decodeHTMLEntities(encodedCartItemsString);
        
        try {
            // JSON 파싱
            var cartItems = JSON.parse(decodedCartItemsString);
            console.log(cartItems); // 파싱된 JSON 데이터 확인
        } catch (e) {
            console.error('JSON 파싱 에러: ', e);
            console.log('파싱 시도한 문자열: ', decodedCartItemsString);
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${path}/resources/assets/js/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="${path}/resources/assets/js/product/productCart.js"></script>
</body>

</html>
