//게시물 전체 조회 스크립트	///////////////////////////

// 특정 행(게시물)을 클릭하면 상세조회 이동
$(document).ready(function() {
// 	$(document).on('click', '.infoBoardRow', function() {
// 		$('#infoBoardform').submit(); // 수정 폼 제출
// 	});



	//글쓰기 버튼을 누르면
	// $(document).on('click', '#addBoardButton', function() {
	// 	$('#addBoardForm').submit(); // 수정 폼 제출
	//
	// });

	
	
	

	//상세조회 스크립트		///////////////////////////
	
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
});
