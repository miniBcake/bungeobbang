<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="row align-items-center">
	<div class="col-12 col-md-1" id="replyTitle">
		<!-- 프로필 사진 -->
		<img class="profilePic" src="resources\assets\images\block.png"
			alt="프로필 사진">
	</div>
	<div class="col-12 col-md-9">
		<div class="replySection">
			<!-- 닉네임 -->
			<span class="nickName">${replyList.memberNum}</span>
			<!-- 댓글 내용 -->
			<span class="replyContent">{replyList.replyContent}</span>
		</div>
	</div>
	<div class="col-12 col-md-2 text-center" id="replyData">
		<!-- 작성 날짜 -->
		<div class="date">{replyList.replyWriteDay}</div>
		<!-- 댓글 삭제 버튼 -->
		<c:if test="false">
			<div class="buttonBox">
				<button class="btn btn-danger" id="deleteReply">삭제</button>
			</div>
		</c:if>
	</div>
	<hr>
</div>