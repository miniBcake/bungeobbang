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
</head>
<body>

	<div class="container search-value">
	
	<custom:header/>
	
		<div class="row">
			<!-- 지도 부분 -->
			<div class="col-md-8">
				<div class="map" id="addressSearchMap">
					<img class="map-value" src="resources\assets\images\map_sample.png"
						alt="맵 이미지">
				</div>
			</div>

			<!-- 주소 검색 창 -->
			<div class="col-md-4 searchContainer">

				<form action="주소 검색 창">
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
				</form>

				<div class="row">
					<div class="col-12">
						<!-- 결과 부분 -->
						<div class="scroll-container">
							<div class="storeData">
								<div class="storeDataTitle">
									<h4>{store.name}</h4>
								</div>
								<div class="storeDataContent">
									<img class="icon"
										src="resources\assets\images\address_icon.png" alt="주소 아이콘">
									<span>{store.address} <br> {store.detail.address}
									</span>
									<button class="copy" id="copy">복사</button>
								</div>
								<div class="storeDataContent">
									<img class="icon"
										src="resources\assets\images\address_icon.png" alt="전화번호 아이콘">
									<span>{store.phone}</span>
									<button class="copy" id="copy">복사</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<custom:footer/>
	</div>
</body>
</html>