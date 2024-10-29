var IMP = window.IMP;
IMP.init("imp42704433");

function requestPay() {
    // 사전 결제 보내는 값
    const uuid = crypto.randomUUID().replace(/-/g, "");
    const currentDate = new Date().toISOString().slice(0, 10).replace(/-/g, '');
    const merchant_uid = uuid + currentDate; // 주문 번호 생성
    const amount = window.additionalPoints; // 선택한 포인트 금액을 결제 금액으로 설정

    // PG사와 결제 방식 설정
    const pg = window.selectedPG;
    const pay_method = window.selectedPM;
	const cardCompany = window.selectedCardCompany;

    // 콘솔에 주요 변수 출력
    console.log("UUID:", uuid);
    console.log("Current Date:", currentDate);
    console.log("Merchant UID:", merchant_uid);
    console.log("Amount:", amount);
    console.log("PG:", pg);
    console.log("Pay Method:", pay_method);
	console.log("Card Company:", cardCompany);

    var selectedRadio = document.querySelector('input[name="point"]:checked');
    const product_name = selectedRadio;

    // 결제 방법 및 사용자 정보 가져오기
    const registered_email = document.getElementById('email').value || null;

    // 추가 콘솔 출력
    console.log("Selected Radio ID (Product Name):", product_name);
    console.log("Registered Email:", registered_email);	

    // 사전 검증 등록
    $.ajax({
        url: "addPrepare.do",
        method: "POST",
        data: { merchant_uid, amount }
    }).done(function (data) {
        console.log("Pre-validation Response:", data);
        if (data === "true") {
            console.log("사전 검증 등록 완료");

            // 사전 검증 조회
            $.ajax({
                url: "checkPrepareResult.do",
                method: "POST",
                dataType: "json",
                data: { merchant_uid }
            }).done(function (data) {
                console.log("Pre-validation Check Response:", data);
                if (!isNaN(data.amountRes) && data.amountRes > 0) {
                    console.log("사전 검증 조회 성공, Amount:", data.amountRes);
                    amount = data.amountRes;
                } else {
                    console.error("오류 발생: 반환된 값이 유효하지 않음");
                }
            }).fail(function (error) {
                console.error("사전 검증 조회 AJAX 오류:", error);
            });
        } else {
            console.error("사전 검증 등록 실패");
        }
    }).fail(function (error) {
        console.error("사전 검증 등록 AJAX 오류:", error);
    });

    // 결제 요청
    IMP.request_pay({
        pg,
        pay_method,
		cardCompany,
        merchant_uid,
        amount,
        name: product_name,
        buyer_email: registered_email
    }, function (rsp) {
        console.log("Payment Response:", rsp);
        if (rsp.success) {
            // 결제 성공 시
            $.ajax({
                url: "infoPayment.do",
                method: "POST",
                data: {
                    imp_uid: rsp.imp_uid,
                    merchant_uid: rsp.merchant_uid
                }
            }).done(function (data) {
                console.log("Info Payment Response:", data);
                if (rsp.paid_amount === data) {
                    alert("결제 및 결제 검증 완료");
                    location.href = `makeReservation.do?merchant_uid=${merchant_uid}&reservation_registrarion_date=${reservationDate}`;
                } else {
                    alert("검증 실패");
                    location.href = `cancelPayment.do?merchant_uid=${merchant_uid}`;
                }
            }).fail(function (error) {
                console.error("결제 검증 AJAX 오류:", error);
            });
        } else {
            console.error("결제 실패: ", rsp.error_msg);
            alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
        }
    });
}
