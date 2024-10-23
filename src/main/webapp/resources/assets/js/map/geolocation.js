/*
$(document).ready(function() {
	kakao.maps.load(function() {
		console("맵 로드 완료 - geolocation 시작");

		// HTML5의 geolocation으로 사용할 수 있는지 확인
		if (navigator.geolocation) {

			// GeoLocation을 이용해서 접속 위치를 얻어옴
			navigator.geolocation.getCurrentPosition(function(position) {
				// lat : 위도, lon : 경도
				var lat = position.coords.latitude,
					lon = position.coords.longitude;

				// locPosition: geolocation으로부터 마커가 표시될 위치 좌표를 생성
				// message: 인포 윈도우에 표시될 내용
				var locPosition = new kakao.maps.LatLng(lat, lon),
					message = '<div style="padding:5px;">여기에 계신가요?!</div>';

				// 마커와 인포윈도우를 표시
				displayMarker(locPosition, message);

			});

			// 만약 확인할 수 없다면
			// 마커 표시 위치와 인포윈도우 내용을 설정
		} else {
			// 특정 좌표를 지정
			// 나중에 가게 하나를지정하여 그곳 위치를 찝음
			var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),
				// 
				message = 'geolocation을 사용할수 없어요..'

			displayMarker(locPosition, message);
		}

		// 지도에 마커와 인포윈도우를 표시하는 함수
		function displayMarker(locPosition, message) {

			// 마커를 생성
			var marker = new kakao.maps.Marker({
				map: map,
				position: locPosition
			});

			// 인포 윈도우에 표시할 내용
			var iwContent = message,
				iwRemoveable = true;

			// 인포윈도우를 생성
			var infowindow = new kakao.maps.InfoWindow({
				content: iwContent,
				removable: iwRemoveable
			});

			// 인포윈도우를 마커위에 표시
			infowindow.open(map, marker);

			// 지도 중심좌표를 접속위치로 변경
			map.setCenter(locPosition);
		}
	});
}); */