<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
    
<!DOCTYPE html>
<html>

<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <meta charset="UTF-8">
    <title>마이 페이지</title>
    <style type="text/css">
.content {
    padding-bottom: 5px;
}

.table {
    text-align: center; /* 테이블 내용 가운데 정렬 */
    border-collapse: collapse; /* 테이블 선 없애기 */
    width: 100%;
}

.table td {
    padding: 10px; /* 셀 패딩 추가 */
}

.table td:nth-child(2) {
    border: none; /* 두 번째 열의 테두리 없애기 */
}

.underline {
    border-bottom: 1px solid black; /* 첫 번째 열에만 밑줄 */
}

        </style> 
    <link rel="stylesheet" href="/resources/assets/css/loginAndsign.css">
    <link rel="stylesheet" href="../resources/assets/css/main.css">
    <link rel="stylesheet" href="../resources/assets/css/header.css">

</head>

<body>
    <custom:header />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>

        <div class="container text-center">
            <br><br><br>
            <h2>마이 페이지</h2>
            <br><br>
        <!--개인정보&사이드바 행-->
        <div class="row align-items-start">
            <br>
            <br>
            <!--1열 붕어빵 이미지 및 프로필 수정버튼-->
            <div class="col-md-4" style="text-align: center;">
                <span class="col-2">
                    <br><br>
                    <img src="/resources/assets/images/breadfishProfile.jpg" class="signupimg">
                </span>
                <br>
                <div class="col-10" style="text-align:right;">
                    <a href="">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                            class="bi bi-upload" viewBox="0 0 16 16">
                            <path
                                d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5" />
                            <path
                                d="M7.646 1.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 2.707V11.5a.5.5 0 0 1-1 0V2.707L5.354 4.854a.5.5 0 1 1-.708-.708z" />
                        </svg>
                    </a>
                </div>
                <br><br>
                <div>
                    <h4>Point &nbsp; &nbsp; &nbsp; 123</h4>
                    <br>
                    <button type="button" class="btn btn-primary">포인트 충전</button><br><br>
                    <button type="button" class="btn btn-danger">프로필 수정</button>
                    <br><br>
                    <br><br>
                    <br><br>
                    <br><br>
                    <br><br>
                    <br><br>
                    <button class="btn btn-warning btn-lg" type="button">회원탈퇴</button>
                </div>
            </div>

             <!-- 회원정보 테이블 -->
             <div class="col-md-4">
                <br><br>
                <br><br>
                <table class="table">
                    <tr>
                        <td class="underline">닉네임</td>
                        <td>붕어빵</td>
                    </tr>
                    <tr>
                        <td class="underline">이름</td>
                        <td>회원</td>
                    </tr>
                    <tr>
                        <td class="underline">이메일</td>
                        <td>admin@academy.com</td>
                    </tr>
                    <tr>
                        <td class="underline">전화번호</td>
                        <td>010-1234-5678</td>
                    </tr>
                    <tr>
                        <td class="underline">주소</td>
                        <td>강남구 테헤란로</td>
                    </tr>
                </table>
            </div>
            <!--3열 사이드바-->
            <div class="col-md-4">
                사이드바
                <custom:boardSideBar />
            </div>
        </div>
    </div>
</body>

</html>