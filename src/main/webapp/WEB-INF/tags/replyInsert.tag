<%@ tag language="java" pageEncoding="UTF-8"%>

<!-- 댓글 등록 -->
<form action="비동기로 하실건가요?">

	<div class="profile">
		<!-- 프로필 사진 -->
		<img class="profilePic" src="resources\assets\images\block.png"
			alt="프로필 사진"> <span id="myNickName">{session 닉네임 값}</span>
	</div>
	<div class="replyInput">
		<!-- 댓글 입력 창 -->
		<textarea id="myReplyContent" name="replyContent"
			placeholder="댓글을 입력해주세요" required>{댓글내용}</textarea>
	</div>
	<!-- 댓글 작성 버튼 -->
	<div class="replyButtom">
		<input type="submit" value="댓글 작성">
	</div>

</form>