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
    // Swiper 슬라이더를 초기화하여 여러 상품을 슬라이딩 형태로 표시
    new Swiper(containerClass, {
        slidesPerView: 4, // 한 번에 표시할 슬라이드 개수
        spaceBetween: 30, // 슬라이드 간격
        slidesPerGroup: 4, // 슬라이드 이동 시 그룹화 개수
        loop: false, // 무한 반복을 비활성화
        navigation: {
            nextEl: nextButtonClass, // 다음 버튼
            prevEl: prevButtonClass, // 이전 버튼
        },
        pagination: {
            el: paginationClass, // 페이지네이션 요소
            clickable: true, // 페이지네이션 클릭 가능 여부
        }
    });
}

// 팝업 초기화 함수
function initializePopup() {
    const popup = document.getElementById("pointPopup");
    const pointButton = document.getElementById("pointButton");
    const closeButton = document.querySelector(".close-popup");

    // 버튼 클릭 시 팝업 표시 및 위치 조정
    pointButton.addEventListener('click', function () {
        // 버튼의 화면 위치 (뷰포트) 정보를 가져옴
        const rect = pointButton.getBoundingClientRect();
        
        // 팝업 위치를 버튼 위치에 맞춰 조정
		popup.style.top = `${rect.bottom + window.scrollY }px`; // 버튼 아래에 여유를 두고 위치 설정
        popup.style.left = `${rect.left + window.scrollX }px`; // 버튼의 x좌표에 맞춰 위치
        popup.style.display = "block"; // 팝업 표시

        // 버튼 숨기기
        pointButton.style.display = "none";
    });

    // 닫기 버튼 클릭 시 팝업 닫기 및 버튼 다시 표시
    closeButton.addEventListener('click', function () {
        popup.style.display = "none"; // 팝업 숨기기
        pointButton.style.display = "block"; // 버튼 다시 표시
    });

    // 클릭 시 팝업 외부 클릭 감지하여 팝업 닫기
    window.addEventListener('click', function (event) {
        // 팝업 또는 버튼 외부를 클릭하면 팝업을 닫음
        if (event.target !== popup && event.target !== pointButton && !popup.contains(event.target)) {
            popup.style.display = "none";
            pointButton.style.display = "block"; // 버튼 다시 표시
        }
    });
}

// 검색 옵션 설정 함수
function setupSearchOptions() {
    const searchInput = document.getElementById('searchInput');
    const categorySelect = document.getElementById('categorySelect');
    const minPriceInput = document.getElementById('minPrice');
    const maxPriceInput = document.getElementById('maxPrice');

    // 검색 입력란 클릭 시 검색 옵션 열기
    searchInput.addEventListener('click', function () {
        toggleSearchOptions();
    });

    // 검색 버튼 클릭 시 폼 제출
    document.getElementById('searchButton').addEventListener('click', function (event) {
        event.preventDefault(); // 기본 폼 제출 방지

        // 가격 유효성 검사 후 제출 여부 결정
        if (validatePrices()) {
            const searchForm = document.querySelector('form');
            searchForm.submit(); // 폼 제출
        } else {
            // 유효성 검사 실패 시 경고 메시지 표시
            Swal.fire({
                icon: 'error',
                title: '잘못된 입력입니다',
                text: '최소 가격은 0 이상이어야 하며, 최대 가격은 최소 가격보다 크거나 같아야 합니다.',
                confirmButtonText: '확인'
            });
        }
    });

    // 옵션 변경 시 유효성 검사 및 선택된 옵션 업데이트
    categorySelect.addEventListener('change', updateSelectedOptions);
    minPriceInput.addEventListener('input', function () {
        // 앞의 0을 제거하는 로직 (예: 001 -> 1)
        this.value = this.value.replace(/^0+/, '');
        updateSelectedOptions(); // 선택된 옵션 업데이트
        validatePrices(); // 가격 유효성 검사 실행
    });
    maxPriceInput.addEventListener('input', function () {
        updateSelectedOptions(); // 선택된 옵션 업데이트
        validatePrices(); // 가격 유효성 검사 실행
    });
}

// 가격 유효성 검사 함수
function validatePrices() {
    const minPrice = parseInt(document.getElementById('minPrice').value, 10);
    const maxPrice = parseInt(document.getElementById('maxPrice').value, 10);
    const minPriceWarning = document.getElementById('minPriceWarning');
    const maxPriceWarning = document.getElementById('maxPriceWarning');
    let isValid = true;

    // 최소 가격이 0 미만일 경우 경고 표시
    if (isNaN(minPrice) || minPrice < 0) {
        minPriceWarning.style.display = 'block';
        isValid = false;
    } else {
        minPriceWarning.style.display = 'none';
    }

    // 최대 가격이 최소 가격보다 작을 경우 경고 표시
    if (!isNaN(minPrice) && !isNaN(maxPrice) && maxPrice < minPrice) {
        maxPriceWarning.style.display = 'block';
        isValid = false;
    } else {
        maxPriceWarning.style.display = 'none';
    }

    return isValid; // 유효한 경우 true 반환, 아니면 false 반환
}

// 검색 옵션 토글
function toggleSearchOptions() {
    const searchBox = document.querySelector('.search-box');
    const searchOptions = document.getElementById('searchOptions');

    // 검색 옵션이 보이지 않을 때 표시, 보일 때 숨김
    if (searchOptions.style.display === 'none' || searchOptions.style.display === '') {
        searchOptions.style.display = 'block';
        searchBox.classList.add('search-box-expanded'); // 확장된 스타일 추가
    } else {
        searchOptions.style.display = 'none';
        searchBox.classList.remove('search-box-expanded'); // 확장된 스타일 제거
    }
}

// 선택된 옵션 업데이트
function updateSelectedOptions() {
    const selectedOptionsDiv = document.getElementById('selectedOptions');
    const categorySelect = document.getElementById('categorySelect');
    const minPrice = document.getElementById('minPrice').value;
    const maxPrice = document.getElementById('maxPrice').value;
    const selectedCategory = categorySelect.options[categorySelect.selectedIndex].text;

    selectedOptionsDiv.innerHTML = ''; // 기존 선택된 옵션 제거

    // 최소 가격 옵션 추가
    if (minPrice) {
        selectedOptionsDiv.innerHTML += `<span class="badge badge-primary m-1 selected-option" onclick="removeOption('minPrice')">최소 가격: ${minPrice}원 <span class="remove-x" title="제거하기">×</span></span>`;
    }

    // 최대 가격 옵션 추가
    if (maxPrice) {
        selectedOptionsDiv.innerHTML += `<span class="badge badge-primary m-1 selected-option" onclick="removeOption('maxPrice')">최대 가격: ${maxPrice}원 <span class="remove-x" title="제거하기">×</span></span>`;
    }

    // 카테고리 옵션 추가
    if (categorySelect.value) {
        selectedOptionsDiv.innerHTML += `<span class="badge badge-primary m-1 selected-option" onclick="removeOption('category')">카테고리: ${selectedCategory} <span class="remove-x" title="제거하기">×</span></span>`;
    }
}

// 옵션 제거 함수
function removeOption(option) {
    if (option === 'category') {
        document.getElementById('categorySelect').selectedIndex = 0; // 카테고리 선택 초기화
    } else if (option === 'minPrice') {
        document.getElementById('minPrice').value = ''; // 최소 가격 초기화
    } else if (option === 'maxPrice') {
        document.getElementById('maxPrice').value = ''; // 최대 가격 초기화
    }
    updateSelectedOptions(); // 선택된 옵션 업데이트
}
