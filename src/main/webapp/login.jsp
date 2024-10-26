<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<!-- 자바스크립트 -->
<script src="assets/js/jquery.min.js" defer></script>
<script src="assets/js/main.js" defer></script>

<meta charset="UTF-8">
<title>로그인</title>

</head>
<body>
	<custom:header />
	<!-- 부트스트랩 CSS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
<script src="setPW.js"></script>
	<!-- 로그인 페이지 -->
	<div class="container text-center">
		<br> <br> <br>
		<h2>로그인</h2>
		<br> <br>
		<div class="row align-items-start">
			<div class="col" style="text-align: center;">
				<img src="\resources\assets\images\breadfishmiddle.jpg" class="img">
			</div>

			<!-- 로그인 폼태그 -->
			<form id="login" action="login.do" method="POST">
				<div class="col" style="text-align: left;">
					<div class="input-container">

						<!-- 1. 이메일 입력 안내 -->
						<span class="label">이메일</span>
						<div class="input-containerbox">

							<!-- 우편 모양 아이콘 -->
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
								fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
                            <path
									d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z" />
                        </svg>

							<!-- 이메일 입력란 -->
							<input type="email" class="inputbox" name="email"
								placeholder="이메일을 입력해주세요" required>
						</div>

						<!-- 2. 비밀번호 입력 안내 -->
						<br> <span class="label">비밀번호</span>
						<div class="input-containerbox">

							<!-- 자물쇠 아이콘 -->
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
								fill="currentColor" class="bi bi-lock" viewBox="0 0 16 16">
                            <path
									d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2m3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2M5 8h6a1 1 0 0 1 1 1v5a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V9a1 1 0 0 1 1-1" />
                        </svg>

							<!-- 비밀번호 입력란 -->
							<input type="password" class="inputbox"
								placeholder="비밀번호를 입력해주세요" required>
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
						아직 회원이 아니신가요? <a href="signUp.do">회원가입</a>
					</div>
				</div>
			</form>
		</div>

	</div>
	<!-- 1차 회원정보 확인 모달창 -->
	<div class="modal fade" id="forgetModal" tabindex="-1"
		aria-labelledby="forgetModalLabel" aria-hidden="true">
		<!-- 모달 다이얼로그 -->
		<div class="modal-dialog">
			<div class="modal-content">
				<form action="findPW.do" id="findPW" method="POST">
					<span class="close" id="close"
						style="text-align: right; cursor: pointer; margin: 10px; padding-right: 10px;">&times;</span>
					<!-- 비밀번호 찾기 안내 -->
					<div class="modal-header">
						<h2 class="modal-title" id="forgetModalLabel">비밀번호를 잊어버리셨나요?</h2>
					</div>
					<div class="modal-body">
						<p>이메일 인증이 필요합니다.</p>
						<br>
						<div class="input-container">
							<!-- 1. 이름 입력 -->
							<span class="label">이름</span>
							<div class="input-containerbox mb-3">
								<div class="d-flex align-items-center border rounded">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
										fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
                                <path
											d="M3 14s-1 0-1-1 1-1 1-1h10s1 0 1 1-1 1-1 1H3zm8-8a3 3 0 1 0-6 0 3 3 0 0 0 6 0z" />
                            </svg>
									<!-- form-control ms-2 border-0 : 파란테두리 -->
									<input type="text" class="form-control ms-2 border-0" id="name"
										name="name" placeholder="이름을 입력해주세요" required
										style="margin: 0; padding: 0.375rem 0.75rem;">
								</div>
							</div>
							<br>
							<!-- 이메일 입력 -->
							<span class="label">이메일</span>
							<div class="input-containerbox mb-3">
								<div class="d-flex align-items-center border rounded">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
										fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
                                <path
											d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z" />
                            </svg>
									<input type="email" class="form-control ms-2 border-0"
										id="email" name="email" placeholder="이메일을 입력해주세요" required
										style="margin: 0; padding: 0.375rem 0.75rem;">
								</div>
							</div>
							<br>
							<!-- 인증번호 발송 버튼 -->
							<div style="text-align: right">
								<button type="button" class="btn btn-secondary" id="sendNum">메일로
									인증번호 보내기</button>
							</div>

							<br>
							<!-- 수신한 인증번호 입력 -->
							<span id="sendEmailMsg" class="label">인증번호 확인</span>
							<div class="input-containerbox mb-3">
								<div class="d-flex align-items-center border rounded">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
										fill="currentColor" class="bi bi-key" viewBox="0 0 16 16">
                                <path
											d="M0 8a4 4 0 0 1 7.465-2H14a.5.5 0 0 1 .354.146l1.5 1.5a.5.5 0 0 1 0 .708l-1.5 1.5a.5.5 0 0 1-.708 0L13 9.207l-.646.647a.5.5 0 0 1-.708 0L11 9.207l-.646.647a.5.5 0 0 1-.708 0L9 9.207l-.646.647A.5.5 0 0 1 8 10h-.535A4 4 0 0 1 0 8m4-3a3 3 0 1 0 2.712 4.285A.5.5 0 0 1 7.163 9h.63l.853-.854a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.793-.793-1-1h-6.63a.5.5 0 0 1-.451-.285A3 3 0 0 0 4 5" />
                                <path
											d="M4 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0" />
                            </svg>
									<input type="text" class="form-control ms-2 border-0"
										id="checkNumMsg" placeholder="인증번호를 입력해주세요"
										requeired="requeired"
										style="margin: 0; padding: 0.375rem 0.75rem;">
								</div>
							</div>
						</div>
					</div>
					<br>
					<!-- 인증번호가 일치할 경우, 비밀번호 재설정 버튼 open / 인증번호 빈칸 혹은 입력값 틀렸다면 hidden처리 -->
					<div class="d-grid gap-2 text-center">
						<button type="button" class="btn btn-dark" id="resetPw"
							name="resetPw" data-bs-target="#setPwModal" data-bs-toggle="modal">비밀번호
							재설정하러 가기</button>
					</div>
					<div class="text-center mt-3">
						<a href="main.do">메인으로 돌아가기</a> <br>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 1차 회원정보 확인 모달창 -->
	<div class="modal fade" id="mainModal" tabindex="-1"
		aria-labelledby="mainModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<!-- 수직 중앙 정렬 -->
			<div class="modal-content">
				<form id="modalForm" method="POST">
					<span class="close" id="close"
						style="text-align: right; cursor: pointer; margin: 10px; padding-right: 10px;">&times;</span>
					<div class="modal-header">
						<h2 class="modal-title" id="mainModalLabel">비밀번호를 잊어버리셨나요?</h2>
					</div>
					<div class="modal-body" id="modalBody">
						<!-- 초기 내용: 비밀번호 찾기 -->
						<p>이메일 인증이 필요합니다.</p>
						<div class="input-container">
							<span class="label">이름</span>
							<div class="input-containerbox mb-3">
								<input type="text" class="form-control" id="name" name="name"
									placeholder="이름을 입력해주세요" required>
							</div>
							<span class="label">이메일</span>
							<div class="input-containerbox mb-3">
								<input type="email" class="form-control" id="email" name="email"
									placeholder="이메일을 입력해주세요" required>
							</div>
							<div style="text-align: right">
								<button type="button" class="btn btn-secondary" id="sendNum">메일로
									인증번호 보내기</button>
							</div>
							<span class="label">인증번호 확인</span>
							<div class="input-containerbox mb-3">
								<input type="text" class="form-control" id="checkNumMsg"
									placeholder="인증번호를 입력해주세요" required>
							</div>
						</div>
						<div class="d-grid gap-2 text-center">
							<button type="button" class="btn btn-dark" id="setPW">비밀번호
								재설정 완료</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div>
		<br> <br> <br> <br> <br>
		<custom:footer />
	</div>
</body>

</html>