//로그인하기 위한 비밀번호 찾기(회원 여부 확인)

/*1. 이름 이메일 입력
2. 비밀번호 재설정 하러가기 클릭
3. 비동기처리 : 이름, 이메일 기반 회원정보 확인(checkEmailName.do)
4. 반환값 : Map<String, Object> (String : true/false | Object : MemberDTO)
5. 키값이 true이면 스위트 알랏으로 회원정보가 확인되었습니다. 새 비밀번호를 입력해주세요. 이때, MemberDTO 고유번호 가지고 있기
6. 키값이 false이면 스위트 알랏으로 회원정보가 없습니다. 다시 정보를 입력해주시거나 회원가입해주세요.
*/
$(document).ready(function() {
	console.log('loginPwFind.js');
	
	// 전역 변수로 memberNum 정의
	let memberNum;


	//회원 정보 확인하기
	$('#loginPwFind').on('click', function() {//회원정보 확인 버튼 누르면
		console.log("log: loginPwFind clicked");
		//이벤트가 발생하게 만든 주체, 즉 사용자가 입력한 상태값을 가져와 상태로 변수로 지칭
		const name = document.getElementById('name').value;
		const email = document.getElementById('email').value;

		console.log('name: ' + name);
		console.log('email: ' + email);

		//ajax를 통해 비동기처리 진행
		$.ajax({
			url: 'checkPWFind.do',
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify({
				memberName: name,
				memberEmail: email
			}),
			dataType: 'json',
			success: function(result) {
				console.log("response : " + result);
				if (result > 0) { // 키 값이 true인 경우
					Swal.fire({
						icon: 'success',
						title: '회원 정보 확인',
						text: '회원정보가 확인되었습니다. 새 비밀번호를 입력해주세요.',
						confirmButtonText: '새로운 비밀번호로 변경하기'
					}).then(function() {
						// MemberDTO 고유번호 가지고 새로운 비밀번호 입력 모달 열기
						openSetPasswordModal(result); // memberNum을 넘겨주는 함수
					});
				} else { // 키 값이 false인 경우
					Swal.fire({
						icon: 'error',
						title: '회원 정보 없음',
						text: '회원정보가 없습니다. 다시 정보를 입력해주시거나 회원가입해주세요.',
						confirmButtonText: '확인'
					});
				}
			},
			error: function(error) {
				console.error('AJAX 요청 실패:', error);
				Swal.fire({
					icon: 'error',
					title: '오류',
					text: '서버와의 통신에 실패했습니다.',
					confirmButtonText: '확인'
				});
			}
		});
	});
	
	// 비밀번호 변경 버튼 클릭 이벤트
	document.getElementById('completePw').addEventListener('click', function(event) {
		event.preventDefault(); // 선 작동 방지

		const password = document.getElementById('changPassword').value;
		const passwordCheck = document.getElementById('passwordCheck').value;

		console.log("log: password : [" + password + "]");
		console.log("log: passwordCheck : [" + passwordCheck + "]");

		// // 비밀번호 일치 여부 확인
		// if (password !== passwordCheck) {
		//     return; // 비밀번호가 일치하지 않으면 함수 종료
		// }
		// 비밀번호 일치 여부 확인
		if (password === passwordCheck) {
			$('#setPw').submit(); // 비밀번호가 일치하면 전송
		}


		// 비밀번호 변경 요청
		// $.ajax({
		//     url: 'setPw.do',
		//     type: 'POST',
		//     contentType: 'application/json',
		//     data: JSON.stringify({
		//         memberNum: $('#passwordFindResult').val(), 	// 가지고 있던 member정보
		//         memberPassword: password		// 사용자가 입력한 신규 비밀번호
		//     }),
		//     dataType: 'json',
		//     success: function(result) {
		//         if (result.success) {
		//             Swal.fire({
		//                 icon: 'success',
		//                 title: '비밀번호 변경 성공',
		//                 text: '비밀번호가 성공적으로 변경되었습니다.',
		//                 confirmButtonText: '확인'
		//             }).then(() => {
		//                 closedModal(); // 모달 닫기
		// 				console.log("loginPwFind.js newPassword complete");
		//             });
		//         }
		//         else {
		//             Swal.fire({
		//                 icon: 'error',
		//                 title: '오류',
		//                 text: '비밀번호 변경에 실패했습니다.',
		//                 confirmButtonText: '확인'
		//             });
		// 			console.log("loginPwFind.js newPassword success end");
		//         }
		//     },
		//     error: function() {
		//         console.error('서버와의 통신 실패:', error);
		//         Swal.fire({
		//             icon: 'error',
		//             title: '오류',
		//             text: '서버와의 통신에 실패했습니다.',
		//             confirmButtonText: '확인'
		//         });
		// 		console.log("loginPwFind.js newPassword error end");
		//     }
		// });
	});
});


//두번째 모달창(새비밀번호입력) 열기
function openSetPasswordModal(memberNum) {
	// memberNum 저장
	document.getElementById('passwordFindResult').value = memberNum;
	document.getElementById('forgetModal').style.display = 'none';//첫번째 모달 닫기
	document.getElementById('setPwModal').style.display = 'block';//두번째 모달 열기
	console.log("loginPwFind.js second modal open");
	// 비밀번호 일치 여부 확인 초기화
	// document.getElementById('resultPW').textContent = '';
}

// 비밀번호 확인 입력 필드의 값이 변경될 때마다 일치 여부 확인
// $(document).ready(function() {
//     $('#passwordCheck').on('change', function() {
//         var doublePassword = $(this).val(); // 비밀번호 확인란의 값
//         var password = $('#password').val(); // 신규 비밀번호란의 값
//
//         $('#completePw').prop('disabled', false);
//         console.log("loginPwFind.js Password document ready");
//
//         if(doublePassword === password){
//             console.log("log: password check clear")
//             $('#completePw').prop('disabled', true);
//         }
//     });
// });