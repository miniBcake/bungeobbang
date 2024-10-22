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
    <title>회원탈퇴</title>
    <link rel="stylesheet" href="/webapp/resources/assets/css/loginAndsign.css">
    <link rel="stylesheet" href="/webapp/resources/assets/css/modal.css">
</head>

<body>
    <custom:header />

    <!--bootstrap CDN코드-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>

    <!--전체 컨테이너 시작-->
    <div class="container text-center">
        <br><br><br>
        <!--1 회원탈퇴-->
        <h2>회원탈퇴</h2>
        <br><br>

        <!-- 1) 붕어빵 이미지-->
        <div class="col" style="text-align: center ">
            <img src="/resources/assets/images/breadfishCat.jpg" class="breadfishCat">

            <!-- 2) 회원탈퇴 시 개인정보 관련 안내-->
            <div class="input-container">
                000님 정말 회원탈퇴하시겠어요?<br>
                <br>
                '회원탈퇴'를 입력 후 탈퇴버튼을 누르면<br>
                적립한 포인트 등 개인정보가 모두 삭제됩니다<br><br>

                개인정보를 다시 복구할 수 없으니 신중히 고려해주세요<br>
                탈퇴 후 작성한 게시물은 남아있으며, 삭제 불가합니다.<br><br>
                <form></form>
                <!--3) 회원탈퇴 문구 작성 및 탈퇴 요청버튼-->
                <div class="input-containerbox">
                    <input type="text" class="inputbox" placeholder="회원탈퇴">
                    <button class="btn btn-warning btn-lg" type="button">회원탈퇴 요청</button>
                </div>
                <!--3) 회원탈퇴 문구 작성 및 탈퇴 요청버튼 끝-->

                <br>
            </div>
            <!-- 2) 회원탈퇴 시 개인정보 관련 안내 끝-->
             
            <br>
        </div><!-- 1) 붕어빵 이미지 끝 -->
    </div><!--전체 컨테이너 끝-->
    <custom:footer />

</body>

</html>