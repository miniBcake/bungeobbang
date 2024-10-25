<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<title>갈빵질빵 - 메뉴 목록 보기</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="${path}/resources/assets/css/productList.css" />
	<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
</head>
<body>
    <!-- 헤더 -->
    <custom:header />
    <div class="container mt-5">
   	<%
		Object myPoint = application.getAttribute("userPoint");
		if (myPoint == null) {
		         myPoint = 0; // 기본값 설정
		}
	 %>
		<div class="d-flex justify-content-end">
		    <button id="pointButton" class="btn btn-outline-primary">내 포인트 보기</button>
		</div>
		<div class="d-flex justify-content-end">
			<div id="pointPopup" class="popup">
			    <div class="popup-content">
			        <button class="close-popup">&times;</button>
			        <p id="pointValue"><strong><%= myPoint %></strong>Point</p>
			    </div>
			</div>
		</div>
        
        <!-- 상품 카테고리 버튼 -->
		<div class="category-buttons">
		    <c:forEach var="category" items="${productCategory}">
		        <a href="loadListProduct.do?categoryNum=${category.productCateNum}" 
		           class="category-link">${category.productCateName}</a>
		    </c:forEach>
		</div>

		<!-- 검색 섹션 -->
		<form action="loadListProduct.do" method="GET">
		    <div class="search-container">
		    	<input type="hidden" name="searchCondition" id="conditionInput" value="SELECT_PART_TITLE">
		        <div class="search-box">
		            <input type="text" class="form-control" id="searchInput" placeholder="검색 옵션을 열려면 클릭하세요" readonly>
		            <button class="btn btn-dark" id="searchButton">검색</button>
		        </div>
		        <div class="selected-options mt-3" id="selectedOptions"></div>
		                
		        <div class="search-options" id="searchOptions" style="display: none;">
		            <div class="filter-section mt-3">
		                <h5>검색 키워드 입력</h5>
		                <input type="text" class="form-control" id="searchKeywordInput" name="keyword" placeholder="검색할 키워드를 입력하세요">
		                
		                <h5 class="mt-4">검색 설정</h5>
		                <div class="form-check">
		                    <input class="form-check-input" type="radio" name="searchCategory" value="TITLE" id="searchTitle" checked>
		                    <label class="form-check-label" for="searchTitle">제목</label>
		                </div>
		                <div class="form-check">
		                    <input class="form-check-input" type="radio" name="searchCategory" value="CONTENT" id="searchContent">
		                    <label class="form-check-label" for="searchContent">상품명</label>
		                </div>
		            </div>
		
		            <div class="price-section mt-4">
		                <h5>가격 설정</h5>
		                <div id="minPriceWarning" style="display:none; color: red;">최소 가격은 0 이상이어야 합니다.</div>
		                <div class="input-group mb-2">
		                    <div class="input-group-prepend">
		                        <span class="input-group-text">최소</span>
		                    </div>
		                    <input type="number" class="form-control" id="minPrice" name="minPrice" placeholder="최소 가격 입력" min="0" value="0">
		                </div>
		                <div id="maxPriceWarning" style="display:none; color: red;">최대 가격은 최소 가격보다 크거나 같아야 합니다.</div>
		                <div class="input-group mb-2">
		                    <div class="input-group-prepend">
		                        <span class="input-group-text">최대</span>
		                    </div>
		                    <input type="number" class="form-control" id="maxPrice" name="maxPrice" placeholder="최대 가격 입력">
		                </div>
		            </div>
		
					<div class="category-section mt-4">
					    <h5>카테고리 설정</h5>
					    <select class="form-control" id="categorySelect" name="categoryNum">
					        <option value="">전체 카테고리</option>
					        <!-- 카테고리 목록을 동적으로 생성 -->
					        <c:forEach var="category" items="${productCategory}">
					            <option value="${category.productCateNum}">
					                ${category.productCateName}
					            </option>
					        </c:forEach>
					    </select>
					</div>
		        </div>   
		    </div>
		</form>



		<section id="content">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<!-- Main Content -->
						<section>
							<h2>필터링된 상품 목록</h2>
							<!-- 예시 사진 -->
							<c:forEach var="product" items="${productList}">
								<div class="product-item">
									<c:choose>
										<c:when test="${not empty product.productProfileWay}">
											<a href="infoProduct.do?productNum=${product.productNum}"
												class="bordered-feature-image"> <img
												src="${product.productProfileWay}"
												alt="${product.productName}"
												style="width: 300px; height: 300px; object-fit: cover; border-radius: 8px; margin: 10px 0;"
												class="thumbnail-image" />
											</a>
										</c:when>

										<c:otherwise>
											<a href="infoProduct.do?productNum=${product.productNum}"
												class="bordered-feature-image"> <img
												src="assets/images/default.png" alt="${product.productName}"
												class="thumbnail-image" />
											</a>
										</c:otherwise>
									</c:choose>
									<span>제목: ${product.boardTitle}</span><br> 
									<span>카테고리: ${product.productCateName}</span><br> 
									<span>상품명:${product.productName}</span><br> 
									<span>가격: ${product.productPrice}원</span>
								</div>
								<hr>
							</c:forEach>

							<!-- 이전 페이지 버튼 -->
							<c:if test="${page > 1}">
							    <a href="?page=${page - 1}
							            &categoryNum=${param.categoryNum}
							            &minPrice=${minPrice}
							            &maxPrice=${maxPrice}
							            &searchCondition=${searchCondition}
							            &keyword=${keyword}">
							        &laquo; 이전
							    </a>
							</c:if>
							
							<!-- 페이지 번호 -->
							<c:forEach var="i" begin="1" end="${pageCount}">
							    <c:choose>
							        <c:when test="${i == page}">
							            <strong>${i}</strong>
							        </c:when>
							        <c:otherwise>
							            <a href="?page=${i}
							                    &categoryNum=${param.categoryNum}
							                    &minPrice=${minPrice}
							                    &maxPrice=${maxPrice}
							                    &searchCondition=${searchCondition}
							                    &keyword=${keyword}">
							                ${i}
							            </a>
							        </c:otherwise>
							    </c:choose>
							</c:forEach>
							
							<!-- 다음 페이지 버튼 -->
							<c:if test="${page < pageCount}">
							    <a href="?page=${page + 1}
							            &categoryNum=${param.categoryNum}
							            &minPrice=${minPrice}
							            &maxPrice=${maxPrice}
							            &searchCondition=${searchCondition}
							            &keyword=${keyword}">
							        다음 &raquo;
							    </a>
							</c:if>
						</section>
					</div>
				</div>
			</div>
		</section>

        <!-- 푸터 -->
        <custom:footer />

        <!-- 스크립트 -->
        <script src="${path}/resources/assets/js/jquery.min.js"></script>
        <script src="${path}/resources/assets/js/browser.min.js"></script>
        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="${path}/resources/assets/js/product/productList.js"></script>
    </div>
</body>
</html>
