<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="boardSideBar" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<meta charset="UTF-8">
<title>마이 페이지</title>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style type="text/css">
/* 두, 세번째 열의 테두리 없애기 */
.table td:nth-child(2), .table td:nth-child(3) {
	border: none;
}
/* 예시 CSS */
#image {
	max-width: 80%; /* 이미지 크기 조정 */
}
</style>
<link rel="stylesheet" href="${path}/resources/assets/css/main.css">
<link rel="stylesheet" href="${path}/resources/assets/css/header.css">
<link rel="stylesheet" href="${path}/resources/assets/css/myPage.css">

</head>

<body>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="${path}/resources/assets/js/member/mypageUpdate.js"></script>
	<custom:header />
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<div class="container text-center">
		<br> <br> <br>
		<h2>마이 페이지 수정</h2>
		<br> <br>
		<form id="submitBtn" action="updateProfile.do" method="POST">
			<!--개인정보&사이드바 행-->
			<div class="row align-items-start justify-content-center">
				<br> <br>
				<!--1열 프로필 이미지 미리보기 및 수정버튼-->

				<div class="col-md-4" style="text-align: center;">
					<span class="col-2"> <br> <br> <!-- 프로필 사진 미리보기 -->
						<img id="previewImage" alt="프로필사진 미리보기" class="signupimg"
						src="${not empty member.memberProfileway ? memberDTO.memberProfileway : '${path}/resources/assets/images/breadfishProfile.jpg'}"
						style="display: block;">
					</span> <br>

					<!-- 프로필 사진 변경 버튼 -->
					<div class="col-10" style="text-align: right;">
						<label for="file" style="cursor: pointer;"> <svg
								xmlns="http://www.w3.org/2000/svg" width="16" height="16"
								fill="currentColor" class="bi bi-upload" viewBox="0 0 16 16">
                			<path
									d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5" />
                				<path
									d="M7.646 1.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 2.707V11.5a.5.5 0 0 1-1 0V2.707L5.354 4.854a.5.5 0 1 1-.708-.708z" />
            				</svg> <input type="file" id="file" name="file"
							style="display: none;" onchange="a(event)">
						</label>
					</div>
					<br> <br>
					<div>
						<h4>Point &nbsp; &nbsp; &nbsp;
							${member.paymentAmount}</h4>
						<br>
						<button type="submit" class="btn btn-primary">수정 완료</button>
						<!-- 회원정보 업데이트 -->
						<a href="javascript:history.back()" class="btn btn-danger"
							role="button">취소</a>
						<!-- 마이페이지로 -->
					</div>
				</div>

				<!-- 회원정보 테이블 -->
				<div class="col-md-5">
					<br> <br> <br> <br>
					<table class="table">
						<tr>
							<td class="underline">이메일</td>
							<td><input type="email" class="inputbox" id="email"
								name="email" value="${memberDTO.memberEmail}"
								placeholder="이메일 입력해주세요"
								pattern="/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9 \-]+\.[A-za-z0-9\-]+/"></td>
							<td><button class="btn btn-light" id="checkEmailBtn">중복검사</button></td>
						</tr>
						<tr>
							<td class="underline">이름</td>
							<td><input type="text" class="inputbox" id="name"
								name="name" value="${memberDTO.memberEmail}"
								placeholder="이름 입력해주세요"></td>
						</tr>
						<tr>
							<td class="underline">닉네임</td>
							<td><input type="text" class="inputbox" id="nickname"
								name="nickName" value="${memberDTO.memberNickname}"
								placeholder="닉네임 입력해주세요"></td>
							<td><button class="btn btn-light" id="checkNicknameBtn">중복검사</button></td>
						</tr>
						<tr>
							<td class="underline">전화번호</td>
							<td><input type="tel" class="inputbox" id="phoneNum"
								value="${memberDTO.memberPhone}"
								pattern=" /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/"
								placeholder="전화번호 입력해주세요"></td>
						</tr>
						<!-- 주소 기입 여부 따라 사용자에게 보여주기 -->
						<c:if test="${not empty memberDTO.memberAdress}">
							<tr>
								<td class="underline">주소</td>
								<td><input type="text" class="inputbox"
									placeholder="주소 입력해주세요"></td>
								<td><button>주소검색</button></td>
							</tr>
						</c:if>
						<tr>
							<td class="underline">비밀번호</td>
							<td><input type="password" class="inputbox"
								id="mypagePassword" value="${memberDTO.password}"
								placeholder="영문,숫자,특수문자 포함해 입력해주세요"
								pattern="^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$"></td>
						</tr>
					</table>
				</div>

				<!--3열 사이드바-->
				<div class="col-md-3">
					<custom:boardSideBar />
				</div>
			</div>
		</form>
		<div>
			<br> <br> <br> <br> <br>
			<custom:footer />
		</div>
	</div>
</body>
</html>