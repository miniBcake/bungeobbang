// 초기 데이터를 cartItems로 설정
var productList = cartItems;

// 장바구니 아이템 렌더링 함수
function renderCart() {
    const cartProductsContainer = document.querySelector('.cart-products');
    cartProductsContainer.innerHTML = ''; // 기존 내용을 지웁니다.

    console.log('productList:', productList); // 데이터 확인

    productList.forEach((product) => {
        console.log('Rendering product:', product); // 각 상품 정보 로그

        const productItem = document.createElement('div');
        productItem.className = 'product-item';
        productItem.innerHTML = `
            <div class="product-info">
                <input type="checkbox" class="form-check-input me-2">
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
            <button class="btn btn-light remove-btn" data-product-id="${product.productNum}">X</button>
        `;
        cartProductsContainer.appendChild(productItem);
    });

    updateTotalPrice(); // 장바구니가 렌더링된 후 총 금액을 업데이트합니다.
    attachEventListeners(); // 삭제 버튼 이벤트 리스너를 다시 연결합니다.
}

// 삭제 버튼 이벤트 리스너
function attachEventListeners() {
    const removeButtons = document.querySelectorAll('.remove-btn');
    removeButtons.forEach((button) => {
        button.addEventListener('click', function() {
            const productId = parseInt(this.getAttribute('data-product-id'));
            removeProduct(productId);
        });
    });

    // 수량 선택 시 총 금액 업데이트
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

// 제품 삭제 함수
function removeProduct(productId) {
    const productIndex = productList.findIndex(product => product.productNum === productId);
    if (productIndex !== -1) {
        const productItem = document.querySelector(`.remove-btn[data-product-id="${productId}"]`).closest('.product-item');
        productItem.classList.add('fade-out');

        productItem.addEventListener('animationend', function() {
            productList.splice(productIndex, 1); // 데이터에서 제거
            renderCart(); // 장바구니를 다시 렌더링
        });
    }
}

// 제품 수량 업데이트 함수
function updateProductQuantity(productId, quantity) {
    const product = productList.find(product => product.productNum === productId);
    if (product) {
        product.quantity = quantity;
    }
}

// 총 금액 업데이트 함수
function updateTotalPrice() {
    const totalPriceElement = document.querySelector('.total-price');
    const totalPrice = productList.reduce((acc, product) => acc + (product.productPrice * product.quantity), 0);
    totalPriceElement.textContent = `${totalPrice.toLocaleString()}P`;
}

// 초기 장바구니 렌더링
document.addEventListener('DOMContentLoaded', renderCart);
