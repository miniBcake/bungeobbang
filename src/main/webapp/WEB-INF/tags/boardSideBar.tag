<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="boardSideBar"%>
<%--<img class="image" id="image" src="resources/assets/images/breadfishmiddle.jpg" alt="붕어빵 사진">
<br>
<p>붕어빵 생각날 때 붕어빵가게 갈빵?</p>--%>
<br>
<!-- 각 버튼을 블록 요소로 만들고 마진을 제거 -->
<div style="display: flex; flex-direction: column; gap: 10px; text-align: center;">
    <a href="loadListBoard.do" class="btn btn-light" role="button" id="my-write-board">작성한 게시글</a>
    <a href="loadListPayment.do" class="btn btn-light" role="button">포인트 구매내역</a>
    <a href="loadListPoint.do" class="btn btn-light" role="button">포인트 결제내역</a>
</div>
