// 페이지가 로드 되었을 때 실행
$(document).ready(function() {

	// 체크박스 상태가 변경될 때 호출되는 이벤트 핸들러
	toggleTagByCheckbox();

	// x버튼을 눌렀을 때 해당 태그를 제거
	tagByXbutton();

	// storeList 페이지네이션
	storePagenation();


});


// 함수 목록 ------------------------------------------------------------------------------------------------

// 체크박스 내부 값 로그 함수
function checkBoxLog() {
	// 체크 박스의 값을 담을 배열 생성
	const checkedValues = [];

	// checkbox 값들 가져오기
	// 메뉴 checkbox 가져오기
	const menuCheckBox = document.querySelectorAll('input[name="storeMenu"]:checked');
	console.log('menuCheckBox : [' + Array.from(menuCheckBox) + ']');

	// 결제방법 checkbox 가져오기
	const paymentCheckBox = document.querySelectorAll('input[name="storePayment"]:checked');
	console.log('paymentCheckBox : [' + Array.from(paymentCheckBox) + ']');

	// 체크박스의 값을 모두 모을 배열 생성
	menuCheckBox.forEach((checkbox) => {
		checkedValues.push(checkbox.value);
	});
	paymentCheckBox.forEach((checkbox) => {
		checkedValues.push(checkbox.value);
	});

	console.log('체크된 값들 : [' + checkedValues + ']');
}

// 체크박스로 태그값을 변경하는 함수
function toggleTagByCheckbox() {
	$('input[type="checkbox"]').on('change', function() {
		// 기존의 데이터 리스트를 가져옴
		// 데이터가 변경될 것이므로 객체 자체를 가져옴
		var dataList = $('#tagBox');

		// 체크박스가 선택된 경우
		if ($(this).is(':checked')) {
			// 해당 체크박스의 data-role 값 가져오기
			const checkBoxValue = $(this).attr('data-role');
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
			// 해당 체크박스의 data-role 값 가져오기
			$(this).attr('data-role');
			const checkedBoxValue = $(this).attr('data-role');
			console.log('checkedBoxValue : [' + checkedBoxValue + ']')

			console.log('텍스트 요소가 같은 요소를 찾음');

			// 텍스트 요소가 같은 요소를 찾아서 제거
			dataList.find('.filterOption').filter(function() {
				// value값이 같은 값 반환
				var tag = $(this).text().trim();

				// 뒤에 x자 지우기 (1글자 생략)
				tag = tag.slice(0, -1);

				console.log('tag : [' + tag + ']');
				return tag === checkedBoxValue;
			}).remove();


			// 체크박스 해제 로그
			console.log(checkedBoxValue + ' 체크 해제')
		}

		checkBoxLog();

	});
}

function tagByXbutton() {
	$(document).on('click', '.filterButton', function() {
		// 해당 태그의 텍스트 가져옴
		// closest()으로 가장 가까운 부모 중 class가 'filterOption'인 요소를 찾음
		// .content를 통해 span 요소의 모든 자식 노드를 가져옴
		const tag = $(this).parent('.filterOption').contents().filter(function() {
			// 현재 노드 타입이 text 노드인 값만 가져옴
			return this.nodeType === Node.TEXT_NODE;
		}).text().trim();

		// span 태그의 text만 출력
		console.log('tag : [' + tag + ']')

		// 태그 제거
		$(this).parent('.filterOption').remove();

		// 해당 테그와 일치하는 체크박스 해제
		$('input[type="checkbox"]').filter(function() {
			// 해당 체크박스의 data-role 값 가져오기
			const checkBoxValue = $(this).attr('data-role');
			console.log('checkBox의 값 : [' + checkBoxValue + '], tag 값 : [' + tag + ']');

			return checkBoxValue === tag;
		}).prop('checked', false);

		checkBoxLog();
	});
}

// 가게 페이지네이션을 위한 함수
function storePagenation() {

	// id가 pagenationValue인 것을 클릭했다면
	$('.pagenationValue').on('click', function() {
		// a태그 링크를 잠시 멈춤
		console.log("페이지에이션 버튼 클릭");

		// 값들을 가져오기 위힌 배열
		var menu_arr = [];
		var payment_arr = [];
		var storeClosed = null;
		let checkBoxUrl = '';
		console.log("checkBoxUrl : " + checkBoxUrl);

		// input 태그 중 name 값이 storeMenu이면서 checked 된 값들 menu_arr에 넣음
		$("input[name=storeMenu]:checked").each(function() {
			const menu = document.querySelectorAll('input[name="storeMenu"]:checked');
			menu_arr.push(menu);
			console.log("menu : " + menu);
			console.log("menu_arr : " + menu_arr);
		})
		// input 태그 중 name 값이 storePayment이면서 checked 된 값들 payment_arr에 넣음
		$("input[name=storePayment]:checked").each(function() {
			const payment = document.querySelectorAll('input[name="storePayment"]:checked');
			payment_arr.push(payment);
			console.log("payment : " + payment);
			console.log("payment_arr : " + payment_arr);
		})
		// input 태그 중 name 값이 storeClosed이면서 이면서 checked 된 값들 storeClosed에 넣음
		$("input[name=storeClosed]:checked").each(function() {
			storeClosed = $(this).val().trim();
			console.log("storeClosed : " + storeClosed);
		})

		// url에 넣을 checkBoxUrl 생성 부분
		// menu_arr에 있는 요소들을 '&storeMenu='와 붙여서 넣음
		menu_arr.forEach(function(menu) {
			checkBoxUrl += '&storeMenu=' + encodeURIComponent(menu);
		})
		// payment_arr에 있는 요소들을 '&storePayment='와 붙여서 넣음
		payment_arr.forEach(function(payment) {
			checkBoxUrl += '&storePayment=' + encodeURIComponent(payment);
		})
		// storeClosed가 존재한다면 '&storeClosed='을 붙여서 넣음
		if (storeClosed != null) {
			checkBoxUrl += '&storeClosed=' + encodeURIComponent(storeClosed);
		}

		// 페이지네이션 관련 요소들 가져옴
		let preLink = document.getElementById('pagenationPreValue');
		let nextLink = document.getElementById('pagenationNextValue');
		let pageLinks = document.querySelectorAll('#pagination a[class^="pagenationValue"]');

		console.log('pageLinks : [' + pageLinks + ']');

		if (pageLinks.length > 0) {
			pageLinks.forEach(function(link) {
				link.addEventListener('click', function(event) {
					event.preventDefault();
					link.href += checkBoxUrl; // 검색 조건 추가
					window.location.href = link.href;
				});
			});
		}
		if (preLink) {
			preLink.addEventListener('click', function(event) {
				event.preventDefault();
				preLink.href += checkBoxUrl; // 검색 조건 추가
				window.location.href = preLink.href;
			});
		}
		if (nextLink) {
			nextLink.addEventListener('click', function(event) {
				event.preventDefault();
				nextLink.href += checkBoxUrl; // 검색 조건 추가
				window.location.href = nextLink.href;
			});
		}


		console.log("완료된 checkBoxUrl : " + checkBoxUrl);
	});
}
