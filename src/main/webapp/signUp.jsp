<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>

<head>
	<!--bootstrap CDN코드-->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

	<meta charset="UTF-8">
	<title>회원가입</title>
	<!--css 파일-->
	<link rel="stylesheet" href="/resources/assets/css/loginAndsign.css">
</head>

<body>
	<custom:header />
	<!--bootstrap CDN코드-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>

	<div class="container text-center">
		<div class="row-md-12">
			<h2>회원가입</h2>
			<br><br>
		</div>

		<div class="row">
			<div class="col-6"><!--1-1열 : 이미지 및 업로드,제거-->
				<div class="row-md-12"><!--1행 : 프로필사진 등록-->
					<img src="/resources/assets/images/breadfishmiddle.jpg" class="signupimg"> <br> <br>
				</div><!--프로필사진 등록 끝-->

				<div class="row-md-12"><!-- 프로필사진 버튼-->
					<!--이미지 업로드-->
					<button class="btn btn-warning btn-lg" type="button">이미지업로드</button>
					&nbsp &nbsp
					<!--이미지 제거-->
					<button class="btn btn-warning btn-lg" type="button">이미지제거</button>
				</div><!--프로필사진 버튼 끝-->
			</div><!--이미지 및 업로드,제거 끝-->

			<div class="col-6"><!--1-3열 : 회원가입 정보입력-->
				<!--항목1 이메일-->
				<div class="row-12">
					<span class="label">Email address</span>
				</div>
				<!--항목1 인풋값 및 버튼-->
				<div class="row-md-12">
					<!--인풋값-->
					<div class="input-containerbox">
						<!--편지아이콘-->
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
							class="bi bi-envelope" viewBox="0 0 16 16">
							<path
								d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z" />
						</svg>
						<input type="email" class="inputbox" placeholder="이메일을 입력해주세요">
						</span>
						<!--이메일 중복확인버튼-->
						<button class="btn btn-warning btn-lg" type="button">중복확인</button>
					</div>
				</div>
				<br>
				<!--항목2 인증번호-->
				<div class="row-12">
					<span class="label">Activation Code</span>
				</div>
				<!--항목2 인풋값 및 인증번호 전송 버튼-->
				<div class="row-md-12">
					<!--인풋값-->
					<div class="input-containerbox">
						<!--키아이콘-->
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
							class="bi bi-key" viewBox="0 0 16 16">
							<path
								d="M0 8a4 4 0 0 1 7.465-2H14a.5.5 0 0 1 .354.146l1.5 1.5a.5.5 0 0 1 0 .708l-1.5 1.5a.5.5 0 0 1-.708 0L13 9.207l-.646.647a.5.5 0 0 1-.708 0L11 9.207l-.646.647a.5.5 0 0 1-.708 0L9 9.207l-.646.647A.5.5 0 0 1 8 10h-.535A4 4 0 0 1 0 8m4-3a3 3 0 1 0 2.712 4.285A.5.5 0 0 1 7.163 9h.63l.853-.854a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.793-.793-1-1h-6.63a.5.5 0 0 1-.451-.285A3 3 0 0 0 4 5" />
							<path d="M4 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0" />
						</svg>
						<input type="text" class="inputbox" placeholder="인증번호를 입력해주세요">
						</span>
						<!--인증번호 전송 버튼-->
						<button class="btn btn-warning btn-lg" type="button">인증번호 보내기</button>
					</div>
				</div>
				<br>
				<!--항목3 비밀번호-->
				<div class="row-12">
					<span class="label">Password</span>
				</div>
				<!--항목3 인풋값 및 비밀번호 확인 버튼-->
				<div class="row-md-12">
					<!--인풋값-->
					<div class="input-containerbox">
						<!--자물쇠 아이콘-->
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
							class="bi bi-lock" viewBox="0 0 16 16">
							<path
								d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2m3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2M5 8h6a1 1 0 0 1 1 1v5a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V9a1 1 0 0 1 1-1" />
						</svg>
						<input type="text" class="inputbox" placeholder="비밀번호를 입력해주세요">
						</span>
					</div>
				</div>
				<br>
				<div class="row-12">
					<span class="label">Password</span>
				</div>
				<!--항목3 인풋값 및 비밀번호 확인 버튼-->
				<div class="row-md-12">
					<!--인풋값-->
					<div class="input-containerbox">
						<!--자물쇠 아이콘-->
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
							class="bi bi-lock" viewBox="0 0 16 16">
							<path
								d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2m3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2M5 8h6a1 1 0 0 1 1 1v5a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V9a1 1 0 0 1 1-1" />
						</svg>
						<input type="text" class="inputbox" placeholder="비밀번호를 다시 입력해주세요">
						</span>
						<!--비밀번호 확인 버튼-->
						<button class="btn btn-warning btn-lg" type="button">비밀번호 확인</button>
					</div>
				</div>
				<br>
				<!--항목4 이름-->
				<div class="row-12">
					<span class="label">Name</span>
				</div>
				<div class="row-md-12">
					<!--인풋값-->
					<div class="input-containerbox">
						<!--사람 아이콘-->
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
							class="bi bi-incognito" viewBox="0 0 16 16">
							<path fill-rule="evenodd"
								d="m4.736 1.968-.892 3.269-.014.058C2.113 5.568 1 6.006 1 6.5 1 7.328 4.134 8 8 8s7-.672 7-1.5c0-.494-1.113-.932-2.83-1.205l-.014-.058-.892-3.27c-.146-.533-.698-.849-1.239-.734C9.411 1.363 8.62 1.5 8 1.5s-1.411-.136-2.025-.267c-.541-.115-1.093.2-1.239.735m.015 3.867a.25.25 0 0 1 .274-.224c.9.092 1.91.143 2.975.143a30 30 0 0 0 2.975-.143.25.25 0 0 1 .05.498c-.918.093-1.944.145-3.025.145s-2.107-.052-3.025-.145a.25.25 0 0 1-.224-.274M3.5 10h2a.5.5 0 0 1 .5.5v1a1.5 1.5 0 0 1-3 0v-1a.5.5 0 0 1 .5-.5m-1.5.5q.001-.264.085-.5H2a.5.5 0 0 1 0-1h3.5a1.5 1.5 0 0 1 1.488 1.312 3.5 3.5 0 0 1 2.024 0A1.5 1.5 0 0 1 10.5 9H14a.5.5 0 0 1 0 1h-.085q.084.236.085.5v1a2.5 2.5 0 0 1-5 0v-.14l-.21-.07a2.5 2.5 0 0 0-1.58 0l-.21.07v.14a2.5 2.5 0 0 1-5 0zm8.5-.5h2a.5.5 0 0 1 .5.5v1a1.5 1.5 0 0 1-3 0v-1a.5.5 0 0 1 .5-.5" />
						</svg>
						<input type="email" class="inputbox" placeholder="이름을 입력하세요">
						</span>
					</div>
				</div>
				<br>

				<!--항목5 닉네임-->
				<div class="row-12">
					<span class="label">Nickname</span>
				</div>
				<div class="row-md-12">
					<!--인풋값-->
					<div class="input-containerbox">
						<!--사람 아이콘-->
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
							class="bi bi-incognito" viewBox="0 0 16 16">
							<path fill-rule="evenodd"
								d="m4.736 1.968-.892 3.269-.014.058C2.113 5.568 1 6.006 1 6.5 1 7.328 4.134 8 8 8s7-.672 7-1.5c0-.494-1.113-.932-2.83-1.205l-.014-.058-.892-3.27c-.146-.533-.698-.849-1.239-.734C9.411 1.363 8.62 1.5 8 1.5s-1.411-.136-2.025-.267c-.541-.115-1.093.2-1.239.735m.015 3.867a.25.25 0 0 1 .274-.224c.9.092 1.91.143 2.975.143a30 30 0 0 0 2.975-.143.25.25 0 0 1 .05.498c-.918.093-1.944.145-3.025.145s-2.107-.052-3.025-.145a.25.25 0 0 1-.224-.274M3.5 10h2a.5.5 0 0 1 .5.5v1a1.5 1.5 0 0 1-3 0v-1a.5.5 0 0 1 .5-.5m-1.5.5q.001-.264.085-.5H2a.5.5 0 0 1 0-1h3.5a1.5 1.5 0 0 1 1.488 1.312 3.5 3.5 0 0 1 2.024 0A1.5 1.5 0 0 1 10.5 9H14a.5.5 0 0 1 0 1h-.085q.084.236.085.5v1a2.5 2.5 0 0 1-5 0v-.14l-.21-.07a2.5 2.5 0 0 0-1.58 0l-.21.07v.14a2.5 2.5 0 0 1-5 0zm8.5-.5h2a.5.5 0 0 1 .5.5v1a1.5 1.5 0 0 1-3 0v-1a.5.5 0 0 1 .5-.5" />
						</svg>
						<input type="email" class="inputbox" placeholder="닉네임을 입력하세요">
						</span>
						<button class="btn btn-warning btn-lg" type="button">중복확인</button>
					</div>
				</div>
				<br>

				<!--항목6 주소-->
				<div class="row-12">
					<span class="label">Address</span>
				</div>
				<div class="row-md-12">
					<!--인풋값-->
					<div class="input-containerbox">
						<!--사람 아이콘-->
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
							class="bi bi-house-door" viewBox="0 0 16 16">
							<path
								d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4z" />
						</svg>
						<input type="text" class="inputbox" placeholder="기본 주소">
						</span>
						<button class="btn btn-warning btn-lg" type="button">주소 찾기</button>
					</div>
				</div>
				<div class="row-md-12">
					<!--인풋값-->
					<div class="input-containerbox">
						<!--사람 아이콘-->
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
							class="bi bi-house-door" viewBox="0 0 16 16">
							<path
								d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4z" />
						</svg>
						<input type="text" class="inputbox" placeholder="상세주소">
						</span>
					</div>
				</div>
				<div class="row-md-12">
					<!--인풋값-->
					<div class="input-containerbox">
						<!--사람 아이콘-->
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
							class="bi bi-house-door" viewBox="0 0 16 16">
							<path
								d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4z" />
						</svg>
						<input type="text" class="inputbox" placeholder="우편번호">
						</span>
					</div>
				</div>
				<br>

