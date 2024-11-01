//로그인하기 위한 비밀번호 찾기(회원 여부 확인)

/*1. 이름 이메일 입력
2. 비밀번호 재설정 하러가기 클릭
3. 비동기처리 : 이름, 이메일 기반 회원정보 확인(checkEmailName.do)
4. 반환값 : Map<String, Object> (String : true/false | Object : MemberDTO)
5. 키값이 true이면 스위트 알랏으로 회원정보가 확인되었습니다. 새 비밀번호를 입력해주세요. 이때, MemberDTO 고유번호 가지고 있기
6. 키값이 false이면 스위트 알랏으로 회원정보가 없습니다. 다시 정보를 입력해주시거나 회원가입해주세요.
*/

// 전역 변수로 memberNum 정의
let memberNum; 


//회원 정보 확인하기
$('#loginPwFind').on('click', function() {//회원정보 확인 버튼 누르면
	//이벤트가 발생하게 만든 주체, 즉 사용자가 입력한 상태값을 가져와 상태로 변수로 지칭
	const name = document.getElementByid('name').value;
	const email = document.getElementByid('email').value;

	console.log('name: ' + name);
	console.log('email: ' + email);

	//ajax를 통해 비동기처리 진행
	$.ajax({
		url: 'checkEmailName.do',
		type: 'POST',
		contentType: 'application/json',
		data: JSON.stringify({
			name: name,
			email: email
		}),
		dataType: 'json',
		success: function(result) {
			if (result.true) { // 키 값이 true인 경우
				Swal.fire({
					icon: 'success',
					title: '회원 정보 확인',
					text: '회원정보가 확인되었습니다. 새 비밀번호를 입력해주세요.',
					confirmButtonText: '새로운 비밀번호로 변경하기'
				}).then(function() {
					// MemberDTO 고유번호 가지고 새로운 비밀번호 입력 모달 열기
					openSetPasswordModal(result.MemberDTO.memberNum); // memberNum을 넘겨주는 함수
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
		error: function() {
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


//두번째 모달창(새비밀번호입력) 열기
function openSetPasswordModal(memberNum) {
	//전역변수로 memberNum 저장
	memberNum = memberNum;
	document.getElementById('loginModal').style.display = 'none';//첫번째 모달 닫기
	document.getElementById('setPwModal').style.display = 'block';//두번째 모달 열기
	console.log("loginPwFind.js second modal open");    
	// 비밀번호 일치 여부 확인 초기화
	   document.getElementById('resultPW').textContent = '';
}

// 비밀번호 확인 입력 필드의 값이 변경될 때마다 일치 여부 확인
$(document).ready(function() {
    $('#passwordCheck').on('input', function() {
        var doublePassword = $(this).val(); // 비밀번호 확인란의 값
        var password = $('#password').val(); // 신규 비밀번호란의 값
		console.log("loginPwFind.js Password document ready");    

		
        // 비밀번호 확인 입력란이 비어있지 않은 경우
        if (doublePassword) {
            $.ajax({
                url: 'checkedPW.do',
                type: 'POST',
                data: { password: password, doublePassword: doublePassword },
                success: function(result) {
                    if (result == 'true') {
                        $('#resultPW').text('비밀번호가 일치합니다.').css('color', 'blue');
						console.log("loginPwFind.js Password each success");    
                    } else if (data == 'false') {
                        $('#resultPW').text('비밀번호가 다릅니다. 다시 입력해주세요.').css('color', 'red');
						console.log("loginPwFind.js Password difference");    
						}
                }
            });
        } else {
            $('#resultPW').text(' '); // 입력란이 비어있으면 공백 처리
			console.log("loginPwFind.js doublePassword ' ' check");    
		}
    });
});

// 비밀번호 변경 버튼 클릭 이벤트
document.getElementById('completePw').addEventListener('click', function(event) {
    event.preventDefault(); // 선 작동 방지

    const password = document.getElementById('password').value;
    const passwordCheck = document.getElementById('passwordCheck').value;

    // 비밀번호 일치 여부 확인
    if (password !== passwordCheck) {
        return; // 비밀번호가 일치하지 않으면 함수 종료
    }

    // 비밀번호 변경을 위한 데이터 준비
    const data = {
        memberNum: memberNum, 	// 전역 변수
        password: password		// 사용자가 입력한 신규 비밀번호
    };

    // 비밀번호 변경 요청
    $.ajax({
        url: 'setPw.do',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(data),
        dataType: 'json',
        success: function(result) {
            if (result.success) {
                Swal.fire({
                    icon: 'success',
                    title: '비밀번호 변경 성공',
                    text: '비밀번호가 성공적으로 변경되었습니다.',
                    confirmButtonText: '확인'
                }).then(() => {
                    closedModal(); // 모달 닫기
					console.log("loginPwFind.js newPassword complete");
                });
            } else {
                Swal.fire({
                    icon: 'error',
                    title: '오류',
                    text: '비밀번호 변경에 실패했습니다. 비밀번호가 서로 일치하는지 확인해주세요.',
                    confirmButtonText: '확인'
                });
				console.log("loginPwFind.js newPassword success end");
            }
        },
        error: function() {
            console.error('서버와의 통신 실패:', error);
            Swal.fire({
                icon: 'error',
                title: '오류',
                text: '서버와의 통신에 실패했습니다.',
                confirmButtonText: '확인'
            });
			console.log("loginPwFind.js newPassword error end");
        }
    });
});