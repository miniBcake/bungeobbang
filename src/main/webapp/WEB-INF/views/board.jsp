<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.ArrayList, java.util.HashMap, java.util.Map, java.util.List"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<!-- css 변경을 위한 캐시 방지 -->
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
<!-- 파비콘 -->
<link rel="icon" href="${path}/resources/assets/images/logo.png"
	type="image/x-icon" />

<meta charset="UTF-8">
<title>게시글 상세</title>
<link rel="stylesheet" href="${path}/resources/assets/css/main.css">
<link rel="stylesheet"
	href="${path}/resources/assets/css/board/board.css">
<link rel="stylesheet"
	href="${path}/resources/assets/css/board/reply.css">
<link rel="stylesheet"
	href="${path}/resources/assets/css/pagination.css">

<!-- bootstrap -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
</head>
<body>
	<div id="page-wrapper">
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
		<script src="${path}/resources/assets/js/board/board.js"></script>
		<script src="${path}/resources/assets/js/board/replyList.js"></script>

		<div class="container">
			<custom:header />
			<div class="row justify-content-center">
				<div class="col-12 col-md-10">

					<!-- 두 번째 행 : 게시글 정보 -->
					<div class="row">
						<div class="col-12">
							<br> <br>
							<button id="back-button" class="btn button-yello"
							onclick="history.back()">게시판 돌아가기</button>
							<table class="customTable">
								<thead>
									<tr>
										<th class="tableTitle">제목</th>
										<th class="tableTitleValue">${board.boardTitle}</th>

										<!-- 좋아요 수 -->
										<th class="tableLike"><svg
												xmlns="http://www.w3.org/2000/svg" width="16" height="16"
												fill="currentColor" class="bi bi-hand-thumbs-up-fill"
												viewBox="0 0 16 16">
  											<path
													d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a10 10 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733q.086.18.138.363c.077.27.113.567.113.856s-.036.586-.113.856c-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.2 3.2 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.8 4.8 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z" />
										</svg>&nbsp; 좋아요 &nbsp; ${board.likeCnt}</th>

										<!-- 작성자명 -->
										<th class="tableWriter">${board.memberNickname}<input
											type="hidden" id="memberNum" name="memberNum"
											value="${board.memberNum}"> <input type="hidden"
											id="boardNum" name="boardNum" value="${board.boardNum}">
										</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td colspan="4" align="left" id="boardContent">${board.boardContent}</td>
									<tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="button-container col-12 d-flex justify-content-end">
						<!-- 작성자가 지금 로그인한 유저라면 게시물수정버튼 생성/아니라면 숨김-->
						<c:if test="${board.memberNum eq userPK}">
							<div id="edit-button-container" style="display: inline;">
								<br> <a href="updateBoard.do?boardNum=${board.boardNum}"
									class="btn button-orange" role="button">수정 </a>
								<button type="button" id="deleteButton" class="btn btn-danger"
									role="button">삭제</button>
							</div>
						</c:if>
					</div>
					<!-- 세 번째 행 : 댓글 -->
					<div class="row">
						<div class="col-12">
							<div class="replyTop">
								<br> <br> <br>
								<div class="row">
									<div class="col-12 col-md-2" id="replyTitle">댓글쓰기</div>
									<div class="col-0 col-md-7"></div>
									<div class="col-12 col-md-3" id="replyCnt">댓글
										${replyCnt}개</div>
								</div>
								<hr>
							</div>
							<div class="replyMid">
								<!-- 댓글 등록 -->
								<div class="profile">
									<span id="userNickname"><strong>${userNickname}</strong></span>
								</div>
								<div class="replyInput">
									<input type="hidden" id="replyMemberNum" name="memberNum"
										value="${userPK}">
									<!-- 댓글 입력 창 :replyContent로 form데이터 전송-->
									<textarea id="myReplyContent" name="replyContent"
										placeholder="댓글을 입력해주세요" required>${replyList.replyContent}</textarea>
								</div>
								<!-- 댓글 작성 버튼 -->
								<div class="replyButtom">
									<c:choose>
										<c:when test="${empty userPK}">
											<%--로그인 상태가 아니라면 로그인으로 이동--%>
											<button class="btn button-orange" type="button"
												onclick="location.href='login.do'">댓글작성</button>
										</c:when>
										<c:otherwise>
											<%--로그인 상태라면 댓글 작성 진행--%>
											<button class="btn button-orange" type="button"
												id="insertReply" name="insertReply">댓글작성</button>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div id="replyList" class="replyList">
								<%--댓글이 들어갈 공간 / 비동기--%>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<form action="deleteBoard.do" id="deleteForm" method="POST">
			<input type="hidden" name="boardNum" value="${board.boardNum}">
		</form>
		<custom:footer />
	</div>
</body>
</html>