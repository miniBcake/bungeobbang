// 페이지가 로드 되었을 때 실행
$(document).ready(function() {

	// 복사하기 버튼 눌렀을 때 수행 되는 함수
	copyStorePhoneNumber();

	// storeList 페이지네이션
	storePagenation();

});

// 복사하기 버튼 눌렀을 때 수행 되는 함수
function copyStorePhoneNumber() {
	// class가 copy인 btn이 클릭되었을 때
	$('.copy').on('click', function() {
		// 버튼에서 val 값을 가져옴
		const storePhoneNum = $(this).val();

		// 복사 기능
		navigator.clipboard.writeText(storePhoneNum).then(function() {
			alert('복사 했습니다!');
		}, function(err) {
			alert('복사에 실패 했습니다..: ', err);
		});
	});
}