/*
1. 이메일 중복검사 및 닉네임 중복검사해야만 수정완료 버튼 작용
*/
//아래로직과 똑같음.. 나중에 제거 필요. 컴파일 꼬임 발생으로 2개 생성함
function a(event) {
	// 선택된 파일을 가져옴
	const file = event.target.files[0];
	console.log('mypageUpdate.js previewImge(event) load complete');

	// FileReader 객체를 생성
	const reader = new FileReader();
	console.log('mypageUpdate.js previewImge(event) read');

	// 파일이 로드되었을 때 실행되는 이벤트 핸들러
	reader.onload = function() {
		console.log('mypageUpdate.js previewImge(event) loading');

		// 미리보기 이미지 태그의 src 속성을 선택된 파일의 데이터로 설정
		const previewImage = document.getElementById('previewImage');
		previewImage.src = reader.result; // 파일의 데이터 URL
		//reviewImage.style.display = 'block'; // 이미지 태그를 보이도록 설정
		console.log('mypageUpdate.js previewImge(event) show');

	};

	// 파일 읽기 시작
	reader.readAsDataURL(file);
	console.log('mypageUpdate.js previewImge(event) show complete');

}
$(document).ready(function() {

	// 파일 입력 필드에서 파일이 선택되었을 때 호출되는 함수
	function previewImage(event) {
		// 선택된 파일을 가져옴
		const file = event.target.files[0];
		console.log('mypageUpdate.js previewImge(event) load complete');

		// FileReader 객체를 생성
		const reader = new FileReader();
		console.log('mypageUpdate.js previewImge(event) read');

		// 파일이 로드되었을 때 실행되는 이벤트 핸들러
		reader.onload = function() {
			console.log('mypageUpdate.js previewImge(event) loading');

			// 미리보기 이미지 태그의 src 속성을 선택된 파일의 데이터로 설정
			const previewImage = document.getElementById('previewImage');
			previewImage.src = reader.result; // 파일의 데이터 URL
			previewImage.style.display = 'block'; // 이미지 태그를 보이도록 설정
			console.log('mypageUpdate.js previewImge(event) show');

		};

		// 파일 읽기 시작
		reader.readAsDataURL(file);
		console.log('mypageUpdate.js previewImge(event) show complete');

	}
	//마이페이지 정보 수정 필수 요소
	var isNicknameChecked = false; // 닉네임 중복 확인 여부
	var isPhoneNumChecked = false;//전화번호 12자리 확인 여부
	var isPasswordChecked = false;//비밀번호 영문/한글/숫자 보안성 확보 여부

	// 닉네임 중복 확인 버튼 클릭
	var nick = "${member.memberNickname}";
	$('#checkNicknameBtn').on('click', function() {
		if ($('#nickname').val() !== '') {//닉네임 입력되어 있고
			if ($('#nickname').val() === nick) {//내 이전 닉네임과 같을 때
				$("#checkNicknameMsg").text("기존의 닉네임과 동일한 닉네임입니다.").css('color', 'red');
				isNicknameChecked = true; // 중복결과 동일하다 true반환
				console.log("mypageUpdate.js nicknameCheckButton each");
			} else {
				console.log("mypageUpdate.js nicknameCheckButton react");
				checkNicknameFunction(); //비동기처리 진행
			}
		} else {
			Swal.fire({
				icon: 'error',
				title: '오류',
				text: '닉네임을 다시 입력해주세요',
				confirmButtonText: '확인'
			});
		}
	});

	// 닉네임 중복 확인 함수
	function checkNicknameFunction() {
		console.log("mypageUpdate.js checkNickNameFunction() start");
		var nickName = $('#nickName').val();
		$.ajax({
			url: 'checkNickName.do',
			method: 'POST',
			data: {
				nickName: nickName
			},
			success: function(data) {
				console.log("[" + data + "]");
				if (data === 'true') {
					$("#checkNickNameMsg")
						.text("사용가능한 닉네임입니다.").css('color', 'green');
					isNickNameChecked = true; // 중복 확인 성공 시 true로 설정
				} else {
					$("#checkNickNameMsg").text(
						"이미 사용중인 닉네임입니다.").css('color', 'red');
					$('#nickName').val('').focus();
				}
				console.log("mypageUpdate.js checkNickNameFunction() sucess");
			},
			error: function() {
				Swal.fire({
					icon: 'error',
					title: '닉네임 중복 확인 오류',
					text: '닉네임 중복 확인 중 오류가 발생했습니다',
					confirmButtonText: '확인'
				});
				console.log("mypageUpdate.js checkNickNameFunction() error");
			}
		});
	}
	//전화번호 12자리 확인
	$('#phoneNum').on('input', function() {
		var realPhoneNum = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
		var phoneNum = $('#phoneNum').val();
		if (realPhoneNum.test(phoneNum) === false) {
			return false;
		}
		isPhoneNumChecked == true;//전화번호 확인
	});
	//비밀번호 보안성 확인
	$('#mypagePassword').on('input', function() {
		var realPassword = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
		var mypagePassword = $('#mypagePassword').val();
		if (realPassword.test(mypagePassword) === false) {
			return false;
		}
		isPasswordChecked == true;//비밀번호 확인
	});
	// 폼 제출 시 중복 확인 여부 검사
	$('#submit-button').on('click', function(event) {
		if (!isNicknameChecked) {//초기값:!false=>중복검사 미실시
			console.log("mypageUpdate.js form ninameCheck");
			Swal.fire({
				icon: 'error',
				title: '닉네임 중복확인',
				text: '닉네임 중복확인을 해주세요',
				confirmButtonText: '확인'
			})
			event.preventDefault(); // 폼 제출 막기
			return false;
		}
		if (!isEmailChecked) {//초기값:!false=>중복검사 미실시
			console.log("mypageUpdate.js form emailCheck");
			Swal.fire({
				icon: 'error',
				title: '이메일 중복확인',
				text: '이메일 중복확인을 해주세요',
				confirmButtonText: '확인'
			});
			event.preventDefault(); // 폼 제출 막기
			return false;
		}
		if (!isPhoneNumChecked) {	//핸드폰번호 12자리			
			console.log("mypageUpdate.js form PhoneNumCheck");
			Swal.fire({
				icon: 'error',
				title: '이메일 중복확인',
				text: '이메일 중복확인을 해주세요',
				confirmButtonText: '확인'
			});
			event.preventDefault(); // 폼 제출 막기
			return false;
		}
		//길이는 8자 이상 15자 이하
		//각각 최소 1개 이상의 영문, 숫자, 특수문자 포함
		if (!isPasswordChecked) {
			console.log("mypageUpdate.js form passwordCheck");
			Swal.fire({
				icon: 'error',
				title: '비밀번호 보안성 확인',
				text: '비밀번호 보안을 위해 영문, 숫자, 특수문자 모두 포함해주세요',
				confirmButtonText: '확인'
			});
			event.preventDefault(); // 폼 제출 막기
			return false;
		}
	});
});
/*
// 이메일 중복 확인 버튼 클릭
var email = "${member.memberEmail}";
$('#checkEmailBtn').on('click', function() {
	//인풋값이 있고
	if ($('#email').val() !== '') {
		//기존 이메일과 같다면
		if ($('#email').val() === email) {
			$("#checkEmailMsg").text("기존의 이메일과 동일한 이메일입니다.").css('color', 'red');
			console.log("mypageUpdate.js form emailCheckButton each");
			isEmailChecked = true; // 중복 확인 성공 시 true로 설정
		} else {
			console.log("mypageUpdate.js form emailCheckButton react");

			checkEmailFunction();//비동기처리 진행
		}
	} else {
		Swal.fire({
			icon: 'error',
			title: '이메일 기재 요청',
			text: '이메일을 다시 입력해주세요',
			confirmButtonText: '확인'
		});
	}
});

// 이메일 중복 확인 함수
function checkEmailFunction() {

	console.log("mypageUpdate.js checkEmailFunction() start");

	//12자리가 일치 여부 확인
	var realEmail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9 \-]+\.[A-za-z0-9\-]+/
	var email = $('#email').val();

	if (realEmail.test(email) === false) {//만약 이메일 형태가 아니라면 false반환
		console.log("mypageUpdate.js checkEmailFunction() RealEmail false");
	}

	$.ajax({
		url: 'checkEmail.do',
		method: 'POST',
		data: {
			email: email
		},
		success: function(data) {
			console.log("[" + data + "]");
			if (data === 'true') {
				$("#checkEmailMsg").text("사용 가능한 이메일입니다.")
					.css('color', 'green');
				isEmailChecked = true; // 중복 확인 성공 시 true로 설정
			} else {
				$("#checkEmailMsg").text("이미 사용중인 이메일입니다.")
					.css('color', 'red');
				$('#email').val('').focus();
			}
			console.log("mypageUpdate.js checkEmailFunction() success end");
		},
		error: function() {
			Swal.fire({
				icon: 'error',
				title: '오류',
				text: '이메일 중복 확인 중 오류가 발생했습니다',
				confirmButtonText: '확인'
			});
			console.log("mypageUpdate.js checkEmailFunction() error end");
		}
	});
}

 */