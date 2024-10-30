<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>주문받은 상품 페이지</title>
<meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
	name="viewport" />
<link rel="icon" href="resources/assets/images/logo.png"
	type="image/x-icon" />

<!-- 웹 폰트 및 아이콘 -->
<script src="resources/assets/js/plugin/webfont/webfont.min.js"></script>
<script>
	WebFont.load({
		google : {
			families : [ "Public Sans:300,400,500,600,700" ]
		},
		custom : {
			families : [ "Font Awesome 5 Solid", "Font Awesome 5 Regular",
					"Font Awesome 5 Brands", "simple-line-icons", ],
			urls : [ "resources/assets/css/fonts.min.css" ],
		},
		active : function() {
			sessionStorage.fonts = true;
		},
	});
</script>

<!-- CSS 스타일 -->
<link rel="stylesheet" href="resources/assets/css/bootstrap.min.css" />
<link rel="stylesheet" href="resources/assets/css/plugins.min.css" />
<link rel="stylesheet" href="resources/assets/css/kaiadmin.min.css" />
<link rel="stylesheet" href="resources/assets/css/admin.css">
</head>
<body>
	<script src="resources/assets/js/closedStoreDeclareList.js"></script>

	<!--1. 페이지 로드 시, 체크박스의 값이 1인지 0인지를 구분.
2. 1이라면 체크 표시 및 부모요소 <tr>의 배경색(해당 행) 회색처리
3. 0이라면 미체크 표시 및 부모요소 <tr>의 배경색 없음.(기본)
4. 사용자가 미체크 상태에서 체크할 시, 체크상태로 전환
5. 사용자가 체크상태에서 체크할 시, 미체크상태로 전환 
	2,4 / 3,5세트