<!--항목7 전화번호(선택)-->
				<div class="row-12">
					<span class="label">Phone Number(선택)</span>
				</div>
				<div class="row-md-12">
					<!--인풋값-->
					<div class="input-containerbox">
						<!--사람 아이콘-->
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
						class="bi bi-phone" viewBox="0 0 16 16">
						<path
							d="M11 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM5 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z" />
						<path d="M8 14a1 1 0 1 0 0-2 1 1 0 0 0 0 2" />
					</svg>
						<input type="text" class="inputbox" placeholder="전화번호를 입력해주세요(선택)">
						</span>
					</div>
				</div>

				<!-- 구글 로그인 버튼 시작 : ** client_id를 변경하시면 됩니다 -->
				<div>
					<div id="g_id_onload"
						data-client_id="730285026476-3dh5pad8cclbr7gsvi75rrmejnemf58l.apps.googleusercontent.com"
						data-context="signin" data-ux_mode="popup" data-callback="handleCredentialResponse"
						data-auto_prompt="false">
					</div>

					<div class="g_id_signin" data-type="icon" data-shape="circle" data-theme="outline"
						data-text="signin_with" data-size="large">
					</div>
					<!--구글 로그인 버튼 끝 -->
				</div>
				<br>
				<div>
					이미 회원이신가요? <a href="#">로그인</a>
				</div>
			</div>
		</div><!--회원가입 정보입력 끝-->
	</div>
	<custom:footer />
</body>

</html></html>