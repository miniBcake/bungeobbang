<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포인트 충전</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${path}/resources/assets/css/pointRecharge.css" />
</head>

<body>

 <div id="page-wrapper">
   <!-- Header -->
	<custom:header />
    <div class="container">
        <div class="row mb-4">
            <div class="col-2">
                <button class="btn btn-secondary">&lt; 뒤로가기</button>
            </div>
            <div class="col-10">
                <h2>포인트 충전</h2>
            </div>
        </div>

        <div class="row mb-4 table-aligned">
            <div class="col-md-12">
                <h3>충전할 포인트</h3>
                <div class="point-options">
                    <div><input type="radio" name="point" id="point1" value="1000"> <span>1,000 Point</span> <span>1,000원</span></div>
                    <div><input type="radio" name="point" id="point2" value="3000"> <span>3,000 Point</span> <span>3,000원</span></div>
                    <div><input type="radio" name="point" id="point3" value="5000"> <span>5,000 Point</span> <span>5,000원</span></div>
                    <div><input type="radio" name="point" id="point4" value="10000"> <span>10,000 Point</span> <span>10,000원</span></div>
                    <div><input type="radio" name="point" id="point5" value="30000"> <span>30,000 Point</span> <span>30,000원</span></div>
                    <div><input type="radio" name="point" id="point6" value="50000"> <span>50,000 Point</span> <span>50,000원</span></div>
                </div>
            </div>
        </div>

        <div class="row mb-4 table-aligned">
            <div class="col-md-12 text-right">
                <div class="current-point">
                    <p>현재 포인트: <span>12,000P</span></p>
                    <p>충전 후 포인트: <span id="totalPoints">12,000P</span></p>
                </div>
            </div>
        </div>

        <div class="row mb-4 table-aligned">
            <div class="col-12">
                <h3>결제 수단</h3>
                <div class="row mb-3">
                    <div class="col-md-4">
                        <div class="form-check">
                            <label class="form-check-label" for="cardPayment">카드 결제</label>
                            <select class="form-select dropdown-payment" id="cardPayment"
                                onchange="selectPaymentMethod(this.value)">
                                <option value="" disabled selected>카드 선택</option>
                                <option value="신한카드">신한카드</option>
                                <option value="우리카드">우리카드</option>
                            </select>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="form-check">
                            <label class="form-check-label" for="accountPayment">계좌 결제</label>
                            <select class="form-select dropdown-payment" id="accountPayment"
                                onchange="selectPaymentMethod(this.value)">
                                <option value="" disabled selected>계좌 선택</option>
                                <option value="국민은행">국민은행</option>
                                <option value="농협은행">농협은행</option>
                            </select>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="form-check">
                            <label class="form-check-label" for="otherPayment">기타 결제 수단</label>
                            <select class="form-select dropdown-payment" id="otherPayment"
                                onchange="selectPaymentMethod(this.value)">
                                <option value="" disabled selected>기타 선택</option>
                                <option value="카카오페이">카카오페이</option>
                                <option value="네이버페이">네이버페이</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mb-4 table-aligned">
            <div class="col-md-12">
                <h3>결제 정보</h3>
                <div class="mb-3">
                    <label for="email">이메일</label>
                    <input type="email" id="email" class="form-control" placeholder="이메일을 입력하세요">
                </div>
                <div class="mb-3">
                    <label for="paymentMethodSelected">결제 방법</label>
                    <input type="text" id="paymentMethodSelected" class="form-control" value="" readonly>
                </div>
                <div class="mb-3">
                    <label for="paymentAmount">결제 금액</label>
                    <input type="text" id="paymentAmount" class="form-control" value="0원" readonly>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="agreeTerms">
                    <label class="form-check-label" for="agreeTerms">
                        위 내용으로 결제에 동의합니다.
                    </label>
                </div>
                <div class="final-buttons mt-3">
                    <button class="btn btn-primary">결제하기</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer -->
	<custom:footer />
   </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
