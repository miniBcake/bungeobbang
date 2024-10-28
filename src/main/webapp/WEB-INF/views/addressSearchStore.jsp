<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<!-- css 변경을 위한 캐시 방지 -->
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">


<meta charset="UTF-8">
<title>가게 주소 검색</title>

<link rel="stylesheet" href="${path}/resources/assets/css/main.css">
<link rel="stylesheet" href="${path}/resources/assets/css/searchbar.css">
<link rel="stylesheet"
	href="${path}/resources/assets/css/searchvalue.css">

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
<script src="${path}/resources/assets/js/storeList.js"></script>
<script src="${path}/resources/assets/js/store/copy.js"></script>
<script src="${path}/resources/assets/js/map/printMap.js"></script>

</head>
<body>

		<custom:header />

	<div class="container">

		<div class="row">
			<!-- 지도 부분 -->
			<div class="col-12 col-md-8 nonePadding fullWidthHeight">
				<div class="fullMap" id="addressSearchMap"></div>
			</div>

			<!-- 주소 검색 창 -->
			<div class="col-12 col-md-4 mapSearchContainer">

				<div class="col-12 ">
					<!-- 검색 부분 -->

					<div class="row row-gap">
						<div class="col-12 text-center">
							<!-- 제목 -->
							<h4>주소 검색</h4>
						</div>
					</div>
					<div class="row row-gap">
						<div class="col-12 text-center">
							<!-- 주소 select-->
							<select name="address1">
								<option value="서울시">서울시</option>
								<option value="부산시">부산시</option>
							</select>
							<!-- 구 주소-->
							<select name="address2">
								<option value="강남구">강남구</option>
								<option value="동작구">동작구</option>
							</select>
						</div>
					</div>
					<div class="row row-gap">
						<div class="col-12">
							<!-- 입력 부분 -->
							<div class="searchInput">
								<img src="resources/assets/images/search_icon.png"
									alt="검색창 아이콘 이미지" width="40px" height="40px"> <input
									type="text" name="storeName" placeholder="가게 이름을 입력해주세요.">
								<input type="submit" value="검색">
							</div>
							<hr>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-12">
						<!-- 결과 부분 -->
						<div class="scroll-container">
							<custom:simpleStoreData />
						</div>
					</div>
				</div>
			</div>
		</div>
		<br>
		<custom:footer />
	</div>
</body>
</html>