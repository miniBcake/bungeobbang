<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>

<head>
<!--bootstrap CDN코드-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<meta charset="UTF-8">
<title>회원탈퇴</title>
<link rel="stylesheet"
	href="/webapp/resources/assets/css/loginAndsign.css">
<link rel="stylesheet" href="/webapp/resources/assets/css/modal.css">
</head>

<body>
	<custom:header />
	<script src="setPW.js"></script>

	<!--bootstrap CDN코드-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	
	<form id="deleteMember.do" action="deleteMember.do" method="POST">
		<!--전체 컨테이너 시작-->
		<div class="container text-center">
			<br> <br> <br>
			<!--제목 : 회원탈퇴-->
			<h2>회원탈퇴</h2>
			<br> <br>

			<!-- 붕어빵 이미지-->
			<div class="col" style="text-align: center">
				<img src="/resources/assets/images/breadfishCat.jpg"
					class="breadfishCat">
				<!-- 회원탈퇴 시 개인정보 관련 안내-->
				<div class="input-container">
					${data.memberNickName}님 정말 회원탈퇴하시겠어요?<br> <br> '회원탈퇴'를 입력
					후 탈퇴버튼을 누르면<br> 적립한 포인트 등 개인정보가 모두 삭제됩니다<br> <br>
					개인정보를 다시 복구할 수 없으니 신중히 고려해주세요<br> 탈퇴 후 작성한 게시물과 댓글은 남아있으며, 삭제
					불가합니다.<br> <br>

					<!-- 회원탈퇴 문구 작성 및 탈퇴 요청버튼-->
					<div class="input-containerbox">
						<input type="text" class="inputbox" id="signOutText"
							placeholder="회원탈퇴">
						<button type="submit" class="btn btn-warning btn-lg" id="signOut">회원탈퇴
							요청</button>
					</div>
					<!-- 회원탈퇴 문구 작성 및 탈퇴 요청버튼 끝-->
					<br>
				</div>
				<!-- 회원탈퇴 시 개인정보 관련 안내 끝-->
				<br>
			</div>
			<!-- 붕어빵 이미지 끝 -->
			<br> <br> <br> <br> <br>
		</div>
	</form>
	<!--전체 컨테이너 끝-->
	<div>
		<custom:footer />
	</div>

	<script>
	//<!-- 회원탈퇴 버튼 초기에 hidden처리. 인풋값 입력해야 회원탈퇴 버튼 생성됨. -->
	//<!-- 비동기로 회원탈퇴 글자 입력되었는지 확인. 입력되었다면 회원탈퇴버튼 보여줌  --> 
	//<!-- 회원탈퇴 버튼 누르면 deleteMember.do로 이동
	
	// [1] 회원탈퇴 버튼 초기에는 hidden 처리
	// signOutButton변수 : 실행되는 현재 문서의 회원탈퇴버튼
    const signOutButton = document.querySelector('.btn-warning');
	signOutButton.style.display = 'none';//첫 화면에는 보이지 않음.
	
	// [2] signOut
	//현재 문서에서 기능 다 수행하고 마지막으로 이하 익명함수 실행
	$(document).ready(function() {
		//아이디값이 signOutText인 input에 값이 들어오면, 즉 공백에서 변경되면
		$('#signOutText').on('input', function() {
			var signOutText = $(this).val();
			console.log('signOutText : [' + signOutText + ']');

			// 비동기로 회원탈퇴 글자 입력되었는지 확인
            if (signOutText === '회원탈퇴') {
                signOutButton.style.display = 'block'; // 버튼 보이기
            } else {
                signOutButton.style.display = 'none'; // 버튼 숨기기
            }
        });
	</script>
</body>
</html>