// 초기 데이터를 cartItems로 설정
var productList = cartItems;

$(document).ready(function() {
    renderCart();

    // 전체 선택 체크박스 이벤트 리스너 설정
    $('#selectAll').on('change', function() {
        const isChecked = $(this).is(':checked');
        $('.product-checkbox').prop('checked', isChecked);

        if (isChecked) {
            $('.remove-btn').show(); // 모든 삭제 버튼 표시
            $('#deleteAllBtn').show(); // 전체 삭제 버튼 표시
            $('#selectAll').next('label').text('전체 해제'); // 라벨 변경
        } else {
            $('.remove-btn').hide(); // 모든 삭제 버튼 숨기기
            $('#deleteAllBtn').hide(); // 전체 삭제 버튼 숨기기
            $('#selectAll').next('label').text('전체 선택'); // 라벨 변경
        }
        // 총 금액 업데이트
        updateTotalPrice();
    });

    // 개별 체크박스 변경 시 전체 선택 체크박스 상태 업데이트
    $(document).on('change', '.product-checkbox', function() {
        const totalCheckboxes = $('.product-checkbox').length;
        const checkedCheckboxes = $('.product-checkbox:checked').length;

        // 전체 선택 체크박스의 상태 업데이트
        $('#selectAll').prop('checked', totalCheckboxes === checkedCheckboxes);

        // 전체 삭제 버튼 표시 여부 결정
        if (checkedCheckboxes > 0) {
            $('#deleteAllBtn').show(); // 체크박스가 하나라도 선택된 경우
        } else {
            $('#deleteAllBtn').hide(); // 아무것도 선택되지 않았을 때 전체 삭제 버튼 숨기기
        }

        // 개별 선택 시 개별 삭제 버튼 토글
        const isChecked = $(this).is(':checked');
        $(this).closest('.product-item').find('.remove-btn').toggle(isChecked);
        // 총 금액 업데이트
        updateTotalPrice();
    });

    // 개별 삭제 버튼 클릭 시 해당 제품 삭제
    $(document).on('click', '.remove-btn', function(event) {
        event.stopPropagation(); // 이벤트 전파 방지
        const productId = $(this).data('product-id');
        removeProduct(productId);
    });
    
	// 전체 삭제 버튼 클릭 이벤트 설정
	$('#deleteAllBtn').on('click', function() {
	    removeAllProducts();
        // 전체 선택 해제 및 버튼 초기화
        $('#selectAll').prop('checked', false);
        $('#selectAll').next('label').text('전체 선택');
        $('#deleteAllBtn').hide(); // 전체 삭제 버튼 숨기기
    });
});

// 삭제 후 전체 선택 버튼과 전체 삭제 버튼 초기화를 위한 함수
function resetSelectionButtons() {
    $('#selectAll').prop('checked', false);
    $('#selectAll').next('label').text('전체 선택');
    $('#deleteAllBtn').hide();
}

// 장바구니 아이템 렌더링 함수
function renderCart() {
    const cartProductsContainer = document.querySelector('.cart-products');
    cartProductsContainer.innerHTML = ''; // 기존 내용을 지웁니다.

    productList.forEach((product) => {
        const productItem = document.createElement('div');
        productItem.className = 'product-item';
        productItem.innerHTML = `
            <div class="product-info">
                <input type="checkbox" class="form-check-input me-2 product-checkbox">
                <div class="product-image">
                    <img src="${product.productProfileWay}" alt="${product.productName}" class="img-fluid">
                </div>
                <div>
                    <strong>${product.productName}</strong><br>
                    ${product.productPrice}P / 
                    <span class="product-quantity">
                        <select class="form-select form-select-sm" data-product-id="${product.productNum}">
                            ${[...Array(10).keys()].map(i => `
                                <option value="${i + 1}" ${product.quantity === i + 1 ? 'selected' : ''}>
                                    ${i + 1}개
                                </option>`).join('')}
                        </select>
                    </span>
                </div>
            </div>
            <button class="btn btn-light remove-btn" data-product-id="${product.productNum}" style="display: none;">X</button>
        `;
        cartProductsContainer.appendChild(productItem);
    });

    updateTotalPrice(); // 장바구니가 렌더링된 후 총 금액을 업데이트합니다.
    attachEventListeners(); // 삭제 버튼 이벤트 리스너를 다시 연결합니다.
	setupChargeButton();
	setupPurchaseButton();
}

