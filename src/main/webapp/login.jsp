<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://accounts.google.com/gsi/client" async defer></script>
<script type="text/javascript" src="assets/js/loginGoogleAPI.js" defer></script>



<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="/resources/assets/css/loginAndsign.css">
<link rel="stylesheet" href="/resources/assets/css/modal.css">
</head>
<body>
	<custom:header />

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>

	<div class="container text-center">
		<br> <br> <br>
		<h2>로그인</h2>
		<br> <br>
		<div class="row align-items-start">
			<div class="col" style="text-align: right;">
				<img src="\resources\assets\images\breadfishmiddle.jpg" class="img">
			</div>

			<!--2열 : 절취선-->
			<div class="line">
				<div class="d-flex">
					<div class="vr"></div>
				</div>
				<div class="d-flex">
					<div class="vr"></div>
				</div>
				<div class="d-flex">
					<div class="vr"></div>
				</div>
				<div class="d-flex">
					<div class="vr"></div>
				</div>
				<div class="d-flex">
					<div class="vr"></div>
				</div>
			</div>
			<div class="col" style="text-align: left;">
				<div class="input-container">
					<span class="label">Email address</span>
					<div class="input-containerbox">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
							fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
                            <path
								d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z" />
                        </svg>
						<input type="email" class="inputbox" placeholder="이메일을 입력해주세요">
					</div>
					<br> <span class="label">Password</span>
					<div class="input-containerbox">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
							fill="currentColor" class="bi bi-lock" viewBox="0 0 16 16">
                            <path
								d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2m3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2M5 8h6a1 1 0 0 1 1 1v5a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V9a1 1 0 0 1 1-1" />
                        </svg>
						<input type="password" class="inputbox" placeholder="비밀번호를 입력해주세요">
					</div>
					<a href="#" style="text-align: left" data-bs-target="#forgetModal"
						data-bs-toggle="modal">비밀번호를 잊어버리셨나요?</a>
				</div>
				<br>
				<div class="d-grid gap-2 col-mx-auto">
					<button class="btn btn-warning" type="button">로그인</button>
				</div>
				<br>
				<!-- 구글 로그인 버튼 시작 : ** client_id를 변경하시면 됩니다 -->
				<div>
					<div id="g_id_onload"
						data-client_id="730285026476-3dh5pad8cclbr7gsvi75rrmejnemf58l.apps.googleusercontent.com"
						data-context="signin" data-ux_mode="popup"
						data-callback="handleCredentialResponse" data-auto_prompt="false">
					</div>

					<div class="g_id_signin" data-type="icon" data-shape="circle"
						data-theme="outline" data-text="signin_with" data-size="large">
					</div>
					<!--구글 로그인 버튼 끝 -->
				</div>
				<br>
				<div>
					아직 회원이 아니신가요? <a href="#">회원가입</a>
				</div>
			</div>
		</div>
				<custom:footer />
		
	</div>
	<!--비밀번호 찾기 모달창-->
	<div class="modal" id="forgetModal">
		<div class="modal-content">
			<span class="close" style="text-align: right">&times;</span>
			<!--비밀번호 찾기 안내-->
			<h2>비밀번호를 잊어버리셨나요?</h2>
			<p>이메일 인증이 필요합니다.</p>
			<br>
			<div class="input-container">
				<!--1. 이름 입력-->
				<span class="label">이름(Name)</span>
				<div class="input-containerbox">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
						fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
                        <path fill-rule="evenodd"
							d="m4.736 1.968-.892 3.269-.014.058C2.113 5.568 1 6.006 1 6.5 1 7.328 4.134 8 8 8s7-.672 7-1.5c0-.494-1.113-.932-2.83-1.205l-.014-.058-.892-3.27c-.146-.533-.698-.849-1.239-.734C9.411 1.363 8.62 1.5 8 1.5s-1.411-.136-2.025-.267c-.541-.115-1.093.2-1.239.735m.015 3.867a.25.25 0 0 1 .274-.224c.9.092 1.91.143 2.975.143a30 30 0 0 0 2.975-.143.25.25 0 0 1 .05.498c-.918.093-1.944.145-3.025.145s-2.107-.052-3.025-.145a.25.25 0 0 1-.224-.274M3.5 10h2a.5.5 0 0 1 .5.5v1a1.5 1.5 0 0 1-3 0v-1a.5.5 0 0 1 .5-.5m-1.5.5q.001-.264.085-.5H2a.5.5 0 0 1 0-1h3.5a1.5 1.5 0 0 1 1.488 1.312 3.5 3.5 0 0 1 2.024 0A1.5 1.5 0 0 1 10.5 9H14a.5.5 0 0 1 0 1h-.085q.084.236.085.5v1a2.5 2.5 0 0 1-5 0v-.14l-.21-.07a2.5 2.5 0 0 0-1.58 0l-.21.07v.14a2.5 2.5 0 0 1-5 0zm8.5-.5h2a.5.5 0 0 1 .5.5v1a1.5 1.5 0 0 1-3 0v-1a.5.5 0 0 1 .5-.5" />
                    </svg>
					<input type="email" class="inputbox" placeholder="이름을 입력해주세요">
				</div>
				<br>
				<!--이메일 입력-->
				<span class="label">이메일(Email Adress)</span>
				<div class="input-containerbox">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
						fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
                        <path
							d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z" />
                    </svg>
					<input type="email" class="inputbox" placeholder="이메일을 입력해주세요">
				</div>
				<br>
				<!--인증번호 발송-->
				<div style="text-align: right">
					<button type="button" class="btn btn-secondary">인증번호 보내기</button>
				</div>
				<!--수신한 인증번호 입력-->
				<!--인증번호 일치 비동기처리-->
				<span class="label">인증번호(Activation Code)</span>
				<div class="input-containerbox">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
						fill="currentColor" class="bi bi-key" viewBox="0 0 16 16">
                        <path
							d="M0 8a4 4 0 0 1 7.465-2H14a.5.5 0 0 1 .354.146l1.5 1.5a.5.5 0 0 1 0 .708l-1.5 1.5a.5.5 0 0 1-.708 0L13 9.207l-.646.647a.5.5 0 0 1-.708 0L11 9.207l-.646.647a.5.5 0 0 1-.708 0L9 9.207l-.646.647A.5.5 0 0 1 8 10h-.535A4 4 0 0 1 0 8m4-3a3 3 0 1 0 2.712 4.285A.5.5 0 0 1 7.163 9h.63l.853-.854a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.793-.793-1-1h-6.63a.5.5 0 0 1-.451-.285A3 3 0 0 0 4 5" />
                        <path d="M4 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0" />
                    </svg>
					<input type="number" class="inputbox" placeholder="인증번호를 입력해주세요">
				</div>
				<br> <br>
				<!--인증번호가 일치할 경우, 비밀번호 재설정 버튼 open / 인증번호 빈칸 혹은 입력값 틀렸다면 hidden처리-->
				<div class="d-grid gap-2">
					<button type="button" class="btn btn-dark"
						data-bs-target="#setPWModal" data-bs-toggle="modal">비밀번호
						재설정하기</button>
				</div>
				<a href="#" style="text-align: right">로그인페이지로 돌아가기</a>
			</div>
		</div>
	</div>

	<script>
    // 모달 요소
    var modal = document.getElementById("forgetModal");

    // 링크 클릭 시 모달 열기
    document.getElementById("forgetModal").onclick = function (event) {
    event.preventDefault(); // 기본 링크 동작 방지
    modal.style.display = "block";
    }

    // 모달 닫기
    document.getElementsByClassName("close")[0].onclick = function () {
    modal.style.display = "none";
    }

    // 모달 외부 클릭 시 닫기
    window.onclick = function (event) {
    	if (event.target == modal) {
    	modal.style.display = "none";
    	}
    }
	</script>

</body>

</html>