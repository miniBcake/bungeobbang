//게시물 전체 조회 스크립트	///////////////////////////

// 특정 행(게시물)을 클릭하면 상세조회 이동
$(document).ready(function() {

	//상세조회에서 수정 버튼을 누르면
	$(document).on('click', '#updateButton', function() {
		$('#updateForm').submit(); // 수정 폼 제출

	});



	//상세조회에서 삭제 버튼을 누르면
	$(document).on('click', '#deleteButton', function() {

		Swal.fire({
			icon: 'warning',
			title: '게시물 삭제 확인',
			text: '해당 게시물을 삭제합니다. 정말 삭제하시겠습니까?',
			showCancelButton: true, // 취소 버튼 생성
			confirmButtonText: '확인', // 확인
			cancelButtonText: '취소' // 취소
		}).then((result) => {
			if (result.isConfirmed) {
				$('#deleteForm').submit(); // 삭제 폼 제출
			}
		})
	});

	// 좋아요 버튼을 눌렀다면
	$('#likeBtn').click(function() {
		const $this = $(this);
		const boardNum = $this.data('board-id');
		const userPK = $this.data('user-pk');
		console.log('boardNum : ' + boardNum);
		console.log('userPK : ' + userPK);

		var likeNum;
		var likeCnt;
		console.log('likeCnt : ' + likeCnt);

		// 로그인을 했다면
		if (userPK) {

			getLikeNum()
				.then(likeNumData => {
					likeNum = likeNumData;
					console.log('likeNum : ' + likeNum);

					return getLikeCnt(likeNum);
				})
				.then(likeCntData => {
					likeCnt = likeCntData;

					// 좋아요가 아니라면 상태라면
					if ($this.hasClass('like-false')) {
						// 좋아요 상태로 변경
						$this.removeClass('like-false').addClass('like-true');
						$.ajax({
							url: 'addLike.do',
							type: 'POST',
							contentType: 'application/json',
							data: JSON.stringify({
								boardNum: boardNum,
								memberNum: userPK
							}),
							dataType: 'json',
							success: function(data) {
								console.log('addLike data : ' + data);

								// 추가 성공
								if (data === true) {
									console.log('좋아요 추가 성공');
									// 1 추가
									likeCnt = likeCnt + 1;

									// 새 값 넣어주기
									document.getElementById('likeCount').innerText = likeCntValue;
								}
								else {
									// 실패
									console.log('좋아요 추가 실패');
								}
							}
						});
					} else {
						// 좋아요 취소 상태로 변경
						$this.removeClass('like-true').addClass('like-false');
						$.ajax({
							url: 'deleteLike.do',
							type: 'POST',
							data: { likeNum: data },
							success: function(data2) {
								console.log('deleteLike data2 : ' + data2);

								// 삭제 성공
								if (data2 === true) {
									console.log('좋아요 삭제 성공');
									// 1 빼기
									likeCnt = likeCnt - 1;

									// 새 값 넣어주기
									document.getElementById('likeCount').innerText = likeCntValue;
								}
								// 삭제 실패
								else {
									console.log('좋아요 삭제 실패');
								}
							}
						});
					}
				})
		}
		// 로그인이 안 됐을 때
		else {
			Swal.fire({
				title: '로그아웃 상태',
				text: '로그인 후에 이용해주세요.',
				icon: 'error',
				confirmButtonText: '확인',
			}).then(() => {
				// 버튼 클릭 후 링크로 이동
				window.location.href = "login.do";
			});
		}
	});
	// 좋아요 버튼 끝
});

// likeNum을 얻기 위한 비동기 처리 함수
function getLikeNum() {
	return new Promise((resolve, reject) => {
		// likeNum을 얻기 위한 비동기 처리
		$.ajax({
			url: 'infoLike.do',
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify({
				boardNum: boardNum,
				memberNum: userPK
			}),
			dataType: 'json',
			success: function(likeNumData) {
				console.log('likeNumData : ' + likeNumData);
				resolve(likeNumData);
			},
			error: function(error) {
				reject(error);
			}
		});
	});
}

// 
function getLikeCnt(likeNum) {
	return new Promise((resolve, reject) => {
		// likeCnt을 얻기 위한 비동기 처리
		$.ajax({
			url: 'infoLikeCnt.do',
			type: 'POST',
			data: { likeNum: likeNum },
			success: function(likeCntData) {
				console.log('likeCntData : ' + likeCntData);
				resolve(likeCntData);
			}
			,
			error: function(error) {
				reject(error);
			}
		});
	});

}