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

<title>게시글</title>
<meta charset="utf-8" />
<link rel="stylesheet" href="${path}/resources/assets/css/main.css">
<link rel="stylesheet" href="${path}/resources/assets/css/boardlist.css">
<link rel="stylesheet" href="${path}/resources/assets/css/searchbar.css">
<link rel="stylesheet"
	href="${path}/resources/assets/css/boardsidebar.css">
<link rel="stylesheet"
	href="${path}/resources/assets/css/pagination.css">

<!-- bootstrap -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
	<script src="${path}/resources/assets/js/board/board.js"></script>

</head>
<body>
	
	<div class="container">
		<div class="row align-items-center">
			<div class="col-10">
				<!-- 첫 번째 행 -->
				<div class="row">
					<custom:pageTitle>${userNickname}님이 작성한 게시글</custom:pageTitle>
				</div>

				<!-- 두 번째 행 -->
				<div class="row align-items-center">
					<!-- search line -->
					<div class="col-3 justify-content-center">
						<div class="categoryBox">
							<!-- 카테고리 -->
							<select id="contentFilter" name="contentFilter"
								class="category half" required>
								<option value="category" disabled selected>카테고리</option>
								<option value="TITLE">제목</option>
								<option value="CONTENT">내용</option>
							</select>
							<!-- 날짜 -->
							<select id="condition" name="writeDayFilter"
								class="category half" required>
								<option value="date" disabled selected>기간</option>
								<option value="BOARDALL">전체</option>
								<option value="7DAYS">일주일</option>
								<option value="1YEARS">1년</option>
							</select>
						</div>
					</div>
					<div class="col-8">
						<p>검색창</p>
						<div class="searchInput" id="searchBox">
							<img src="resources/assets/images/search_icon.png"
								alt="검색창 아이콘 이미지" width="30px" height="30px"> 
								<input type="text" id="keyword" name="keyword"
								placeholder="검색어를 입력해주세요." value="${keyword}"> 
								<input type="submit" value="검색">
						</div>
					</div>
					<div class="col-1 text-end justify-content-center">
						<p>글쓰기</p>
						<a href="addBoard.do" class="btn btn-primary" role="button"
							id="addBoard" name="addBoard">글쓰기</a>
					</div>
				</div>
				<!-- 세 번째 행 -->
				<div class="row">
					<div class="col-12">
						<p>게시글 리스트</p>
						<table class="customTable">
							<thead>
								<tr>
									<th class="tableDate">작성일자</th>
									<th class="tableNum">번호</th>
									<th class="tableTitle">제목</th>
									<th class="tableWriter">작성자</th>
									<th class="tableReplyNum">댓글 수</th>
									<th class="tableLike">좋아요 수</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${fn:length(datas) < 1 || empty datas}">
									<tr>
										<td colspan="6">검색 결과가 없습니다.</td>
									</tr>
								</c:if>
								<c:if test="true">
									<c:forEach var="boardList" items="${boardList}">
										<!-- 상세조회로 가는 form -->
										<form action="infoBoard.do" method="POST" id="infoBoardform">
											<input type="hidden" id="boardCategoryNum"
												name="boardCategoryNum"
												value="${boardList.boardCategoryNum}"> <input
												type="hidden" id="boardNum" name="boardNum"
												value="${boardList.boardNum}">
										</form>
										<tr class="infoBoardRow">
											<!-- 게시글카테고리(문의/일반) -->
											<td align="center">${boardList.boardCategoryName}<input
												type="hidden" name="${boardList.boardCategoryNum}"
												value="${boardList.boardCategoryNum}"></td>
											<!-- 작성일자 -->
											<td align="center">${boardList.boardWriteDay}</td>
											<!-- 고유번호  -->
											<td align="center">${boardList.boardNum}</td>
											<!-- 제목 -->
											<td align="center">${boardList.boardTitle}</td>
											<!-- 작성자 -->
											<td align="left">${boardList.memberNum}</td>
											<!-- 댓글수 -->
											<td align="left">${boardList.replyCnt}</td>
											<!-- 좋아요수 -->
											<td align="left"><svg xmlns="http://www.w3.org/2000/svg"
													width="16" height="16" fill="currentColor"
													class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16">
  											<path
														d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a10 10 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733q.086.18.138.363c.077.27.113.567.113.856s-.036.586-.113.856c-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.2 3.2 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.8 4.8 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z" />
											</svg> &nbsp;${boardList.likeCnt}</td>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
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
			<div class="col-2 sideBar">
				<!-- sidebar 1행 -->
				<div class="row">
					<div class="col-12">
						<div class="nullBox"></div>
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<custom:boardSideBar />
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>