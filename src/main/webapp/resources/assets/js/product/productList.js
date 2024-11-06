//전역변수 선언
let popup = document.getElementById("pointPopup");
let btnPoint = document.getElementById("pointButton");
let btnClosePopup = document.querySelector(".close-popup");
let inputSearch = document.getElementById('searchInput');
let selectCategory = document.getElementById('categorySelect');
let inputMinPrice = document.getElementById('minPrice');
let inputMaxPrice = document.getElementById('maxPrice');
let inputCondition = document.getElementById('conditionInput');
let divSelectedOptions = document.getElementById('selectedOptions');
let btnSearch = document.getElementById('searchInputBTN');
const memberNum = document.getElementById("memberPK") ? document.getElementById("memberPK").textContent : null;

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
    btnPoint.addEventListener('click', function () {
        
        if (!memberNum) {
            // 로그인하지 않았으면 로그인 페이지로 리디렉션
            window.location.href = "login.do";
            return;
        }
        
        // 로그인한 경우 포인트 팝업 위치 설정 및 표시
        const buttonTop = btnPoint.offsetTop;
        const buttonLeft = btnPoint.offsetLeft;
        popup.style.top = `${buttonTop - popup.offsetHeight - 15}px`;
        popup.style.left = `${buttonLeft - 5}px`;
        popup.style.display = "block";
    });

    btnClosePopup.addEventListener('click', function () {
        popup.style.display = "none";
    });

    window.addEventListener('click', function (event) {
        if (event.target !== popup && event.target !== btnPoint && !popup.contains(event.target)) {
            popup.style.display = "none";
        }
    });
}

// 검색 옵션 설정 함수
function setupSearchOptions() {
    inputSearch.addEventListener('click', function () {
        toggleSearchOptions();
    });

    btnSearch.addEventListener('click', function () {
        // 기본 폼 제출 동작을 막지 않음

        const searchCategory = document.querySelector('input[name="searchCategory"]:checked').value;

        if (searchCategory === 'TITLE') {
            inputCondition.value = 'SELECT_PART_TITLE';
        } else if (searchCategory === 'CONTENT') {
            inputCondition.value = 'SELECT_PART_NAME';
        }

        if (!validatePrices()) {
            // 유효성 검사 실패 시 알림을 띄우고, 폼 제출을 막기 위해 'return false' 사용
            Swal.fire({
                icon: 'error',
                title: '잘못된 입력입니다',
                text: '최소 가격은 0 이상이어야 하며, 최대 가격은 최소 가격보다 크거나 같아야 합니다.',
                confirmButtonText: '확인'
            });
            return false;
        }
        // 유효성 검사가 통과되면 폼이 동기적으로 제출됨
    });

    selectCategory.addEventListener('change', updateSelectedOptions);
    inputMinPrice.addEventListener('input', function () {
        this.value = this.value.replace(/^0+/, '');
        updateSelectedOptions();
        validatePrices();
    });
    inputMaxPrice.addEventListener('input', function () {
        updateSelectedOptions();
        validatePrices();
    });
}


// 가격 유효성 검사 함수
function validatePrices() {
    const minPrice = parseInt(inputMinPrice.value, 10);
    const maxPrice = parseInt(inputMaxPrice.value, 10);
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
    const searchInput = document.querySelector('.searchInput');
    const searchOptions = document.getElementById('searchOptions');

    if (searchOptions.style.display === 'none' || searchOptions.style.display === '') {
        searchOptions.style.display = 'block';
        searchInput.classList.add('searchInput-expanded');
    } else {
        searchOptions.style.display = 'none';
        searchBox.classList.remove('searchInput-expanded');
    }
}

// 선택된 옵션 업데이트 함수
function updateSelectedOptions() {
    divSelectedOptions.innerHTML = '';

    const minPrice = inputMinPrice.value;
    const maxPrice = inputMaxPrice.value;
    const selectedCategory = selectCategory.options[selectCategory.selectedIndex].text;

    if (minPrice) {
        divSelectedOptions.innerHTML += `<span class="badge badge-primary m-1 selected-option" onclick="removeOption('minPrice')">최소 가격: ${minPrice}원 <span class="remove-x" title="제거하기">×</span></span>`;
    }

    if (maxPrice) {
        divSelectedOptions.innerHTML += `<span class="badge badge-primary m-1 selected-option" onclick="removeOption('maxPrice')">최대 가격: ${maxPrice}원 <span class="remove-x" title="제거하기">×</span></span>`;
    }

    if (selectCategory.value) {
        divSelectedOptions.innerHTML += `<span class="badge badge-primary m-1 selected-option" onclick="removeOption('category')">카테고리: ${selectedCategory} <span class="remove-x" title="제거하기">×</span></span>`;
    }
}

// 옵션 제거 함수
function removeOption(option) {
    if (option === 'category') {
        selectCategory.selectedIndex = 0;
    } else if (option === 'minPrice') {
        inputMinPrice.value = '';
    } else if (option === 'maxPrice') {
        inputMaxPrice.value = '';
    }
    updateSelectedOptions();
}
