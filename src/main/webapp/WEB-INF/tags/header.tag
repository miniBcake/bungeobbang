<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="header"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>


<!-- Bootstrap -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- font-awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<!-- Custom CSS -->
<link rel="stylesheet" href="${path}/resources/assets/css/header.css" />

<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=block" rel="stylesheet">

<!-- Header -->
<div class="header">
    <h1><c:out value="${title}" /></h1>
</div>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
   <div class="container-fluid">
      <!-- 사이드바 토글 버튼 -->
      <button id="toggleSidebar" class="btn btn-outline-secondary ml-auto">
         <i class="fas fa-bars"></i>
      </button>
      
      <!-- 로고 -->
		<a class="navbar-brand" href="mainPage.do" style="font-family: 'Nanum Pen Script', cursive;">
		    <img src="${path}/resources/assets/images/logo.png" alt="Logo" style="width: 40px; height: auto;">
		    갈빵질빵
		</a>

      <!-- 네비게이션 메뉴 -->
      <div class="collapse navbar-collapse" id="navbarNav">
         <ul class="navbar-nav ml-auto">
            <li class="nav-item">
               <a class="nav-link" href="mainPage.do">메인화면</a>
            </li>
            <li class="nav-item">
               <a class="nav-link" href="searchStore.do">붕어빵찾기</a>
            </li>
            <li class="nav-item">
               <a class="nav-link" href="listProduct.do">MD상품</a>
            </li>
            <li class="nav-item">
               <a class="nav-link" href="listBoards.do?boardCateName=normal">게시판</a>
            </li>
            <li class="nav-item">
               <a class="nav-link" href="insertStore.do">가게 제보</a>
            </li>

            <!-- 로그인/회원가입 or 프로필 이미지 표시 -->
            <c:choose>
               <c:when test="${empty memberPK}">
                  <li class="nav-item">
                     <a class="nav-link" href="signupPage.do">회원가입</a>
                  </li>
                  <li class="nav-item">
                     <a class="nav-link" href="login.do">로그인</a>
                  </li>
                  <li class="nav-item">
                     <img src="${path}/resources/assets/images/default_profile.png" class="rounded-circle" style="width: 40px; height: 40px;" alt="Default Profile">
                  </li>
               </c:when>
               <c:otherwise>
                  <li class="nav-item">
                     <img src="${profileImageUrl}" class="rounded-circle" style="width: 40px; height: 40px;" alt="Profile Image">
                  </li>
                  <li class="nav-item">
                     <a class="nav-link" href="logout.do">로그아웃</a>
                  </li>
               </c:otherwise>
            </c:choose>
         </ul>
      </div>
   </div>
</nav>

<!-- 사이드바 -->
<div id="sidebar" class="bg-light border-right" style="left: -250px; position: fixed; top: 0; height: 100%; width: 250px; transition: left 0.3s ease;">
   <div class="sidebar-header d-flex align-items-center justify-content-between px-3 py-2">
       <a class="navbar-brand d-flex align-items-center" href="mainPage.do" style="font-family: 'Nanum Pen Script', cursive;">
         <img src="${path}/resources/assets/images/logo.png" alt="Logo" style="width: 40px; height: auto; margin-right: 10px;">
         갈빵질빵
      </a>
      <!-- 사이드바 닫기 버튼 -->
      <button id="closeSidebar" class="btn btn-light">
         <i class="fas fa-times"></i> 	
      </button>
   </div>
   <ul class="navbar-nav">
      <li class="nav-item">
         <a class="nav-link" href="mainPage.do">메인화면</a>
      </li>
      <li class="nav-item">
         <a class="nav-link" href="searchStore.do">붕어빵찾기</a>
      </li>
      <li class="nav-item">
         <a class="nav-link" href="listProduct.do">MD상품</a>
      </li>
      <li class="nav-item">
         <a class="nav-link" href="listBoards.do?boardCateName=normal">게시판</a>
      </li>
      <li class="nav-item">
               <a class="nav-link" href="insertStore.do">가게 제보</a>
      </li>
      <c:choose>
         <c:when test="${empty memberPK}">
            <li class="nav-item">
               <a class="nav-link" href="signupPage.do">회원가입</a>
            </li>
            <li class="nav-item">
               <a class="nav-link" href="login.do">로그인</a>
            </li>
         </c:when>
         <c:otherwise>
            <li class="nav-item">
               <a class="nav-link" href="logout.do">로그아웃</a>
            </li>
         </c:otherwise>
      </c:choose>
   </ul>
</div>

<!-- Optional JavaScript for Bootstrap -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- 사이드바 스크립트 -->
<script>
    // 사이드바 토글
	document.getElementById("toggleSidebar").addEventListener("click", function() {
	    var sidebar = document.getElementById("sidebar");
	    var body = document.body;
	    
	    // 사이드바가 열려 있으면 닫고, 닫혀 있으면 여는 조건 처리
	    if (sidebar.style.left === "0px") {
	        sidebar.style.left = "-250px";  // 사이드바 닫기
	        body.style.marginLeft = "0";  // 본문 원래 위치로
	    } else {
	        sidebar.style.left = "0";  // 사이드바 열기
	        body.style.marginLeft = "250px";  // 본문을 오른쪽으로 밀기
	    }
	});


    // 사이드바 닫기
    document.getElementById("closeSidebar").addEventListener("click", function() {
        var sidebar = document.getElementById("sidebar");
        var body = document.body;

        sidebar.style.left = "-250px";  // 사이드바 닫기
        body.style.marginLeft = "0";  // 본문 원래 위치로
    });

    // 화면 크기가 일정 이하로 작아질 때 자동으로 사이드바 열기
    window.addEventListener("resize", function() {
        var sidebar = document.getElementById("sidebar");
        var body = document.body;

        // 화면이 768px 이하로 작아질 때 사이드바 자동 열기
        if (window.innerWidth <= 768) {
            sidebar.style.left = "0";  // 사이드바 열기
            body.style.marginLeft = "250px";  // 본문을 오른쪽으로 밀기
        } else {
            sidebar.style.left = "-250px";  // 사이드바 닫기
            body.style.marginLeft = "0";  // 본문 원래 위치로
        }
    });

    // 페이지가 로드될 때 화면 크기를 확인하고 초기 사이드바 상태 설정
    window.addEventListener("load", function() {
        var sidebar = document.getElementById("sidebar");
        var body = document.body;

        if (window.innerWidth <= 768) {
            sidebar.style.left = "0";  // 사이드바 열기
            body.style.marginLeft = "250px";  // 본문을 오른쪽으로 밀기
        } else {
            sidebar.style.left = "-250px";  // 사이드바 닫기
            body.style.marginLeft = "0";  // 본문 원래 위치로
        }
    });
</script>