-->

	<script>
	// 체크박스의 값 1일 때 배경색 설정(완료처리)
	document.addEventListener('DOMContentLoaded', () => {
	    const checkboxes = document.querySelectorAll('input[type="checkbox"]');
	    checkboxes.forEach(checkbox => {
	        const row = checkbox.closest('tr');
	        if (checkbox.checked) {
	            row.style.backgroundColor = '#d4edda'; // 초기 체크된 경우의 배경색
	        }
	    });
	});
	
	/*	주문 내역 확인 완료(체크박스) 표시 전환
		숨김 처리된 체크박스의 값
		1: 체크완료(처리)로 전환	|	0: 체크취소(미처리)로 전환		*/
	function adminchecking(checkbox) {
		const hiddenInput = document.querySelector('input[type="hidden"][name="adminChecked"]');
		hiddenInput.value = checkbox.checked ? "1" : "0";
		colorChecked(checkbox);
		// form태그 제출
		document.getElementById('adminchecking').submit();
	}
	function colorChecked(checkbox) {
		const row = checkbox.closest('tr'); // 체크박스의 부모 요소<tr> 확인
		if (checkbox.checked) {
			row.style.backgroundColor = '#d4edda'; // 체크된 경우의 배경색
		} else {
			row.style.backgroundColor = ''; // 체크 해제된 경우의 기본 배경색
		}
	}			
	</script>
	<div class="wrapper">
		<!-- 전체 페이지를 감싸는 wrapper -->
		<!-- Sidebar -->
		<custom:adminSidebar></custom:adminSidebar>
		<!-- End Sidebar -->
		<!-- 페이지의 메인 부분 -->
		<div class="main-panel">
			<div class="container">
				<div class="page-inner">
					<!-- 페이지 내부 -->
					<div class="page-header">
						<h3 class="fw-bold mb-3">주문받은 상품 목록</h3>
						<!-- 페이지 제목 -->
						<ul class="breadcrumbs mb-3">
							<!-- 관리자 페이지 내의 페이지 경로 -->
							<!-- 첫 번째 경로 -->
							<li class="nav-home"><a href="loadListOrder.do"> <!-- 홈 링크 -->
									<i class="icon-home"></i> <!-- 홈 아이콘 -->
							</a></li>
							<li class="separator"><i class="icon-arrow-right"></i> <!-- > 아이콘 -->
							</li>
							<!-- 두 번째 경로 -->
							<li class="nav-item"><a href="loadListOrder.do">주문받은 상품
							</a></li>
						</ul>
					</div>

					<!-- 메인 작성 부분-->
					<div class="row">
						<div class="col-md-12">
							<!-- 하얀 배경 부분-->
							<div class="card">
								<div class="card-body">
									<div class="table-responsive" style="text-align: center;">
										<!-- 테이블을 감싸는 div 추가 -->
										<form id="adminchecking" method="post"
											action="updateOrderCheck.do">
											<table class="table table-hover">
												<!--현재 확인하고 있는 행 확인 위한 호버-->
													<tr>
														<!--1열 : 상품주문내역 정보 카테고리-->
														<th scope="col">확인여부</th>
														<th scope="col">주문번호</th>
														<th scope="col">구매일시</th>
														<th scope="col">구매회원</th>
														<th scope="col">배송주소</th>
														<th scope="col">금액</th>
													</tr>
												<c:forEach var="orderList" items="${orderList}">
													<!-- 만약 체크박스 표시된 상태라면 해당 블록의 배경색을 변경 -->
													<tr>
														<!--주문내역 확인 여부-->
														<!-- 1: 주문내역 확인 완료-->
														<!-- 2: 주문내역 미확인 -->
														<td><div class="form-check">
																<input class="form-check-input" type="checkbox"
																	id="flexCheckDefault" id="adminCheck"
																	name="adminChecked" value="1"
																	onchange="adminchecking(checkbox)"
																	<c:if test="${orderList.checkedOrder == 1}"> checked </c:if>>
																<!-- 체크박스 표시 -->
															</div> <input type="hidden" id="adminUnCheck"
															name="adminChecked" value="0"></td>
														<!--주문번호-->
														<td>${orderList.orderNum}</td>
														<!--구매일시-->
														<td>${orderList.paymentDay}</td>
														<!--구매회원-->
														<td>${orderList.memberNum}</td>
														<!--금액-->
														<td>${orderList.paymentAmount}</td>
													</tr>
												</c:forEach>
											</table>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<footer class="footer">
				<!-- 페이지 하단 푸터 -->
				<div class="container-fluid d-flex justify-content-between">
					<!-- 푸터 내용, 플루이드 컨테이너로 좌우 정렬 -->
					<nav class="pull-left">
						<!-- 왼쪽 내비게이션 -->
					</nav>
					<div class="copyright">
						<!-- 저작권 정보 -->
						<img src="resources/assets/images/favicon.png"> 갈빵질빵
						<!-- ThemeKita 링크 -->
					</div>
					<div>
						<!-- 추가 정보 -->
						붕어빵원정대
						<!-- 배포 정보 -->
					</div>
				</div>
			</footer>
		</div>
		<!-- 메인 패널 종료 -->
	</div>
	<!-- 전체 wrapper 종료 -->

	<!-- Core JS Files -->
	<script src="../resources/assets/js/core/jquery-3.7.1.min.js"></script>
	<!-- jQuery 라이브러리 -->
	<script src="../resources/assets/js/core/popper.min.js"></script>
	<!-- Popper.js (툴팁 및 팝오버를 위한 라이브러리) -->
	<script src="../resources/assets/js/core/bootstrap.min.js"></script>
	<!-- Bootstrap JavaScript -->

	<!-- jQuery Scrollbar -->
	<script
		src="../resources/assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>
	<!-- jQuery 스크롤바 플러그인 -->
	<!-- Datatables -->
	<script
		src="../resources/assets/js/plugin/datatables/datatables.min.js"></script>
	<!-- DataTables 플러그인 -->

	<!-- Kaiadmin JS -->
	<script>
		$(document)
				.ready(
						function() { // 문서가 준비되면 실행되는 함수
							$("#basic-datatables").DataTable({}); // 기본 DataTable 초기화

							$("#multi-filter-select")
									.DataTable(
											{ // 다중 필터 선택 DataTable 초기화
												pageLength : 5, // 페이지당 항목 수
												initComplete : function() { // 초기화 완료 후 실행되는 함수
													this
															.api()
															// DataTable API 호출
															.columns()
															// 모든 열에 대해
															.every(
																	function() { // 각 열에 대해 반복
																		var column = this; // 현재 열을 변수에 저장
																		var select = $(
																				'<select class="form-select"><option value=""></option></select>' // 필터 선택 박스 생성
																		)
																				.appendTo(
																						$(
																								column
																										.footer())
																								.empty())
																				// 열의 푸터에 추가
																				.on(
																						"change",
																						function() { // 선택 박스 변경 시
																							var val = $.fn.dataTable.util
																									.escapeRegex($(
																											this)
																											.val()); // 선택된 값 정규 표현식으로 변환

																							column
																									// 현재 열에 대해
																									.search(
																											val ? "^"
																													+ val
																													+ "$"
																													: "",
																											true,
																											false)
																									// 선택된 값으로 검색
																									.draw(); // 테이블 다시 그리기
																						});

																		column
																				// 현재 열의 데이터에 대해
																				.data()
																				// 데이터 가져오기
																				.unique()
																				// 고유한 값만 가져오기
																				.sort()
																				// 정렬
																				.each(
																						function(
																								d,
																								j) { // 각 데이터에 대해 반복
																							select
																									.append( // 선택 박스에 옵션 추가
																									'<option value="' + d + '">'
																											+ d
																											+ "</option>");
																						});
																	});
												},
											});

							// Add Row
							$("#add-row").DataTable({ // 추가 행 DataTable 초기화
								pageLength : 5, // 페이지당 항목 수
							});

							var action = // 행에 추가할 액션 버튼 HTML
							'<td> <div class="form-button-action"> <button type="button" data-bs-toggle="tooltip" title="" class="btn btn-link btn-primary btn-lg" data-original-title="Edit Task"> <i class="fa fa-edit"></i> </button> <button type="button" data-bs-toggle="tooltip" title="" class="btn btn-link btn-danger" data-original-title="Remove"> <i class="fa fa-times"></i> </button> </div> </td>';

							$("#addRowButton").click(function() { // 추가 버튼 클릭 시
								$("#add-row") // 추가 행 DataTable에
								.dataTable() // DataTable API 호출
								.fnAddData([ // 데이터 추가
								$("#addName").val(), // 이름 입력값
								$("#addPosition").val(), // 직위 입력값
								$("#addOffice").val(), // 사무실 입력값
								action, // 액션 버튼
								]);
								$("#addRowModal").modal("hide"); // 모달 닫기
							});
						});
	</script>
</body>

</html>