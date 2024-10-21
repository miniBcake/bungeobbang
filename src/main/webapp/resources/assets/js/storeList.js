// 페이지가 로드 되었을 때 실행
$(document).ready(function() {
	// 기존의 데이터 리스트를 가져옴
	// 데이터가 변경될 것이므로 객체 자체를 가져옴
	var dataList = $('#tagBox');

	// 체크박스 상태가 변경될 때 호출되는 이벤트 핸들러
	$('input[type="checkbox"]').on('change', function() {
		// 체크박스가 선택된 경우
		if ($(this).is(':checked')) {
			// 체크박스 다음의 <span> 텍스트 가져오기
			const checkBoxValue = $(this).val();
			console.log('checkBoxValue : [' + checkBoxValue + ']')

			// 기존 박스에 태그 추가
			dataList.append(
				'<span class="filterOption">'
				+ checkBoxValue
				+ '<button class="filterButton">X</button>'
				+ '</span>'
			)
		}
		// 체크박스가 해제된 경우
		else {
			// checkBox의 value 값을 사용하여 해당 태그 제거
			// 체크박스 다음의 <span> 텍스트 가져오기
			const checkBoxValue = $(this).val();

			// 체크박스 해제 로그
			console.log(checkBoxValue + ' 체크 해제')

			// 텍스트 요소가 같은 요소를 찾아서 제거
			dataList.find('.filterOption').filter(function() {
				// value값이 같은 값 반환
				console.log('같은 값 존재 : [' + $(this).data('value') === checkBoxValue + ']')
				return $(this).text().trim() === checkBoxValue;
			}).remove();
		}
	});


	// x버튼을 눌렀을 때 해당 태그를 제거
	$(document).on('click', '.filterButton', function() {
		// 해당 태그의 텍스트 가져옴
		const tag = $(this).parent('.filterOption').text.trim
		console.log('tag : [' + tag + ']')

		// 태그 제거
		$(this).parent('.filterOption').remove();

		// 해당 테그와 일치하는 체크박스 해제
		$('input[type="checkbox"]').filter(function() {
			// <span>의 텍스트와 비교
			console.log('비교'+$(this).next('span').text().trim())
			return $(this).next('span').text().trim() === tag;
		}).prop('checked', false);
	});


});