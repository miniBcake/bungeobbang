//댓글 목록 조회, 추가, 삭제 스크립트

// 페이지 로드 시 댓글 목록 불러오기	////////////////////////////////////////////////////
$(document).ready(() => {
	loadReply();

	// 댓글 목록 불러오기	////////////////////////////////////////////////////
	// 보내는 값 : 게시글 고유번호 boardNum
	// 받는 값 : 댓글 리스트	List<ReplyDTO> replyList
	function loadReply() {
		var boardNum = $('#boardNum').val();
		console.log("replyList.js loadReply start");

		if (boardNum) {
			$.ajax({
				url: 'loadListReply.do',
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify({ boardNum: boardNum }),
				dataType: 'json',
				success: function(result) {
					$('#replyList').empty(); // 댓글 초기화
					$.each(result, function(index, reply) {
						var replyListResult = `
							<!--댓글 고유번호 출력-->
				        	<input type="hidden" id="replyNum" name="replyNum" value="${reply.replyNum}">
				            <div class="row align-items-center">
				            	<div class="col-12 col-md-9">
				                	<div class="replySection"><!-- 댓글 닉네임 및 내용 출력 -->
				                    	<span class="nickName">${reply.replyNickname}</span>
				                    	<span class="replyContent">${reply.replyContent}</span>
				                    </div>
				                </div>
								<!-- 댓글 작성일자 -->
				                <div class="col-12 col-md-2 text-center" id="replyData">
				                	<div class="date">${reply.replyWriteDay}</div>
									<!-- 댓글 삭제버튼 -->
									<!-- 만약 사용자라면 댓글 삭제 보여주기 / 아니라면 숨김-->
									${reply.isUserReply ?
								`<div class="buttonBox">
				                         <button class="btn btn-danger deleteReply" data-reply-num="${reply.replyNum}">삭제</button>
				                     </div>`
								: ''}
				               </div>
				               <hr>
				           </div>
				        `;
						$('#replyList').append(replyListResult); // 댓글 목록에 추가
					});
				},
				error: function() {
					Swal.fire({
						icon: 'error',
						title: '댓글 목록 불러오기 오류',
						text: '댓글 목록 불러오는 도중 오류가 발생했습니다. 새로고침 해주세요.',
						confirmButtonText: '확인'
					});
				}
			});
		}
	}

});


// 댓글 작성 버튼 클릭 시	////////////////////////////////////////////////////
// 보내는 값 : 회원, 게시물, 댓글 고유번호
// 받는 값 : boolean(true/false)
$('#insertReply').on('click', function() {
	//댓글작성 클릭했을 때 댓글 작성한 내용이 있다면
	if ($('input[name="inputReplyContent"]').val() !== '') {
		console.log("replyList.js insertReply start");
		var memberNum = $('#userPK').val();
		var replyContent = $('#inputReplyContent').val();
		var boardNum = $('#boardNum').val();

		$.ajax({
			url: 'addReply.do',
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify({
				memberNum: memberNum,
				replyContent: replyContent,
				boardNum: boardNum
			}),
			dataType: 'json',
			success: function(result) {
				if (result == true) {
					$('#inputReplyContent').val(''); // 댓글 입력란 초기화
					window.location.href = 'board.do'; // board.do로 이동				}
				}else if (result == false) {
					Swal.fire({
						icon: 'error',
						title: '댓글 추가 오류',
						text: '댓글 추가하는 도중 오류가 발생했습니다. 다시 입력해주세요',
						confirmButtonText: '확인'
					});
				}
			}
		});
	}
});

// 댓글 삭제 버튼 클릭 시	////////////////////////////////////////////////////
// 보내는 값 : 댓글 고유번호
// 받는 값 : boolean(true/false)
$(document).on('click', '.deleteReply', function() {
	var replyNum = $(this).data('reply-num');

	Swal.fire({
		icon: 'warning',
		title: '댓글 삭제 확인',
		text: '해당 댓글을 삭제합니다. 정말 삭제하시겠습니까?',
		showCancelButton: true, // 취소 버튼 생성
		confirmButtonText: '확인', // 확인
		cancelButtonText: '취소' // 취소
	}).then((infoResult) => {
		if (infoResult.isConfirmed) { // 확인 버튼 클릭 시 댓글삭제 진행
			$.ajax({
				url: 'deleteReply.do',
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify({ replyNum: replyNum }),
				dataType: 'json',
				success: function(result) {
					if (result.success) { //댓글이 삭제되었다면
						window.location.href = 'board.do'; // board.do로 이동
					} else {
						Swal.fire({
							icon: 'error',
							title: '오류',
							text: '댓글 삭제 중 오류가 발생했습니다.'
						});
					}
				},
				error: function() {
					Swal.fire({
						icon: 'error',
						title: '오류',
						text: '댓글 삭제에 실패했습니다.'
					});
				}
			});
		}
	});
});