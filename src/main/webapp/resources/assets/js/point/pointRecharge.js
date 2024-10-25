// 결제 방법 선택 함수
 function selectPaymentMethod(method) {
     document.getElementById('paymentMethodSelected').value = method;
 }

 // 포인트 선택 시 결제 금액 업데이트
 document.querySelectorAll('input[name="point"]').forEach(function (radio) {
     radio.addEventListener('change', function () {
         var selectedPoint = this.value;
         document.getElementById('paymentAmount').value = selectedPoint + '원';
         
         // 충전 후 포인트 업데이트
         var currentPoints = 12000; // 현재 포인트
         var totalPoints = currentPoints + parseInt(selectedPoint);
         document.getElementById('totalPoints').innerText = totalPoints + 'P';
     });
 });
 
 // 초기화 작업: 다른 드롭다운 선택 시 기존 선택값 초기화
 document.querySelectorAll('.dropdown-payment').forEach(select => {
     select.addEventListener('change', function () {
         document.querySelectorAll('.dropdown-payment').forEach(otherSelect => {
             if (otherSelect !== this) {
                 otherSelect.selectedIndex = 0; // 다른 드롭다운의 선택을 초기화
             }
         });
     });
 });