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
<link rel="stylesheet" href="${path}/resources/assets/css/main.css" />
<link rel="stylesheet" href="${path}/resources/assets/css/productDetail.css" />

</head>
<body>

   <!-- Header -->
   <custom:header />

   <section id="content">
      <div class="container">
         <div class="row">
            <div class="col-12">
               <!-- Main Content -->
               <section>
                  <h2>상품 상세 정보</h2>

                  <div class="product-detail">
                  <!-- 비동기요청을 하기 위해서 -->
                   <input type="hidden" id="productNum" name="productNum" value="${product.productNum}">
                     <p>
                        <strong>게시글 제목:</strong> ${product.boardTitle}
                     </p>

                     <div class="product-images">
                        <!-- 상품 이미지가 있는지 확인 -->
                        <c:choose>
                           <c:when test="${not empty product.productProfileWay}">         
                              <a href="viewProduct.do?productNum=${product.productNum}"
                                 class="bordered-feature-image"> 
                                 <img src="${product.productProfileWay}"
                                 alt="${product.productName}" class="thumbnail-image" />
                              </a>
                           </c:when>

                           <c:otherwise>
                              <a href="viewProduct.do?productNum=${product.productNum}"
                                 class="bordered-feature-image"> 
                                 <img src="assets/images/default.png" 
                                 	  alt="${product.productName}"
                                      class="thumbnail-image"/>
                              </a>
                           </c:otherwise>
                        </c:choose>

                        <!-- 나머지 사진이 있는지 확인하고 나머지 사진 출력 -->
                        <div class="gallery">
                           <c:forEach var="image" items="${images}"
                              varStatus="status">
                              <!-- 첫 번째 사진을 제외하고 나머지 사진 출력 -->
                              <img src="${image.imageWay}" alt="${product.productName} 추가 이미지"
                                 class="gallery-image"/>
                           </c:forEach>
                        </div>
                     </div>

                     <p>
                        <strong>상품명:</strong> ${product.productName}
                     </p>
                     <p>
                        <strong>가격:</strong> ${product.productPrice}원
                     </p>
                     <p>
                        <strong>상세 설명:</strong>
                     </p>
                     <p>${product.boardContent}</p>

                     <!-- 수량 선택 옵션 -->
                     <div>
                        <label for="quantity">수량 선택: </label>
                        <select id="quantity" class="form-control" style="width: 100px; display: inline-block;">
                           <option value="1">1</option>
                           <option value="2">2</option>
                           <option value="3">3</option>
                           <option value="4">4</option>
                           <option value="5">5</option>
                        </select>
                     </div>

                     <!-- 구매하기 버튼 -->
                     <button id="addToCartBtn" class="btn btn-primary" style="margin-top: 10px;">구매하기</button>

                     <!-- 장바구니로 가기 버튼 (비동기 요청 후 보여지도록 설정) -->
                     <form action="goToCart.do" method="POST" id="goToCartForm" style="display: none; margin-top: 10px;">
                        <button type="submit" class="btn btn-secondary">장바구니로 가기</button>
                     </form>
                  </div>
               </section>
            </div>
         </div>
      </div>
   </section>

   <!-- Footer -->
   <custom:footer />

   <script src="${path}/resources/assets/js/jquery.min.js"></script>
   <script src="${path}/resources/assets/js/browser.min.js"></script>
   <script src="${path}/resources/assets/js/util.js"></script>
   <script src="${path}/resources/assets/js/product/productDetail.js" defer></script>
</body>
</html>
