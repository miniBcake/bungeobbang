var element_layer = document.getElementById('addressLayer');

function closeDaumPostcode() {
    element_layer.style.display = 'none';
}

function sample2_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            // 주소 유형에 따라 처리
            if (data.userSelectedType === 'R') { 
                addr = data.roadAddress;
            } else { 
                addr = data.jibunAddress;
            }

            // 도로명 주소일 때 참고 항목 추가
            if (data.userSelectedType === 'R') {
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraAddr += data.bname;
                }
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if (extraAddr !== '') {
                    extraAddr = ' (' + extraAddr + ')';
                }
                
            } else {
                extraAddr='';
            }

            // 우편번호와 주소 입력
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("addressMain").value = addr + extraAddr;
            document.getElementById("addressDetail").focus();

            // 레이어 닫기
            element_layer.style.display = 'none';
        },
        width: '100%',
        height: '100%',
        maxSuggestItems: 5
    }).embed(element_layer);

    // 레이어 보이기
    element_layer.style.display = 'block';
    initLayerPosition();
}

// 레이어 중앙 배치 함수
function initLayerPosition(){
    var width = 800; 
    var height = 400; 
    var borderWidth = 5; 

    element_layer.style.width = width + 'px';
    element_layer.style.height = height + 'px';
    element_layer.style.border = borderWidth + 'px solid';

    element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width) / 2 - borderWidth) + 'px';
    element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height) / 2 - borderWidth) + 'px';
}