<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="boardlist"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
		<c:forEach var="data" items="${datas}">
			<tr>
				<td align="center">안녕</td>
				<td align="center">아안ㄴ</td>
				<td align="center">${data.title}</td>
				<td align="left">${data.writer}</td>
				<td align="left">${data.replyCnt}</td>
				<td align="left">${data.likeCnt}</td>
			<tr>
		</c:forEach>
		</c:if>
	</tbody>
</table>