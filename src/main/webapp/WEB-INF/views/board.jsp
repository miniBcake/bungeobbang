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


<meta charset="UTF-8">
<title>커뮤니티 게시글</title>
<link rel="stylesheet" href="${path}/resources/assets/css/main.css">
<link rel="stylesheet"
	href="${path}/resources/assets/css/boardsidebar.css">
<link rel="stylesheet" href="${path}/resources/assets/css/board.css">
<link rel="stylesheet" href="${path}/resources/assets/css/reply.css">
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

	<div class="container">

		<custom:header />

		<div class="row align-items-center">
			<div class="col-12 col-md-10">
				<!-- 첫 번째 행 -->
				<div class="row">
					<custom:pageTilte>게시글</custom:pageTilte>
				</div>

				<!-- 두 번째 행 -->
				<div class="row">
					<div class="col-12">
						<custom:board />
					</div>
				</div>

				<!-- 세 번째 행 -->
				<div class="row">
					<div class="col-12">
						<p hidden>댓글구역</p>
						<div class="replyTop">
							<div class="row">
								<div class="col-12 col-md-2" id="replyTitle">댓글쓰기</div>
								<div class="col-0 col-md-7"></div>
								<div class="col-12 col-md-3" id="replyCnt">댓글 {n}개</div>
							</div>
						</div>
						<div class="replyMid">
							<custom:replyInsert />
						</div>

						<div class="replyList">
							<custom:reply />
						</div>
					</div>
				</div>

				<!-- 네 번째 행 -->
				<div class="row">
					<div class="col-12">
						<p hidden>페이지네이션</p>
						<!-- 페이지네이션 -->
						<custom:pagination />
					</div>
				</div>
			</div>

			<div class="col-12 col-md-2">
				<!-- sidebar 1행 -->
				<custom:boardSideBar/>
			</div>
		</div>

		<custom:footer />
	</div>
</body>
</html>