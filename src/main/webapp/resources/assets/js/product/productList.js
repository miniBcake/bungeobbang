// 전역 변수 선언
const popup = document.getElementById("pointPopup");
const pointButton = document.getElementById("pointButton");
const closeButton = document.querySelector(".close-popup");
const searchInput = document.getElementById('searchInput');
const categorySelect = document.getElementById('categorySelect');
const minPriceInput = document.getElementById('minPrice');
const maxPriceInput = document.getElementById('maxPrice');
const conditionInput = document.getElementById('conditionInput');
const selectedOptionsDiv = document.getElementById('selectedOptions');
const searchButton = document.getElementById('searchButton');

// DOMContentLoaded 이벤트 리스너
document.addEventListener('DOMContentLoaded', function () {
    // 추천 상품 Swiper 초기화
    initializeSwiper('.swiper-recommend', '.swiper-recommend-prev', '.swiper-recommend-next', '.swiper-recommend-pagination');
    // 최근에 본 상품 Swiper 초기화
    initializeSwiper('.swiper-recent', '.swiper-recent-prev', '.swiper-recent-next', '.swiper-recent-pagination');

    // 포인트 팝업 초기화
    initializePopup();

    // 검색 옵션 토글 및 설정
    setupSearchOptions();
});

// Swiper 초기화 함수
function initializeSwiper(containerClass, prevButtonClass, nextButtonClass, paginationClass) {
    new Swiper(containerClass, {
        slidesPerView: 4,
        spaceBetween: 30,
        slidesPerGroup: 4,
        loop: false,
        navigation: {
            nextEl: nextButtonClass,
            prevEl: prevButtonClass,
        },
        pagination: {
            el: paginationClass,
            clickable: true,
        }
    });
}

// 팝업 초기화 함수
function initializePopup() {
    pointButton.addEventListener('click', function () {
        const buttonTop = pointButton.offsetTop;
        const buttonLeft = pointButton.offsetLeft;

        popup.style.top = `${buttonTop - popup.offsetHeight - 15}px`;
        popup.style.left = `${buttonLeft - 5}px`;
        popup.style.display = "block";
    });

    closeButton.addEventListener('click', function () {
        popup.style.display = "none";
    });

    window.addEventListener('click', function (event) {
        if (event.target !== popup && event.target !== pointButton && !popup.contains(event.target)) {
            popup.style.display = "none";
        }
    });
}

// 검색 옵션 설정 함수
function setupSearchOptions() {
    searchInput.addEventListener('click', function () {
        toggleSearchOptions();
    });

    searchButton.addEventListener('click', function (event) {
        event.preventDefault();

        const searchCategory = document.querySelector('input[name="searchCategory"]:checked').value;

        if (searchCategory === 'TITLE') {
            conditionInput.value = 'SELECT_PART_TITLE';
        } else if (searchCategory === 'CONTENT') {
            conditionInput.value = 'SELECT_PART_NAME';
        }

        if (validatePrices()) {
            const searchForm = document.querySelector('form');
            searchForm.submit();
        } else {
            Swal.fire({
                icon: 'error',
                title: '잘못된 입력입니다',
                text: '최소 가격은 0 이상이어야 하며, 최대 가격은 최소 가격보다 크거나 같아야 합니다.',
                confirmButtonText: '확인'
            });
        }
    });

    categorySelect.addEventListener('change', updateSelectedOptions);
    minPriceInput.addEventListener('input', function () {
        this.value = this.value.replace(/^0+/, '');
        updateSelectedOptions();
        validatePrices();
    });
    maxPriceInput.addEventListener('input', function () {
        updateSelectedOptions();
        validatePrices();
    });
}

// 가격 유효성 검사 함수
function validatePrices() {
    const minPrice = parseInt(minPriceInput.value, 10);
    const maxPrice = parseInt(maxPriceInput.value, 10);
    const minPriceWarning = document.getElementById('minPriceWarning');
    const maxPriceWarning = document.getElementById('maxPriceWarning');
    let isValid = true;

    if (isNaN(minPrice) || minPrice < 0) {
        minPriceWarning.style.display = 'block';
        isValid = false;
    } else {
        minPriceWarning.style.display = 'none';
    }

    if (!isNaN(minPrice) && !isNaN(maxPrice) && maxPrice < minPrice) {
        maxPriceWarning.style.display = 'block';
        isValid = false;
    } else {
        maxPriceWarning.style.display = 'none';
    }

    return isValid;
}

// 검색 옵션 토글 함수
function toggleSearchOptions() {
    const searchBox = document.querySelector('.search-box');
    const searchOptions = document.getElementById('searchOptions');

    if (searchOptions.style.display === 'none' || searchOptions.style.display === '') {
        searchOptions.style.display = 'block';
        searchBox.classList.add('search-box-expanded');
    } else {
        searchOptions.style.display = 'none';
        searchBox.classList.remove('search-box-expanded');
    }
}

// 선택된 옵션 업데이트 함수
function updateSelectedOptions() {
    selectedOptionsDiv.innerHTML = '';

    const minPrice = minPriceInput.value;
    const maxPrice = maxPriceInput.value;
    const selectedCategory = categorySelect.options[categorySelect.selectedIndex].text;

    if (minPrice) {
        selectedOptionsDiv.innerHTML += `<span class="badge badge-primary m-1 selected-option" onclick="removeOption('minPrice')">최소 가격: ${minPrice}원 <span class="remove-x" title="제거하기">×</span></span>`;
    }

    if (maxPrice) {
        selectedOptionsDiv.innerHTML += `<span class="badge badge-primary m-1 selected-option" onclick="removeOption('maxPrice')">최대 가격: ${maxPrice}원 <span class="remove-x" title="제거하기">×</span></span>`;
    }

    if (categorySelect.value) {
        selectedOptionsDiv.innerHTML += `<span class="badge badge-primary m-1 selected-option" onclick="removeOption('category')">카테고리: ${selectedCategory} <span class="remove-x" title="제거하기">×</span></span>`;
    }
}

// 옵션 제거 함수
function removeOption(option) {
    if (option === 'category') {
        categorySelect.selectedIndex = 0;
    } else if (option === 'minPrice') {
        minPriceInput.value = '';
    } else if (option === 'maxPrice') {
        maxPriceInput.value = '';
    }
    updateSelectedOptions();
}
