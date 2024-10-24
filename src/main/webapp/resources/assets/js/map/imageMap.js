// 페이지가 모두 준비되면 작동
// 주소를 좌표로 추출 + 이미지 지도 생성 + 마커 표시
// 좌표값을 생성해서바로 사용해야 하므로 좌표 추출 함수 내부에 이미지 지도를생성하고 마커를 표시하는 코드를 작성
$(document).ready(function() {
	console.log('주소를 좌표로 변경 시작');
	
	// id가 address 요소를 가져오기
	// 해당 부문에서 주소 값을 가져올 예정
	var element = document.getElementById('address');

	// 가져온 element 값에서 text 값만 추출해서 가져옴
	var address = element.textContent.trim();
	console.log('address : ['+address+']');

	// 좌표를 담을 변수 제작
	var latLng = {};

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

			// 좌표 값을 배열에 담음
			// 위도를 담음
			latLng.lat = result[0].y;
			// 경도를 담음
			latLng.lng = result[0].x;

			console.log('위도 값:[' + latLng.lat + '], 경도 값 : [' + latLng.lng + ']');
			
			// 이미지 지도를 생성하고, 마커를 포시하는 함수를 사용
			imageMap(latLng);
		}
	});
});

// 이미지 지도를 생성하고, 마커를 표시하는 함수
function imageMap(latLng) {
	// 좌표 객체 만들기
	var markerPosition = new kakao.maps.LatLng(latLng.lat, latLng.lng);
	
	// 지도에 표시할 마커 생성
	var marker = {
		position: markerPosition
	}
	
	// 이미지 지도를 표시할 div를 설정하고, 옵션 셋팅
	var staticMapContainer = document.getElementById('map'),
		staticMapOption = {
			// 이미지 지도의 중심좌표
			center: markerPosition,
			// 이미지 지도의 확대 레벨
			level: 3,
			// 이미지 지도에 표시할 마커
			marker: marker
		};

	// 이미지 지도를 표시할 div와 옵션으로 이미지 지도를 생성
	var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption);
	console.log('이미지 지도 생성 완료');
}