<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML>

<html>
<head>
<title>가게 상세정보</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />

<link rel="stylesheet" href="${path}/resources/assets/css/main.css" />
<link rel="stylesheet"
	href="${path}/resources/assets/css/pagination.css">
<link rel="stylesheet" href="${path}/resources/assets/css/store.css">

<!-- js를 쓰므로 jquery 사용 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 외부 script 파일 사용 -->
<script src="${path}/resource/assets/js/fontAndIcon.js"></script>
<script src="${path}/resources/assets/js/copy.js"></script>

</head>
<body class="subpage">
	<div id="page-wrapper">


		<!-- Content -->
		<div class="container">

			<custom:header />
			<br>

			<!-- 페이지 제목-->
			<div class="row text-center">
				<div class="col-12">
					<h2>가게 상세 정보</h2>
					<hr>
				</div>
			</div>

			<!-- 상세 페이지 내용-->
			<div class="row">
				<div class="col-12">
					<!-- 가게 상세 -->
					<div class="row viewContainer">
						<div class="col-12 col-md-6">
							<!-- 왼쪽 부분 -->
							<div class="row">
								<div class="col-12">
									<!-- 가게 이름 -->
									<h4 class="storeName">
										${storeData.storeName}{가게이름} <span class="tag" id="openStore">영업중</span>
										<span class="tag" id="closedStore">폐업</span>
									</h4>
									<br>
									<!-- 별점 플러그인 -->
								</div>
							</div>

							<div class="row">
								<div class="col-12">
									<!-- 영업 요일 -->
									<h5>
										<i class="far fa-calendar"></i> 영업 요일
									</h5>
									<div class="tagContainer2">
										<ul class="weekList">
											<li class="listValue"><span class="tag"><span
													class="week">월요일</span><span class="time">시작시간 ~
														종료시간</span></span></li>
											<li class="listValue"><span class="tag"><span
													class="week">월요일</span><span class="time">시작시간 ~
														종료시간</span></span></li>
										</ul>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-12">
									<!-- 메뉴 -->
									<h5>
										<i class="far fa-book-open"></i> 메뉴
									</h5>
									<div class="tagContainer">
										<span class="tag">팥/슈크림</span> <span class="tag">야채/김치/만두</span>
										<span class="tag">팥/슈크림</span> <span class="tag">팥/슈크림</span>
										<span class="tag">팥/슈크림</span> <span class="tag">팥/슈크림</span>
										<span class="tag">팥/슈크림</span>

									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-12">
									<!-- 결제 방식 -->
									<h5>
										<i class="fas fa-money-bill"></i> 결제방식
									</h5>
									<div class="tagContainer">
										<span class="tag">카드결제</span> <span class="tag">계좌이체</span>
									</div>
								</div>
							</div>

						</div>
						<div class="col-12 col-md-6">
							<!-- 오른쪽 부분-->
							<div class="row justify-content-center">
								<div class="col-9 justify-content-end warningBox">
									<!-- 폐점 신고 버튼 -->
									<a href="신고 액션"> <i class="fas fa-exclamation-circle"></i>
										<span>폐점 신고</span></a>
									<!-- 관리자에게만 보이는 삭제 버튼 -->
									<c:if test="${role}==ADMIN">
										<button id="deleteBtn">가게 삭제</button>
									</c:if>
								</div>
							</div>
							<div class="row map-height justify-content-center">
								<div class="col-9">
									<!-- 지도 -->
									<div class="map">
										<img class="mapValue"
											src="resources\assets\images\map_sample.png" alt="맵 이미지">
									</div>
								</div>
							</div>

							<div class="row  data-height justify-content-center">
								<div class="col-9 text-center">
									<!-- 주소, 전화번호 -->
									<div class="storeData">
										<div class="storeDataContent">
											<i class="fas fa-map"></i> <span>${storeData.storeDefaultAddress}
												<br> ${store.detail.address}
											</span>
											<button class="copy" value="${store.address} ${store.detail.address}">복사</button>
										</div>
										<div class="storeDataContent">
											<i class="fas fa-phone"></i> <span>${store.phone}</span>
											<button class="copy" value="${store.phone}">복사</button>
										</div>
									</div>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>

			<custom:footer />

		</div>


	</div>

	<!-- Scripts -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/browser.min.js"></script>
	<script src="assets/js/breakpoints.min.js"></script>
	<script src="assets/js/util.js"></script>
	<script src="assets/js/main.js"></script>

</body>
</html>