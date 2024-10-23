<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML>
<html>
<head>
    <title>갈빵질빵 - 상품 목록 페이지</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${path}/resources/assets/css/productList.css" />
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
</head>

<body>
    <!-- 헤더 -->
    <custom:header />
    <div class="container mt-5">
		<div class="d-flex justify-content-end">
		    <button id="pointButton" class="btn btn-outline-primary">내 포인트 보기</button>
		</div>
		<div class="d-flex justify-content-end">
		    <div id="pointPopup" class="popup">
		        <div class="popup-content">
		            <button class="close-popup">&times;</button>
		            <p id="pointValue"><strong>0</strong> Point</p>
		        </div>
		    </div>
		</div>

        
        <!-- 상품 카테고리 버튼 -->
        <div class="category-buttons">
            <a href="searchProductMD.do?productCateName=stationery" class="category-link">문구류</a> 
            <a href="searchProductMD.do?productCateName=accessory" class="category-link">악세사리</a> 
            <a href="searchProductMD.do?productCateName=daily" class="category-link">생활용품</a> 
            <a href="searchProductMD.do?productCateName=clothes" class="category-link">의류</a> 
            <a href="searchProductMD.do?productCateName=electronics" class="category-link">전자기기</a>
        </div>

		<!-- 검색 섹션 -->
		<form action="searchProductMD.do" method="GET">
		    <div class="search-container">
		        <div class="search-box">
		            <input type="text" class="form-control" id="searchInput" placeholder="검색 옵션을 열려면 클릭하세요" readonly>
		            <button class="btn btn-dark" id="searchButton">검색</button>
		        </div>
		        <div class="selected-options mt-3" id="selectedOptions"></div>
		                
		        <div class="search-options" id="searchOptions" style="display: none;">
		            <div class="filter-section mt-3">
		                <h5>검색 키워드 입력</h5>
		                <input type="text" class="form-control" id="searchKeywordInput" name="searchKeyword" placeholder="검색할 키워드를 입력하세요">
		                
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
		                <select class="form-control" id="categorySelect" name="productCateName">
		                    <option value="">전체 카테고리</option>
		                    <option value="stationery">문구류</option>
		                    <option value="accessory">악세사리</option>
		                    <option value="daily">생활용품</option>
		                    <option value="clothes">의류</option>
		                    <option value="electronics">전자기기</option>
		                </select>
		            </div>
		        </div>   
		    </div>
		</form>
	 
	<!-- 추천 상품 섹션 -->
	<section id="recommend-products-section">
	    <div class="container">
	        <div class="recommend-products">
	            <c:choose>
	                <c:when test="${not empty recommendedProducts}">
	                    <h2>추천 상품</h2>
	                    <div class="swiper-container swiper-recommend">
	                        <div class="swiper-wrapper">
	                            <c:forEach var="product" items="${recommendedProducts}">
	                                <div class="swiper-slide">
	                                    <div class="product-card">
	                                        <div class="product-row">
	                                            <div class="product-image">
	                                                <img src="${product.productProfileWay}" alt="상품 이미지" />
	                                            </div>
	                                            <div class="product-title">
	                                                <p>${product.productName}</p>
	                                            </div>
	                                        </div>
	                                        <div class="product-row">
	                                            <span>${product.productPrice}원</span>
	                                            <button class="btn btn-primary">
	                                                <a href="viewProduct.do?productNum=${product.productNum}" class="text-white text-decoration-none">상품 보러 가기</a>
	                                            </button>
	                                        </div>
	                                    </div>
	                                </div>
	                            </c:forEach>
	                        </div>
	                        <div class="swiper-pagination swiper-recommend-pagination"></div>
	                    </div>
	                    <div class="swiper-navigation">
	                        <button class="swiper-button-prev swiper-recommend-prev"></button>
	                        <button class="swiper-button-next swiper-recommend-next"></button>
	                    </div>
	                </c:when>
	                <c:otherwise>
	                    <h2>상품을 구경하시면 상품을 추천해드립니다.</h2>
	                    <a href="searchProductMD.do" class="btn btn-outline-primary">전체 상품 보러가기</a>
	                </c:otherwise>
	            </c:choose>
	        </div>
	    </div>
	</section>
	
	<!-- 최근에 본 상품 섹션 -->
	<section id="recent-products-section">
	    <div class="container">
	        <div class="recent-products">
	            <c:choose>
	                <c:when test="${not empty resentProducts}">
	                    <h2>최근에 본 상품</h2>
	                    <div class="swiper-container swiper-recent">
	                        <div class="swiper-wrapper">
	                            <c:forEach var="product" items="${resentProducts}">
	                                <div class="swiper-slide">
	                                    <div class="product-card">
	                                        <div class="product-row">
	                                            <div class="product-image">
	                                                <img src="${product.productProfileWay}" alt="상품 이미지" />
	                                            </div>
	                                            <div class="product-title">
	                                                <p>${product.productName}</p>
	                                            </div>
	                                        </div>
	                                        <div class="product-row">
	                                            <span>${product.productPrice}원</span>
	                                            <button class="btn btn-primary">
	                                                <a href="viewProduct.do?productNum=${product.productNum}" class="text-white text-decoration-none">상품 보러 가기</a>
	                                            </button>
	                                        </div>
	                                    </div>
	                                </div>
	                            </c:forEach>
	                        </div>
	                        <div class="swiper-pagination swiper-recent-pagination"></div>
	                    </div>
	                    <div class="swiper-navigation">
	                        <button class="swiper-button-prev swiper-recent-prev"></button>
	                        <button class="swiper-button-next swiper-recent-next"></button>
	                    </div>
	                </c:when>
	                <c:otherwise>
	                    <h2>최근에 본 상품이 없습니다.</h2>
	                    <p>다양한 상품을 검색해보세요!</p>
						<div class="empty-photo-album">
						    <div class="photo-album">
						        <c:forEach var="index" begin="1" end="16">
						            <c:choose>
						                <c:when test="${index % 2 == 0}">
						                    <img src="${pageContext.request.contextPath}/resources/assets/images/image${index}.png" 
						                         alt="이미지 ${index}" 
						                         class="stacked-photo even" 
						                         style="--index: ${index};">
						                </c:when>
						                <c:otherwise>
						                    <img src="${pageContext.request.contextPath}/resources/assets/images/image${index}.png" 
						                         alt="이미지 ${index}" 
						                         class="stacked-photo odd" 
						                         style="--index: ${index};">
						                </c:otherwise>
						            </c:choose>
						        </c:forEach>
						    </div>
						</div>
	                </c:otherwise>
	            </c:choose>
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
