<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="customStore" tagdir="/WEB-INF/tags/store"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML>

<html>
<head>
<title>가게 목록</title>
<meta charset="utf-8" />
<link rel="stylesheet" href="${path}/resources/assets/css/main.css">
<link rel="stylesheet" href="${path}/resources/assets/css/searchbar.css">
<link rel="stylesheet"
	href="${path}/resources/assets/css/searchvalue.css">
<link rel="stylesheet"
	href="${path}/resources/assets/css/pagination.css">

<!-- bootstrap -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<!-- 맵을 그리기 위한 script -->
<!-- appkey에 발급받은 APP KEY를 넣음 -->
<!-- 추가 기능 사용 시 &libraries=services 코드 추가(주소를 좌표로) -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c29b2d7f614a4d9b5ef9ee4c2ec83a48&libraries=services"></script>

<!-- js를 쓰므로 jquery 사용 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 외부 script 파일 사용 -->
<script src="${path}/resources/assets/js/store/storeList.js"></script>
<script src="${path}/resources/assets/js/store/copy.js"></script>
<script src="${path}/resources/assets/js/map/imageMap.js"></script>


</head>
<body>
	<div id="page-wrapper">

		<!-- Header 커스터 태그 -->

		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
			crossorigin="anonymous">
			
		</script>

		<custom:header />

		<div class="container">

			<!-- container01 : 1행 1열-->
			<div class="row">
				<div class="col-12">
					<!-- 검색창 -->
					<form action="filterSearchStore.do">
						<div class="container">
							<!-- container02 : 1행-->
							<!-- 가게명 검색 -->
							<div class="row align-items-center row-gap">
								<!-- container02 : 1행 1열-->
								<div class="col-sm-2 col-md-2">
									<div class="category" id="categoryName">가게명 검색</div>
								</div>
								<!-- container02 : 1행 2열-->
								<div class="col-10 col-md-10">
									<%--<custom:searchbar placeholder="가게 이름을 입력해 주세요." />--%>
								</div>
							</div>

							<!-- 필터 조건들 출력 부분 -->
							<div class="row align-items-center row-gap">
								<div class="col-sm-2 col-md-2">
									<!-- 필터 조건들을 2번째 열에 출력하기 위한 빈 공간 -->
								</div>
								<div class="col-10 col-md-10">
									<div id=tagBox></div>
									<hr>
								</div>
							</div>

							<!-- 가게 메뉴 -->
							<div class="row align-items-center row-gap">
								<div class="col-sm-2 col-md-2">
									<div class="category" id="categoryMenu">가게 메뉴</div>
								</div>
								<div class="col-10 col-md-10">
									<div class="row">
										<custom:categoryKeyword name="storeMenu" value="MENU_NORMAL" id="">팥/슈크림<span>
												(${menuCnt.storeMenuNormalCnt})</span>
										</custom:categoryKeyword>
										<custom:categoryKeyword name="storeMenu" value="MENU_VEG"
											id="">야채/김치/만두<span> (${menuCnt.storeMenuVegCnt})</span>
										</custom:categoryKeyword>
										<custom:categoryKeyword name="storeMenu" value="MENU_MINI" id="">미니 붕어빵<span>
												(${menuCnt.storeMenuMiniCnt})</span>
										</custom:categoryKeyword>
										<custom:categoryKeyword name="storeMenu" value="MENU_POTATO" id="">고구마<span>
												(${menuCnt.storeMenuPotatoCnt})</span>
										</custom:categoryKeyword>
										<custom:categoryKeyword name="storeMenu" value="MENU_ICE"
											id="">아이스크림/초코<span> (${menuCnt.storeMenuIceCnt})</span>
										</custom:categoryKeyword>
										<custom:categoryKeyword name="storeMenu" value="MENU_CHEESE" id="">치즈<span>
												(${menuCnt.storeMenuCheeseCnt})</span>
										</custom:categoryKeyword>
										<custom:categoryKeyword name="storeMenu" value="MENU_PASTRY" id="">페스츄리<span>
												(${menuCnt.storeMenuPastryCnt})</span>
										</custom:categoryKeyword>
										<custom:categoryKeyword name="storeMenu" value="MENU_OTHER" id="">기타<span>
												(${menuCnt.storeMenuOtherCnt})</span>
										</custom:categoryKeyword>
									</div>
								</div>
							</div>

							<!-- 결제방법 -->
							<div class="row align-items-center row-gap">
								<div class="col-sm-2 col-md-2">
									<div class="category" id="categoryPayment">결제 방법</div>
								</div>
								<div class="col-10 col-md-10">
									<div class="row">
										<custom:categoryKeyword name="storePayment" value="PAYMENT_CASHMONEY" id="">현금결제<span>
												(${paymentCnt.storePaymentCashmoneyCnt})</span>
										</custom:categoryKeyword>
										<custom:categoryKeyword name="storePayment" value="PAYMENT_CARD" id="">카드결제<span>
												(${paymentCnt.storePaymentCardCnt})</span>
										</custom:categoryKeyword>
										<custom:categoryKeyword name="storePayment" value="PAYMENT_ACCOUNT" id="">계좌이체<span>
												(${paymentCnt.storePaymentAccountCnt})</span>
										</custom:categoryKeyword>
									</div>
								</div>
							</div>

							<!-- 운영상태 -->
							<div class="row align-items-center row-gap">
								<div class="col-sm-2 col-md-2">
									<div class="category" id="categoryState">운영 상태</div>
								</div>
								<div class="col-10 col-md-10">
									<div class="row">
										<custom:categoryKeyword name="storeClosed" value="Y" id="">영업중인 가게만 보기</custom:categoryKeyword>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<hr>
			</div>

			<!-- container01 : 2행 1열-->
			<div class="row align-items-center">
				<div class="searchValue">
					<div class="col-6 text-center nonePadding fullWidthHeight">
						<!-- 검색 결과 출력 부분-->
						<div class="map" id="map"></div>
					</div>
					<div class="col-6 text-center">
						<div class="storeList">
							<c:forEach var="data" items="${datas}">
								<customStore:simpleStoreData />
							</c:forEach>
						</div>
					</div>
				</div>
			</div>

			<!-- container01 : 3행 1열 -->
			<div class="row ">
				<div class="col-12">
					<!-- 페이지네이션 -->
					<section id="pagination">
						<div class="pagination">
							<!-- 이전 페이지 버튼 -->
							<c:if test="${currentPage > 1}">
								<a
									href="?page=${currentPage - 1}&storeName=${param.storeName != null ? param.storeName : ''}"
									id="pagenationPreValue">&laquo; 이전</a>
							</c:if>

							<c:set var="startPage" value="${currentPage - 5}" />
							<c:set var="endPage" value="${currentPage + 4}" />

							<c:if test="${startPage < 1}">
								<c:set var="startPage" value="1" />
							</c:if>
							<c:if test="${endPage > totalPages}">
								<c:set var="endPage" value="${totalPages}" />
							</c:if>

							<c:forEach var="i" begin="${startPage}" end="${endPage}">
								<c:choose>
									<c:when test="${i == currentPage}">
										<strong>${i}</strong>
									</c:when>
									<c:otherwise>
										<a
											href="?page=${i}&storeName=${param.storeName != null ? param.storeName : ''}"
											class="pagenationValue">${i}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>

							<c:if test="${currentPage < totalPages}">
								<a
									href="?page=${currentPage + 1}&storeName=${param.storeName != null ? param.storeName : ''}"
									id="pagenationNextValue">다음 &raquo;</a>
							</c:if>
						</div>
					</section>
					<!-- 페이지네이션 종료 -->
				</div>
			</div>
		</div>

	</div>

	<!-- footer 커스텀 태그 -->
	<custom:footer />

	<script>
		
	</script>
</body>
</html>
