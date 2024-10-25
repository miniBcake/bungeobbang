// 페이지가 모두 준비되면 작동
$(document).ready(function() {
	console.log("페이지 준비 완료");

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

	// map 객체 생성 확인
	console.log('map 생성 확인 : [' + map + ']');
	
kakao.maps.load(function() {
	console.log("맵 로드 완료 - map 출력 시작");

	// 내 위치 중심으로 표시
	geolocation(map);
	
	// 주변 가게 출력
	addressToLatLngAndMarker(map, '서울시 강남구 논현로87길 17');
});
});

// 사용자의 위치를 표시하는 함수
function geolocation(map) {
console.log("맵 로드 완료 - geolocation 시작");

// HTML5의 geolocation으로 사용할 수 있는지 확인
// 사용자의 위치를 확인할 수 있는지 여부를 판단하는 조건
if (navigator.geolocation) {
	console.log('사용자 위치 확인 가능');

	// GeoLocation을 이용해서 접속 위치를 얻어옴
	// 사용자의 위치좌표를 콜백 함수로 전달
	navigator.geolocation.getCurrentPosition(function(position) {
		// 현재 좌표값을 가져와 저장
		// lat : 위도, lon : 경도
		var lat = position.coords.latitude,
			lon = position.coords.longitude;

		// 좌표 로그
		console.log('좌표 : [' + lat, lon + ']');

		// 카카오 지도에서 사용할 수 있는 좌표객체 생성
		// locPosition: geolocation으로부터 마커가 표시될 위치 좌표를 생성
		// message: 인포 윈도우에 표시될 내용
		var locPosition = new kakao.maps.LatLng(lat, lon),
			message = '<div style="padding:5px;">여기에 계신가요?!</div>';

		// 좌표 객체 확인
		console.log('좌표 객체 : [' + locPosition + ']');

		// 마커와 인포윈도우를 표시
		displayMarker(locPosition, message);

	});

	// 만약 확인할 수 없다면
	// 마커 표시 위치와 인포윈도우 내용을 설정
} else {
	console.log('사용자 위치 확인 불가능');
	// 기본 좌표를 지정
	// 나중에 가게 하나를지정하여 그곳 위치를 찝음
	var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),
		// 
		message = 'geolocation을 사용할수 없어요..'

	displayMarker(locPosition, message);
}

// 지도에 마커와 인포윈도우를 표시하는 함수
function displayMarker(locPosition, message) {
	console.log("지도 위에 마커 표시 시작");

	// 마커를 생성
	// map이라는 지도 객체에 locPosition에서 지정한 좌표로 설정
	var marker = new kakao.maps.Marker({
		map: map,
		position: locPosition
	});

	// 마커 생성 확인 
	console.log('marker 확인 : [' + marker + ']')

	// 인포 윈도우에 표시할 내용
	// 표시 내용가 인포윈도를 닫을 수 있도록 허용 
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
}

// 주소를 좌표로 변경하고 마커를 찍는 함수
function addressToLatLngAndMarker(map, address) {
console.log('주소를 좌표로 변경 시작');

// 주소를 좌표로 변환 객체를 생성
// Geocoder()은 주소를 좌표로 변환하거나, 좌표를 주소로 변환하는 역할을 함
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색
// addressSearch(주소값, 콜백 함수) : 주소를 좌표로 변경해주는 함수
// result : 검색된 좌표 정보가 들어있는 배열
// status : 검색 요청의 결과 상태를 나타냄 (정상 시 ok 상태가 반환)
geocoder.addressSearch(address, function(result, status) {

	// 정상적으로 검색이 완료됐다면
	// 만약 OK 상태가 반환돼었다면
	if (status === kakao.maps.services.Status.OK) {
		console.log('주소를 좌표로 변경 완료');
		
		// 마커를 생성하는 코드
		// 결과의 좌표값을 입력 함
		var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

		// 마커 생성
		// 결과값으로 받은 위치를 마커로 표시
		var marker = new kakao.maps.Marker({
			// 마커가 표시될 객체 지정
			map: map,
			// 마커가 표시될 좌표 설정
			position: coords
		});
		
		console.log('marker 확인 : [' + marker + ']');

		// 인포윈도우로 장소에 대한 설명을 표시
		var infowindow = new kakao.maps.InfoWindow({
			content: '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
		});
		infowindow.open(map, marker);
	}
});
}