<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>갈빵질빵 - 상품 자세히 보기</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <link rel="stylesheet" href="${path}/resources/assets/css/productDetail.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap" rel="stylesheet">
</head>
<body>

   <!-- Header -->
   <custom:header />
	<div class="product-page">
	   <section id="content" class="container mt-5">
	      <div class="row">
	         <div class="col-md-6">
	            <div class="product-images">
	               <c:choose>
	                  <c:when test="${not empty product.productProfileWay}">         
	                     <img src="${product.productProfileWay}"
	                          alt="${product.productName}" class="thumbnail-image" />
	                  </c:when>
	                  <c:otherwise>
	                     <img src="assets/images/default.png" 
	                          alt="${product.productName}"
	                          class="thumbnail-image"/>
	                  </c:otherwise>
	               </c:choose>
	            </div>
	         </div>
	
	         <div class="col-md-4">
	            <!-- 상품 정보 -->
				<div class="product-info mb-4 card p-4 shadow-sm">
				    <h4 class="card-title mb-3" style="font-family: 'Gamja Flower', sans-serif;">상품 정보</h4>
				    <div class="row mb-2">
				        <div class="col-3 font-weight-bold">소개</div>
				        <div class="col-9">${product.boardTitle}</div>
				    </div>
				    <div class="row mb-2">
				        <div class="col-3 font-weight-bold">상품명</div>
				        <div class="col-9">${product.productName}</div>
				    </div>
				    <div class="row mb-2">
				        <div class="col-3 font-weight-bold">가격</div>
				        <div class="col-9">${product.productPrice}원</div>
				    </div>
				    <div class="row">
				        <div class="col-3 font-weight-bold">상세 설명</div>
				        <div class="col-9">${product.boardContent}</div>
				    </div>
				</div>
	
	
	            <!-- 수량 선택 -->
	            <div class="quantity-section mb-4">
	                <h5>수량 선택</h5>
	                <select id="quantity" class="form-control" style="width: 100px;">
	                    <option value="1">1</option>
	                    <option value="2">2</option>
	                    <option value="3">3</option>
	                    <option value="4">4</option>
	                    <option value="5">5</option>
	                </select>
	            </div>
	
	            <!-- 버튼 -->
	            <div class="btn-section">
	            	<input type="hidden" id="productNum" name="productNum" value="${product.productNum}">
	                <button id="addToCartBtn" class="btn btn-primary mb-2">구매하기</button>
	                <form action="goToCart.do" method="POST" id="goToCartForm">
	                    <button type="submit" class="btn btn-secondary">장바구니로 가기</button>
	                </form>
	            </div>
	         </div>
	      </div>
	   </section>
	</div>
   <!-- Footer -->
   <custom:footer />

   <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
   <script src="${path}/resources/assets/js/jquery.min.js"></script>
   <script src="${path}/resources/assets/js/browser.min.js"></script>
   <script src="${path}/resources/assets/js/util.js"></script>
   <script src="${path}/resources/assets/js/product/productDetail.js" defer></script>
</body>
</html>
