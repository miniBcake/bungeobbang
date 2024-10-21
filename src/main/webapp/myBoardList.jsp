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
</head>
<body>
	<div class="container">
		<div class="row align-items-center">
			<div class="col-10">
				<!-- 첫 번째 행 -->
				<div class="row">
					<custom:pageTilte>${member.memberName}님이 작성한 게시글</custom:pageTilte>
				</div>

				<!-- 두 번째 행 -->
				<div class="row align-items-center">
					<custom:boardSearchBar/>
				</div>

				<!-- 세 번째 행 -->
				<div class="row">
					<div class="col-12">
						<p hidden>게시글 리스트</p>
						<custom:boardlist />
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