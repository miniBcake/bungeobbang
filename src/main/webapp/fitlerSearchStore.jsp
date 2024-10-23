<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>가게 검색 페이지</title>
<meta charset="utf-8" />
<link rel="stylesheet" href="${path}/resources/assets/css/searchbar.css">
<style type="text/css">
</style>
</head>
<body>

	<!-- 검색창 부분 -->
	<form action="filterSearchStore.do"></form>
	<div class="search-bar">
		<div></div>
		<!-- 가게명 박스 -->
		<div class="category-box" id="storeNameBox">
			<div class="category" id="categoryName">가게명 검색</div>
			<div class="row">
				<div class="search-input">
					<input type="text" name="storeName" placeholder="가게 이름을 입력해주세요.">
					<input type="submit" value="검색">
				</div>
			</div>
		</div>
		<div class="category-box">
			<div class="category hidden"></div>
			<div>
				<div class="row">
					<span class="filterOption">안녕<button class="hidden">X</button></span>
				</div>
				<hr>
			</div>
		</div>

		<!-- 가게 메뉴 박스 -->
		<div class="category-box" id="storeMenuBox">
			<div class="category" id="categoryMenu">가게 메뉴</div>

			<div class="row">
				<!-- 1. 팥/슈크림 -->
				<div class="col-3 col-6-medium col-12-small">
					<section>
						<label class="custom-checkbox"> <input type="checkbox" name="storeMenu" value="팥/슈크림"
								id="num1-pot">
							<span class="checkmark">팥 / 슈크림 (0)</span>
						</label>
					</section>
				</div>
				<!-- 2. 야채/김치/만두 -->
				<div class="col-3 col-6-medium col-12-small">
					<section>
						<label class="custom-checkbox"> <input type="checkbox" name="storeMenu" value="야채/김치/만두"
								id="num1-pot">
							<span class="checkmark">야채/김치/만두 (0)</span>
						</label>
					</section>
				</div>
				<!-- 3. 미니 붕어빵 -->
				<div class="col-3 col-6-medium col-12-small">
					<section>
						<label class="custom-checkbox"> <input type="checkbox" name="storeMenu" value="미니"
								id="num1-pot">
							<span class="checkmark">미니 붕어빵 (0)</span>
						</label>
					</section>
				</div>
				<!-- 4. 고구마 -->
				<div class="col-3 col-6-medium col-12-small">
					<section>
						<label class="custom-checkbox"> <input type="checkbox" name="storeMenu" value="고구마"
								id="num1-pot">
							<span class="checkmark">고구마 (0)</span>
						</label>
					</section>
				</div>
				<!-- 5. 아이스크림/초코 -->
				<div class="col-3 col-6-medium col-12-small">
					<section>
						<label class="custom-checkbox"> <input type="checkbox" name="storeMenu" value="아이스크림/초코"
								id="num1-pot">
							<span class="checkmark">아이스크림/초코 (0)</span>
						</label>
					</section>
				</div>
				<!-- 6. 치즈 -->
				<div class="col-3 col-6-medium col-12-small">
					<section>
						<label class="custom-checkbox"> <input type="checkbox" name="storeMenu" value="치즈"
								id="num1-pot">
							<span class="checkmark">치즈 (0)</span>
						</label>
					</section>
				</div>
				<!-- 7. 패스츄리 -->
				<div class="col-3 col-6-medium col-12-small">
					<section>
						<label class="custom-checkbox"> <input type="checkbox" name="storeMenu" value="패스츄리"
								id="num1-pot">
							<span class="checkmark">패스츄리 (0)</span>
						</label>
					</section>
				</div>
				<!-- 8.기타 -->
				<div class="col-3 col-6-medium col-12-small">
					<section>
						<label class="custom-checkbox"> <input type="checkbox" name="storeMenu" value="기타"
								id="num1-pot">
							<span class="checkmark">기타 (0)</span>
						</label>
					</section>
				</div>
			</div>
		</div>


		<!-- 결제 방법 박스 -->
		<div class="category-box" id="storePayBox">
			<div class="category" id="categoryPayment">결제 방법</div>



			<div class="row">
				<!-- 1. 현금결제 -->
				<div class="col-3 col-6-medium col-12-small">
					<section>
						<label class="custom-checkbox"> <input type="checkbox" name="storePayment" value="현금결제"
								id="num1-pot">
							<span class="checkmark">현금결제 (0)</span>
						</label>
					</section>
				</div>
				<!-- 2. 카드결제 -->
				<div class="col-3 col-6-medium col-12-small">
					<section>
						<label class="custom-checkbox"> <input type="checkbox" name="storePayment" value="카드결제"
								id="num1-pot">
							<span class="checkmark">카드결제 (0)</span>
						</label>
					</section>
				</div>
				<!-- 3. 계좌이체 -->
				<div class="col-3 col-6-medium col-12-small">
					<section>
						<label class="custom-checkbox"> <input type="checkbox" name="storePayment" value="계좌이체"
								id="num1-pot">
							<span class="checkmark">계좌이체 (0)</span>
						</label>
					</section>
				</div>
			</div>
		</div>

		<!-- 운영 상태 박스 -->
		<div class="category-box" id="storeOpenBox">
			<div class="category" id="categoryState">운영 상태</div>

			<div class="row">
				<!-- 가게 운영 상태 -->
				<div class="col-3 col-6-medium col-12-small">
					<section>
						<label class="custom-checkbox"> <input type="checkbox" name="storePayment" value="현금결제"
								id="num1-pot">
							<span class="checkmark">영업중인 가게 (0)</span>
						</label>
					</section>
				</div>
			</div>

		</div>

		<hr>

	</div>
</body>
</html>