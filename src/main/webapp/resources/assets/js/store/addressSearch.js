// 페이지기 다 준비되면 작동
$(document).ready(function() {
	// 값이 그대로일 경우에 검색 방지를 위한 초기값 저장
	var preCity = $('#city').val();
	var preDistrict = $('#district').val();
	console.log('addressSearch.js : preCity : [' + preCity + ']');
	console.log('addressSearch.js : preDistrict : [' + preDistrict + ']');

	// id가 city인 것의 값이 변경되면
	$('#city').change(function() {
		console.log('addressSearch.js : select city가 변경됨');

		// 주소 검색 값들 가져옴
		// id가 city 값인 value 가져오기
		var city = $(this).val();
		console.log('addressSearch.js : city : [' + city + ']');

		// 만약 preCity 값과 city 값이 다르다면
		if (preCity !== city) {
			// 나머지 주소 가져오기
			// id가 district 값인 value 가져오기
			var district = $(this).val();
			console.log('addressSearch.js : district : [' + district + ']');

			// 두 주소 검색값을 하나로 합치기
			var address = city + ' ' + district;
			address = address.trim();
			console.log('addressSearch.js : address : [' + address + ']');

			// 검색 및 출력 작업
			selectSearch(address);
			
			// 값 변경해주기
			preCity = city;
		}
	});

	// id가 city인 것의 값이 변경되면
	$('#district').change(function() {
		console.log('addressSearch.js : select district가 변경됨');
		// id가 district 값인 value 가져오기
		var district = $(this).val();
		console.log('addressSearch.js : district : [' + district + ']');

		// 만약 preCity 값과 city 값이 다르다면
		if (preDistrict !== district) {
			// 나머지 주소 가져오기
			// id가 district 값인 value 가져오기
			var city = $('#city').val();
			console.log('addressSearch.js : city : [' + city + ']');

			// 두 주소 검색값을 하나로 합치기
			var address = city + ' ' + district;
			address = address.trim();
			console.log('addressSearch.js : address : [' + address + ']');

			// 검색 및 출력 작업
			selectSearch(address);
			
			// 값 변경해주기
			preDistrict = district;
		}
	});
});

function selectSearch(address) {
	// 검색한 가게들 가져오기
	searchStore(address)
		// 주소 검색이 들어가야 함
		.then(positions => {
			console.log('addressSearch.js : positions : [' + positions + ']');

			createMapAndMarker(positions);
		})
		.catch(error => {
			console.error(error);
		});
}


// 사용자 주소 검색 함수
function searchStore(address) {
	// ajax 실행
	return new Promise((resolve, reject) => { // Promise를 반환하도록 수정
		$.ajax({
			// json 형식으로 전달
			url: 'addressSearch.do',
			type: 'POST',
			// 요청 데이터 application/json
			contentType: 'application/json',
			data: JSON.stringify({ storeDefaultAddress: address }),
			dataType: 'json',
			// 성공 시
			success: function(data) {
				// data 존재 확인 로그 (데이터 자체를 보기는 힘듬으로 자체를 보기는 힘듬으로 길이만 잼)
				console.log('addressSearch.js : data.length : [' + data.length + ']');

				// #storeList 가져오기
				// 내부 요소들을 변경할 것이므로 요소 자체를 가져옴
				var storeList = $('#storeList');
				console.log('addressSearch.js : storeList : ');
				console.log('                   [' + storeList + ']');

				// 기존 데이터 초기화
				storeList.empty();

				// 주소를 좌표로 변환 객체를 생성
				var geocoder = new kakao.maps.services.Geocoder();

				// 데이터가 만약 비어있다면
				if (data.length < 0) {
					storeList.append('<span> 검색 결과 없음</span>');
					resolve([]); // 비어있는 배열 반환
				} else {
					// 주소의 좌표를 보관할 배열 생성
					var positions = [];
					// 모든 비동기 작업을 보관할 배열
					var promises = [];

					// 온 data 갯수만큼 하나씩 코드를 작성하여 넣음
					data.forEach(function(item) {
						// <customStore:simpleStoreData/> 출력
						append(storeList, item);

						// 지도에 표시
						// item에서 주소 가져오기
						var itemAddress = item.storeDefaultAddress;
						console.log('addressSearch.js : itemAddress : [' + itemAddress + ']');

						// 주소로 좌표를 검색
						var promise = new Promise((innerResolve, innerReject) => {
							geocoder.addressSearch(itemAddress, function(result, status) {
								// 정상적으로 검색이 완료됐다면
								if (status === kakao.maps.services.Status.OK) {
									console.log('addressSearch.js : 주소를 좌표로 변경 완료');

									// positions.에 값 넣어줌
									positions.push({
										title: item.storeName,
										latlng: new kakao.maps.LatLng(result[0].y, result[0].x)
									});
									innerResolve(); // innerPromise 해결
								} else {
									innerReject(status); // 실패 시 reject
								}
							});
						});
						promises.push(promise); // 모든 비동기 작업을 promises 배열에 추가
					});

					// 모든 비동기 작업이 완료된 후 처리
					Promise.all(promises)
						.then(() => {
							resolve(positions); // 최종적으로 positions 반환
						})
						.catch((error) => {
							console.error('주소 변환 중 오류 발생: ', error);
							reject(error); // 오류 발생 시 reject
						});
				}
			},
			// ajax 요청 실패 시
			error: function(err) {
				console.error('ajax 요청 실패 : ', err);
				reject(err); // ajax 실패 시 reject
			}
		});
	});
}

// map을 생성하고 마커 표시
function createMapAndMarker(positions) {
	//지도를 담을 영역의 DOM 레퍼런스
	var container = document.getElementById('addressSearchMap');
	//지도를 생성할 때 필요한 기본 옵션
	var options = {
		//지도의 중심좌표. 위도 경도 순으로 작성
		center: new kakao.maps.LatLng(33.450701, 126.570667),
		//지도의 레벨(확대, 축소 정도)
		level: 3
	};

	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

	// map에 표시
	for (var i = 0; i < positions.length; i++) {

		// 마커를 생성
		var marker = new kakao.maps.Marker({
			map: map,
			position: positions[i].latlng,
			title: positions[i].title
		});
	}

	// 지도 이동
	// 지도 중심좌표를 접속위치로 변경
	map.setCenter(positions[0].latlng);
}