// attachEventListeners 정의
function attachEventListeners() {
    const quantitySelectors = document.querySelectorAll('.product-quantity select');
    quantitySelectors.forEach((select) => {
        select.addEventListener('change', function() {
            const productId = parseInt(this.getAttribute('data-product-id'));
            const selectedQuantity = parseInt(this.value);
            updateProductQuantity(productId, selectedQuantity);
            updateTotalPrice();
        });
    });
}


async function removeProduct(productId) {
    const productIndex = productList.findIndex(product => product.productNum === productId);
    if (productIndex !== -1) {
        const productItem = document.querySelector(`.remove-btn[data-product-id="${productId}"]`).closest('.product-item');
        productItem.classList.add('fade-out');

        try {
            const response = await fetch('removeCart.do', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ productNum: productId })
            });

            if (response.ok) {
                const result = await response.json();
                if (result.status === "success") {
                    console.log('서버에서 제품이 성공적으로 삭제되었습니다.');
                    productList.splice(productIndex, 1); // 데이터에서 제거
                    productItem.remove(); // 화면에서 삭제
                    renderCart(); // 장바구니 다시 렌더링
                    resetSelectionButtons(); // 버튼 초기화
                } else {
                    console.error('서버에서 제품 삭제 실패:', result.message);
                    Swal.fire({
                        icon: 'error',
                        title: '삭제 실패',
                        text: result.message || '삭제 중 문제가 발생했습니다. 다시 시도해주세요.',
                        confirmButtonText: '확인'
                    });
                }
            } else {
                console.error('서버 응답 오류:', response.statusText);
                Swal.fire({
                    icon: 'error',
                    title: '삭제 요청 실패',
                    text: '삭제 요청에 실패했습니다. 네트워크 상태를 확인해주세요.',
                    confirmButtonText: '확인'
                });
            }
        } catch (error) {
            console.error('AJAX 요청 오류:', error);
            Swal.fire({
                icon: 'error',
                title: '삭제 요청 실패',
                text: '삭제 요청에 실패했습니다. 네트워크 상태를 확인해주세요.',
                confirmButtonText: '확인'
            });
        }
    }
}

// 전체 삭제 함수
async function removeAllProducts() {
    const productsToDelete = $('.product-checkbox:checked').map(function() {
        return $(this).closest('.product-item').find('.remove-btn').data('product-id');
    }).get();

    for (let productId of productsToDelete) {
        await removeProduct(productId);
    }
}





// 제품 수량 업데이트 함수
function updateProductQuantity(productId, quantity) {
    const product = productList.find(product => product.productNum === productId);
    if (product) {
        product.quantity = quantity;
    }
}

// 총 금액 업데이트 함수 (선택된 값만 가격으로 표시)
function updateTotalPrice() {
    const totalPriceElement = document.querySelector('.total-price');
    let totalPrice = 0;

    console.log('--- 총 금액 업데이트 시작 ---');
    // 선택된 체크박스에 해당하는 제품만 가격을 합산
    $('.product-checkbox:checked').each(function() {
        // 체크박스의 가장 가까운 부모 요소인 .product-item에서 productId를 찾습니다.
        const productId = $(this).closest('.product-item').find('.remove-btn').data('product-id');
        console.log('선택된 제품 ID:', productId);

        const product = productList.find(p => p.productNum === productId);

        if (product) {
            console.log('선택된 제품 정보:', product);
            console.log('제품 가격:', product.productPrice);
            console.log('제품 수량:', product.quantity);
            totalPrice += product.productPrice * product.quantity;
            console.log('현재 누적 총 금액:', totalPrice);
        } else {
            console.log('제품을 찾을 수 없습니다:', productId);
        }
    });

    console.log('최종 총 금액:', totalPrice);
    totalPriceElement.textContent = `${totalPrice.toLocaleString()}P`;
    console.log('--- 총 금액 업데이트 완료 ---');
}

// "충전관련 함수"

