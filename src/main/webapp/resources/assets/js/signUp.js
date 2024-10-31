


$(document).ready(()=>{
	var checkNickname = false;
	var checkEmail = false;

//닉네임 중복확인 실행
	function checkNicknameFunction() {
		console.log("로그 : 닉네임 중복확인 시작");
		var nickname = $('input[name="nickName"]').val();
		// 닉네임 입력값 저장
		$.ajax({
			url: "checkNickname",
			method: "POST",
			data: {
				nickname: nickname
			},
			success: function(data) {
				console.log("[" + data + "]");
				checkNickname = data; //flag(true or false)로 반환
				if (checkNickname === 'true') {
					$("#checkNicknameMsg")
						.text("사용가능한 닉네임입니다.").css('color',
						'green');
				} else {
					$("#checkNicknameMsg").text(
						"이미 사용중인 닉네임입니다.").css('color',
						'red');

					// 닉네임이 중복인 경우, 입력란을 비우고, 입력창으로 이동
					$("#nickname").val('').focus();
				}
				console.log("signUp.js nicknameCheck end");
			},
			error: function(error) {

				console.log("signUp.js nicknameCheck error");
			}
		});
	}

// 이메일 중복확인
	function checkEmailFunction(email) {
		console.log("signUp.js emailCheck start")
		console.log('email: ['+email+']');
		$.ajax({
			method: "POST",
			url: "checkEmailName.do",
			data: {
				memberEmail: email
			},
			success: function(data) {
				console.log("data [" + data + "]");
				console.log("typeof data [" + typeof data + "]");
				checkEmail = data; //true or false
				if (checkEmail === 'false') {
					//TODO 검증 완료 후 값을 고정할 것인지, 고정한다면 어떤 방식으로 사용자에게 안내(UIUX)할 것인지는 view 측에서 결정해 진행해주시면 될 것 같습니다!
					$("#checkEmailMsg").text("사용 가능한 이메일입니다.").css('color', 'green')
					//$('input[name ="memberEmail"]').prop('disabled', true);
					sendEmail(email);
					//sendEmail에 Swal있어서 중복이길래 뺐습니다.
					// Swal.fire({
					// 	icon: 'success',
					// 	title: '인증 번호 발송',
					// 	text: '가입 가능한 이메일 입니다. 인증 번호 입력바랍니다.',
					// 	confirmButtonText: '확인'
					// });
				} else {
					$("#checkEmailMsg").text("이미 사용중인 이메일입니다.").css('color', 'red');

					// 이메일이 중복인 경우, 입력란을 비우고, 입력창으로 이동
					$('#email').val('').focus();
				}
				console.log("signUp.js emailCheck end")
			},
			error: function(error) {
				//비동기 통신 실패 시
				console.error("signUp.js emailCheck error")
			}
		});

	}

	//닉네임 값이 있다면 중복확인 진행 가능
	//닉네임값이 없다면 입력 안내
	$('#checkNicknameBtn').on('click', function() {
		//버튼 클릭시 메세지 초기화
		$('#checkNicknameMsg').text("");
		if ($('input[name="nickname"]').val() !== '') {
			checkNicknameFunction(); //닉네임값이 있다면 중복확인  진행
		} else {
			Swal.fire({
				icon: 'error',
				title: '닉네임 미기재',
				text: '닉네임을 입력해주세요',
				confirmButtonText: '확인'
			});
		}
	});


	//이메일 값 있다면 중복확인 진행 가능
	//이메일 값 없다면 입력 안내
	$('#checkEmailBtn').on('click', function() {
		console.log('log: #checkEmailBtn.onclick');
		//버튼 클릭시 메세지 초기화
		$('#checkEmailMsg').text("");
		let email = $('#email').val();
		console.log('email: ['+email+']');

		//유효한 값인지 검증해 유효하다면 계속 진행
		//TODO 아주 기본적인 검증만 넣어두었습니다. 검증 로직 추가로 진행해주세요.
		if (email.trim().includes('@')) { //JS는 contains대신 includes
			console.log('email input tag email : ['+email+']');
			//중복 닉네임 확인
			checkEmailFunction(email);
		}
		else {
			Swal.fire({
				icon: 'error',
				title: '유효하지 않은 이메일',
				text: '이메일 형식에 맞춰 작성바랍니다.',
				confirmButtonText: '확인'
			});
		}
	});

	// 비밀번호 일치 여부 확인
	$('#password2').on('input', function() {//비밀번호 재확인에 인풋값이 들어오면
		// 입력값 받아오기
		var password1 = $('#password1').val();
		var password2 = $('#password2').val();

		if (password1 !== password2) {
			resultPW.text("비밀번호가 일치하지 않습니다. 다시 입력해주세요");
			resultPW.css('color', 'red');
			$('#password2').val('').focus();//재확인 비밀번호 초기화

		} else {
			resultPW.text("비밀번호가 일치합니다.");
			resultPW.css('color', 'green');
		}

	});

	var sendEmailResult = false;
	var checkNumResult = false;

	// 이메일 전송 기능
	function sendEmail(email) {
		console.log("signUp.js sendEmail() start");

		$.ajax({
			url: "sendEmail",
			method: "POST",
			data: {
				email: email
			},
			success: function(data) {
				console.log(data);
				sendEmailResult = data;
				if (sendEmailResult == 'true') {
					$("#sendEmailMsg").text("인증번호 전송 완료");

				} else {
					$("#sendEmailMsg").text(
						"인증번호 전송 실패").css('color', 'red');
				}
			},
			error: function(error) {
				Swal.fire({
					icon: 'error',
					title: '인증번호 전송 오류',
					text: '인증번호 전송 중 오류가 발생했습니다.',
					confirmButtonText: '확인'
				}); console.log("signUp.js sendEmail() error");
			}
		});

	}

// 사용자가 인증번호 입력한 후 버튼을 통한 인증번호 확인
	function checkNum() {
		console.log("signUp.js checkNum() ");
		// 인증번호 저장
		var checkNum = $('input[name="checkNum"]').val();

		$.ajax({
			url: "emailNumCheck",
			method: "POST",
			data: {
				checkNum: checkNum
			},
			success: function(data) {
				console.log("[" + data + "]");
				checkNumResult = data;
				if (checkNumResult == 'true') {
					$("#checkNumMsg").text(
						"인증번호 일치");
				} else {
					$("#checkNumMsg").text(
						"인증번호 일치하지 않음").css(	'color', 'red');

					// 닉네임이 중복인 경우, 입력란을 비우고, 입력창으로 이동
					$("checkNum").val('').focus();
				}
			},
			error: function(error) {
				Swal.fire({
					icon: 'error',
					title: '인증번호 확인 오류',
					text: '인증번호 확인 중 오류가 발생했습니다.',
					confirmButtonText: '확인'
				}); console.log("signUp.js checkNum() error");
			}
		});
	}

//버튼을 클릭 시 인증번호 확인 함수 실행
	$('#checkNumBtn').on('click', function() {
		//버튼 클릭시 메세지 초기화
		$('#checkNumResult').text("");
		if ($('input[name="checkNum"]')
			.val() !== '') {
			checkNum();//위 인증번호 일치 여부 확인 비동기 실행
		} else {
			Swal.fire({
				icon: 'error',
				title: '인증번호 확인',
				text: '인증번호를 입력해주세요.',
				confirmButtonText: '확인'
			});	}
	});

// 회원가입 버튼 클릭 시 인증 여부 확인
	$('#joinForm').on('submit', function(event) {
		if (checkNumResult !== 'true') {
			Swal.fire({
				icon: 'error',
				title: '인증번호 확인 오류',
				text: '이메일 인증번호를 확인해주세요',
				confirmButtonText: '확인'
			});
			event.preventDefault(); // 폼 제출 중단
		}
	});
})