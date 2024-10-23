<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<!--bootstrap CDN코드-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <meta charset="UTF-8">
    <title>새로운 비밀번호로 변경</title>
    <link rel="stylesheet" href="/webapp/resources/assets/css/loginAndsign.css">
    <link rel="stylesheet" href="/webapp/resources/assets/css/modal.css">
</head>

<body>
	<!--bootstrap CDN코드-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>

    <div class="container text-center">
        <br><br><br>
        <h2>새로운 비밀번호로 변경</h2>
        <!-- 비밀번호 변경 버튼 -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#setModal">
            비밀번호 변경
        </button>

        <!-- 비밀번호 찾기 모달창 -->
        <div class="modal fade" id="setModal" tabindex="-1" aria-labelledby="setModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="setModalLabel">비밀번호 변경</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="input-container">
                            <span class="label">신규 비밀번호(New password)</span>
                            <div class="input-containerbox">
                                <input type="password" class="inputbox" placeholder="신규비밀번호를 입력해주세요">
                            </div>
                            <br>
                            <span class="label">비밀번호 확인(confirm password)</span>
                            <div class="input-containerbox">
                                <input type="password" class="inputbox" placeholder="비밀번호를 확인해주세요">
                            </div>
                            <br>
                            <div class="d-grid gap-2">
                                <button type="button" class="btn btn-dark">비밀번호 변경완료</button>
                            </div>
                            <a href="#" style="text-align:center">로그인페이지로 돌아가기</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
    