function setupChargeButton() {
    // "충전하기" 버튼 클릭 이벤트 리스너
    $('#chargeButton').on('click', function() {
        redirectToChargePage();
    });
}
// 충전 페이지로 리다이렉트하는 함수
function redirectToChargePage() {
    window.location.href = 'chargePoints.do';
}

// "구매하기 버튼 관련 함수"

function setupPurchaseButton() {
    // "구매하기" 버튼 클릭 이벤트 리스너
    $('#purchaseButton').on('click', function() {
		// 로그인 여부 확인 
		const isLoggedIn = Boolean(document.getElementById('memberPK'));
		console.log(isLoggedIn);

		// 로그인 여부 확인
		if (!isLoggedIn) {
		    Swal.fire({
		        icon: 'warning',
		        title: '로그인 필요',
		        text: '구매를 진행하려면 로그인이 필요합니다. 로그인 페이지로 이동합니다.',
		        confirmButtonText: '로그인하기'
		    }).then(() => {
		        // 로그인 페이지로 이동
		        window.location.href = 'login.do';
		    });
		    return;
		}
		
        const selectedProducts = getSelectedProducts();
        console.log(selectedProducts);

        // 선택된 제품이 있는지 확인
        if (selectedProducts.length === 0) {
            Swal.fire({
                icon: 'warning',
                title: '제품 선택',
                text: '선택된 제품이 없습니다. 제품을 선택해주세요.',
                confirmButtonText: '확인'
            });
            return;
        }

        // 총 결제 금액 계산
        let totalPrice = 0;
        selectedProducts.products.forEach(product => {
            const cartProduct = cartItems.find(item => item.productNum === product.productNum);
            if (cartProduct) {
                totalPrice += cartProduct.productPrice * product.quantity;
            }
        });

        // 현재 포인트 가져오기
		// 문자열을 정수로 변환 10진수
		// P 문자 제외
		const currentPoints = parseInt(document.getElementById('myPoint').innerText.replace('P', ''), 10);
		console.log('현재 포인트:', currentPoints);

        // 결제 금액이 현재 포인트보다 높은지 확인
        if (totalPrice > currentPoints) {
            Swal.fire({
                icon: 'warning',
                title: '포인트 부족',
                text: '결제 금액이 현재 포인트보다 높습니다. 충전 페이지로 이동합니다.',
                confirmButtonText: '충전하기'
            }).then(() => {
                // 충전 페이지로 이동
                window.location.href = 'chargePoints.do';
            });
        } else {
            // 서버에 구매 요청 전송
            sendPurchaseRequest(selectedProducts);
        }
    });
}

// 선택된 제품 정보를 수집하는 함수
function getSelectedProducts() {
    // products 리스트를 담을 객체
    const selectedProducts = {
        products: []
    };

    // 체크된 제품에 대해 반복
    $('.product-checkbox:checked').each(function() {
        // 체크박스의 부모 요소인 .product-item에서 productId를 가져옵니다.
        const productId = $(this).closest('.product-item').find('.remove-btn').data('product-id');
        const product = productList.find(p => p.productNum === productId);

        if (product) {
            selectedProducts.products.push({
                productNum: product.productNum,
                quantity: product.quantity
            });
        }
    });

    return selectedProducts;
}

function sendPurchaseRequest(selectedProducts) {
    const jsonData = JSON.stringify(selectedProducts);
    $.ajax({
        url: 'purchaseCart.do', // 서버의 엔드포인트 URL
        type: 'POST', // HTTP 요청 방식 (POST)
        contentType: 'application/json', // 요청 데이터의 콘텐츠 유형 설정 (JSON 형식)
        data: jsonData, // JSON 문자열을 서버에 전송
        success: function(response) {
            console.log('Response:', response);
            Swal.fire({
                icon: 'success',
                title: '구매 성공',
                text: response.message,
                confirmButtonText: '확인'
            }).then(() => {
                // 구매 성공 후 deleteAllBtn 클릭하여 선택된 상품 삭제
                $('#deleteAllBtn').click();
            });
        },
        error: function(xhr, status, error) {
            console.error('Error:', error);
            Swal.fire({
                icon: 'error',
                title: '구매 요청 실패',
                text: '구매 요청 중 오류가 발생했습니다.',
                confirmButtonText: '확인'
            });
        }
    });
}
