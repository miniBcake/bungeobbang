$(document).ready(function() {
	kakao.maps.load(function() {
		console("맵 로드 완료 - map 출력 시작");
		
		//지도를 담을 영역의 DOM 레퍼런스
		var container = document.getElementById('addressSearchMap');
		//지도를 생성할 때 필요한 기본 옵션
		var options = {
			//지도의 중심좌표. 위도 경도 순으로 작성
			center : new kakao.maps.LatLng(33.450701, 126.570667),
			//지도의 레벨(확대, 축소 정도)
			level : 3
		};

		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	});
});