function handleStoreReportLink() {
    const storeReportLink = document.getElementById('storeReportLink');
    if (storeReportLink) {
        storeReportLink.addEventListener('click', function (event) {
            event.preventDefault();
            showLoginAlert(); 
        });
    }
}

function showLoginAlert() {
    Swal.fire({
        icon: 'warning',
        title: '로그인이 필요합니다.',
        text: '가게 제보를 이용하려면 로그인이 필요합니다.',
        confirmButtonText: '로그인하기'
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = 'login.do'; 
        }
    });
}

document.addEventListener('DOMContentLoaded', handleStoreReportLink);